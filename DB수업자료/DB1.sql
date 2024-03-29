-- DQL(Data Query Language) : SELECT문
SELECT * FROM DEPT;
SELECT DEPTNO, DNAME FROM DEPT;

-- DML(Data Manupulation Language, 데이터 조작어) : INSERT, UPDATE, DELETE
INSERT INTO DEPT VALUES (60 ,'총무부', '서울');
UPDATE DEPT SET LOC='뷰산' WHERE DNAME='총무부'; -- DNAME이 '총무부'인 경우에만 '부산'으로 바꿔주세요!
DELETE FROM DEPT WHERE DEPTNO=60; -- WHERE : 조건

-- DDL(Data Definition Language, 데이터 정의어) : CREATE, ALTER, DROP, RENAME, TRUNCATE
DESC DEPT01;
DROP TABLE DEPT01;
CREATE TABLE DEPT01(
    DEPTNO NUMBER(4),
    DNAME VARCHAR2(10),
    LOC VARCHAR2(9)
);
SELECT * FROM DEPT02;
INSERT INTO DEPT02 VALUES(10, '개발부', '서울');

ALTER TABLE DEPT01
MODIFY(DNAME VARCHAR2(30));

RENAME DEPT01 TO DEPT02;
DESC DEPT02;

TRUNCATE TABLE DEPT02; -- TRUNCATE = DELETE + COMMIT

-- ORACLE NULL : 값이 미확정(모르는 값)
-- 3 + NULL(?) = ?
SELECT * FROM EMP;
SELECT SAL, COMM, SAL*12+COMM AS"연봉" FROM EMP; -- 연봉구하기(COMM안에 NULL때문에 안됨)

-- 이렇게 NVL(NULL VALUE) 함수를 사용해서 NULL값을 지정(0또는 다른값)해서 출력하기
SELECT SAL, COMM, SAL*12+NVL(COMM,0) "연봉" FROM EMP; 

-- || (Concatenation, 연결자)
SELECT ENAME, JOB FROM EMP;
SELECT ENAME || 'IS A' || JOB FROM EMP;

-- DISTINCT 키워드 : 동일한 값을 한번만 출력해 준다.
SELECT * FROM EMP; -- 중복이고 뭐고 다 출력돼
SELECT DISTINCT DEPTNO FROM EMP; -- 중복 제거

-- SELECT문에서 WHERE 조건
SELECT * FROM EMP
WHERE SAL >= 3000; -- SAL이 조건에 맞으면 출력됨

SELECT EMPNO, ENAME, SAL FROM EMP
WHERE SAL != 3000; -- 자바는 이거!
-- WHERE SAL <> 3000;
-- WHERE SAL ^= 3000; 다 동일한 표현 (다르다)

-- 문자 데이터 조회
DESC EMP;
SELECT EMPNO, ENAME "이름", SAL -- AS"이름" 같은거
FROM EMP
WHERE ENAME = 'FORD'; -- " " 이거 절대 안돼 주의!!, 그리고 대소문자 구분하니까 주의

-- 날짜 데이터 조회
SELECT * FROM EMP
WHERE HIREDATE<= '82/01/01'; -- 82년 1월 1일 전에 입사한 사람들은?

-- 논리 연산자 : AND, OR, NOT
SELECT * FROM EMP
WHERE DEPTNO= 10 AND JOB= 'MANAGER'; -- 부서 '10'의 '매니저'는 ㄴㄱ?

SELECT * FROM EMP
WHERE DEPTNO= 10 OR JOB= 'MANAGER';

SELECT * FROM EMP
-- WHERE NOT DEPTNO= 10;
WHERE DEPTNO != 10;

-- BETWEEN AND 연산자
SELECT *
FROM EMP
-- WHERE SAL>=2000 AND SAL<=3000; -- 2000 <= SAL <= 3000
WHERE SAL BETWEEN 2000 AND 3000; -- 2000 <= SAL <= 3000

SELECT *
FROM EMP
WHERE HIREDATE BETWEEN '1987/01/01' AND '1987/12/31'; -- 1987/01/01 ~ 1987/12/31에 입사한 사람?

-- IN 연산자
SELECT *
FROM EMP
WHERE COMM=300 OR COMM=500 OR COMM=1400; -- 너무 길어;;

SELECT *
FROM EMP
WHERE COMM IN (300, 500, 1400); -- 해당조건이 IN() 괄호안에 있닝?

-- 반대조건
SELECT *
FROM EMP
WHERE COMM<>300 AND COMM<>500 AND COMM<>1400; -- 해당 조건 다 아닌사람

SELECT *
FROM EMP
WHERE COMM NOT IN (300, 500, 1400); -- 훨씬 간단하고 깔끔 

-- LIKE 연산자와 와일드카드(%, _)
SELECT *
FROM EMP
WHERE ENAME LIKE 'F%'; -- F로 시작하는 문자열 죄다 찾기
 
 SELECT *
 FROM EMP
 WHERE ENAME LIKE '%A%'; -- 앞뒤 아무곳이나 A 들어간느 문자열 죄다 찾기
 
 SELECT *
 FROM EMP
 WHERE ENAME LIKE '%N'; -- 뒤에 N으로 끝나는 문자열 찾아줭
 
 SELECT *
 FROM EMP
 WHERE ENAME LIKE '_A%'; -- 두번째로 A가 오는 문자열 찾아주세요
 
 SELECT *
 FROM EMP
 WHERE ENAME LIKE '__A%'; -- 세번째로 A오는~~
 
 SELECT *
 FROM EMP
 WHERE ENAME NOT LIKE '%A%'; -- 앞뒤에 A가 들어가 있지 않은..
 
 -- NULL을 위한 연산자
 SELECT *
 FROM EMP
--  WHERE COMM=NULL; 잘못된 표현 (COMM이 NULL이다 이거잖아;;)
 -- WHERE COMM IS NULL; -- NULL인거 출력해줘~
 WHERE COMM IS NOT NULL; -- NULL이 아닌거 출력
 
 -- 정렬을 위한 ORDER BY 절
 SELECT *
 FROM EMP
-- ORDER BY SAL ASC; -- SAL 기준으로 오름차순
ORDER BY SAL DESC; -- SAL 기준으로 내림차순

SELECT *
FROM EMP
ORDER BY ENAME;

SELECT *
FROM EMP
ORDER BY HIREDATE DESC;

SELECT *
FROM EMP
ORDER BY SAL DESC, ENAME ASC; -- SAL 은 내림차순 ㄱㄱ 그담 ENAME 은 오름차순으로 ㄱㄱ
 
 
 -- 1. 사원 테이블(EMP)에서 가장 최근에 입사한 사원부터 출력하되, 동일한 입사일인 경우에는 
 -- 사원번호(EMPNO)를 기준으로 오름차순으로 정렬해서 출력하는 SQL문을 작성하세요?
SELECT *
FROM EMP
ORDER BY HIREDATE DESC, EMPNO ASC;
 
 -- 2. 와일드 카드를 사용하여 사원중에서 이름이 K로 시작하는 사원의 사원번호와 이름을 출력하세요?
SELECT  EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE 'K%';
 
 -- 3. 와일드 카드를 사용하여 이름중에서 K를 포함하는 사원의 사원번호와 이름을 출력 하세요?
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '%K%';
 
 -- 4. 와일드 카드를 사용하여 이름중에서 끝에서 두번째 글자가 K로 끝나는 사원의 사원번호와 이름을 출력 하세요?
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '%K_';
 
 
 -- 05장
-- DUAL 테이블은 산술연산의 결과를 한줄로 표현하기 위해 사용
SELECT * FROM DUAL;
SELECT 24*60 FROM DEPT;
SELECT 24*60 FROM DUAL;
SELECT SYSDATE FROM DUAL;

-- 숫자 함수
-- ABS 함수 : 절대값 구하기
SELECT -10, ABS(-10) FROM DUAL; -- 절대값
SELECT 34.5678, FLOOR(34.5678) FROM DUAL; -- 버림
SELECT 34.5678, ROUND(34.5678) FROM DUAL; -- 반올림
SELECT 34.5678, ROUND(34.5678, 2) FROM DUAL; -- 특정자리수 반올림(1)
SELECT 34.5678, ROUND(34.5678, -1) FROM DUAL; -- 특정자리수 반올림(2)
SELECT TRUNC (34.5678, 2), TRUNC(34.5678, -1), TRUNC(34.5678) FROM DUAL; 
-- TRUNC()는 특정 자리수 버림. FLOOR()은 자릿수 개념 아니고 걍 실수 버려
SELECT MOD(27, 2), MOD(27, 5), MOD(27, 7) FROM DUAL; -- 나머지 구하는 MOD()함수

-- 대소문자
SELECT 'Welcome to Oralcle', UPPER('Welcome to Oralcle') FROM DUAL;
SELECT 'Welcome to Oralcle', LOWER('Welcome to Oralcle') FROM DUAL; 
SELECT 'WELCOME TO CANADA', INITCAP('WELCOME TO CANADA') FROM DUAL; -- 앞문자만 대문자로

-- 문자열
SELECT LENGTH('ORACLE'), LENGTH('오라클') FROM DUAL;
SELECT LENGTHB('ORACLE'), LENGTHB('오라클') FROM DUAL; -- BYTE로 계산 알파벳 : 1, 한글 : 3으로 계산 UTF-8(가변문자셋)
SELECT SUBSTR('WELCOME TO ORACLE', 4, 3) FROM DUAL; -- 4번째부터 3글자 추출
SELECT INSTR('WELCOME TO ORACLE', 'O') FROM DUAL; -- O가 위치간 번호는?
SELECT INSTR('데이터베이스', '이', 3, 1), INSTRB('데이터베이스', '이', 3, 1) FROM DUAL; 
-- 3번째부터 시작해서 첫번째로 니오는 '이' 찾아줘, 뒤에꺼는 바이트로 계산해서 출력

-- 여백추가 함수 : LPAD(Left Padding), RPAD(Right Padding)
SELECT LPAD('ORACLE', '20', '#') FROM DUAL;
SELECT RPAD('ORACLE', '20', '#') FROM DUAL;

-- 여백삭제 함수: LTRIM, RTRIM
SELECT LTRIM('   ORACLE   ') FROM DUAL;
SELECT RTRIM('   ORACLE   ') FROM DUAL;
SELECT TRIM('A' FROM 'AAAAAAORACLE') FROM DUAL; -- A 다 잘라버려!

-- 날짜 함수 : SYSDATE
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE-1 "어제", SYSDATE 오늘, SYSDATE+1 내일 FROM DUAL;

-- 반올림 함수 : ROUND
SELECT HIREDATE, ROUND(HIREDATE, 'MONTH') FROM EMP;

-- 형변환 함수 : TO_CHAR, TO_DATE, TO_NUMBER
-- 날짜형을 문자형으로 변환하기 : TO_CHAR
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')"문자형" FROM DUAL; -- SYSDATE 타입 -> CHAR타입

-- 숫자형을 문자형으로 변환하기 : TO_CHAR
SELECT TO_CHAR(123456, '0000000000'), TO_CHAR(123456, '999,999,999') FROM DUAL;

-- 날짜형으로 변환하기 : TO_DATE
-- NUMBER -> DATE
SELECT ENAME, HIREDATE FROM EMP
WHERE HIREDATE=TO_DATE(19810220, 'YYYYMMDD');
-- CHAR->DATE
SELECT TRUNC(SYSDATE - TO_DATE('2022-11-02', 'YYYY-MM-DD')) FROM DUAL; -- 오늘 날짜 - (조건 날짜(문자) -> 날짜로 변환) = 출력

-- 숫자형으로 변환하기 : TO_NUMBER
-- CHAR -> NUMBER
SELECT TO_NUMBER('20,000', '99,999') - TO_NUMBER('10,000', '99,999') FROM DUAL;

CREATE TABLE TESTTIME (
    REGDATE DATE
);
SELECT * FROM TESTTIME;
DESC TESTTIME;
INSERT INTO TESTTIME VALUES ('2022/12/13'); -- 문자는 가능
INSERT INTO TESTTIME VALUES (20221213); -- 숫자는 안들어가져
INSERT INTO TESTTIME VALUES (SYSDATE); -- 당연히 되고
SELECT * FROM TESTTIME;
SELECT TO_CHAR(REGDATE, 'YYYY-MM-DD HH24:MM:SS') FROM TESTTIME;

-- NULL을 다른 값으로 변환하기 : NVL
SELECT ENAME, SAL, COMM, SAL*12+COMM, NVL(COMM,0), SAL*12+NVL(COMM,0)
FROM EMP;

-- DECODE : JAVA의 SWITCH문과 같다.
SELECT ENAME, DEPTNO, DECODE(DEPTNO, 10, 'ACCOUNT',
                                                                                            20, 'RESEARCH',
                                                                                            30, 'SALES',
                                                                                            40, 'OPERATIONS') AS DNAME
FROM EMP;

-- CASE WHEN : IF-ELSE문과 유사
SELECT
    ENAME,
    DEPTNO,
    CASE
        WHEN deptno = 10 THEN
            'ACCOUNTING'
        WHEN deptno = 20 THEN
            'RESEARCH'
        WHEN deptno = 30 THEN
            'SALES'
        WHEN deptno = 40 THEN
            'OPERATIONS'
    END AS DNAME
FROM
    EMP;

-- 1. 사원테이블(EMP)에서 입사일(HIREDATE)을 4자리 연도로 출력되도록 SQL문을 작성하세요? (ex. 1980/01/01)
SELECT ENAME, TO_CHAR(HIREDATE , 'YYYY')"입사연도"
FROM EMP
ORDER BY "입사연도" ASC;

-- 2. 사원테이블(EMP)에서 MGR컬럼의 값이 null 인 데이터의 MGR의 값을 CEO로 출력하는 SQL문을 작성 하세요?
SELECT MGR, NVL(TO_CHAR(MGR), 'CEO')"CEO찾기"
FROM EMP;


