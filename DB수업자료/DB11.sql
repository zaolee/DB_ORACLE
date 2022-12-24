-- �����Լ�(stored function)
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

-- ��������� �˻��Ͽ� �ش� ����� ������ ��� ���� ���� �Լ��� SEL_EMPNAME02��� �̸����� �ۼ��϶�.
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

-- CURSOR�� �̿��ؼ� �μ����̺��� ��� ������ ��ȸ�ϱ�
CREATE OR REPLACE PROCEDURE CURSOR_SAMPLE01
IS
        VDEPT DEPT%ROWTYPE; -- ���ڵ� Ÿ��(�ڹ��� CLASS���� ����), ���� ������Ÿ���� ���� �ʵ���� ����
        CURSOR C1 IS  -- Ŀ���̸� C1
                SELECT * FROM DEPT; -- DEPT������ ����Ű�� Ŀ��C1
BEGIN
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ / �μ��� / ������');
        DBMS_OUTPUT.PUT_LINE('---------------------------------');
        OPEN C1; -- Ŀ�� ����
        LOOP
                FETCH C1 INTO VDEPT.DEPTNO, VDEPT.DNAME, VDEPT.LOC; 
                -- Ŀ���κ��� �����͸� �о�ͼ� ���ú���(VDEPT(���ڵ�Ÿ��))�� �����Ѵ�.
                EXIT WHEN C1%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME || ' / ' || VDEPT.LOC);
        END LOOP;
        CLOSE C1; -- Ŀ�� �ݱ�
END;
/
SET SERVEROUTPUT ON
EXECUTE CURSOR_SAMPLE01;

SELECT * FROM DEPT;

-- CURSOR �� FOR LOOP
CREATE OR REPLACE PROCEDURE CURSOR_SAMPLE02
IS
        VDEPT DEPT%ROWTYPE;
        CURSOR C1 IS
                SELECT * FROM DEPT;
BEGIN
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ / �μ��� / ������');
        DBMS_OUTPUT.PUT_LINE('----------------------------------');
        FOR VDEPT IN C1 LOOP -- �ڵ����� �����
                EXIT WHEN C1%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME || ' / ' || VDEPT.LOC);
        END LOOP;
END;
/
EXECUTE CURSOR_SAMPLE02;

-- �ܼ� �޼����� ����ϴ� Ʈ����(TRIGGER)
-- 1. ������̺� ����
DROP TABLE EMP01;
CREATE TABLE EMP01(
        EMPNO NUMBER(4) PRIMARY KEY,
        ENAME VARCHAR2(20),
        JOB VARCHAR2(20)
);        

-- 2. Ʈ���� �ۼ�
CREATE OR REPLACE TRIGGER TRG_01
        AFTER INSERT
        ON EMP01 -- EMP01�� ���Ե� �Ŀ�
BEGIN
        DBMS_OUTPUT.PUT_LINE('���Ի���� �Ի��߽��ϴ�.');
END;
/

-- 3. ������̺� ������ �ֱ�
SET SERVEROUTPUT ON
INSERT INTO EMP01 VALUES(1, '�', '100��');
-- �̰� �����ϴ� ���� �ܼ�â�� �����س��� Ʈ����(TRG_01)�� �����
SELECT * FROM EMP01;

-- �޿� ������ �ڵ����� �߰��ϴ� Ʈ���� �ۼ��ϱ�
--1. �޿��� ������ ���̺��� �����Ѵ�.
DROP TABLE SAL01;
CREATE TABLE SAL01(
        SALNO NUMBER(4) PRIMARY KEY,
        SAL NUMBER(7,2),
        EMPNO NUMBER(4) REFERENCES EMP01(EMPNO)
);

--2. �޿���ȣ�� �ڵ� �����ϴ� �������� �����ϰ� �� �������κ��� �Ϸù�ȣ�� ��� �޿���ȣ�� �ο��Ѵ�.
CREATE SEQUENCE SAL01_SALNO_SEQ; --  SALNO NUMBER(4) PRIMARY KEY�� ���� ������ ����

--3. Ʈ���� �����Ѵ�.
CREATE OR REPLACE TRIGGER TRG_02
        AFTER INSERT
        ON EMP01 -- EMP01�� �����͸� ���� �Ŀ�
        FOR EACH ROW
BEGIN
        INSERT INTO SAL01 VALUES(SAL01_SALNO_SEQ.NEXTVAL, 100, :NEW.EMPNO);
        -- :NEW.EMPNO : ���� ���� ���ڵ带 �ǹ�(���� �Էµ� (ROW)�����͸� �ǹ�)
        -- :NEW -> EMP01�� ���� ���� ������
        -- :OLD -> ���� ROW(������)�� �ǹ�
END;
/
--4. ��� ���̺� �ο츦 �߰��մϴ�
INSERT INTO EMP01 VALUES(2, '������', '���α׷���');
SELECT * FROM EMP01;
SELECT * FROM SAL01;

INSERT INTO EMP01 VALUES(3, '������', '����');
SELECT * FROM EMP01;
SELECT * FROM SAL01;

INSERT INTO EMP01 VALUES(4, '���', '100��');
SELECT * FROM EMP01;
SELECT * FROM SAL01;

-- �޿� ������ �ڵ����� �����ϴ� Ʈ����
-- 1. ��� ���̺��� �ο츦 �����Ѵ�.
DELETE FROM EMP01 WHERE EMPNO=2; 
-- SQL Error �߻��Ѵ�. SAL01���� �����ϰ� �ֱ� ������ ������� ����� ����.

-- 2. Ʈ���Ÿ� �ۼ��Ѵ�.
CREATE OR REPLACE TRIGGER TRG_03
        AFTER DELETE ON EMP01
        FOR EACH ROW
BEGIN
        DELETE FROM SAL01 
        WHERE EMPNO=:old.EMPNO; -- SAL01�� EMPNO�� OLD��
END;
/
-- 3. ��� ���̺��� �ο츦 �����Ѵ�.
DELETE FROM EMP01 WHERE EMPNO=2;

SELECT * FROM EMP01;
SELECT * FROM SAL01;

-- �μ� ��ȣ�� �����Ͽ� �ش� �μ� �Ҽ� ����� ������ ����ϴ� SEL_EMP ���ν����� Ŀ���� ����Ͽ� �ۼ��϶�.
SELECT * FROM EMP;

CREATE OR REPLACE PROCEDURE SEL_EMP(VDEPTNO EMP.DEPTNO%TYPE) -- ���� �� ������ ����ٰ� ��������
IS
        VEMP EMP%ROWTYPE;
        CURSOR C1 IS
                SELECT *
                FROM EMP
                WHERE DEPTNO = VDEPTNO;
BEGIN
        DBMS_OUTPUT.PUT_LINE('�����ȣ / ����� / ���� / �޿�');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
        FOR VEMP IN C1 LOOP -- �ڵ����� �����
                EXIT WHEN C1%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO || ' ' || VEMP.ENAME || ' ' || VEMP.JOB || ' ' || VEMP.SAL);
        END LOOP;
END;
/
EXECUTE SEL_EMP(20);

-- ��Ű��
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
                DBMS_OUTPUT.PUT_LINE('�μ���ȣ / �μ��� / ������');
                DBMS_OUTPUT.PUT_LINE('-----------------------');
                FOR VDEPT IN C1 LOOP
                        EXIT WHEN C1%NOTFOUND;
                        DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO||
                        ' '||VDEPT.DNAME||' '||VDEPT.LOC);
                END LOOP;
        END;
END;
/

-- ��Ű�� ����
VARIABLE VAR_RES NUMBER;
EXECUTE :VAR_RES := EXAM_PACK.CAL_BONUS(7369);
PRINT VAR_RES;

EXECUTE EXAM_PACK.CURSOR_SAMPLE02;

SELECT * FROM EMP;