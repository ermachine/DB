-- 1
SELECT
    sum(group_size) as total_students
FROM schedule t1
LEFT JOIN (
    SELECT course_id
    FROM course
    WHERE course_name = 'Базы данных'
) t2
    ON t1.course_id = t2.course_id
LEFT JOIN group_table t3
    ON t1.default_group_id = t3.group_id
;


-- 2
SELECT DISTINCT
    t2.head_student_name AS head_student_name
FROM schedule t1
INNER JOIN group_table t2
    ON t2.group_id = t1.default_group_id
INNER JOIN teacher_course t3
    ON t1.course_id = t3.course_id
INNER JOIN (
    SELECT employee_name
    FROM employee
    WHERE employee_name = 'Павлов Марат Манасович'
) t4
    ON t1.teacher_name = t4.employee_name
;


-- 3
SELECT DISTINCT
    t1.auditorium_number as auditorium_number,
    t1.building as building
FROM auditorium t1
INNER JOIN (
    SELECT
        auditorium_id,
        course_id
    FROM schedule
    WHERE TO_CHAR(DATE '2023-03-20', 'D') = '2'
) t2
    ON t1.auditorium_id = t2.auditorium_id
INNER JOIN (
    SELECT course_id
    FROM course
    WHERE course_name = 'Теория вероятности'
) t3
    ON t2.course_id = t3.course_id
;


-- 4
SELECT
    count(*) as teacher_cnt
FROM (
    SELECT
        employee_name
    FROM (
        SELECT
            employee_name,
            department_name
        FROM employee_history
        UNION ALL
        SELECT
            employee_name,
            department_name
        FROM employee
    )
    GROUP BY employee_name
    HAVING count(distinct department_name) > 1
);
