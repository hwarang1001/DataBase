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

ALTER TABLE BOARD 
ADD CONSTRAINT BOARD_PK PRIMARY KEY(BOARD_NO);

DROP SEQUENCE BOARD_SEQ;
CREATE SEQUENCE BOARD_SEQ   
START WITH 1 
INCREMENT BY 1; 

select * from user_constraints where table_name = 'BOARD';
