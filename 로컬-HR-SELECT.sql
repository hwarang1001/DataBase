-- <문제1> 'jking'이란 이메일을 갖은 직원의 이름과 급여와 커미션을 출력하라. (INITCAP, UPPER 사용)
SELECT FIRST_NAME 이름, SALARY 급여, COMMISSION_PCT 커미션 FROM EMPLOYEES
WHERE INITCAP(EMAIL) = INITCAP('jking');
SELECT FIRST_NAME 이름, SALARY 급여, COMMISSION_PCT 커미션 FROM EMPLOYEES
WHERE UPPER(EMAIL) = UPPER('jking');

-- <문제2> 이름이 6글자 이상인 직원의 직원 번호와 이름과 급여를 출력하라.
SELECT EMPLOYEE_ID "직원 번호", FIRST_NAME 이름, SALARY 급여 FROM EMPLOYEES
WHERE FIRST_NAME LIKE '______%';
SELECT EMPLOYEE_ID "직원 번호", FIRST_NAME 이름, SALARY 급여 FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) >= 6;

-- <문제3> 03년도에 입사한 사원 알아내기
-- (비교 연산자와 AND 연산자, BETWEEN AND 연산자, SUBSTR함수)
SELECT FIRST_NAME 이름, HIRE_DATE 입사날짜 FROM EMPLOYEES
WHERE HIRE_DATE >= '03/01/01' AND HIRE_DATE <= '03/12/31';
SELECT FIRST_NAME 이름, HIRE_DATE 입사날짜 FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '03/01/01' AND '03/12/31';
SELECT FIRST_NAME 이름, HIRE_DATE 입사날짜 FROM EMPLOYEES
WHERE SUBSTR(HIRE_DATE,1,2) = 03;

-- <문제4> 이름이 k로 끝나는 직원을 검색
-- (LIKE 연산자와 와일드 카드(%), SUBSTR 함수)
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%k';
SELECT * FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME,-1,1) LIKE 'k';

-- <문제5> 직원 번호가 짝수인 직원들의 직원번호와 이름과 직급을 출력하라.
SELECT EMPLOYEE_ID "직원 번호", FIRST_NAME 이름, job_id 직급 FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID,2) = 0;

-- <문제6>모든 직원은 자신의 상관(MANAGER_ID)이 있다. 하지만 EMPLOYEES 테이블에 유일하게 
-- 상관이 없는 로우가 있는데 그 사원의 MANAGER_ID 칼럼 값이 NULL이다. 상관이 없는 대표이사만 
-- 출력하되 MANAGER_ID 칼럼 값 NULL 대신 CEO로 출력한다.
SELECT EMPLOYEE_ID "직원 번호", FIRST_NAME 이름, job_id 직급, NVL2(MANAGER_ID, '', 'CEO') MANAGER_ID  FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

--<문제7> 부서별에 따라 급여를 인상하도록 하자. (직원번호, 직원명, 직급, 급여) 부서코드가 
-- 20인 직원은 5%, 30인 사원은 10%, 40인 사원은 15%, 60인 직원은 20%인 인상한다.
SELECT EMPLOYEE_ID "직원 번호", FIRST_NAME 직원명, DEPARTMENT_ID "부서 번호", job_id 직급,
SALARY 급여,
DECODE(DEPARTMENT_ID, 
20, SALARY * 1.05,
30, SALARY * 1.10,
40, SALARY * 1.15,
60, SALARY * 1.2) 인상급여
FROM EMPLOYEES WHERE 
DEPARTMENT_ID IN(20, 30, 40, 60);
