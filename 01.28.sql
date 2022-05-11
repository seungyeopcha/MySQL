-- ----------------------------------------------
-- 15장
-- ----------------------------------
use market_db;
create table table1(
col1 int primary key,
col2 int,
col3 int
);
show index from table1; -- show 가 뭘까??

create table table2(
col1 int primary key,
col2 int unique,
col3 int unique -- UNIQUE 제약 조건을 설정하면, 해당 필드는 서로 다른 값을 가져야 합니다.
);
show index from table2;

use market_db;
drop table if exists buy, member;
create table member(
mem_id char(8),
mem_name varchar(10),
mem_number int,
addr char(2)
);

insert into member values('TWC','트와이스',9,'서울');
insert into member values('BLK','블랙핑크',4,'경남');
insert into member values('WMN','여자친구',6,'경기');
insert into member values('OMY','오마이걸',7,'서울');
select * from member;

alter table member
	add constraint
    primary key (mem_id);
select * from member;

alter table member drop primary key; -- 기본키 제거
alter table member
	add constraint
    primary key(mem_name);
select * from member;

insert into member values('GRL','소녀시대',8,'서울');
select * from member;

use market_db;
drop table if exists member;
create table member(
mem_id char(8),
mem_name varchar(10),
mem_number int,
addr char(2)
);

insert into member values('TWC','트와이스',9,'서울');
insert into member values('BLK','블랙핑크',4,'경남');
insert into member values('WMN','여자친구',6,'경기');
insert into member values('OMY','오마이걸',7,'서울');
select * from member;

alter table member
	add constraint
    unique(mem_name);
select * from member;

alter table member
	add constraint
    unique(mem_name); -- ????? 시발 얘네 뭐하느 건데
select * from member;

insert into member values('GRL','소녀시대',8,'서울');
 select * from member;
 
-- ---------------------------------------------------
-- 16강
-- -------------------------------------
use market_db;
create table cluster -- 클러스터형 테이블
(
mem_id char(8),
mem_name varchar(10)
);
insert into cluster values('TWC','트와이스');
insert into cluster values('BLK','블랙핑크');
insert into cluster values('WMN','여자친구');
insert into cluster values('GRL','소녀시대');
insert into cluster values('ITZ','잇지');
insert into cluster values('RED','레드벨벳');
insert into cluster values('APN','에이핑크');
insert into cluster values('SPC','우주소녀');
insert into cluster values('MMU','마마무');
select * from cluster;

alter table cluster
	add constraint
    primary key (mem_id);
select * from cluster;

use market_db;
create table second -- 보조인덱스 테이블
(
mem_id char(8),
mem_name varchar(10)
);
insert into second values('TWC','트와이스');
insert into second values('BLK','블랙핑크');
insert into second values('WMN','여자친구');
insert into second values('OMY','오마이걸');
insert into second values('GRL','소녀시대');
insert into second values('ITZ','잇지');
insert into second values('APN','에이핑크');
insert into second values('SPC','우주소녀');
insert into second values('MMU','마마무');

alter table second
	add constraint
    unique (mem_id);

select * from second;
-- -----------------------------------
-- 17강 -- 인덱스 활용
-- ------------------------------
use market_db;
select * from member;

show index from member;

show table status like 'member'; -- 뭔 개소리야

create index idx_member_addr
	on member (addr);


show index from member;

show table status like 'member';

analyze table member;
show table status like 'member';

create unique index idx_member_mem_number
	on member (mem_number); -- 오류발생 
    
create unique index idx_member_mem_name
	on member (mem_name);
    
show index from member;

insert into member values('MOO','마마무',2,'태국','001','12341234',155,'2020.10.10');

analyze table member; -- 지금까지 만든 인덱스르 모두 적용
show index from member;

select * from member;

select mem_id, mem_name, addr from member;

select mem_id,mem_name,addr
	from member
    where mem_name = '에이핑크';
    
create index idx_member_mem_number
	on member (mem_number);
analyze table member; -- 인덱스 적용

create index idx_member_mem_number
	on member (mem_number);
analyze table member; -- 인덱스 적용

select mem_name, mem_number
	from member
    where mem_number >= 7;
    
select mem_name, mem_number
	from member
    where mem_number >= 1;
    
select mem_name, mem_number
	from member
    where mem_number*2 >= 14;
    
select mem_name, mem_number
	from member
    where mem_number>= 14/2;
    
show index from member;

drop index idx_member_mem_name on member;
drop index idx_member_addr on member;
drop index idx_member_mem_number on member;

alter table member
	drop primary key;
    
select table_name, constraint_name
	from information_schema.referential_constraints
    where constraint_schema = 'market_db'
  
-- 뭐야 이거 ㅅㅂ
alter table buy
	drop foreign key buy_ibfk_1;
alter table member
	drop primary key;
-- ????? 

 select mem_id, mem_name, mem_number,addr
	from member
    where mem_name = '에이핑크';










