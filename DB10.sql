SELECT * FROM DUAL; -- ��Ű�� �Ƚ��� -> ���Ǿ ����� ���
SELECT * FROM SYS.DUAL;

SELECT * FROM SYSTBL; -- ���Ǿ� �������̶� ���� �ʾ�
SELECT * FROM SYSTEM.SYSTBL; -- SYSTEM���� SYSTBL�� ������ SCOTT���� �ο�(�ο����ϸ� ����)

-- ���Ǿ� �����ϱ�
CREATE SYNONYM SYSTBL FOR SYSTEM.SYSTBL; -- SYSTEM���� ���Ǿ� ���� ���� �ο��޾Ƽ� ��밡��
--  SYSTEM.SYSTBL -> SYSTBL �� ���Ǿ� ����
SELECT * FROM SYSTBL; -- ��밡��

-- PL/SQL : PROCEDURE LANGUAGE EXTENTION TO SQL
SET SERVEROUTPUT ON -- ����� �ִ� ������ ȭ�鿡 �����ֵ��� �����Ѵ�,

BEGIN
        DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
        --  DBMS_OUTPUT : ��Ű��(Ŭ��������) PUT_LINE : ����� FUNCTION(�Լ�����)
END;
/

-- ���� ����ϱ�
DECLARE
        -- ����ο��� ������ ����
        VEMPNO NUMBER(4);
        VENAME VARCHAR2(10);
BEGIN
        -- ����ο��� ���๮ �ۼ�
        VEMPNO := 7788;
        VENAME := 'SCOTT';
        DBMS_OUTPUT.PUT_LINE('��� / �̸�');
        DBMS_OUTPUT.PUT_LINE('----------------');
        DBMS_OUTPUT.PUT_LINE(VEMPNO || '/' || VENAME);
END;
/

-- ����� �̸� �˻��ϱ�
SELECT * FROM EMP;
DESC EMP;

DECLARE
        VEMPNO EMP.EMPNO%TYPE;
        VENAME EMP.ENAME%TYPE;
BEGIN
        DBMS_OUTPUT.PUT_LINE('��� / �̸�');
        DBMS_OUTPUT.PUT_LINE('--------------');
        SELECT EMPNO, ENAME INTO VEMPNO, VENAME
        FROM EMP
        WHERE ENAME = 'SMITH';
        DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME);
END;
/

-- ���̺� Ÿ�� ����ϱ�
DECLARE
        -- ���̺� Ÿ���� ���� :�迭Ÿ�԰� ������. ��) �ڹ��� ��� String[] ENAME�� ���� �迭 Ÿ��
        TYPE ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE
            INDEX BY BINARY_INTEGER;
        TYPE JOB_TABLE_TYPE IS TABLE OF EMP.JOB%TYPE
            INDEX BY BINARY_INTEGER;
            
        -- ���̺� Ÿ������ ���� ����
        ENAME_TABLE ENAME_TABLE_TYPE;
        JOB_TABLE JOB_TABLE_TYPE;        
        I BINARY_INTEGER := 0;
        -- ���� �� 3�� ������
BEGIN
        FOR K IN (SELECT ENAME, JOB FROM EMP) LOOP -- 'SELECT ENAME, JOB FROM EMP' �� ����� K�� ����
            I := I+1;
            ENAME_TABLE(I) := K.ENAME;
            JOB_TABLE(I) := K.JOB;
        END LOOP;
        
        FOR J IN 1..I LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(ENAME_TABLE(J),12) || ' / ' || RPAD(JOB_TABLE(J),9));
        END LOOP;
END;
/

--���ڵ� Ÿ�� ����ϱ�
DECLARE
        -- ���ڵ� Ÿ���� ���� : �ڹ��� Ŭ���� Ÿ��(�ٸ� Ÿ���� �ʵ�)�� ���� ����
        TYPE EMP_RECORD_TYPE IS RECORD(
            V_EMPNO EMP.EMPNO%TYPE,
            V_ENAME EMP.ENAME%TYPE,
            V_JOB EMP.JOB%TYPE,
            V_DEPTNO EMP.DEPTNO%TYPE);
            -- �������� Ÿ�Ե��� ���� �ٸ�
            
        -- ���ڵ�� ���� ����
        EMP_RECORD EMP_RECORD_TYPE;
BEGIN
        SELECT EMPNO, ENAME, JOB, DEPTNO INTO EMP_RECORD
        FROM EMP
        WHERE ENAME=UPPER('smith'); -- �ҹ��� ����ڷ� �ٲ���
        -- ���
        DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || TO_CHAR(EMP_RECORD.V_EMPNO));
        DBMS_OUTPUT.PUT_LINE('��       �� : ' || EMP_RECORD.V_ENAME);
        DBMS_OUTPUT.PUT_LINE('������ : ' || EMP_RECORD.V_JOB);
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || EMP_RECORD.V_DEPTNO);
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
        
        DBMS_OUTPUT.PUT_LINE('���     �̸�     �μ���');
        DBMS_OUTPUT.PUT_LINE(VEMPNO || '    ' || VENAME || '    ' || VDEPTNO);
END;
/

-- IF ~ THEN ~ ELESIF ~ ELSE ~ END IF
DECLARE
        VEMP EMP%ROWTYPE; -- ������ RECORDŸ��
        VDNAME VARCHAR2(14);
BEGIN
        DBMS_OUTPUT.PUT_LINE('��� / �̸� / �μ���');
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
        FOR N IN 1..5 LOOP -- 1���� 5����
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

-- ���� ���ν���(STORED PROCEDURE) �����ϱ�
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
SHOW ERROR; -- ���� ������ ��ü������ �˷���

-- ���� ���ν��� ����
EXECUTE DEL_ALL;

-- ���� ���ν��� ��ȸ�ϱ�
SELECT NAME, TEXT FROM USER_SOURCE;

-- �Ű����� ���� ���ν���
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

-- IN, OUT, INOUT �Ű�����
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

-- ���ε� ����
-- ':'�� ���ٿ��ִ� ������ �̸� ����Ǿ� �־�� �Ѵ�.
VARIABLE VAR_ENAME VARCHAR2(15);
VARIABLE VAR_SAL NUMBER;
VARIABLE VAR_JOB VARCHAR2(9);

-- OUT �Ű��������� ���� �޾ƿ��� ���ؼ��� ���ν��� ȣ�� �� ���� �տ� ':'�� �����δ�.
EXECUTE SEL_EMPNO(7654, :VAR_ENAME, :VAR_SAL, :VAR_JOB);
PRINT VAR_ENAME;
PRINT VAR_SAL;
PRINT VAR_JOB;
SELECT ENAME, SAL FROM EMP
WHERE EMPNO=7654;


-- ��������� �˻��Ͽ� �ش� ����� ������ ��� ���� ���� ���ν����� SEL_EMPNAME��� �̸����� �ۼ��϶�.
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

