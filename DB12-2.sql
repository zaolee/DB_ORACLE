SHOW USER;
SELECT * FROM USR_I;


-- DML�� ���� ���������͸𵨸� ���� (�������� : �⺻������ �����Ͱ� �����ؾ��� -> ���̵�����)
-- 1. ����(dummy) ������ �Է��Ѵ�.
INSERT INTO "USR_I" (USERID, USERNAME) VALUES ('TEST1', 'TEST1');
INSERT INTO "USR_I" (USERID, USERNAME) VALUES ('TEST2', 'TEST2');
SELECT * FROM USR_I;

-- 2. �䱸���׿� �´� ���� SQL���� �ۼ��Ѵ�.
INSERT INTO USR_Y VALUES ('TEST1',2017,132);
INSERT INTO USR_Y VALUES ('TEST2',2017,396);
INSERT INTO USR_Y VALUES ('TEST1',2018,1); -- �ΰ��� �������� PK�� ����ϱ� ������ ������ �Ǵϱ� �־���
INSERT INTO USR_Y VALUES ('TEST2',2018,5);
INSERT INTO USR_Y VALUES ('TEST3',2018,32); -- TEST3�� PK�� ��� ���� ����
SELECT * FROM USR_Y;

INSERT INTO USR_M VALUES ('TEST1',2018,1,0);
INSERT INTO USR_M VALUES ('TEST1',2018,2,1);
INSERT INTO USR_M VALUES ('TEST1',2018,2,3); -- ����Ű�� �����, ������ �� �� �ߺ� ��.
SELECT * FROM USR_M;
-- ����: ����, �ش� ACCOUNT�� ���ӵǾ� �־� ������ ���� ������ �� ���� ���
-- ORA-01940: ���� ���ӵǾ� �ִ� ����ڴ� ������ �� �����ϴ�
-- 01940. 00000 - "cannot drop a user that is currently connected"

SELECT SID,SERIAL# FROM V$SESSION WHERE USERNAME = 'USER01';
ALTER SYSTEM KILL SESSION '<SID>, <SERIAL>';
DROP USER USER10 CASCADE;