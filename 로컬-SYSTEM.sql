ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- 기존 사용자 삭제 (MODEL)
DROP USER MODEL CASCADE;

-- 사용자 만들기 (MODEL)
CREATE USER USERMEMBER IDENTIFIED BY 123456
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;

-- 권한 설정(접속요청, CURD 요청, 관리자 요청
GRANT CONNECT, RESOURCE, DBA TO USERMEMBER;

-- 테이블 스페이스 (데이터베이스 저장될 공간 생성)
CREATE TABLESPACE FIRSTDATA
DATAFILE 'E:\oracle\oradata\XE\FIRST01.DBF' SIZE 10M;

-- 테이블 스페이스 (데이터베이스 저장될 공간 추가) 1M
ALTER TABLESPACE FIRSTDATA
ADD DATAFILE 'E:\oracle\oradata\XE\FIRST02.DBF' SIZE 1M;

-- 테이블 스페이스 (데이터베이스 저장될 공간 크기 수정하는 방법: 작게는 안된다.)
ALTER DATABASE
DATAFILE 'E:\oracle\oradata\XE\FIRST02.DBF' RESIZE 10M;

-- 테이블 스페이스 (데이터베이스 저장될 공간을 자동설정하는 방법)
alter database datafile 'E:\oracle\oradata\XE\FIRST02.DBF'autoextend on 
next 1M maxsize 20M;

-- 1)시스템 권한을 가진자가 계정을 설정 (로컬-SYSTEM)
-- 2) TEST와 비밀번호 1234
CREATE USER TEST IDENTIFIED BY 1234
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;
-- 3)권한 설정을 CONNECT, RESOURCE, DBA 권한을 설정한다.
GRANT CONNECT, RESOURCE, DBA TO TEST;

