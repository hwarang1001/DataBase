-- <문제1> JOB의 종류가 몇 개인지 즉, 중복되지 않은 직업의 개수를 구해보자.
SELECT COUNT(DISTINCT JOB_ID) FROM EMPLOYEES;
SELECT COUNT(*) AS "직업의 갯수" FROM (SELECT JOB_ID FROM EMPLOYEES GROUP BY JOB_ID); -- 서브쿼리

-- <문제2> 부서별로 직원의 수와 커미션을 받는 직원의 수를 카운트해 보자.
SELECT DEPARTMENT_ID 부서, COUNT(*) "직원의 수", COUNT(COMMISSION_PCT) "커미션을 받는 직원의 수"
FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID 
ORDER BY DEPARTMENT_ID;
