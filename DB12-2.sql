SHOW USER;
SELECT * FROM USR_I;


-- DML을 통한 물리데이터모델링 검증 (전제조건 : 기본적으로 데이터가 존재해야함 -> 더미데이터)
-- 1. 더미(dummy) 데이터 입력한다.
INSERT INTO "USR_I" (USERID, USERNAME) VALUES ('TEST1', 'TEST1');
INSERT INTO "USR_I" (USERID, USERNAME) VALUES ('TEST2', 'TEST2');
SELECT * FROM USR_I;

-- 2. 요구사항에 맞는 검증 SQL문을 작성한다.
INSERT INTO USR_Y VALUES ('TEST1',2017,132);
INSERT INTO USR_Y VALUES ('TEST2',2017,396);
INSERT INTO USR_Y VALUES ('TEST1',2018,1); -- 두개의 조합으로 PK를 사용하기 때문에 구별이 되니까 넣어져
INSERT INTO USR_Y VALUES ('TEST2',2018,5);
INSERT INTO USR_Y VALUES ('TEST3',2018,32); -- TEST3은 PK로 없어서 들어가지 않음
SELECT * FROM USR_Y;

INSERT INTO USR_M VALUES ('TEST1',2018,1,0);
INSERT INTO USR_M VALUES ('TEST1',2018,2,1);
INSERT INTO USR_M VALUES ('TEST1',2018,2,3); -- 복합키로 사용자, 연도랑 월 다 중복 됨.
SELECT * FROM USR_M;
-- 참고: 만약, 해당 ACCOUNT가 접속되어 있어 다음과 같이 삭제할 수 없는 경우
-- ORA-01940: 현재 접속되어 있는 사용자는 삭제할 수 없습니다
-- 01940. 00000 - "cannot drop a user that is currently connected"

SELECT SID,SERIAL# FROM V$SESSION WHERE USERNAME = 'USER01';
ALTER SYSTEM KILL SESSION '<SID>, <SERIAL>';
DROP USER USER10 CASCADE;