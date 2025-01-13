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
LEFT JOIN group t3
    ON t1.default_group_id = t2.group_id
;


-- 2
SELECT DISTINCT
    g.head_student_name AS head_student_name
FROM schedule t1
INNER JOIN group t2
    ON g.group_id = sch.default_group_id
INNER JOIN teacher_course t3
    ON sch.course_id = tc.course_id
INNER JOIN (
    SELECT employee_name
    FROM employee
    WHERE employee_name = 'Иванов Александр Максимович'
) t4
    ON tc.teacher_name = e.employee_name
;


-- 3
SELECT DISTINCT
    a.auditorium_number as auditorium_number,
    a.building_number as building_number
FROM auditorium t1
INNER JOIN (
    SELECT
        auditorium_id,
        course_id
    FROM schedule
    WHERE DAYOFWEEK(sch.start_dt) = 2
    -- Функция DAYOFWEEK() возвращает значения от 1 (воскресенье) до 7 (суббота), поэтому понедельник будет 2
) t2
    ON t1.auditorium_id = t2.auditorium_id
INNER JOIN (
    SELECT course_id
    FROM course
    WHERE course_name = 'Теория вероятностей'
) t3
    ON t2.course_id = t3.course_id
;


-- 4
SELECT
    count(*) as teacher_cnt
FROM (
    SELECT
        employee_name
    FROM employee_history
    GROUP BY employee_name
    HAVING count(distinct department_name) > 1
);
