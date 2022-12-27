SELECT * FROM DEPT;

INSERT INTO DEPT VALUES(10, 'TEST', SEOUL); -- 'UNIQUE' �������� ����

DESC DEPT;

DESC USER_CONSTRAINTS;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT';
-- TYPE -> P : PRIMARY Ÿ��

-- NOT NULL ���� ������ �������� �ʰ� ���̺� �����ϱ�
DROP TABLE EMP01;
CREATE TABLE EMP01(
        EMPNO NUMBER(4),
        ENAME VARCHAR2(10),
        JOB VARCHAR2(9),
        DEPTNO NUMBER(2)
);
SELECT * FROM EMP01;
INSERT INTO EMP01 VALUES(NULL, NULL, 'SALESMAN', 30);

-- NOT NULL ���� ������ �����Ͽ� ���̺� �����ϱ�
DROP TABLE EMP02;
CREATE TABLE EMP02(
        EMPNO NUMBER(4) NOT NULL,
        ENAME VARCHAR2(10) NOT NULL,
        JOB VARCHAR(9),
        DEPTNO NUMBER(2)
);        
INSERT INTO EMP02 VALUES(NULL, NULL, 'SALESMAN', 30); 
-- cannot insert NULL into ("SCOTT"."EMP02"."EMPNO") -> NULL�� ������ �����
INSERT INTO EMP02 VALUES(10, '�ҿ�', 'SALESMAN', 30); 
SELECT * FROM EMP02;
        
-- UNIQUE ���� ������ �����Ͽ� ���̺� �����ϱ�
DROP TABLE EMP03;
CREATE TABLE EMP03(
        EMPNO NUMBER(4) CONSTRAINT EMP_EMPNO_UQ UNIQUE,
        ENAME VARCHAR2(10) NOT NULL,
        JOB VARCHAR2(9),
        DEPTNO NUMBER(2)
);
INSERT INTO EMP03 VALUES(7499, 'ZAO', 'SALEMAN', 30);
SELECT * FROM EMP03;
INSERT INTO EMP03 VALUES(7499, 'LEE', 'MANAGER', 20);
-- unique constraint (SCOTT.SYS_C007028) violated -> 'UNIQUE' �������� �Ȱ��� EMPNO�� �ü� ����
-- unique constraint (SCOTT.EMP_EMPNO_UQ) violated -> ���� ���Ǹ� ������
INSERT INTO EMP03 VALUES(NULL, 'LEE', 'MANAGER', 20);
INSERT INTO EMP03 VALUES(NULL, 'LEEE', 'MANAGER', 20);
INSERT INTO EMP03 VALUES(NULL, 'LEEEE', 'MANAGER', 20); 
-- 'UNIQUE' ���ǿ��� �ټ��� NULL�� �� �� ����.(������ �𸣴� ���̶�)
-- ������ 'UNIQUE'��ü�� NULL�� ���� �ȵǴ� ��찡 ���Ƽ� 'NOT NULL'�̶� ���� �ٴ�

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP03';
-- EMP03�� �������Ǹ� ������ֽ�?

-- PRIMARY KEY(PK, �⺻Ű) �������� �����ϱ�
DROP TABLE EMP05;
CREATE TABLE EMP05(
        EMPNO NUMBER(4) CONSTRAINT EMP05_EMPNO_PK PRIMARY KEY,
        ENAME VARCHAR2(10) CONSTRAINT EMP05_ENAME_NN NOT NULL,
        JOB VARCHAR2(9),
        DEPTNO NUMBER(2)
);
INSERT INTO EMP05 VALUES(7499, 'ALLEN', 'SALESMAN', 30);
SELECT * FROM EMP05;
INSERT INTO EMP05 VALUES(7499, 'ZAO', 'MANAGER', 20);
-- unique constraint (SCOTT.EMP05_EMPNO_PK) violated
INSERT INTO EMP05 VALUES(NULL, 'ZAO', 'MANAGER', 20);
-- cannot insert NULL into ("SCOTT"."EMP05"."EMPNO")

-- EMP, DEPT ���̺��� �������� Ȯ��
SELECT TABLE_NAME, CONSTRAINT_TYPE, CONSTRAINT_NAME, R_CONSTRAINT_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('DEPT','EMP');

DROP TABLE EMP06;
CREATE TABLE EMP06(
        EMPNO NUMBER(4) CONSTRAINT EMP06_EMPNO_PK PRIMARY KEY,
        ENAME VARCHAR2(10) CONSTRAINT EMP06_ENAME_NN NOT NULL,
        JOB VARCHAR2(9),
        DEPTNO NUMBER(2) CONSTRAINT EMP06_DEPTNO_FK REFERENCES DEPT(DEPTNO)
);
INSERT INTO EMP06 VALUES(7499, 'ZAO', 'SALESMAN', 30);
SELECT * FROM EMP06;
INSERT INTO EMP06 VALUES(7498, 'LEE', 'MANAGER', 50);
--  integrity constraint (SCOTT.EMP06_DEPTNO_FK) violated - parent key not found
-- DEPT(DEPTNO)���� 50�� ���� ������ �����߻�(FK�� ���̺�� ���̺� ���� ���� ���ѳ�����)

-- CHECK ���� ���� �����ϱ�
DROP TABLE EMP07;
CREATE TABLE EMP07(
        EMPNO NUMBER(4) CONSTRAINT EMP07_EMPNO_PK PRIMARY KEY,
        ENAME VARCHAR2(10) CONSTRAINT EMP07_ENAME_NN NOT NULL,
        SAL NUMBER(7,2) CONSTRAINT EMP07_SAL_CK CHECK(SAL BETWEEN 500 AND 5000),
        GENDER VARCHAR2(1) CONSTRAINT EMP07_GENDER_CK CHECK(GENDER IN('M', 'F'))
);
INSERT INTO EMP07 VALUES(7499, 'ZAO', 500, 'F');
INSERT INTO EMP07 VALUES(7498, 'LEE', 700, 'A');
-- check constraint (SCOTT.EMP07_GENDER_CK) violated -> GENDER �� 'M' �ƴ� 'F'�� �ֱ� ����
-- CHECK�� �츮�� ���ϴ� ������ �����ϱ� ���� �Ŵ� ��������

SELECT TABLE_NAME,CONSTRAINT_TYPE, CONSTRAINT_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME= 'EMP07';
-- SEARCH_CONDITION : ���� ���� �������� �־�����.

-- DEFAULT ���� ���� �����ϱ�
DROP TABLE DEPT01;
CREATE TABLE DEPT01(
        DEPTNO NUMBER(2) PRIMARY KEY,
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) DEFAULT 'SEOUL'
);
INSERT INTO DEPT01(DEPTNO, DNAME) VALUES (10, 'ACCOUNTING');
-- ������ LOC�� �������ϰ� ���� �Է¾��ϸ� �˾Ƽ� NULL�� ���µ� 
-- �츮�� �������ǿ� LOC ���� SEOUL�� ������� �����س���, ���� LOC�� ���� ������ �ش� ������ ��
INSERT INTO DEPT01 VALUES(20, 'RESEARCH', 'BUSAN'); -- LOC���� 'BUSAN' ��
SELECT * FROM DEPT01;
        
-- �÷� ������ ���������� �����ϱ�
DROP TABLE EMP01;
CREATE TABLE EMP01(
        EMPNO NUMBER(4) PRIMARY KEY,
        ENAME VARCHAR2(10) NOT NULL,
        JOB VARCHAR2(9) UNIQUE,
        DEPTNO NUMBER(4) REFERENCES DEPT(DEPTNO)
);

-- ���̺� ������ �������� �����ϱ�
DROP TABLE EMP02;
CREATE TABLE EMP02(
        EMPNO NUMBER(4),
        ENAME VARCHAR2(10) NOT NULL,
        JOB VARCHAR2(9),
        DEPTNO NUMBER(4),
        PRIMARY KEY(EMPNO),
        UNIQUE(JOB),
        FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO) -- �̷��� ���̺� ������ �������� ����
);

-- CASCADE �ɼ����� ���� ���� ���������� ��Ȱ���ϱ�
-- DROP TABLE DEPT01 CASCADE CONSTRAINTS; 
-- DEPT01�� �����ϰ� �ִ� �ڽ����̺��� �ִٸ� ����� ��� ������ ���ִ°�
DROP TABLE DEPT01;
CREATE TABLE DEPT01
AS
SELECT * FROM DEPT;
SELECT * FROM DEPT01;
DESC DEPT01; -- ���������� ���� �ȵ�

ALTER TABLE DEPT01
ADD CONSTRAINT DEPT01_DEPTNO_PK PRIMARY KEY (DEPTNO); -- ���̺� ���� ������� �������� �߰�
DESC DEPT01;

DROP TABLE EMP01;
CREATE TABLE EMP01
AS
SELECT * FROM EMP WHERE 1=0; -- ���̺� ������ ������
SELECT * FROM EMP01;
DESC EMP01;

ALTER TABLE EMP01
ADD CONSTRAINT EMP1_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT01(DEPTNO);
-- ON DELETE CASCADE;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE,TABLE_NAME, R_CONSTRAINT_NAME, STATUS
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN('DEPT01', 'EMP01');

SELECT * FROM DEPT01;
SELECT * FROM EMP01; -- DEPTNO�� �θ�DEPT01�� �����ϰ� ����

INSERT INTO EMP01(DEPTNO) VALUES(10); -- DEPTNO���� �� 10 �־���. �������� NULL

DELETE FROM DEPT01
WHERE DEPTNO = 10; --�θ� DEPT01�� �ִ� 10 �����~
-- integrity constraint (SCOTT.EMP1_DEPTNO_FK) violated - child record found
-- �� ������~ �ڽ�(EMP01)���� ���� �ְɶ�
-- ������� �ڽĿ� ���� �ִ� DEPTNO ����� ����~ : ������� ������, �ڽ� �� ���� ã�� ���� ����µ� �Ѥ�
-- ���⼭, �ڽ��� ���鶧 �ɼ� �־��ָ� ��

ALTER TABLE EMP01
ADD CONSTRAINT EMP1_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT01(DEPTNO)
ON DELETE CASCADE; -- �߰�����

INSERT INTO EMP01(DEPTNO) VALUES(10); -- 10 �־��ְ�

DELETE FROM DEPT01
WHERE DEPTNO = 10; -- 10 ���� -> ����
-- �θ𲨸� ����ϱ� �ڽĿ��� ���� �ִ��ǵ� �˾Ƽ� �ξ� ������. ���� �ϳ��ϳ� �ڽ� ã�Ƽ� ����� �̷��� �ϱ������ �̰� ���
-- ��� ���輺�� ������ �����ϱ�~(���û���,�ɼ�)

DROP TABLE DEPT01; -- �̰͵� CASCADE CONSTRAINTS������ ������� ����� ����
DROP TABLE DEPT01 CASCADE CONSTRAINTS; -- �̷������� ����� �ƿ� ���� ����
SELECT * FROM DEPT01;
SELECT * FROM EMP01;

-- �������̺��� ��
SELECT * FROM EMP;
SELECT EMPNO, ENAME FROM EMP;
SELECT * FROM EMP
WHERE DEPTNO=10;

-- ���� �⺻ ���̺� �����ϱ�
DROP TABLE DEPT_COPY;
CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPT;

SELECT * FROM DEPT_COPY; -- ���� �⺻ ���̺� ����

DROP TABLE EMP_COPY;
CREATE TABLE EMP_COPY
AS
SELECT * FROM EMP;
SELECT * FROM EMP_COPY; -- ���� �⺻ ���̺� ����

-- �� �����ϱ�
CREATE VIEW EMP_VIEW30
AS
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP_COPY
WHERE DEPTNO=30; -- SYSTEM���� SCOTT���� �� ������ ��  �ִ� ���� �ο���.
-- SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP_COPY
-- WHERE DEPTNO=30;
-- �̺κ��� ���� ����Ҽ��� �����ϱ�, ���� ��� ����°ž�

--GRANT CREATE VIEW TO SCOTT;
-- SYSTEM����(��ũ��Ʈ)���� SCOTT���� ������� �� �ִ� ���� �ο�

SELECT * FROM EMP_VIEW30; -- ���̺� ���ƺ�������, �ƴ� �� �����ؼ� �츮�� ���ϴ� �� �ٷιٷ� ġ�� ����!

-- �ܼ� ���� �÷��� ��Ī �ο��ϱ�
DESC EMP_VIEW30; -- 4���� �÷����� �̷��� ���� ��
CREATE VIEW EMP_VIEW(�����ȣ, �����, �μ���ȣ)
AS 
SELECT EMPNO, ENAME, DEPTNO
FROM EMP_COPY;
SELECT * FROM EMP_COPY;

SELECT * FROM EMP_VIEW;

-- ���� ���� �����
DROP VIEW EMP_VIEW_DEPT;
CREATE VIEW EMP_VIEW_DEPT
AS
SELECT E.EMPNO �����ȣ, E.ENAME �����, E.SAL ����, E.DEPTNO �μ���ȣ, D.DNAME �μ���, D.LOC ���� -- �̷��� ���������� ���� ����
FROM EMP E, DEPT D -- �ΰ��� ���̺� �̿�
WHERE E.DEPTNO = D.DEPTNO 
ORDER BY EMPNO DESC;

SELECT*FROM EMP_VIEW_DEPT;
-- �� ������ ���� ���� �ٷιٷ� �־ ���� ������ �� �並 ���� �Ǵ°���. ����

-- �� �����ϱ�
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS; -- ������� �� ����

DROP VIEW EMP_VIEW; -- ���ŵ�
-- ��� ���� ���������� ���� ����ϴ°�!! ������ ���� ���� ���� �����ϰ� ���̺�ó�� ���� �ְ� ����°� + ����

-- �� �ɼ�
-- �� �����ϰ� ������? -> DROP�ؼ� �����ؼ� �ٽ� ���� -> �־�;;;
-- �ƿ� OR RELACE �ɼ� ���̱�
CREATE OR REPLACE VIEW EMP_VIEW_DEPT
AS
SELECT E.EMPNO �����ȣ, E.ENAME �����, E.DEPTNO �μ���ȣ, D.DNAME �μ���, D.LOC ���� -- �̷��� ���������� ���� ����
FROM EMP E, DEPT D -- �ΰ��� ���̺� �̿�
WHERE E.DEPTNO = D.DEPTNO 
ORDER BY EMPNO DESC; -- ���� ����(������ �ִ°�) ������ ���� �����Ǵ°Ű�

SELECT*FROM EMP_VIEW_DEPT;

-- �⺻ ���̺� ���� �並 �����ϰ� ������
-- FORCE �ɼ�
CREATE OR REPLACE VIEW EMPLOYEES_VIEW
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMPLOYEES -- EMPLOYEES �������� �ʴ� ���̺���
WHERE DEPTNO=30;
-- table or view does not exist
CREATE OR REPLACE FORCE VIEW EMPLOYEES_VIEW -- FORCE �־��ֱ�
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMPLOYEES -- EMPLOYEES �������� �ʴ� ���̺���
WHERE DEPTNO=30;

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS; -- ���� EMPLOYEES_VIEW�� ���� ��, ������ ����ٰ� �����ϸ� ���ҵ�

-- WHIT CHECK OPTION
-- �並 ������ �� ���� ���ÿ� ���� �÷����� �������� ���ϰ� �ϴ� ���
CREATE OR REPLACE VIEW VIEW_CHK30
AS
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO
FROM EMP_COPY
WHERE DEPTNO=30 WITH CHECK OPTION;

SELECT * FROM VIEW_CHK30
WHERE DEPTNO=20; --������ �� DEPTNO = 30�� �������� �ɾ��� ������ ������ ����.

SELECT * FROM VIEW_CHK30;

UPDATE VIEW_CHK30
SET DEPTNO=20
WHERE SAL>=1200; -- ���� �����Ҳ��� SAL>=1200�� �ֵ� DEPTNO�� 20���� �ٲ��ֽ�?
-- view WITH CHECK OPTION where-clause violation -> CHECK OPTION���� ������
-- ���� WHERE�������� �ɾ�а� UPDATE�ϸ� �����ϰ� �ǹ����ϱ� �װ� ���ϰ� ���°�
-- ���� ������ �ٲ��� ���ϵ��� ������ CHECK OPTION�� �ɾ�δ°�.

-- WITH READ ONLY �ɼ�
SELECT * FROM VIEW_CHK30; -- DEPT = 30�� �� ����
UPDATE VIEW_CHK30
SET DEPTNO=20;

SELECT * FROM EMP_COPY; -- ���� ������� DEPTNO�� 30�� �ֵ���� 20���� �ٲ���� ����

CREATE OR REPLACE VIEW VIEW_READ30
AS
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO
FROM EMP_COPY
WHERE DEPTNO=30 WITH READ ONLY; -- ONLY �д� ��ɸ� �ο��ϴ°���

UPDATE VIEW_READ30
SET DEPTNO=20;
--  WITH READ ONLY�� ����߱� ������
-- cannot perform a DML operation on a read-only view -> �̷��� ������

SELECT * FROM VIEW_READ30;

-- ROWNUM �÷� ���� : �ش� ���̺� �Էµ� �������� �Էµ� ������ ��Ÿ��.
SELECT ROWNUM, EMPNO, ENAME, HIREDATE
FROM EMP
ORDER BY ENAME ASC; -- ROWNUM ������ ������ �޶���

-- �޿�(SAL)�� ���� �޴� 6~10° ����� ����ϱ�
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL DESC; -- SAL���� �޴� ������ ����

SELECT RNUM, ENAME, SAL -- �װſ� �ο� ��, ����� �޿� ������ְ�
FROM (SELECT ROWNUM RNUM, ENAME, SAL -- �ο��, �����, �޿� ���
        FROM (SELECT * FROM EMP ORDER BY SAL DESC)) --�� ����� ���(�޿� ������)
WHERE RNUM BETWEEN 6 AND 10;        
-- SELECT * FROM EMP ORDER BY SAL DESC �̰ɷ� ���ο� ���̺�� ���������
-- �׷��� ���� EMP���̺�� ROWNUM�� �ٸ�
-- �̰� ���� ���� : ������ ���鶧 �Խñ��� 2�������� ~��°���� ~��°���� ����Ҷ� ���

-- 1. ��� ���̺�(EMP)���� ���� �ֱٿ� �Ի��� ������߿� 3~5��°�� ����� ������� ����ϴ� SQL���� �ۼ��ϼ���?
SELECT RNUM, ENAME �����, EMPNO �����ȣ
FROM (SELECT ROWNUM RNUM, ENAME, EMPNO 
        FROM (SELECT * FROM EMP ORDER BY HIREDATE DESC)) 
WHERE RNUM BETWEEN 3 AND 5;       