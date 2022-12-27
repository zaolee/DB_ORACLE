-- DQL(Data Query Language) : SELECT��
SELECT * FROM DEPT;
SELECT DEPTNO, DNAME FROM DEPT;

-- DML(Data Manupulation Language, ������ ���۾�) : INSERT, UPDATE, DELETE
INSERT INTO DEPT VALUES (60 ,'�ѹ���', '����');
UPDATE DEPT SET LOC='���' WHERE DNAME='�ѹ���'; -- DNAME�� '�ѹ���'�� ��쿡�� '�λ�'���� �ٲ��ּ���!
DELETE FROM DEPT WHERE DEPTNO=60; -- WHERE : ����

-- DDL(Data Definition Language, ������ ���Ǿ�) : CREATE, ALTER, DROP, RENAME, TRUNCATE
DESC DEPT01;
DROP TABLE DEPT01;
CREATE TABLE DEPT01(
    DEPTNO NUMBER(4),
    DNAME VARCHAR2(10),
    LOC VARCHAR2(9)
);
SELECT * FROM DEPT02;
INSERT INTO DEPT02 VALUES(10, '���ߺ�', '����');

ALTER TABLE DEPT01
MODIFY(DNAME VARCHAR2(30));

RENAME DEPT01 TO DEPT02;
DESC DEPT02;

TRUNCATE TABLE DEPT02; -- TRUNCATE = DELETE + COMMIT

-- ORACLE NULL : ���� ��Ȯ��(�𸣴� ��)
-- 3 + NULL(?) = ?
SELECT * FROM EMP;
SELECT SAL, COMM, SAL*12+COMM AS"����" FROM EMP; -- �������ϱ�(COMM�ȿ� NULL������ �ȵ�)

-- �̷��� NVL(NULL VALUE) �Լ��� ����ؼ� NULL���� ����(0�Ǵ� �ٸ���)�ؼ� ����ϱ�
SELECT SAL, COMM, SAL*12+NVL(COMM,0) "����" FROM EMP; 

-- || (Concatenation, ������)
SELECT ENAME, JOB FROM EMP;
SELECT ENAME || 'IS A' || JOB FROM EMP;

-- DISTINCT Ű���� : ������ ���� �ѹ��� ����� �ش�.
SELECT * FROM EMP; -- �ߺ��̰� ���� �� ��µ�
SELECT DISTINCT DEPTNO FROM EMP; -- �ߺ� ����

-- SELECT������ WHERE ����
SELECT * FROM EMP
WHERE SAL >= 3000; -- SAL�� ���ǿ� ������ ��µ�

SELECT EMPNO, ENAME, SAL FROM EMP
WHERE SAL != 3000; -- �ڹٴ� �̰�!
-- WHERE SAL <> 3000;
-- WHERE SAL ^= 3000; �� ������ ǥ�� (�ٸ���)

-- ���� ������ ��ȸ
DESC EMP;
SELECT EMPNO, ENAME "�̸�", SAL -- AS"�̸�" ������
FROM EMP
WHERE ENAME = 'FORD'; -- " " �̰� ���� �ȵ� ����!!, �׸��� ��ҹ��� �����ϴϱ� ����

-- ��¥ ������ ��ȸ
SELECT * FROM EMP
WHERE HIREDATE<= '82/01/01'; -- 82�� 1�� 1�� ���� �Ի��� �������?

-- �� ������ : AND, OR, NOT
SELECT * FROM EMP
WHERE DEPTNO= 10 AND JOB= 'MANAGER'; -- �μ� '10'�� '�Ŵ���'�� ����?

SELECT * FROM EMP
WHERE DEPTNO= 10 OR JOB= 'MANAGER';

SELECT * FROM EMP
-- WHERE NOT DEPTNO= 10;
WHERE DEPTNO != 10;

-- BETWEEN AND ������
SELECT *
FROM EMP
-- WHERE SAL>=2000 AND SAL<=3000; -- 2000 <= SAL <= 3000
WHERE SAL BETWEEN 2000 AND 3000; -- 2000 <= SAL <= 3000

SELECT *
FROM EMP
WHERE HIREDATE BETWEEN '1987/01/01' AND '1987/12/31'; -- 1987/01/01 ~ 1987/12/31�� �Ի��� ���?

-- IN ������
SELECT *
FROM EMP
WHERE COMM=300 OR COMM=500 OR COMM=1400; -- �ʹ� ���;;

SELECT *
FROM EMP
WHERE COMM IN (300, 500, 1400); -- �ش������� IN() ��ȣ�ȿ� �ִ�?

-- �ݴ�����
SELECT *
FROM EMP
WHERE COMM<>300 AND COMM<>500 AND COMM<>1400; -- �ش� ���� �� �ƴѻ��

SELECT *
FROM EMP
WHERE COMM NOT IN (300, 500, 1400); -- �ξ� �����ϰ� ��� 

-- LIKE �����ڿ� ���ϵ�ī��(%, _)
SELECT *
FROM EMP
WHERE ENAME LIKE 'F%'; -- F�� �����ϴ� ���ڿ� �˴� ã��
 
 SELECT *
 FROM EMP
 WHERE ENAME LIKE '%A%'; -- �յ� �ƹ����̳� A ���� ���ڿ� �˴� ã��
 
 SELECT *
 FROM EMP
 WHERE ENAME LIKE '%N'; -- �ڿ� N���� ������ ���ڿ� ã�Ƣa
 
 SELECT *
 FROM EMP
 WHERE ENAME LIKE '_A%'; -- �ι�°�� A�� ���� ���ڿ� ã���ּ���
 
 SELECT *
 FROM EMP
 WHERE ENAME LIKE '__A%'; -- ����°�� A����~~
 
 SELECT *
 FROM EMP
 WHERE ENAME NOT LIKE '%A%'; -- �յڿ� A�� �� ���� ����..
 
 -- NULL�� ���� ������
 SELECT *
 FROM EMP
--  WHERE COMM=NULL; �߸��� ǥ�� (COMM�� NULL�̴� �̰��ݾ�;;)
 -- WHERE COMM IS NULL; -- NULL�ΰ� �������~
 WHERE COMM IS NOT NULL; -- NULL�� �ƴѰ� ���
 
 -- ������ ���� ORDER BY ��
 SELECT *
 FROM EMP
-- ORDER BY SAL ASC; -- SAL �������� ��������
ORDER BY SAL DESC; -- SAL �������� ��������

SELECT *
FROM EMP
ORDER BY ENAME;

SELECT *
FROM EMP
ORDER BY HIREDATE DESC;

SELECT *
FROM EMP
ORDER BY SAL DESC, ENAME ASC; -- SAL �� �������� ���� �״� ENAME �� ������������ ����
 
 
 -- 1. ��� ���̺�(EMP)���� ���� �ֱٿ� �Ի��� ������� ����ϵ�, ������ �Ի����� ��쿡�� 
 -- �����ȣ(EMPNO)�� �������� ������������ �����ؼ� ����ϴ� SQL���� �ۼ��ϼ���?
SELECT *
FROM EMP
ORDER BY HIREDATE DESC, EMPNO ASC;
 
 -- 2. ���ϵ� ī�带 ����Ͽ� ����߿��� �̸��� K�� �����ϴ� ����� �����ȣ�� �̸��� ����ϼ���?
SELECT  EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE 'K%';
 
 -- 3. ���ϵ� ī�带 ����Ͽ� �̸��߿��� K�� �����ϴ� ����� �����ȣ�� �̸��� ��� �ϼ���?
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '%K%';
 
 -- 4. ���ϵ� ī�带 ����Ͽ� �̸��߿��� ������ �ι�° ���ڰ� K�� ������ ����� �����ȣ�� �̸��� ��� �ϼ���?
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '%K_';
 
 
 -- 05��
-- DUAL ���̺��� ��������� ����� ���ٷ� ǥ���ϱ� ���� ���
SELECT * FROM DUAL;
SELECT 24*60 FROM DEPT;
SELECT 24*60 FROM DUAL;
SELECT SYSDATE FROM DUAL;

-- ���� �Լ�
-- ABS �Լ� : ���밪 ���ϱ�
SELECT -10, ABS(-10) FROM DUAL; -- ���밪
SELECT 34.5678, FLOOR(34.5678) FROM DUAL; -- ����
SELECT 34.5678, ROUND(34.5678) FROM DUAL; -- �ݿø�
SELECT 34.5678, ROUND(34.5678, 2) FROM DUAL; -- Ư���ڸ��� �ݿø�(1)
SELECT 34.5678, ROUND(34.5678, -1) FROM DUAL; -- Ư���ڸ��� �ݿø�(2)
SELECT TRUNC (34.5678, 2), TRUNC(34.5678, -1), TRUNC(34.5678) FROM DUAL; 
-- TRUNC()�� Ư�� �ڸ��� ����. FLOOR()�� �ڸ��� ���� �ƴϰ� �� �Ǽ� ����
SELECT MOD(27, 2), MOD(27, 5), MOD(27, 7) FROM DUAL; -- ������ ���ϴ� MOD()�Լ�

-- ��ҹ���
SELECT 'Welcome to Oralcle', UPPER('Welcome to Oralcle') FROM DUAL;
SELECT 'Welcome to Oralcle', LOWER('Welcome to Oralcle') FROM DUAL; 
SELECT 'WELCOME TO CANADA', INITCAP('WELCOME TO CANADA') FROM DUAL; -- �չ��ڸ� �빮�ڷ�

-- ���ڿ�
SELECT LENGTH('ORACLE'), LENGTH('����Ŭ') FROM DUAL;
SELECT LENGTHB('ORACLE'), LENGTHB('����Ŭ') FROM DUAL; -- BYTE�� ��� ���ĺ� : 1, �ѱ� : 3���� ��� UTF-8(�������ڼ�)
SELECT SUBSTR('WELCOME TO ORACLE', 4, 3) FROM DUAL; -- 4��°���� 3���� ����
SELECT INSTR('WELCOME TO ORACLE', 'O') FROM DUAL; -- O�� ��ġ�� ��ȣ��?
SELECT INSTR('�����ͺ��̽�', '��', 3, 1), INSTRB('�����ͺ��̽�', '��', 3, 1) FROM DUAL; 
-- 3��°���� �����ؼ� ù��°�� �Ͽ��� '��' ã����, �ڿ����� ����Ʈ�� ����ؼ� ���

-- �����߰� �Լ� : LPAD(Left Padding), RPAD(Right Padding)
SELECT LPAD('ORACLE', '20', '#') FROM DUAL;
SELECT RPAD('ORACLE', '20', '#') FROM DUAL;

-- ������� �Լ�: LTRIM, RTRIM
SELECT LTRIM('   ORACLE   ') FROM DUAL;
SELECT RTRIM('   ORACLE   ') FROM DUAL;
SELECT TRIM('A' FROM 'AAAAAAORACLE') FROM DUAL; -- A �� �߶����!

-- ��¥ �Լ� : SYSDATE
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE-1 "����", SYSDATE ����, SYSDATE+1 ���� FROM DUAL;

-- �ݿø� �Լ� : ROUND
SELECT HIREDATE, ROUND(HIREDATE, 'MONTH') FROM EMP;

-- ����ȯ �Լ� : TO_CHAR, TO_DATE, TO_NUMBER
-- ��¥���� ���������� ��ȯ�ϱ� : TO_CHAR
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')"������" FROM DUAL; -- SYSDATE Ÿ�� -> CHARŸ��

-- �������� ���������� ��ȯ�ϱ� : TO_CHAR
SELECT TO_CHAR(123456, '0000000000'), TO_CHAR(123456, '999,999,999') FROM DUAL;

-- ��¥������ ��ȯ�ϱ� : TO_DATE
-- NUMBER -> DATE
SELECT ENAME, HIREDATE FROM EMP
WHERE HIREDATE=TO_DATE(19810220, 'YYYYMMDD');
-- CHAR->DATE
SELECT TRUNC(SYSDATE - TO_DATE('2022-11-02', 'YYYY-MM-DD')) FROM DUAL; -- ���� ��¥ - (���� ��¥(����) -> ��¥�� ��ȯ) = ���

-- ���������� ��ȯ�ϱ� : TO_NUMBER
-- CHAR -> NUMBER
SELECT TO_NUMBER('20,000', '99,999') - TO_NUMBER('10,000', '99,999') FROM DUAL;

CREATE TABLE TESTTIME (
    REGDATE DATE
);
SELECT * FROM TESTTIME;
DESC TESTTIME;
INSERT INTO TESTTIME VALUES ('2022/12/13'); -- ���ڴ� ����
INSERT INTO TESTTIME VALUES (20221213); -- ���ڴ� �ȵ���
INSERT INTO TESTTIME VALUES (SYSDATE); -- �翬�� �ǰ�
SELECT * FROM TESTTIME;
SELECT TO_CHAR(REGDATE, 'YYYY-MM-DD HH24:MM:SS') FROM TESTTIME;

-- NULL�� �ٸ� ������ ��ȯ�ϱ� : NVL
SELECT ENAME, SAL, COMM, SAL*12+COMM, NVL(COMM,0), SAL*12+NVL(COMM,0)
FROM EMP;

-- DECODE : JAVA�� SWITCH���� ����.
SELECT ENAME, DEPTNO, DECODE(DEPTNO, 10, 'ACCOUNT',
                                                                                            20, 'RESEARCH',
                                                                                            30, 'SALES',
                                                                                            40, 'OPERATIONS') AS DNAME
FROM EMP;

-- CASE WHEN : IF-ELSE���� ����
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

-- 1. ������̺�(EMP)���� �Ի���(HIREDATE)�� 4�ڸ� ������ ��µǵ��� SQL���� �ۼ��ϼ���? (ex. 1980/01/01)
SELECT ENAME, TO_CHAR(HIREDATE , 'YYYY')"�Ի翬��"
FROM EMP
ORDER BY "�Ի翬��" ASC;

-- 2. ������̺�(EMP)���� MGR�÷��� ���� null �� �������� MGR�� ���� CEO�� ����ϴ� SQL���� �ۼ� �ϼ���?
SELECT MGR, NVL(TO_CHAR(MGR), 'CEO')"CEOã��"
FROM EMP;


