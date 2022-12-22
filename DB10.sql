SELECT * FROM DUAL; -- 스키마 안써줌 -> 동의어를 사용한 경우
SELECT * FROM SYS.DUAL;

SELECT * FROM SYSTBL; -- 동의어 생성전이라 뜨지 않아
SELECT * FROM SYSTEM.SYSTBL; -- SYSTEM에서 SYSTBL의 권한을 SCOTT에게 부여(부여안하면 못봐)

-- 동의어 생성하기
CREATE SYNONYM SYSTBL FOR SYSTEM.SYSTBL; -- SYSTEM에서 동의어 생성 권한 부여받아서 사용가능
--  SYSTEM.SYSTBL -> SYSTBL 로 동의어 생성
SELECT * FROM SYSTBL; -- 사용가능

-- PL/SQL : PROCEDURE LANGUAGE EXTENTION TO SQL
SET SERVEROUTPUT ON -- 출력해 주는 내용을 화면에 보여주도록 설정한다,

BEGIN
        DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
        --  DBMS_OUTPUT : 패키지(클래스느낌) PUT_LINE : 스토어 FUNCTION(함수느낌)
END;
/

-- 변수 사용하기
DECLARE
        -- 선언부에는 변수를 선언
        VEMPNO NUMBER(4);
        VENAME VARCHAR2(10);
BEGIN
        -- 실행부에는 실행문 작성
        VEMPNO := 7788;
        VENAME := 'SCOTT';
        DBMS_OUTPUT.PUT_LINE('사번 / 이름');
        DBMS_OUTPUT.PUT_LINE('----------------');
        DBMS_OUTPUT.PUT_LINE(VEMPNO || '/' || VENAME);
END;
/

-- 사번과 이름 검색하기
SELECT * FROM EMP;
DESC EMP;

DECLARE
        VEMPNO EMP.EMPNO%TYPE;
        VENAME EMP.ENAME%TYPE;
BEGIN
        DBMS_OUTPUT.PUT_LINE('사번 / 이름');
        DBMS_OUTPUT.PUT_LINE('--------------');
        SELECT EMPNO, ENAME INTO VEMPNO, VENAME
        FROM EMP
        WHERE ENAME = 'SMITH';
        DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME);
END;
/

-- 테이블 타입 사용하기
DECLARE
        -- 테이블 타입을 정의 :배열타입과 유사함. 예) 자바인 경우 String[] ENAME와 같은 배열 타입
        TYPE ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE
            INDEX BY BINARY_INTEGER;
        TYPE JOB_TABLE_TYPE IS TABLE OF EMP.JOB%TYPE
            INDEX BY BINARY_INTEGER;
            
        -- 테이블 타입으로 변수 선언
        ENAME_TABLE ENAME_TABLE_TYPE;
        JOB_TABLE JOB_TABLE_TYPE;        
        I BINARY_INTEGER := 0;
        -- 변수 총 3개 선언함
BEGIN
        FOR K IN (SELECT ENAME, JOB FROM EMP) LOOP -- 'SELECT ENAME, JOB FROM EMP' 이 결과를 K에 담음
            I := I+1;
            ENAME_TABLE(I) := K.ENAME;
            JOB_TABLE(I) := K.JOB;
        END LOOP;
        
        FOR J IN 1..I LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(ENAME_TABLE(J),12) || ' / ' || RPAD(JOB_TABLE(J),9));
        END LOOP;
END;
/

--레코드 타입 사용하기
DECLARE
        -- 레코드 타입을 정의 : 자바의 클래스 타입(다른 타입의 필드)과 같은 개념
        TYPE EMP_RECORD_TYPE IS RECORD(
            V_EMPNO EMP.EMPNO%TYPE,
            V_ENAME EMP.ENAME%TYPE,
            V_JOB EMP.JOB%TYPE,
            V_DEPTNO EMP.DEPTNO%TYPE);
            -- 변수마다 타입들이 각각 다름
            
        -- 레코드로 변수 선언
        EMP_RECORD EMP_RECORD_TYPE;
BEGIN
        SELECT EMPNO, ENAME, JOB, DEPTNO INTO EMP_RECORD
        FROM EMP
        WHERE ENAME=UPPER('smith'); -- 소문자 대분자로 바꿔줘
        -- 출력
        DBMS_OUTPUT.PUT_LINE('사원번호 : ' || TO_CHAR(EMP_RECORD.V_EMPNO));
        DBMS_OUTPUT.PUT_LINE('이       름 : ' || EMP_RECORD.V_ENAME);
        DBMS_OUTPUT.PUT_LINE('담당업무 : ' || EMP_RECORD.V_JOB);
        DBMS_OUTPUT.PUT_LINE('부서번호 : ' || EMP_RECORD.V_DEPTNO);
END;
/

-- IF ~ THEN ~ END IF
SELECT * FROM EMP;
DECLARE
        VEMPNO NUMBER(4);
        VENAME VARCHAR(20);
        VDEPTNO EMP.DEPTNO%TYPE;
        VDNAME VARCHAR2(20) := NULL;
BEGIN
        SELECT EMPNO, ENAME, DEPTNO INTO VEMPNO, VENAME, VDEPTNO
        FROM EMP
        WHERE EMPNO=7654;
        
        IF (VDEPTNO = 10) THEN
            VDNAME := 'ACCOUNTING';
        END IF;
        IF (VDEPTNO = 20) THEN
            VDNAME := 'SALES';
        END IF;
        IF (VDEPTNO = 40) THEN
            VDNAME := 'OPERATIONS';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('사번     이름     부서명');
        DBMS_OUTPUT.PUT_LINE(VEMPNO || '    ' || VENAME || '    ' || VDEPTNO);
END;
/

-- IF ~ THEN ~ ELESIF ~ ELSE ~ END IF
DECLARE
        VEMP EMP%ROWTYPE; -- 참조형 RECORD타입
        VDNAME VARCHAR2(14);
BEGIN
        DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 부서명');
        DBMS_OUTPUT.PUT_LINE('-------------------------');
        SELECT * INTO VEMP
        FROM EMP
        WHERE ENAME='SMITH';
        
        IF(VEMP.DEPTNO = 10) THEN 
            VDNAME := 'ACCOUNTING';
        ELSIF (VEMP.DEPTNO = 20) THEN
            VDNAME := 'RESEARCH'; 
        ELSIF (VEMP.DEPTNO = 30) THEN
            VDNAME := 'SALES';
        ELSE
            VDNAME := 'OPERATIONS';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO||'/'||VEMP.ENAME||'/'||VDNAME);
END;
/

-- LOOP ~ END LOOP
DECLARE
        N NUMBER := 1;
BEGIN
        LOOP
            DBMS_OUTPUT.PUT_LINE(N);
            N := N+1;
            IF N > 5 THEN
                EXIT;
            END IF;   
        END LOOP;
END;
/

-- FOR LOOP
DECLARE
BEGIN
        FOR N IN 1..5 LOOP -- 1부터 5까지
            DBMS_OUTPUT.PUT_LINE(N);
        END LOOP;
END;
/

-- WHILE LOOP
DECLARE
        N NUMBER := 1;
BEGIN
        WHILE N <= 5 LOOP
            DBMS_OUTPUT.PUT_LINE(N);
            N := N+1;
        END LOOP;
END;
/

-- 저장 프로시저(STORED PROCEDURE) 생성하기
DROP TABLE EMP01;
CREATE TABLE EMP01
AS
SELECT * FROM EMP;

SELECT * FROM EMP01;

CREATE OR REPLACE PROCEDURE DEL_ALL
IS
BEGIN
        DELETE FROM EMP01;        
END;
/
SHOW ERROR; -- 에러 났을때 구체적으로 알려줌

-- 저장 프로시저 실행
EXECUTE DEL_ALL;

-- 저장 프로시저 조회하기
SELECT NAME, TEXT FROM USER_SOURCE;

-- 매개변수 저장 프로시저
DROP TABLE EMP01;
CREATE TABLE EMP01
AS
SELECT * FROM EMP;
SELECT * FROM EMP01;

CREATE OR REPLACE PROCEDURE DEL_ENAME(VENAME EMP01.ENAME%TYPE)
IS
BEGIN
        DELETE FROM EMP01
        WHERE ENAME = VENAME;        
END;
/
SELECT * FROM EMP01;
EXECUTE DEL_ENAME('SMITH');

-- IN, OUT, INOUT 매개변수
DROP PROCEDURE SEL_EMPNO;
CREATE OR REPLACE PROCEDURE SEL_EMPNO
        ( VEMPNO IN EMP.EMPNO%TYPE,
        VENAME OUT EMP.ENAME%TYPE,
        VSAL OUT EMP.SAL%TYPE,
        VJOB OUT EMP.JOB%TYPE
        )
IS
BEGIN
        SELECT ENAME, SAL, JOB INTO VENAME, VSAL, VJOB
        FROM EMP
        WHERE EMPNO=VEMPNO;
END;
/

-- 바인드 변수
-- ':'를 덧붙여주는 변수는 미리 선언되어 있어야 한다.
VARIABLE VAR_ENAME VARCHAR2(15);
VARIABLE VAR_SAL NUMBER;
VARIABLE VAR_JOB VARCHAR2(9);

-- OUT 매개변수에서 값을 받아오기 위해서는 프로시저 호출 시 변수 앞에 ':'를 덧붙인다.
EXECUTE SEL_EMPNO(7654, :VAR_ENAME, :VAR_SAL, :VAR_JOB);
PRINT VAR_ENAME;
PRINT VAR_SAL;
PRINT VAR_JOB;
SELECT ENAME, SAL FROM EMP
WHERE EMPNO=7654;


-- 사원명으로 검색하여 해당 사원의 직급을 얻어 오는 저장 프로시저를 SEL_EMPNAME라는 이름으로 작성하라.
SELECT * FROM EMP;
CREATE OR REPLACE PROCEDURE  SEL_EMPNAME(
        VENAME IN EMP.ENAME%TYPE,
        VJOB OUT EMP.JOB%TYPE
        )
IS
BEGIN
        SELECT JOB INTO  VJOB
        FROM EMP
        WHERE ENAME=VENAME;
END;
/
VARIABLE VAR_JOB VARCHAR2(9);

EXECUTE SEL_EMPNAME('SMITH', :VAR_JOB);
PRINT VAR_JOB;

SELECT JOB FROM EMP
WHERE ENAME = 'SMITH';

