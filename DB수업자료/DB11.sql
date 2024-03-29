-- 저장함수(stored function)
SELECT * FROM EMP;
CREATE OR REPLACE FUNCTION CAL_BONUS(VEMPNO IN EMP.EMPNO%TYPE)
        RETURN NUMBER
IS
        VSAL NUMBER(7,2);
BEGIN
        SELECT SAL INTO VSAL
        FROM EMP
        WHERE EMPNO=VEMPNO;
        
        RETURN (VSAL * 2);
END;
/

VARIABLE VAR_RES NUMBER;

EXECUTE :VAR_RES := CAL_BONUS(7369);
PRINT VAR_RES;

-- 사원명으로 검색하여 해당 사원의 직급을 얻어 오는 저장 함수를 SEL_EMPNAME02라는 이름으로 작성하라.
CREATE OR REPLACE FUNCTION SEL_EMPNAME02(VENAME IN EMP.ENAME%TYPE)
        RETURN VARCHAR2
IS
        VJOB VARCHAR2(9);
BEGIN
        SELECT JOB INTO VJOB
        FROM EMP
        WHERE ENAME=VENAME;
        
        RETURN (VJOB);
END;
/

VARIABLE VAR_JOB VARCHAR2(9);

EXECUTE :VAR_JOB := SEL_EMPNAME02('SMITH');
PRINT VAR_JOB;

-- CURSOR를 이용해서 부서테이블의 모든 내용을 조회하기
CREATE OR REPLACE PROCEDURE CURSOR_SAMPLE01
IS
        VDEPT DEPT%ROWTYPE; -- 레코드 타입(자바의 CLASS형과 유사), 여러 데이터타입을 가진 필드들이 존재
        CURSOR C1 IS  -- 커서이름 C1
                SELECT * FROM DEPT; -- DEPT쿼리를 가르키는 커서C1
BEGIN
        DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
        DBMS_OUTPUT.PUT_LINE('---------------------------------');
        OPEN C1; -- 커서 열기
        LOOP
                FETCH C1 INTO VDEPT.DEPTNO, VDEPT.DNAME, VDEPT.LOC; 
                -- 커서로부터 데이터를 읽어와서 로컬변수(VDEPT(레코드타입))에 저장한다.
                EXIT WHEN C1%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME || ' / ' || VDEPT.LOC);
        END LOOP;
        CLOSE C1; -- 커서 닫기
END;
/
SET SERVEROUTPUT ON
EXECUTE CURSOR_SAMPLE01;

SELECT * FROM DEPT;

-- CURSOR 와 FOR LOOP
CREATE OR REPLACE PROCEDURE CURSOR_SAMPLE02
IS
        VDEPT DEPT%ROWTYPE;
        CURSOR C1 IS
                SELECT * FROM DEPT;
BEGIN
        DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
        DBMS_OUTPUT.PUT_LINE('----------------------------------');
        FOR VDEPT IN C1 LOOP -- 자동으로 실행돼
                EXIT WHEN C1%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME || ' / ' || VDEPT.LOC);
        END LOOP;
END;
/
EXECUTE CURSOR_SAMPLE02;

-- 단순 메세지를 출력하는 트리거(TRIGGER)
-- 1. 사원테이블 생성
DROP TABLE EMP01;
CREATE TABLE EMP01(
        EMPNO NUMBER(4) PRIMARY KEY,
        ENAME VARCHAR2(20),
        JOB VARCHAR2(20)
);        

-- 2. 트리거 작성
CREATE OR REPLACE TRIGGER TRG_01
        AFTER INSERT
        ON EMP01 -- EMP01에 삽입된 후에
BEGIN
        DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다.');
END;
/

-- 3. 사원테이블에 데이터 넣기
SET SERVEROUTPUT ON
INSERT INTO EMP01 VALUES(1, '쏘연', '100수');
-- 이걸 실행하는 순간 콘솔창에 지정해놓은 트리거(TRG_01)가 실행됨
SELECT * FROM EMP01;

-- 급여 정보를 자동으로 추가하는 트리거 작성하기
--1. 급여를 저장할 테이블을 생성한다.
DROP TABLE SAL01;
CREATE TABLE SAL01(
        SALNO NUMBER(4) PRIMARY KEY,
        SAL NUMBER(7,2),
        EMPNO NUMBER(4) REFERENCES EMP01(EMPNO)
);

--2. 급여번호를 자동 생성하는 시퀀스를 정의하고 이 시퀀스로부터 일련번호를 얻어 급여번호에 부여한다.
CREATE SEQUENCE SAL01_SALNO_SEQ; --  SALNO NUMBER(4) PRIMARY KEY를 위해 시퀀스 정의

--3. 트리거 생성한다.
CREATE OR REPLACE TRIGGER TRG_02
        AFTER INSERT
        ON EMP01 -- EMP01에 데이터를 넣은 후에
        FOR EACH ROW
BEGIN
        INSERT INTO SAL01 VALUES(SAL01_SALNO_SEQ.NEXTVAL, 100, :NEW.EMPNO);
        -- :NEW.EMPNO : 새로 들어온 레코드를 의미(새로 입력된 (ROW)데이터를 의미)
        -- :NEW -> EMP01에 새로 들어온 데이터
        -- :OLD -> 이전 ROW(데이터)를 의미
END;
/
--4. 사원 테이블에 로우를 추가합니다
INSERT INTO EMP01 VALUES(2, '전수빈', '프로그래머');
SELECT * FROM EMP01;
SELECT * FROM SAL01;

INSERT INTO EMP01 VALUES(3, '김종현', '교수');
SELECT * FROM EMP01;
SELECT * FROM SAL01;

INSERT INTO EMP01 VALUES(4, '찌오', '100수');
SELECT * FROM EMP01;
SELECT * FROM SAL01;

-- 급여 정보를 자동으로 삭제하는 트리거
-- 1. 사원 테이블의 로우를 삭제한다.
DELETE FROM EMP01 WHERE EMPNO=2; 
-- SQL Error 발생한다. SAL01에서 참조하고 있기 때문에 마음대로 지울수 없다.

-- 2. 트리거를 작성한다.
CREATE OR REPLACE TRIGGER TRG_03
        AFTER DELETE ON EMP01
        FOR EACH ROW
BEGIN
        DELETE FROM SAL01 
        WHERE EMPNO=:old.EMPNO; -- SAL01의 EMPNO가 OLD면
END;
/
-- 3. 사원 테이블의 로우를 삭제한다.
DELETE FROM EMP01 WHERE EMPNO=2;

SELECT * FROM EMP01;
SELECT * FROM SAL01;

-- 부서 번호를 전달하여 해당 부서 소속 사원의 정보를 출력하는 SEL_EMP 프로시저를 커서를 사용하여 작성하라.
SELECT * FROM EMP;

CREATE OR REPLACE PROCEDURE SEL_EMP(VDEPTNO EMP.DEPTNO%TYPE) -- 넣을 값 있을때 여기다가 지정해줌
IS
        VEMP EMP%ROWTYPE;
        CURSOR C1 IS
                SELECT *
                FROM EMP
                WHERE DEPTNO = VDEPTNO;
BEGIN
        DBMS_OUTPUT.PUT_LINE('사원번호 / 사원명 / 직급 / 급여');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
        FOR VEMP IN C1 LOOP -- 자동으로 실행돼
                EXIT WHEN C1%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO || ' ' || VEMP.ENAME || ' ' || VEMP.JOB || ' ' || VEMP.SAL);
        END LOOP;
END;
/
EXECUTE SEL_EMP(20);

-- 패키지
CREATE OR REPLACE PACKAGE EXAM_PACK IS
        FUNCTION CAL_BONUS(VEMPNO IN EMP.EMPNO%TYPE)
                RETURN NUMBER;
        PROCEDURE CURSOR_SAMPLE02;
END;
/

CREATE OR REPLACE PACKAGE BODY EXAM_PACK IS
        FUNCTION CAL_BONUS(VEMPNO IN EMP.EMPNO%TYPE )
                RETURN NUMBER
        IS
                VSAL NUMBER(7, 2);
        BEGIN
                SELECT SAL INTO VSAL
                FROM EMP
                WHERE EMPNO = VEMPNO;
                RETURN (VSAL * 200);
        END;
        PROCEDURE CURSOR_SAMPLE02
        IS
                VDEPT DEPT%ROWTYPE;
                CURSOR C1
                        IS
                        SELECT * FROM DEPT;
        BEGIN
                DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
                DBMS_OUTPUT.PUT_LINE('-----------------------');
                FOR VDEPT IN C1 LOOP
                        EXIT WHEN C1%NOTFOUND;
                        DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO||
                        ' '||VDEPT.DNAME||' '||VDEPT.LOC);
                END LOOP;
        END;
END;
/

-- 패키지 실행
VARIABLE VAR_RES NUMBER;
EXECUTE :VAR_RES := EXAM_PACK.CAL_BONUS(7369);
PRINT VAR_RES;

EXECUTE EXAM_PACK.CURSOR_SAMPLE02;

SELECT * FROM EMP;