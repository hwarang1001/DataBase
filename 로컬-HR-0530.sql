SELECT * FROM EMPLOYEES;
-- 다음은 부서별 오름차순으로 정렬하고, 부서아이디, 부서평균, 부서합계, 부서인원수를 출력하시오.
-- 단 매니저가 있는 사람만 진행하시오.
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY),1), SUM(SALARY), COUNT(SALARY)
FROM EMPLOYEES 
WHERE DEPARTMENT_ID IS NOT NULL 
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID ASC;
DESC EMPLOYEES;

-- 테이블 타입정의해서 그것을 활용한다. (배열) JAVA: INT[] KOR_ARRAY, String[] firstName;
DECLARE
    TYPE FIRST_NAME_TABLE_TYPE IS TABLE OF EMPLOYEES.FIRST_NAME%TYPE INDEX BY BINARY_INTEGER;
    TYPE JOB_ID_TABLE_TYPE IS TABLE OF EMPLOYEES.JOB_ID%TYPE INDEX BY BINARY_INTEGER;
    TYPE EMPLOYEE_ID_TABLE_TYPE IS TABLE OF EMPLOYEES.EMPLOYEE_ID%TYPE INDEX BY BINARY_INTEGER;
    TYPE MANAGER_ID_TABLE_TYPE IS TABLE OF EMPLOYEES.MANAGER_ID%TYPE INDEX BY BINARY_INTEGER;
    -- 변수(배열타입을 적용) 정수형 배열(1개), 문자열 배열(2개)
    NAME_TABLE FIRST_NAME_TABLE_TYPE;
    JOB_TABLE JOB_ID_TABLE_TYPE;
    EMPNO_TABLE EMPLOYEE_ID_TABLE_TYPE;
    MANAGER_TABLE MANAGER_ID_TABLE_TYPE; 
    I BINARY_INTEGER := 0;
BEGIN
    FOR K IN (SELECT FIRST_NAME, JOB_ID, EMPLOYEE_ID, MANAGER_ID FROM EMPLOYEES) LOOP
        I := I + 1;
        NAME_TABLE(I) := K.FIRST_NAME;    
        JOB_TABLE(I) := K.JOB_ID;
        EMPNO_TABLE(I) := K.EMPLOYEE_ID;
        MANAGER_TABLE(I) := K.MANAGER_ID;
    END LOOP;   
    
    FOR J IN 1..I LOOP 
        DBMS_OUTPUT.PUT_LINE('1.FIRST_NAME: '|| NAME_TABLE(J) || ' 2.JOB_ID: ' || 
        JOB_TABLE(J) || ' 3.EMPNO: ' || EMPNO_TABLE(J) || ' 4.MANAGER_ID: ' || NVL(MANAGER_TABLE(J),0));
    END LOOP;
END;
/


-- RECORD TYPE 정의 CLASS 멤버변수 선택 후 하나의 타입으로 정의하는 것과 같다.
-- ROWTYPE 정의 CLASS 모든 멤버변수를 선택 후 하나의 타입으로 정의하는 것과 같다.
DECLARE
    TYPE EMP_RECORD_TYPE IS RECORD (
        EMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE,
        FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE,
        JOB_ID EMPLOYEES.JOB_ID%TYPE,
        DEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE
    );
    -- 변수(배열타입을 적용) 
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    FOR K IN (SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, DEPARTMENT_ID FROM EMPLOYEES) LOOP
        EMP_RECORD.EMPLOYEE_ID := K.EMPLOYEE_ID;
        EMP_RECORD.FIRST_NAME := K.FIRST_NAME;
        EMP_RECORD.JOB_ID := K.JOB_ID;
        EMP_RECORD.DEPARTMENT_ID := K.DEPARTMENT_ID;
        DBMS_OUTPUT.PUT_LINE('1.FIRST_NAME: '|| EMP_RECORD.FIRST_NAME || ' 2.JOB_ID: ' || 
        EMP_RECORD.JOB_ID || ' 3.EMPNO: ' || EMP_RECORD.EMPLOYEE_ID || 
        ' 4.DEPARTMENT_ID: ' || NVL(EMP_RECORD.DEPARTMENT_ID,0));
    END LOOP;   
END;
/

-- ROWTYPE 처리하기
DECLARE
    EMP_RECORD EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO EMP_RECORD FROM EMPLOYEES WHERE UPPER(FIRST_NAME) = 'NEENA';
    DBMS_OUTPUT.PUT_LINE('사원이름 = ' || EMP_RECORD.FIRST_NAME);
END;
/

-- IF THEN ELSE END IF;
-- EMP 에서 NEENA 정보를 가져와서 인상률을 체크해 NULL이면 인상률을 뺀 연봉을 구해서 출력하고,
-- 인상률이 있으면 연봉에 합산해서 출력하시오.
DECLARE
    EMP_RECORD EMPLOYEES%ROWTYPE;
    ANNSALARY NUMBER(10,2);
BEGIN
    SELECT * INTO EMP_RECORD FROM EMPLOYEES WHERE UPPER(FIRST_NAME) = 'NEENA';
    IF (EMP_RECORD.COMMISSION_PCT IS NULL) THEN
        ANNSALARY := EMP_RECORD.SALARY * 12;
    ELSE 
        ANNSALARY := EMP_RECORD.SALARY * 12 + (EMP_RECORD.SALARY * EMP_RECORD.COMMISSION_PCT);
    END IF;
    DBMS_OUTPUT.PUT_LINE('사원이름 = ' || EMP_RECORD.FIRST_NAME || ' 연봉 = ' || ANNSALARY);
END;
/

-- 오라클 랜덤값 DBMS_RANDOM.VALUE(10, 100) (CASTING)(MATH.RANDOM()*(큰값 - 작은값 + 1) + 작은값)
SELECT CEIL(DBMS_RANDOM.VALUE(10,100)) FROM DUAL;

-- 문자값을 임의의 랜덤값으로 구하기 DBMS_RANDOM.STRING('A',3)
SELECT DBMS_RANDOM.STRING('P',6) FROM DUAL;

-- 임의의 부서를 조회해서 첫번째 ROWNUM에 해당하는 월급을 가져와서 출력하고, 
-- 1~5000 낮음, 5001~10000 중간, 10001 ~ 20000 높음, ~ 최상위
DECLARE
    EMP_SALARY EMPLOYEES.SALARY%TYPE;
    EMP_DEPNO EMPLOYEES.DEPARTMENT_ID%TYPE;
    
BEGIN
    EMP_DEPNO := ROUND(DBMS_RANDOM.VALUE(10, 110),-1); -- ROUND(23.232,-1) : 20
    SELECT SALARY INTO EMP_SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = EMP_DEPNO AND ROWNUM <= 1;
    IF (EMP_SALARY BETWEEN 1 AND 5000) THEN
        DBMS_OUTPUT.PUT_LINE('월급 낮음');
    ELSIF (EMP_SALARY BETWEEN 5001 AND 10000) THEN
        DBMS_OUTPUT.PUT_LINE('월급 중간');
    ELSIF (EMP_SALARY BETWEEN 10001 AND 20000) THEN
        DBMS_OUTPUT.PUT_LINE('월급 높음');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('월급 최상위');
    END IF;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('부서번호인 ' || EMP_DEPNO || '가 존재하지 않습니다.');
END;
/
SELECT SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = 90 AND ROWNUM <= 1;

-- 랜덤(1~21)으로 단수를 구해서 출력하는 프로그램을 작성하시오.
DECLARE
    DAN NUMBER;
    I NUMBER;
    TOTAL NUMBER;
BEGIN
    -- 랜덤(1~21)으로 단수를 구하기
    DAN := ROUND(DBMS_RANDOM.VALUE(1,21));
    I := 0;
    -- 무한루프
    LOOP 
        I := I + 1;
        TOTAL := DAN * I;
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || I || ' = ' || TOTAL);
        EXIT WHEN ( I >= 9);
    END LOOP;
END;
/

-- CURSOR : ARRAYLIST<DEPARTMENTS> 부서정보를 모두 가져와서 출력하는 프로그램을 작성하시오.
-- CURSOR를 사용할 것
DECLARE
    CURSOR DEPARTMENT_CURSOR IS SELECT * FROM DEPARTMENTS;
    VDEPT DEPARTMENTS%ROWTYPE;
BEGIN
   OPEN DEPARTMENT_CURSOR;
   LOOP
    FETCH DEPARTMENT_CURSOR 
    INTO VDEPT.DEPARTMENT_ID, VDEPT.DEPARTMENT_NAME, VDEPT.MANAGER_ID, VDEPT.LOCATION_ID; 
    EXIT WHEN DEPARTMENT_CURSOR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(VDEPT.DEPARTMENT_ID || ', ' ||VDEPT.DEPARTMENT_NAME || ', ' || 
    VDEPT.MANAGER_ID || ', ' || VDEPT.LOCATION_ID);
   END LOOP;
   CLOSE DEPARTMENT_CURSOR;
END;
/
-- FOR문을 활용해서 출력하시오.
DECLARE
    VDEPT DEPARTMENTS%ROWTYPE;
BEGIN
   FOR VDEPT IN (SELECT * FROM DEPARTMENTS) LOOP
    DBMS_OUTPUT.PUT_LINE(VDEPT.DEPARTMENT_ID || ', ' ||VDEPT.DEPARTMENT_NAME || ', ' || 
    VDEPT.MANAGER_ID || ', ' || VDEPT.LOCATION_ID);
   END LOOP;
END;
/

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 90;