DROP TABLE BOARD;
CREATE TABLE BOARD(   
    BOARD_NO NUMBER DEFAULT 0,                -- pk
    TITLE VARCHAR2(100) NOT NULL CHECK(REGEXP_LIKE(TITLE,'^[가-힣]{3,20}$')),   -- 한글로만 이루어져 있어야한다. 최소 3글자 최대 20자 까지 허용한다.
    CONTENT CHAR(1000) NOT NULL,    -- content 글자사이즈는 1000자로 할당한다.
    WRITER VARCHAR2(10) NOT NULL CHECK(REGEXP_LIKE(WRITER,'^[가-힣A-Za-z]{2,10}$')),   -- 한글과 영문자로 구성되어 있어야 하며, 최소 2글자 최대 10글자로 허용한다.
    REG_DATE DATE DEFAULT SYSDATE   -- 날짜 형식으로 지정하고 미지정시 현재 날짜로 자동 저장한다.
                                    -- 모두 입력을 해야된다.
); 
    -- GENDER CHAR(1) NOT NULL CHECK(GENDER IN('M','F')),
    -- SCORE NUMBER(3) NOT NULL CHECK(SCORE BETWEEN 0 AND 100),
select * from board;
ALTER TABLE BOARD 
ADD CONSTRAINT BOARD_PK PRIMARY KEY(BOARD_NO);

DROP SEQUENCE BOARD_SEQ;
CREATE SEQUENCE BOARD_SEQ   
START WITH 1 
INCREMENT BY 1; 
select * from user_constraints where table_name = 'BOARD';

-- MyBatis 테이블 관리
DROP TABLE MYBATISBOARD;
CREATE TABLE MYBATISBOARD( 
    NO NUMBER, 
    TITLE VARCHAR2(100) NOT NULL, 
    CONTENT VARCHAR2(500) NULL, 
    WRITER VARCHAR2(50) NOT NULL, 
    REG_DATE DATE DEFAULT SYSDATE
); 
ALTER TABLE MYBATISBOARD ADD CONSTRAINT MYBATISBOARD_PK PRIMARY KEY (NO);
SELECT * FROM MYBATISBOARD;
DROP SEQUENCE MYBATISBOARD_SEQ;
CREATE SEQUENCE MYBATISBOARD_SEQ 
START WITH 1 
INCREMENT BY 1;

-- 회원관리 1, 회원권한 N
DROP TABLE MEMBER;
CREATE TABLE MEMBER( 
    NO NUMBER, 
    ID VARCHAR2(50) NOT NULL, 
    PW VARCHAR2(50) NOT NULL, 
    NAME VARCHAR2(100) NOT NULL, 
    COIN NUMBER(10) DEFAULT 0, 
    REG_DATE DATE DEFAULT SYSDATE, 
    UPD_DATE DATE DEFAULT SYSDATE, 
    ENABLED CHAR(1) DEFAULT '1'
); 
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_PK PRIMARY KEY(NO); 

DROP SEQUENCE MEMBER_SEQ;
CREATE SEQUENCE MEMBER_SEQ 
START WITH 1 
INCREMENT BY 1; 

-- 회원 권한 테이블
DROP TABLE MEMBER_AUTH;
CREATE TABLE MEMBER_AUTH ( 
    NO NUMBER NOT NULL, 
    AUTH VARCHAR2(50) NOT NULL 
); 
ALTER TABLE MEMBER_AUTH ADD CONSTRAINT MEMBER_AUTH_NO_FK 
FOREIGN KEY(NO) REFERENCES MEMBER(NO) ON DELETE CASCADE; 

-- 회원이메일 권한 테이블
DROP TABLE MEMBER_EMAIL;
CREATE TABLE MEMBER_EMAIL ( 
    NO NUMBER NOT NULL, 
    EMAIL VARCHAR2(50) NOT NULL 
); 
ALTER TABLE MEMBER_EMAIL ADD CONSTRAINT MEMBER_EMAIL_NO_FK 
FOREIGN KEY(NO) REFERENCES MEMBER(NO) ON DELETE CASCADE; 

SELECT * FROM MEMBER;
SELECT * FROM MEMBER_AUTH;

-- 회원가입
INSERT INTO MEMBER(NO, ID, PW, NAME) 
VALUES(MEMBER_SEQ.NEXTVAL, 'AAA', '123456', 'KDJ');

-- 회원권한설정
INSERT INTO MEMBER_AUTH(NO, AUTH) VALUES(1, 'MEMBER');

-- 회원조회
SELECT M.NO, ID, PW, NAME, REG_DATE, UPD_DATE, AUTH 
FROM MEMBER M LEFT OUTER JOIN MEMBER_AUTH A ON M.NO = A.NO WHERE M.NO = 1;

-- 회원정보요청
SELECT NO, ID, PW, NAME, REG_DATE FROM MEMBER ORDER BY REG_DATE DESC ;

-- 회원수정
UPDATE MEMBER SET NAME = 'sss' WHERE NO = 1;

-- 회원 삭제
DELETE FROM MEMBER WHERE NO = 1;

-- 회원 권한삭제
DELETE FROM MEMBER_AUTH WHERE NO = 1;

INSERT INTO MEMBER_AUTH VALUES(4,'ADMIN');
INSERT INTO MEMBER_EMAIL VALUES(4,'kqwekqe@naver.com');
ROLLBACK;
select * from member;
SELECT M.NO, ID, PW, NAME, REG_DATE, UPD_DATE, AUTH, EMAIL
		FROM MEMBER M LEFT OUTER JOIN MEMBER_AUTH A ON
		M.NO = A.NO left outer JOIN MEMBER_EMAIL E ON A.NO = E.NO WHERE M.NO = 4;
-- MyBatis 멤버 테이블 관리
DROP TABLE MYBATISMEMBER;
CREATE TABLE MYBATISMEMBER( 
    NO NUMBER, 
    ID VARCHAR2(20) NOT NULL, 
    PW VARCHAR2(20) NOT NULL, 
    NAME VARCHAR2(20) NOT NULL, 
    REG_DATE DATE DEFAULT SYSDATE NOT NULL
); 
Commit;
ALTER TABLE MYBATISMEMBER ADD CONSTRAINT MYBATISMEMBER_PK PRIMARY KEY(NO);

DROP SEQUENCE MYBATISMEMBER_SEQ;
CREATE SEQUENCE MYBATISMEMBER_SEQ 
START WITH 1 
INCREMENT BY 1;

-- AOP 테이블 생성
DROP TABLE AOPBOARD;
CREATE TABLE AOPBOARD( 
    NO NUMBER, 
    TITLE VARCHAR2(100) NOT NULL, 
    CONTENT VARCHAR2(1000) NULL, 
    WRITER VARCHAR2(50) NOT NULL, 
    REG_DATE DATE DEFAULT SYSDATE, 
    PRIMARY KEY(NO) 
); 
DROP SEQUENCE AOPBOARD_SEQ;
CREATE SEQUENCE AOPBOARD_SEQ 
START WITH 1 
INCREMENT BY 1;

-- item 테이블 생성 
CREATE TABLE ITEM( 
    ID NUMBER(5), 
    NAME VARCHAR2(20),
    PRICE NUMBER(6), 
    DESCRIPTION VARCHAR2(50), 
    PICTURE_URL VARCHAR2(200) 
); 
ALTER TABLE ITEM ADD CONSTRAINT ITEM_PK PRIMARY KEY(ID);

CREATE SEQUENCE ITEM_SEQ 
START WITH 1 
INCREMENT BY 1; 

DESC ITEM;
select * from item; 