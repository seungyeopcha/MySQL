-- -------------------
-- 5장
-- ---------------------
create database naver_db;

create table sample_table (num int);

drop database if exists naver_db;
create database naver_db;

use naver_db;
drop table if exists member;
create table member       -- 회원 테이블
(mem_id char(8), 
mem_name varchar(10),
mem_number tinyint,
addr char(2),
phone1 char(3),
phone2 char(8),
height tinyint unsigned,
debute_date date);

drop table if exists member;
create table member
(mem_id char(8) not null,
mem_name varchar(10) not null,
mem_number tinyint not null,
addr char(2) not null,
phone1 char(3) null,
phone2 char(8) null,
height tinyint unsigned null,
debut_date date null
);

drop table if exists member;
create table member 
(mem_id char(8) not null primary key,
mem_name varchar(10) not null,
mem_number tinyint not null,
addr char(2) not null,
phone1 char(3) null,
phone2 char(8) null,
height tinyint unsigned null,
debute_date date null
);

drop table if exists buy;
create table buy
(num int auto_increment not null primary key,
mem_id char(8) not null,
prod_name char(6) not null,
group_name char(4) not null,
price int unsigned not null,
amount smallint unsigned not null
);

drop table if exists buy;
create table buy
(num int auto_increment not null primary key,
mem_id char(8) not null,
prod_name char(6) not null,
group_name char(4) null,
price int unsigned not null,
amount smallint unsigned not null,
foreign key(mem_id) references member(mem_id)
);

insert into member values('TWC','트와이스',9,'서울','02','11111111',167,'2015-10-19');
insert into member values('BLK','블랙핑크',4,'경남','055','22222222',163,'2016-8-8');
insert into member values('WMN','여자친구',6,'경기','031','33333333',166,'2015-1-15');

insert into buy values(null,'BLK','지갑',NULL,30,2);
insert into buy values(null,'BLK','맥북프로','디지털',1000,1);
insert into buy values(null,'APN','아이폰','디지털',200,1); -- 회원이 아니라 등록안됨

-- ----
-- 13강
use naver_db;
drop table if exists buy, member;

-- 기본키 설정
create table member
(mem_id char(8) not null primary key,
mem_game varchar(10) not null,
height tinyint unsigned null
);

describe member; -- 테이블구조 확인

drop table if exists member;
create table member
(mem_id char(8) not null,
mem_name varchar(10) not null,
height tinyint unsigned null,
primary key(mem_id)
);

drop table if exists member;
create table member (
mem_id char(8) not null,
mem_name varchar(10) not null,
height tinyint unsigned null
);

-- 테이블에 프라이머리키 추가
alter table member -- 테이블을 수정해라 alter
	add constraint
    primary key(mem_id); 

drop table if exists member;
create table member(
mem_id char(8) not null,
mem_name varchar(10) not null,
height tinyint unsigned null,
constraint primary key Pk_member_mem_id(mem_id) -- 이거 뭐임?
);

-- 외래키 설정
drop table if exists buy, member;
create table member(
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint unsigned null
);

create table buy(
num int auto_increment not null primary key,
mem_id char(8) not null,
prod_name char(6) not null,
foreign key(mem_id) references member(mem_id) -- references 참조한다 
);

drop table if exists buy, member;

create table member(
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint unsigned null
);
create table buy(
num int auto_increment not null primary key,
user_id char(8) not null,
prod_name char(6) not null,
foreign key(user_id) references member(mem_id)
);

drop table if exists buy;

create table buy(
num int auto_increment not null primary key,
mem_id char(8) not null,
prod_name char(6) not null
);
alter table buy
	add constraint
    foreign key(mem_id) references member(mem_id);
    
insert into member values('BLK','블랙핑크',163);
insert into buy values(null,'BLK','지갑');
insert into buy values(null,'BLK','맥북');

select M.mem_id, M.mem_name, B.prod_name
	from buy B
		inner join member M
		on B.mem_id =M.mem_id;
-- 데이터 수정 UPDATE 테이블명 SET 컬럼1 = 수정값1 [, 컬럼2 = 수정값2 ...] [WHERE 조건];
update member set mem_id = 'PINK' where mem_id='BLK';
-- 데이터 삭제
delete from member where mem_id ='BLK';

-- 외래키 업데이트 딜리트
drop table if exists buy;
create table buy(
num int auto_increment not null primary key,
mem_id char(8) not null,
prod_name char(6) not null
);
alter table buy
	add constraint
    foreign key(mem_id) references member(mem_id)
    on update cascade -- 업데이트할시 자식테이블도 업데이트
    on delete cascade; -- 삭제할시 자식테이블에서도 삭제

insert into buy values(null,'BLK','지갑');
insert into buy values(null,'BLK','맥북');

update member set mem_id = 'pink' where mem_id='BLK';

select M.mem_id, M.mem_name, B.prod_name
	from buy B
		inner join member M
		on B.mem_id = M.mem_id;
        
delete from member where mem_id='PINK';

select * from buy;

-- unique ------------
drop table if exists buy, member;
create table member(
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint unsigned null,
email char(30) null unique -- unique == 중복된값 지정 x
);

insert into member values('BLK','블랙핑크',163,'pink@gmail.com');
insert into member values('TWC','트와이스',167,NULL);
insert into member values('APN','에이핑크',164,'pink@gmail.com'); -- unique  때문에 안됨 
select*from member;
-- check ----------
drop table if exists member;
create table member(
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint  unsigned null check (height>=100), --  check : COLUMN에 들어갈 수 있는 값을 제한
phone1 char(3) null
);
insert into member values('BLK','블랙핑크',163,NULL);
insert into member values('TWC','트와이스',99,NULL); -- check

alter table member
	add constraint
    check (phone1 in ('02','031','032','054','055','061'));

insert into member values('TWC','트와이스',167,'02');
insert into member values('OMY','오마이걸',167,'010'); -- check

-- default -----
drop table if exists member;
create table member(
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint unsigned null default 160, -- 기본값 160 설정 + unsigned => 사용범위가 양수로 옮겨짐
phone1 char(3) null
);

alter table member
	alter column phone1 set default '02';
    
insert into member values('RED','레드벨벳',161,'054');
insert into member values('SPC','우주소녀',default,default);
select * from member;
-- ------------------------------------
-- 14강 ----------------가상의 테이블 : 뷰
-- ----------------------------
use market_db;
select mem_id,mem_name,addr from member;

use market_db;
create view v_member
as -- 이렇게 하는 뷰를 v_memeber 라는 이름으로 만들겠다.
	select mem_id,mem_name,addr from member;

select * from v_member;

select mem_name,addr from v_member
	where addr in ('서울','경기'); -- 주소가 서울 경기인 주소만 보여주는 뷰 만들기
    
 select B.mem_id, M.mem_name, B.prod_name,M.addr,
		concat(M.phone1,M.phone2) '연락처'
    from buy B
		inner join member M
		on B.mem_id = M.mem_id; -- 이 기준으로 이너조인
    
create view v_memberbuy
as 
	select B.mem_id,M.mem_name,B.prod_name,M.addr,
			concat(M.phone1,M.phone2) '연락처'
		from buy B
			inner join member M
			on B.mem_id = M.mem_id;

select * from v_memberbuy where mem_name = '블랙핑크';

use market_db;
create view v_viewtest1
as
	select B.mem_id 'Member ID', M.mem_name AS 'Member Name',
		B.prod_name 'Product Name',
        concat(M.phone1, M.phone2) AS 'Office Phone'
	from buy B
     inner join member M
     on B.mem_id = M.mem_id;

select distinct `Member ID`,`Member Name`from v_viewtest1; -- 백틱을 사용 -- distinct : 범주조회
-- ' 문자열 리터럴을 묶기위한 것 - 따옴표
-- ` 테이블 및 열 이름과 같은 식별자를 묶는 데 사용 - 백틱

alter view v_viewtest1
as
	select B.mem_id '회원 아이디', M.mem_name as '회원 이름',
			B.prod_name '제품 이름',
            concat(M.phone1,M.phone2) as '연락처'
		from buy B
			inner join member M
            on B.mem_id =M.mem_id;

select distinct `회원 아이디`,`회원 이름` from v_viewtest1;

drop view v_viewtest1;

use market_db;
create or replace view v_viewtest2
as
	select mem_id,mem_name,addr from member;
    
describe v_viewtest2; -- 자료형태 확인

describe member;

show create view v_viewtest2;

update v_member set addr = '부산' where mem_id = 'BLK';

insert into v_member(mem_id,mem_name,addr)values('BTS','방탄소년단','경기'); -- 뭘깡 not null 값에 맞는 값이 없어서 못들어가는듯

create view v_height167
as
	select * from member where height >= 167;
    
select * from v_height167;

delete from v_height167 where height<167;

insert into v_height167 values('TRA','티아라',6,'서울',NULL,NULL,159,'2005-01-01');

select * from v_height167;

alter view v_height167
as
	select * from member where height >= 167
		with check option; -- 조건에 사용 되어진 컬럼값은 뷰를 통해서는 변경이 불가능하다.
    
insert into v_height167 values('TEB','텔레토비',4,'영국',NULL,NULL,159,'2005-01-01'); -- check option 
select * from v_height167;

alter view v_height167
as
	select * from member where height >= 167
		with check option;
        
insert into v_height167 values('TOB','텔레토비',4,'영국',NULL,NULL,140,'1995-01-01');

create view v_complex
as
	select B.mem_id,M.mem_name,B.prod_name,M.addr
		from buy B
			inner join member M
			on B.mem_id = M.mem_id;
            
drop table if exists buy,member;

select * from v_height167; -- ???

check table v_height167;











