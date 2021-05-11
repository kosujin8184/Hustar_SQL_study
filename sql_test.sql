#테이블 생성
CREATE TABLE t_student(
	st_id INT AUTO_INCREMENT,
	st_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '이름',
	st_height VARCHAR(20),
	st_weight VARCHAR(20),
	st_school VARCHAR(20),
	st_major VARCHAR(20),
	st_birth VARCHAR(10),
	st_content TEXT,
	insert_date DATETIME,
	modify_date DATETIME,
	PRIMARY KEY(st_id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

#데이터 자료형
#문자형, 숫자형, 날짜형
#문자형
#char(10)
#varchar(10) -> char는 무조건 지정된 크기만큼 용량을 잡아먹는데, varchar는 남는공간은 유동적으로 제외해줘.
#text
#숫자형
#int
#tinyint
#float
#날짜형
#date ->'YYYY-MM-DD'
#datetime -> 'YYYY-MM-DD HH:MM:SS'
#time -> 'HH:MM:SS'


#전체 테이블 조회
SHOW TABLES;

#테이블 구조확인
DESC t_student;

#테이블 생성 쿼리 확인
SHOW CREATE TABLE t_student;

#테이블 삭제
DROP TABLE t_student;

#테이블 컬럼 추가
ALTER TABLE t_student ADD st_nick VARCHAR(10) AFTER st_name;

#테이블 컬럼 수정
ALTER TABLE t_student MODIFY st_nick VARCHAR(50);

#테이블 컬럼 삭제
ALTER TABLE t_student DROP st_nick;

#테이블명 변경
ALTER TABLE t_student RENAME TO t_student2;
ALTER TABLE t_student2 RENAME TO t_student;


#데이터 등록
INSERT INTO t_student(st_name, st_height, st_weight, st_school, st_major, st_birth, insert_date)
VALUES('홍길동', '180', '70', '휴스타학교', '컴퓨터공학과', '1999-01-01', NOW());
INSERT INTO t_student(st_name, st_height, st_weight, st_school, st_major, st_birth, insert_date)
VALUES('조인성', '170', '81', '휴스타학교', '디자인과', '1998-02-21', NOW());
INSERT INTO t_student(st_name, st_height, st_weight, st_school, st_major, st_birth, insert_date)
VALUES('김태희', '160', '50', 'IACT학교', '컴퓨터공학과', '1992-03-04', NOW());
INSERT INTO t_student(st_name, st_height, st_weight, st_school, st_major, st_birth, insert_date)
VALUES('송혜교', '156', '45', 'IACT학교', '디자인과', '1984-06-11', NOW());
INSERT INTO t_student(st_name, st_height, st_weight, st_school, st_major, st_birth, insert_date)
VALUES('송중기', '176', '65', '휴스타학교', '컴퓨터공학과', '1990-03-05', NOW());
INSERT INTO t_student(st_name, st_height, st_weight, st_school, st_major, st_birth, insert_date)
VALUES('유재석', '179', '73', 'IACT학교', '컴퓨터공학과', '1979-05-01', NOW());

INSERT INTO t_student SET
st_name='김흥국',
st_height='170',
st_weight='80',
st_school='휴스타학교',
st_major='컴퓨터공학과',
st_birth='1989-07-21',
insert_date=NOW();


#데이터 조회
SELECT * FROM t_student;


#데이터 수정(where없으면 모든 값이 set으로 바뀜)
UPDATE t_student SET st_height ='170' WHERE st_id='1';
UPDATE t_student SET st_height=st_height+1 WHERE st_id='1';

#데이터 삭제
DELETE FROM t_student WHERE st_id='1';


#데이터 조회
SELECT * FROM t_student;
SELECT st_name, st_school, st_birth FROM t_student;
SELECT st_name, st_name AS '이름' FROM t_student;


#count
SELECT COUNT(*) AS cnt FROM t_student;


#oder by
SELECT * FROM t_student WHERE (1) ORDER BY st_name ASC;
SELECT st_height, st_name FROM t_student WHERE (1) ORDER BY st_height DESC;
SELECT st_height, st_name FROM t_student WHERE (1) ORDER BY st_height DESC, st_name ASC;
SELECT * FROM t_student ORDER BY insert_date DESC, st_id DESC;



#where
SELECT * FROM t_student WHERE st_name='조인성';
SELECT * FROM t_student WHERE st_height='170';
SELECT * FROM t_student WHERE st_id='7';
SELECT * FROM t_student WHERE st_name LIKE '송%';
SELECT * FROM t_student WHERE st_height >=170 OR st_height <= 75;


#max, min, avg, sum
SELECT MAX(st_height) FROM t_student;
SELECT MIN(st_height) FROM t_student;
SELECT AVG(st_height) FROM t_student;
SELECT SUM(st_height) FROM t_student WHERE st_name LIKE '김%';


#distinct
SELECT DISTINCT st_school FROM t_student;


#group by
SELECT * FROM t_student;

SELECT st_school, COUNT(*) AS cnt, MAX(st_height) AS max_height, MIN(st_height) AS min_height, AVG(st_height) AS avg_height, SUM(st_height) AS sum_height      
FROM t_student 
GROUP BY st_school;

SELECT st_school, GROUP_CONCAT(st_name ORDER BY st_height SEPARATOR '|') AS st_names FROM t_student GROUP BY st_school;


#limit 
SELECT * FROM t_student WHERE st_school LIKE 'IACT%' ORDER BY st_name ASC LIMIT 0, 2; #limit 0번째 부터 2번째 컬럼만 나와



#IF(조건,참출력,거짓출력)
SELECT st_name, IF(st_name = '유재석', '개그맨', '기타') AS job FROM t_student;
SELECT st_height, IF(st_height > 175, '장신', '단신') AS height FROM t_student;
SELECT SUM(IF(st_height > 175, st_height,0)) FROM t_student;
SELECT SUM(st_height) FROM t_student WHERE st_height > 175;


#ifnull(조건,조건널이면출력)
SELECT *, modify_date,IFNULL(modify_date, '0000-00-00 00:00:00') AS modify_date2 FROM t_student;



#case when -> if문과 같은데 여러건 처리가능
SELECT st_name,
	CASE
		WHEN st_name='유재석' THEN '개그맨'
		WHEN st_name='김흥국' THEN '가수'
		ELSE '기타'
	END AS job
FROM t_student;






# 예제 ) 학생 중 키가 175이하인 학생 중 키가 제일 큰 학생의 이름,키, 구하세요.
SELECT st_name, MAX(st_height)
FROM t_student
WHERE st_height <= 175;

SELECT st_name, st_height 
FROM t_student 
WHERE st_height <= 175 
ORDER BY st_height DESC LIMIT 0,1;#(LIMIT 0~1번 즉, 1개만 들고와라)



#기타 함수들
#abs 절댓값)
SELECT (st_height * -1), ABS(st_height * -1) AS '절댓값' FROM t_student;

#floor(소수점 버림)
SELECT st_weight, (st_weight / 10), FLOOR(st_weight / 10) FROM t_student;

#ceiling(소수점 올림)
SELECT st_weight, (st_weight / 10), CEILING(st_weight / 10) FROM t_student;


#round(처리될 숫자, 반올림될 자리)
SELECT st_weight,(st_weight / 7) FROM t_student;
SELECT st_weight,(st_weight / 7), ROUND(st_weight / 7, 0) FROM t_student;
SELECT st_weight,(st_weight / 7), ROUND(st_weight / 7, 2) FROM t_student;
SELECT st_weight,(st_weight / 7), ROUND(st_weight / 7, -1) FROM t_student;



#concat
SELECT CONCAT('1','2', '3', '4', '5') FROM t_student;
SELECT *, CONCAT(st_school, '_', st_major, '_', st_name) FROM t_student;

#replace(속성, 기준값, 변경될값)
SELECT st_name, REPLACE(st_name, '홍', '김') FROM t_student;

#left, right, substring(=mid)
SELECT st_name, LEFT(st_name, 1) FROM t_student;
SELECT st_birth, LEFT(st_birth, 4) FROM t_student;
SELECT st_birth, RIGHT(st_birth, 2) FROM t_student;
SELECT insert_date, LEFT(insert_date, 10), RIGHT(insert_date, 8) FROM t_student;
SELECT st_birth, SUBSTRING(st_birth, 9, 2) FROM t_student;
SELECT st_birth, MID(st_birth, 9, 2) FROM t_student;


#ltrim, rtrim, trim (공백( ' ') 제거)
UPDATE t_student SET st_name=' 홍길동' WHERE st_id='1';

SELECT st_name, LTRIM(st_name) FROM t_student;		#왼쪽 공백제거
SELECT st_name, RTRIM(st_name) FROM t_student;		#오른쪽 공백제거	
SELECT st_name, TRIM(st_name) FROM t_student;		#양쪽 공백제거
SELECT * FROM t_student WHERE LTRIM(st_name)='홍길동';



#date_add, date_sub
SELECT insert_date, DATE_ADD(insert_date, INTERVAL +1 YEAR) FROM t_student;
SELECT insert_date, DATE_ADD(insert_date, INTERVAL +2 MONTH) FROM t_student;
SELECT insert_date, DATE_ADD(insert_date, INTERVAL +3 DAY) FROM t_student;
SELECT insert_date, DATE_ADD(insert_date, INTERVAL +4 HOUR) FROM t_student;
SELECT insert_date, DATE_ADD(insert_date, INTERVAL +5 MINUTE) FROM t_student;
SELECT insert_date, DATE_ADD(insert_date, INTERVAL +6 SECOND) FROM t_student;

SELECT insert_date, DATE_ADD(insert_date, INTERVAL -1 YEAR) FROM t_student;


#date_format
SELECT insert_date, DATE_FORMAT(insert_date, '%Y.%m.%d %h%i%s') FROM t_student;




#테이블 생성 및 데이터 등록
CREATE TABLE t_student_score(
	sc_id INT AUTO_INCREMENT,
	st_id INT,
	sc_score INT,
	sc_course VARCHAR(20),
	sc_point INT,
	PRIMARY KEY(sc_id)
)DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


INSERT INTO t_student_score SET st_id='1', sc_score='97', sc_course='JAVASCRIPT', sc_point='3';
INSERT INTO t_student_score SET st_id='1', sc_score='56', sc_course='DB', sc_point='5';
INSERT INTO t_student_score SET st_id='1', sc_score='67', sc_course='HTML', sc_point='2';
INSERT INTO t_student_score SET st_id='3', sc_score='54', sc_course='JAVASCRIPT', sc_point='3';
INSERT INTO t_student_score SET st_id='3', sc_score='75', sc_course='DB', sc_point='5';
INSERT INTO t_student_score SET st_id='4', sc_score='81', sc_course='HTML', sc_point='2';
INSERT INTO t_student_score SET st_id='5', sc_score='67', sc_course='JAVASCRIPT', sc_point='3';
INSERT INTO t_student_score SET st_id='5', sc_score='91', sc_course='DB', sc_point='5';
INSERT INTO t_student_score SET st_id='5', sc_score='75', sc_course='HTML', sc_point='2';
INSERT INTO t_student_score SET st_id='5', sc_score='70', sc_course='CSS', sc_point='2';

SELECT * FROM t_student_score;


# 예제1) 학생점수테이블에서 최고, 최저 점수를 구하세요.
SELECT MAX(sc_score) AS '최고 점수', MIN(sc_score) AS '최저 점수' FROM t_student_score;


# 예제2) 학생 ID별 평균점수를 구하세요.
SELECT st_id, AVG(sc_score) AS '평균점수', COUNT(*) AS '수강 과목수' FROM t_student_score GROUP BY st_id;


# 예제3) 학생별로 점수등록이 3개 이상일 경우, 최고점 최저점을 제외한 평균을, 3개 미만일 경우 모든 점수의 평균을 구하세요.
SELECT  st_id ,IF(COUNT(*)>=3, (SUM(sc_score) - MAX(sc_score) - MIN(sc_score)) / (COUNT(*) - 2), AVG(sc_score))
FROM t_student_score
GROUP BY st_id;



# 예제4) 전체의 점수, 점수 등급을 충력하세요.(95이상 A+, 90이상 A, 85이상 B+, 80이상 B, 75이상 C+, 70이상 C, 65이상 D+, 60이상 D, 60미만 F, )
SELECT sc_score AS 점수,
	CASE
		WHEN sc_score >= 95 THEN 'A+'
		WHEN sc_score >= 90 THEN 'A'
		WHEN sc_score >= 85 THEN 'B+'
		WHEN sc_score >= 80 THEN 'B'
		WHEN sc_score >= 75 THEN 'C+'
		WHEN sc_score >= 70 THEN 'C'
		WHEN sc_score >= 65 THEN 'D+'
		WHEN sc_score >= 60 THEN 'D'
		ELSE 'F'
	END AS '점수등급'
FROM t_student_score;


# 예제5) t_student table에서 각 학생별 나이를 구하세요.
# 지금년도 - 생년 + 1 => 한국나이
SELECT st_name, st_birth ,DATE_FORMAT(NOW(), '%Y') - LEFT(st_birth, 4) + 1 FROM t_student;
SELECT st_name, st_birth ,LEFT(NOW(), 4) - LEFT(st_birth, 4) + 1 FROM t_student;







#2중 select
SELECT st_id, AVG(sc_score) AS avg_score 
FROM t_student_score 
GROUP BY st_id;


SELECT st_id, avg_score
FROM (SELECT st_id, AVG(sc_score) AS avg_score FROM t_student_score GROUP BY st_id) AS T1;
WHERE avg_score >= 80;


#평균점수가 가장 높은 2명 학생 ID, 평균점수를 구하세요.
SELECT st_id AS st_id2, avg_score
FROM (SELECT st_id, AVG(sc_score) AS avg_score FROM t_student_score GROUP BY st_id) AS T1
ORDER BY avg_score DESC
LIMIT 0,2;


SELECT * FROM t_student;
UPDATE t_student SET st_name='김태희' WHERE st_id='5';


#예제1) 학생 테이블에서 학생 중 동명이인이 존재하는 학생의 이름, 몇명인지를 출력하세요.
SELECT st_name, cnt
FROM (SELECT st_name, COUNT(*) AS cnt FROM t_student GROUP BY st_name) AS T1
WHERE cnt > 1
ORDER BY cnt DESC;

#예제2) 학생점수 테이블에서 학생별 수강한 학점의 합순으로 정렬하세요.
#등급이 F(60점미만)면 학점 인정 안됨
SELECT * FROM t_student_score;

SELECT st_id, sum_point
FROM (SELECT st_id, SUM(sc_point) AS sum_point  FROM t_student_score WHERE sc_score>=60 GROUP BY st_id) AS T1
ORDER BY sum_point DESC;


SELECT st_id, SUM(sc_point) AS sc_point 
FROM
(
SELECT st_id, sc_score, 
		sc_point,
			CASE
				WHEN sc_score >= 95 THEN 'A+'
				WHEN sc_score >= 90 THEN 'A'
				WHEN sc_score >= 85 THEN 'B+'
				WHEN sc_score >= 80 THEN 'B'
				WHEN sc_score >= 75 THEN 'C+'
				WHEN sc_score >= 70 THEN 'C'
				WHEN sc_score >= 65 THEN 'D+'
				WHEN sc_score >= 60 THEN 'D'
				ELSE 'F'
			END AS grade

FROM t_student_score
) AS T1
WHERE T1.grade <> 'F'
GROUP BY st_id
ORDER BY sc_point DESC;



#예제) t_student 테이블에 st_pass varchar(10) 컬럼을 추가하고, 평균점수가 70점 이상인 학생들을 st_pass값을 '합격'으로 변경
ALTER TABLE t_student ADD st_pass VARCHAR(10);
SELECT * FROM t_student;

UPDATE t_student SET st_pass='합격' WHERE st_id='1' OR st_id='2';
UPDATE t_student SET st_pass='' WHERE st_id IN('1','2');

UPDATE t_student SET st_pass='합격' 
WHERE st_id IN
(
SELECT st_id
FROM (SELECT st_id, AVG(sc_score) AS avg_score FROM t_student_score GROUP BY st_id) AS T1
WHERE avg_score >= 70
);




#JOIN
#inner join(=join)
SELECT * FROM t_student;
SELECT * FROM t_student_score;
SELECT * FROM t_student AS T1 JOIN t_student_score AS T2 ON T1.st_id = T2.st_id;

#outer join
#left outer join, right outer join
SELECT * FROM t_student AS T1 LEFT OUTER JOIN t_student_score AS T2 ON T1.st_id = T2.st_id;


SELECT T1.st_name, IFNULL(T2.avg_score,0) AS avg_score, IFNULL(T3.max_score,0) AS max_score
FROM t_student AS T1 
LEFT OUTER JOIN 
	(
	SELECT st_id, AVG(sc_score) AS avg_score
	FROM t_student_score 
	GROUP BY st_id
	) AS T2 
ON T1.st_id = T2.st_id
LEFT OUTER JOIN
	(
	SELECT st_id, MAX(sc_score) AS max_score
	FROM t_student_score
	GROUP BY st_id
	) T3
ON T1.st_id = T3.st_id
ORDER BY T2.avg_score DESC;



SELECT T1.st_name, T2.avg_score, T2.max_score 
FROM t_student AS T1 
JOIN 
	(
	SELECT st_id, AVG(sc_score) AS avg_score, MAX(sc_score) AS max_score 
	FROM t_student_score 
	GROUP BY st_id
	) AS T2 
ON T1.st_id = T2.st_id;





#예제1) 학교가 휴스타학교인 학생 중 키가 170이상이고, 점수데이터가 입력된 사람 중 총점이 가장 낮은 1명의 이름, 총점을 출력하세요.
SELECT * FROM t_student; 

SELECT T1.st_id, T1.st_name, T2.sum_score
FROM t_student AS T1 
JOIN 
	(
	SELECT st_id, SUM(sc_score) AS sum_score 
	FROM t_student_score 
	GROUP BY st_id
	) AS T2 
ON T1.st_id = T2.st_id
WHERE T1.st_height >= 170 AND T1.st_school='휴스타학교'
ORDER BY T2.sum_score ASC
LIMIT 0,1;



SELECT T1.st_id, T1.st_name, T1.st_school, T1.st_height, T2.sum_score
FROM t_student AS T1 
LEFT OUTER JOIN
(
	SELECT st_id, SUM(sc_score) AS sum_score
	FROM t_student_score
	GROUP BY st_id
) AS T2
ON T1.st_id = T2.st_id
WHERE T1.st_school = '휴스타학교' AND T1.st_height >= 170 AND sum_score IS NOT NULL
ORDER BY sum_score ASC
LIMIT 0,1;





#################################################################################

SELECT * FROM t_student; 

CREATE TABLE t_school(
	sl_id INT AUTO_INCREMENT,
	sl_name VARCHAR(20),
	PRIMARY KEY(sl_id)
)DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

SHOW TABLES;
DESC t_school;

ALTER TABLE t_student ADD sl_id INT;
DESC t_student;


INSERT INTO t_school SET sl_name='휴스타학교';
INSERT INTO t_school SET sl_name='IACT학교';

SELECT * FROM t_school;

SELECT st_school, sl_id FROM t_student;
UPDATE t_student SET sl_id='1' WHERE st_school = '휴스타학교';
UPDATE t_student SET sl_id='2' WHERE st_school = 'IACT학교';

UPDATE t_student SET sl_id=(
	CASE 
		WHEN st_school='휴스타학교' THEN '1'
		WHEN st_school='IACT학교' THEN '2'
		ELSE '0'
	END	
);

ALTER TABLE t_student DROP st_school;

SELECT T1.*, T2.* FROM t_student T1 LEFT OUTER JOIN t_school AS T2 ON T1.sl_id=T2.sl_id;







# 예제1) t_student table에서  st_major에 대한 부분을 따로 테이블을 생성하고, 데이터 insert,
#      t_student에 ma_id int 추가, 해당학과에 맞는 키값 등록, join 쿼리 실행
CREATE TABLE t_major(
	ma_id INT AUTO_INCREMENT,
	ma_name VARCHAR(20),
	PRIMARY KEY(ma_id)
)DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


INSERT INTO t_major SET ma_name='디자인과';
INSERT INTO t_major SET ma_name='컴퓨터공학과';

SELECT * FROM t_major;

ALTER TABLE t_student ADD ma_id INT;

#UPDATE t_student SET ma_id='1' WHERE st_major = '디자인과';
#UPDATE t_student SET ma_id='2' WHERE st_major = '컴퓨터공학과';

UPDATE t_student SET ma_id=(
	CASE 
		WHEN st_major='컴퓨터공학과' THEN '1'
		WHEN st_major='디자인과' THEN '2'
		ELSE '0'
	END	
);

ALTER TABLE t_student DROP st_major;

SELECT T1.*, T2.* 
FROM t_student T1 
LEFT OUTER JOIN t_school AS T2 ON T1.sl_id=T2.sl_id
LEFT OUTER JOIN t_major AS T3 ON T1.ma_id=T3.ma_id;






#index -> 많은 데이터 관리하기 위해 원하는 데이터 찾을때 유용
SHOW INDEX FROM t_student;



#view
CREATE VIEW v_student AS
	SELECT * FROM t_student WHERE st_height >= 170;
	
SELECT * FROM v_student;	

CREATE VIEW v_student_score_sum AS
	SELECT st_id, SUM(sc_score) AS sum_score FROM t_student_score GROUP BY st_id;

SELECT * FROM v_student_score_sum;





CREATE VIEW v_student_score_grades AS
	SELECT *,
		CASE
			WHEN sc_score >= 95 THEN 'A+'
			WHEN sc_score >= 90 THEN 'A'
			WHEN sc_score >= 85 THEN 'B+'
			WHEN sc_score >= 80 THEN 'B'
			WHEN sc_score >= 75 THEN 'C+'
			WHEN sc_score >= 70 THEN 'C'
			WHEN sc_score >= 65 THEN 'D+'
			WHEN sc_score >= 60 THEN 'D'
			ELSE 'F'
		END AS grade
	FROM t_student_score;



SHOW CREATE VIEW v_student_score_grades;

DROP VIEW v_student_score_grades;











