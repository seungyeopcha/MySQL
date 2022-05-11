use market_db;

drop table if exists member;
CREATE TABLE member -- 회원 테이블
( mem_id  		CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  mem_name    	VARCHAR(10) NOT NULL, -- 이름
  mem_number    INT NOT NULL,  -- 인원수
  addr	  		CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  phone1		CHAR(3), -- 연락처의 국번(02, 031, 055 등)
  phone2		CHAR(8), -- 연락처의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 평균 키
  debut_date	DATE  -- 데뷔 일자
);
CREATE TABLE buy -- 구매 테이블
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   mem_id  	CHAR(8) NOT NULL, -- 아이디(FK)
   prod_name 	CHAR(6) NOT NULL, --  제품이름
   group_name 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 가격
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);

INSERT INTO member VALUES('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015.10.19');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016.08.08');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015.01.15');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울', NULL, NULL, 160, '2015.04.21');
INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울', '02', '44444444', 168, '2007.08.02');
INSERT INTO member VALUES('ITZ', '잇지', 5, '경남', NULL, NULL, 167, '2019.02.12');
INSERT INTO member VALUES('RED', '레드벨벳', 4, '경북', '054', '55555555', 161, '2014.08.01');
INSERT INTO member VALUES('APN', '에이핑크', 6, '경기', '031', '77777777', 164, '2011.02.10');
INSERT INTO member VALUES('SPC', '우주소녀', 13, '서울', '02', '88888888', 162, '2016.02.25');
INSERT INTO member VALUES('MMU', '마마무', 4, '전남', '061', '99999999', 165, '2014.06.19');

INSERT INTO buy VALUES(NULL, 'BLK', '지갑', NULL, 30, 2);
INSERT INTO buy VALUES(NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
INSERT INTO buy VALUES(NULL, 'APN', '아이폰', '디지털', 200, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '아이폰', '디지털', 200, 5);
INSERT INTO buy VALUES(NULL, 'BLK', '청바지', '패션', 50, 3);
INSERT INTO buy VALUES(NULL, 'MMU', '에어팟', '디지털', 80, 10);
INSERT INTO buy VALUES(NULL, 'GRL', '혼공SQL', '서적', 15, 5);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 2);
INSERT INTO buy VALUES(NULL, 'APN', '청바지', '패션', 50, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 1);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 1);

create table hongong1 (toy_id int, toy_name char(4), age int); -- 테이블 생성
insert into hongong1 values(1,'우디',25); -- 벨류 삽입

insert into hongong1(toy_id,toy_name) values (2,'버즈'); -- 지정열만 삽입
insert into hongong1(toy_name,age,toy_id) values ('제시',20,3);

-- 아이디 자동입력 => 프라이머리키로 지정
create table hongong2(
	toy_id int auto_increment primary key,
    toy_name char(4),
    age int);

insert into hongong2 values (null,'보핍',25);
insert into hongong2 values (null,'슬링키',22);
insert into hongong2 values (null,'렉스',21);
select * from hongong2;

select last_insert_id();

alter table hongong2 auto_increment=100;
insert into hongong2 values (null,'재남',35);
select * from hongong2;

create table hongong3(
	toy_id int auto_increment primary key,
    toy_name char(4),
    age int);
alter table hongong3 auto_increment=1000;
set @@auto_increment_increment=3;

insert into hongong3 values (null,'토마스',20);
insert into hongong3 values (null,'제임스',23);
insert into hongong3 values (null,'고든',25);
select * from hongong3;

select count(*) from world.city;

desc world.city;

select*from world.city limit 5;

DROP table IF EXISTS city_popul;
create table city_popul(city_name char(35), population int);

insert into city_popul
	select name, population from world.city;
    
-- update => 수정
select * from city_popul where city_name = 'seoul';
update city_popul
	set city_name='서울'
	where city_name = 'Seoul';
select * from city_popul where city_name = '서울';

update city_popul
	set city_name = '뉴욕',population= 0
    where city_name='New York';
    
select * from city_popul where city_name='뉴욕';

update city_popul
	set population = population / 10000;
select * from city_popul limit 5;

delete from city_popul
	where city_name like 'new%'
    limit 5;
    
-- 9강
use market_db;

create table hongong4(
	tinyint_col tinyint,
    smallint_col smallint,
    int_col int,
    bigint_col bigint);

insert into hongong4 values(127,32767,2147483647,9000000000000000000);
insert into hongong4 values(127,32767,2147483647,90000000000000000000);
    
    create table member -- 회원테이블
		(mem_id char(8) not null primary key ,-- 회원아이디(PK)
        mem_name varchar(10) not null, -- 이름
        mem_number int not null,-- 인원수
        addr char(2) not null, -- 주소(경기, 서울, 경남..)
        phone1 char(3), -- 연락처의 국번(02, 031, 055..)
        phone2 char(8), -- 연락처의 나머지 전화번호(하이픈제외)
		height smallint, -- 평균키
        debut_date date -- 데뷔 일자
        );
    
drop table if exists member;
create table member -- 회원테이블
		(mem_id char(8) not null primary key ,-- 회원아이디(PK)
        mem_name varchar(10) not null, -- 이름
        mem_number int not null,-- 인원수
        addr char(2) not null, -- 주소(경기, 서울, 경남..)
        phone1 char(3), -- 연락처의 국번(02, 031, 055..)
        phone2 char(8), -- 연락처의 나머지 전화번호(하이픈제외)
		height tinyint unsigned, -- 평균키
        debut_date date -- 데뷔 일자
        );

drop table if exists member;
create table member -- 회원테이블
	(mem_id char(8) not null primary key, -- 회원아이디(pk),
    mem_name varchar(10) not null, -- 이름
    mem_number tinyint not null, -- 인원수
    addr char(2) not null, -- 주소(경기,서울,경남..)
    phone1 char(3), -- 연락처 국번 (02,031..)
    phone2 char(8), -- 연락처의 나머지 전화번호
    height tinyint unsigned, -- 평균키
	debut_date date -- 데뷔일자 
    );
    
create table big_table(
data1 char(255));

drop table if exists big_table;
create table big_table(
data2 varchar(16383));

create database netflix_db;

use netflix_db;
create table movie
(movie_id int,
movie_title varchar(30),
movie_director varchar(20),
movie_star varchar(20),
movie_script longtext,
movie_film longblob
);

use market_db;
set @myVar1 =5 ; -- 변수설정
set @myVar2 = 4.25;

select @myVar1;
select @myVar1+@myVar2;

set @txt = '가수 이름==>';
set @height= 166;
select @txt, mem_name from member where height>@height;

set @count = 3;
select mem_name, height from member order by height limit @count; -- 안되는 문법

prepare mySQL from 'select mem_name, height from member order by height limit?';
execute mySQL using @count

select avg(price) '평균가격' from buy; -- 안되는 문법

select cast(avg(price) as signed) '평균 가격' from buy; -- sign : 부호가 있는 정수
-- 또는
select convert(avg(price), signed) '평균 가격' from buy;

select cast('2022$12$12' as date);
select cast('2022/12/12' as date);
select cast('2022%12%12' as date);
select cast('2022@12@12' as date); 

select num, concat(cast(price as char),'X',cast(amount as char),'=') '가격x수량',
	price*amount '구매액'
    from buy;

-- 암시적 형변환
select '100'+'200'; -- 문자가 순자로 변환되서 계산
select concat('100','200') 'ㅋㅋ'; -- 문자와 문자 연결
select concat(100,'200'); -- 정수와 문자를 연결 정수가 문자로 변환
select 1> '2mega'; -- 정수인 2로 변환되어 비교
select 3>'2MEGA'; -- 정수인 2로 변환되어 비교
select 0 = 'mega2'; -- 문자는 0으로 변환

-- 11강
use market_db;

select *
	from buy
		inner join member
        on buy.mem_id=member.mem_id
	where buy.mem_id='GRL';
    
select *
	from buy
		inner join member
        on buy.mem_id = member.mem_id;
        
select mem_id, mem_name, prod_name, addr, concat(phone1,phone2) as '연락처'
	from buy
		inner join member
        on buy.mem_id = member.mem_id; -- 슬랙트할 mem_id 어디거냐?

select buy.mem_id, mem_name, prod_name, addr, concat(phone1,phone2) as '연락처'
	from buy
		inner join member
        on buy.mem_id = member.mem_id;
        
select B.mem_id, M.mem_name, B.prod_name, M.addr,
	concat(M.phone1,M.phone2) as '연락처'
    from buy B -- buy 테이블을 B라고 하겠다
     inner join member M -- member 테이블을 M이라 하겠다
     on B.mem_id = M.mem_id;

select M.mem_id, M.mem_name, B.prod_name, M.addr
	from buy B
		inner join member M
		on B.mem_id=M.mem_id
    order by M.mem_id;
    
select distinct M.mem_id, M.mem_name, M.addr -- 중복제거
	from buy B
     inner join member M
     on B.mem_id=M.mem_id
	order by M.mem_id;

select M.mem_id, M.mem_name, B.prod_name, M.addr
	from member M
		left outer join buy B
        on M.mem_id = B.mem_id
	order by M.mem_id;
    
select M.mem_id, M.mem_name, B.prod_name, M.addr
	from buy B
     right outer join member M
	 on M.mem_id = B.mem_id
	order by M.mem_id;
    
select distinct M.mem_id, B.prod_name, M.mem_name, M.addr
	from member M
		left outer join buy B
        on M.mem_id = B.mem_id
	where B.prod_name is NULL
    order by M.mem_id ;
    
select *
	from buy
    cross join member; -- 무작위 섞기

select count(*) "데이터 개수"
	from sakila.inventory
     cross join world.city;
     
select count(*) "데이터 개수"
	from sakila.inventory
     cross join world.city;
     
create table cross_table
	select *
		from sakila.actor
			cross join world.country;
            
select * from cross_table LIMit 5;

use market_db;
create table emp_table (emp char(4), manager char(4), phone varchar(8));

insert into emp_table values('대표',null,'0000');
insert into emp_table values('영업이사','대표','1111');
insert into emp_table values('관리이사','대표','2222');
insert into emp_table values ('정보이사','대표','3333');
insert into emp_table values ('영업과장','영업이사','1111-1');
insert into emp_table values('경리부장','관리이사','2222-1');
insert into emp_table values('인사부장','관리이사','2222-2');
insert into emp_table values ('개발팀장','정보이사','3333-1');
insert into emp_table values ('개발주임','정보이사','3333-1-1');

select A.emp "직원", B.emp "직속상관", B.phone "직속상관연락처"
	from emp_table A
		inner join emp_table B
         on A.manager=B.emp
	where A.emp = '경리부장';
	
 -- ----------------------------------
 -- 12강
 -- ----------------------------------
 drop procedure if exists ifProc1;
 
delimiter $$
create procedure ifProc1()
begin
	if 100=100 then
		select '100은 100과 같습니다';
	end if;
end $$
delimiter ;
call ifProc1();

drop procedure if exists ifProc2;
delimiter $$
create procedure ifProc2()
begin
	declare myNum int; -- mynum 변수선언
    set myNum=200; -- 변수에 값 대입
    if myNum = 100 then
		select '100입니다';
	else 
		select '100이 아닙니다.';
	end if;
end $$
delimiter ;
call ifProc2();

drop procedure if exists ifProc3;
delimiter $$
create procedure ifProc3()
begin
	declare debutDate Date; -- 데뷔일
    declare curDate Date; -- 오늘
    declare days int; -- 활동한 일수
    
    select debut_date into debutDate -- debute_date 결과를 hireDate에 대입
     from market_db.member
     where mem_id = 'APN';
     
     set curDate = current_date(); -- 현재날짜
     set days = datediff(curDate,debutDate); -- 날짜의 차이 일단위
     
     if (days/365)>=5 then -- 5년이 지났다면
		select concat('데뷔한지',days,'일이나 지났습니다 ㅊㅊ!');
	else 
		select '데뷔한지'+days+'얼마안됨 ㅋㅋ';
	end if;
end$$
delimiter ;
call ifProc3();

select current_date(), datediff('2021-12-31','2000-1-1');

drop procedure if exists caseProc;
delimiter $$
create procedure caseProc()
begin
	declare point int;
    declare credit char(1);
    set point =88;
    
    case
		when point >=90 then
			set credit = 'A';
		when point >= 80 then
			set credit = 'B';
		when point >= 70 then
			set credit = 'C';
		when point >= 60 then 
			set credit = 'D';
		else
			set credit = 'F';
	end case;
    select concat('취득점수==>',point),concat('학점==>',credit);
end$$
delimiter ;
call caseProc();

select mem_id, sum(price*amount) '총구매액'
	from buy
    group by mem_id;
    
select mem_id, sum(price*amount) '총구매액'
	from buy
    group by mem_id
    order by sum(price*amount) desc;
    
select B.mem_id,M.mem_name,sum(price*amount) "총구매액"
	from buy B
		inner join member M
		on B.mem_id = M.mem_id
	group by B.mem_id
    order by sum(price*amount) Desc;
    
select M.mem_id, M.mem_name, sum(price*amount) "총구매액"
	from buy B
     right outer join member M
     on B.mem_id = M.mem_id
	group by M.mem_id
    order by sum(price*amount) desc;
    
select M.mem_id, M.mem_name, sum(price*amount) "총구매액",
	case
		when (sum(price*amount)>=1500) then '최우수고객'
        when (sum(price*amount) >= 1000) then '우수고객'
        when (sum(price*amount)>=1) then '일반고객'
        else '유령고객'
	end '회원등급'
from buy B
 right outer join member M
 on B.mem_id =M.mem_id
group by M.mem_id
order by sum(price*amount) desc;

drop procedure if exists whileProc; 
delimiter $$
create procedure whileProc()
begin
	declare i int; -- 1~100 증가할 정수 변수
    declare hap int; -- 더한값을 누적할 변수
    set i =1;
    set hap = 0;
    
    while(i<=100) do
		set hap=hap+i; -- 합= 합 플러스 아이
        set i=i+1 ; -- i 1씩증가
	end while;
    
    select '1부터 100까지의합 ==>',hap;
end $$
delimiter ;
call whileProc();

drop procedure if exists whileProc2;
delimiter $$
create procedure whileProc2()
begin 
	declare i int;
    declare hap int;
    set i = 1;
    set hap = 0;
    
    myWhile: -- while 문에 label을 지정
    while (i<=100) do 
		if(i%4=0) then -- % : 나눈 나머지
			set i = i+1;
            iterate myWhile; -- 지정한 label 문으로 가서 계속 진행
		end if;
        set hap=hap+i;
        if (hap>1000) then
         leave myWhile; -- 지정한  label 문을 떠남 
		end if;
        set i = i+1;
	end while;
    
	select '1부터 100까지의 합(4의 배수 제외), 1000넘으면 종료 ==>', hap;
end $$
delimiter ;
call whileProc2();

use market_db;
prepare myQuery from 'select * from member where mem_id = "BLK"';
execute myQuery;
deallocate prepare myQuery; -- 해제

drop table if exists gate_table;
create table gate_table (id int auto_increment primary key, entry_time datetime);

set @curDate=current_timestamp(); -- 현재 날짜와 시간

prepare  myQuery from 'insert into gate_table values(NULL,?);';
execute myQuery using @curDate;
deallocate prepare myQuery;

select * from gate_table;