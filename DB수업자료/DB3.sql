-- ORACLE OUTER JOIN
SELECT *
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+);

-- ANSI OUTER JOIN : ���ι��� ���ʿ� �ִ� ���̺��� ��� ����� ������ �� 
-- ������ ���̺� �����͸� ��Ī�ϰ�, ��Ī�Ǵ� �����Ͱ� ���� ��� NULL�� ǥ���Ѵ�.
SELECT *
FROM EMP E LEFT OUTER JOIN EMP M
ON E.MGR = M.EMPNO(+);

-- 08�� ��������
-- ��������
SELECT DNAME
FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO
                                        FROM EMP
                                        WHERE ENAME = 'SCOTT');
                                        
SELECT DNAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO AND
EMP.ENAME = 'SCOTT';

-- ������ ���� ����
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP); -- SELECT AVG(SAL) FROM EMP : ������ -> �񱳿����� ��� ����

-- ������ ���� ���� : IN, ANY, SOME, ALL, EXIST
-- IN ������ : ���������� ����߿��� �ϳ��� ��ġ�ϸ� ���̴�.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (SELECT DISTINCT DEPTNO -- ������ó�� �񱳿����� ��� ����.
        FROM EMP
        WHERE SAL >= 3000); -- ���� ���ǿ��� ���� ����� ����ϴ°�

-- ALL ������ : ���� ������ �� ������ ���� ������ �˻� ����� ��� ���� ��ġ�ϸ� ���̴�.
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL
        FROM EMP
        WHERE DEPTNO = 30); --()���� ���� �����߿� 2850���� ���� ���� �������(���� �� �������ִϱ�)
        
-- ANY ������ : ���� ������ �� ������ ���� ������ �˻� ����� �ϳ� �̻� ��ġ�ϸ� ���̴�.
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ANY(SELECT SAL -- ANY = OR ���� SAL > 1600 OR SAL > 1250 OR... SAL>950
        FROM EMP
        WHERE DEPTNO = 30); -- ������ �ϳ��� �����ص� �� �������
        
SELECT ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT SAL -- IN (= ����)
        FROM EMP
        WHERE DEPTNO = 30);        
        
-- EXISTS ������ : ���������� ��� ���� �ϳ� �̻� �����ϸ� ���� ���ǽ��� ��� TRUE,
-- �������� ������ ��� FALSE�� �Ǵ� �������̴�.
SELECT *
FROM EMP
WHERE 1=1; 

SELECT *
FROM EMP
WHERE EXISTS (SELECT DNAME
            FROM DEPT
            WHERE DEPTNO=10); -- ()���� ������ �� �̸� ��µǴ°�
            
-- 2. IN�����ڸ� �̿��Ͽ� �μ����� ���� ���� �޿��� �޴� ����� ����(�����ȣ,�����,�޿�,�μ���ȣ)�� ����ϴ� SQL���� �ۼ� �ϼ���?
SELECT *
FROM EMP;

SELECT EMPNO �����ȣ, ENAME �����, SAL �޿�, DEPTNO �μ���ȣ
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
        FROM EMP
        WHERE DEPTNO = 30
        UNION
        SELECT DISTINCT MAX(SAL)
        FROM EMP
        WHERE DEPTNO = 20
        UNION
        SELECT DISTINCT MAX(SAL)
        FROM EMP
        WHERE DEPTNO = 10); 
 
SELECT EMPNO �����ȣ, ENAME �����, SAL �޿�, DEPTNO �μ���ȣ
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
        FROM EMP
        GROUP BY DEPTNO);       

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE (DEPTNO, SAL) IN(
SELECT DEPTNO, MAX(SAL) -- ~�μ���ȣ�� MAX, �̷��� �ΰ� ���� �ɾ��ֱ�
FROM EMP
GROUP BY DEPTNO -- �׷캰�� ������ ��
);

UPDATE EMP SET SAL = 2850
WHERE ENAME = 'SMITH';

-- 09�� DDL : CREATE, ALTER, RENAME, TRUNCATE, DROP �����ͺ��̽� ����� ���
-- DML : INSERT, UPDATE, DELETE, SELECT : �ַ� ���
-- CREATE��
CREATE TABLE EX2_1(
        COLUMN1 CHAR(10),
        COLUMN2 VARCHAR2(10),
        COLUMN3 VARCHAR2(10),
        COULMN4 NUMBER
);
DESC EX2_1;
-- ���Ӱ� ���̺� �����ϱ�
CREATE TABLE EMP01 (
        EMPNO NUMBER(4),
        ENAME VARCHAR2(20),
        SAL NUMBER(7,2)
);
DESC EMP01;
SELECT * FROM EMP01;

-- ���� ������ ���̺� �����ϱ�(�������?)
CREATE TABLE EMP02
AS
SELECT * FROM EMP; -- �� ���� �׷��� �����ؼ� ����
DESC EMP02;

-- Ư���� �÷�(��)���� ������ ���� ���̺� �����ϱ�
CREATE TABLE EMP03
AS
SELECT EMPNO, ENAME FROM EMP; -- Ư�� �÷� ����
SELECT * FROM EMP03;

-- ���ϴ� ��(ROW)���� ������ ���� ���̺� �����ϱ�
CREATE TABLE EMP05
AS
SELECT * FROM EMP
WHERE DEPTNO = 10;
SELECT * FROM EMP05;

-- ���̺� ������ �����ϱ� (�����ʹ� ������ ������ ������)
CREATE TABLE EMP06
AS
SELECT * FROM EMP
WHERE 1=0; -- �̷��� ����(�����ʹ� �־����� �ʾ�)
SELECT * FROM EMP06;

-- ALTER TABLE
-- ADD : �߰�
DESC EMP01;

ALTER TABLE EMP01
ADD(JOB VARCHAR2(9)); -- �߰� ������

-- MODIFY : �Ӽ� ����
ALTER TABLE EMP01
MODIFY(JOB VARCHAR2(30)); -- 9 -> 30���� ����

-- DELETE : ����
ALTER TABLE EMP01
DROP COLUMN JOB; -- -> ����

-- SET UNUSESD
SELECT * FROM EMP02;
ALTER TABLE EMP02
SET UNUSED(JOB);

ALTER TABLE EMP02
DROP UNUSED COLUMNS;

-- DROP TABLE : ���̺� ����
DROP TABLE EMP01;
SELECT * FROM EMP01;
SELECT * FROM EMP02;
DROP TABLE EMP02;

SELECT * FROM EMP03; -- DML : DELETE -> �޸𸮿� �ִ°� ����(��ũ�� �ִ°� ����°� �Ƴ�)
-- DML : INSERT, UPDATE, DELETE �� ��� �� �޸𸮿����� ��°�. �޸𸮿��� �ְ�, ������Ʈ�ϰ�, �����ϰ�.. ��ũ�ʹ� ���� 
DELETE FROM EMP03; -- ������
ROLLBACK; -- �ٽ� �ǵ����� �� �� -> �ٽ� ��ũ�� �ִ°� �޸𸮷� ������

TRUNCATE TABLE EMP03; -- DDL : TRUNCATE = DELETE + COMMIT -> �������� ��ũ�� �ݿ���(Ŀ��)
-- DDL : TRUNCATE, CREATE, ALTER, RENAME, DROP -> �⺻������ COMMIT�� ���� �Ǿ� �ִ� �����ϱ�
-- ��, ��ũ�� �����ִ°�. ��ũ�� �ݿ��Ǵ°�.
-- DDL ������ �����ϱ�!
ROLLBACK; -- �ҿ� ����.. -> ��ũ���� �����ϱ� �����ð� ���°���.

-- ����� ���࿡ �ٹ��� ������� ����.. ������ ��������.. �� �ȯ�濡�� SELECT ������ ����..

-- RENAME TABLE : ���̺�� ����
RENAME EMP03 TO TEST; -- EMP03 -> TEST�� �̸� �����
SELECT * FROM TEST;

-- USER _������ ��ųʸ�
SHOW USER;

DESC USER_TABLES;

SELECT TABLE_NAME 
FROM USER_TABLES
ORDER BY TABLE_NAME ASC; -- USER(SCOTT)�� ���� ���̺� ������ ����~

-- ������ ���̽��� ����� �߽����� ������� -> ��Ű��

-- ALL_������ ��ųʸ�
SELECT * FROM DEPT;
SELECT * FROM SYSTEM.HELP;
-- �⺻������ �ٸ� ������ ���̺��� ���� ����.(HELP���� -> ���� ��� ���ذ�)�� �������� ALL_��ųʸ��� ������� 

DESC ALL_TABLES;
SELECT OWNER, TABLE_NAME FROM ALL_TABLES; -- SCOTT���� ���� ������ ���̺� ��� ���

SHOW USER;
SELECT TABLE_NAME, OWNER FROM DBA_TABLES; -- SCOTT�� ����� ���������� DBA ���� ���� (SYSTEM������ ����)

-- DML : INSERT, UPDATE, DELETE
-- INSERT��
DESC DEPT01;
ALTER TABLE DEPT01
ADD(LOC VARCHAR2(10));

INSERT INTO DEPT01 VALUES(10, 'ACCOUNTING', 'NEWYORK');
SELECT * FROM DEPT01;
INSERT INTO DEPT01 VALUES(30, 'DEVELOPMENT', NULL); -- ���� �� �������� ������� ���� NULL�� ä���
INSERT INTO DEPT01 (DEPTNO, DNAME) VALUES (40, 'SALES'); -- �̷��� ���� ���� �����ؼ� �־ ��

DROP TABLE DEPT01;
CREATE TABLE DEPT01
AS
SELECT * FROM DEPT WHERE 1=0;
SELECT * FROM DEPT01;
