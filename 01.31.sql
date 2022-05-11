use market_db;
-- 프로시저
drop procedure if exists user_proc;
delimiter $$
create procedure user_proc()
begin
	select * from member;
end $$
delimiter ;

call user_proc(); 

drop procedure user_proc;

use market_db;
drop procedure if exists user_proc1;
delimiter $$
create procedure user_proc1(in userName varchar(10))
begin 
	select * from member where mem_name = userName;
end $$
delimiter ;
call user_proc1('에이핑크');

drop procedure if exists user_proc2;
delimiter $$
create procedure user_proc2(
in userNumber int,
in userHeight int)
begin 
	select * from member
		where mem_number>userNumber AND height > userHeight;
end $$
delimiter ;

call user_proc2(6,165);

drop procedure if exists user_proc3;
delimiter $$
create procedure user_proc3(
in txtValue char(10),
out outValue int
)
begin
	insert into notable values(NULL,txtValue);
    select max(id) into outValue from notable;
end $$
delimiter ;

desc notable;

create table if not exists notable(
id int auto_increment primary key,
txt char(10)
);

call user_proc3('테스트1',@myValue);
select concat('입력된 ID 값 ==>', @myValue);

drop procedure if exists ifelse_proc;
delimiter $$
create procedure ifelse_proc(
in memName varchar(10)
)
begin
	declare debutYear int; -- 변수 선언
    select year(debut_date) into debutYear from member
		where mem_name = memName;
	if (debutYear >= 2015) then
		select '신인 가수네요. 화이팅 하세요' as '메세지';
	else
		select '고참 가수네요. 그동안 수고하셨어요' as '메세지';
	end if;
end $$
delimiter ; 
call ifelse_proc ('오마이걸');
select year(curdate()),month(curdate()),day(curdate());

drop procedure if exists while_proc;
delimiter $$
create procedure while_proc()
begin
	declare hap int; -- 합계
    declare num int; -- 1부터 100까지 증가
    set hap =0; -- 합계 초기화
	set num =1;
    
    while (num <= 100) do -- 100까지 반복
		set hap = hap + num;
        set num = num +1; -- 숫자증가
	end while;
    select hap as '1~100 합계';
end $$
delimiter ;

call while_proc();

drop procedure if exists dynamic_proc;
delimiter $$
create procedure dynamic_proc(
in tableName varchar(20)
)
begin
	set @sqlQuery = concat('select * from ', tableName); -- from 뒤에 띄어쓰기 주의
    prepare myQuery from @sqlQuery;
    execute myQuery;
    deallocate  prepare myQuery;
end $$
delimiter ;

call dynamic_proc('member');

-- -------------------------
-- 스토어드 함수, 커서
-- -----------------------------
set global log_bin_trust_function_creators = 1;

use market_db;
drop function if exists sumFunc;
delimiter $$
create function sumFunc(number1 int, number2 int)
	returns int -- 반환하는 자료형인가?
begin 
	return number1+number2;
end $$
delimiter ;

select sumFunc(100,200) as '합계';

drop function if exists calcYearFunc;
delimiter $$
create function calcYearFunc(dYear int)
	returns int
begin
	declare runYear int; -- 활동기간(연도)
    set runYear = Year(curdate()) - dYear;
    return runYear;
end $$
delimiter ;

select calcYearFunc(2010) as '활동햇수';

select calcYearFunc(2007) into @debut2007;
select calcYearFunc(2013) into @debut2013;
select @debut2007-@debut2013 as '2007과 2013 차이';

select mem_id, mem_name, calcYearFunc(YEAR(debut_date)) as '활동 햇수'
	from member;

show create function calcYearFunc;

drop function calcYearFunc;

use market_db;
drop procedure if exists cursor_proc;

delimiter $$
create procedure cursor_proc()
begin
	declare memNumber int; -- 회원의 인원수
    declare cnt int default 0; -- 읽은 행의수
    declare totNumber int default 0; -- 인원의 합계
	declare endOfRow boolean default false; -- 행의 끝 여부(기본을 False)
    
    declare memberCuror cursor for -- 커서 선언
		select mem_number from member;

	declare continue handler 
		for not found set endOfRow = true;
        
	open memberCuror; -- 커서 열기
    
    cursor_loop: Loop
		Fetch memberCuror into memNumber;
        
		if endOfRow then
			leave cursor_loop;
		end if;
        
        set cnt = cnt +1;
        set totNumber = totNumber + memNumber;
	end loop cursor_loop;
    
    select (totNumber/cnt) as '회원의 평균 인원 수';
    
    close memberCuror;
end $$
delimiter ;

call cursor_proc();

-- ?????????????????? 커서 이해안됨

-- ------------------------------------------------
-- 트리커 
-- ---------------------------------------------
use market_db;
drop table if exists trigger_table;
create table if not exists trigger_table (id int, txt varchar(10));
insert into trigger_table values(1,'레드벨벳');
insert into trigger_table values(2, '잇지');
insert into trigger_table values(3,'블랙핑크');

drop trigger if exists myTrigger;
delimiter $$
create trigger myTrigger -- 트리거 이름
	after delete -- 삭제후 작동
    on trigger_table -- 트리거를 부착할 테이블
    for each row -- 각 행마다 적용시킴
begin
	set @msg = '가수 그룹이 삭제됨' ; -- 트리거 실행시 작동되는 코드들
end $$
delimiter ;

set @msg = '';
insert into trigger_table values(4,'마마무');
select @msg ; -- 인설트 라 트리거 작동안함
update trigger_table set txt='블핑' where id = 3;
select @msg; -- 업데이트라 작동 안함

delete from trigger_table where id=4;
select @msg;

use market_db;
create table singer (select mem_id,mem_name,mem_number, addr from member);

drop table if exists backup_singer;
create table backup_singer(
mem_id char(8) not null,
mem_name varchar(10) not null,
mem_number int not null,
addr char(2) not null,
modType char(2), -- 변경된 타입 '수정' 또는 '삭제'
modDate date, -- 변경된 날짜
modUser varchar(30) -- 변경한 사용자
);

drop trigger if exists singer_updateTrg;
delimiter $$
create trigger singer_updateTrg -- 트리거 이름
	after update -- 변경 후에 작동하도록 지정
    on singer -- 트리거를 부착할 테이블
    for each row
begin
	insert into backup_singer values(OLD.mem_id,OLD.mem_name,OLD.mem_number,
    OLD.addr, '수정', curdate(),current_user());
end $$
delimiter ;

drop trigger if exists singer_deleteTRg
delimiter $$
create trigger singer_deleteTrg
	after delete -- 삭제 후에 작동하도록 지정
    on singer -- 트리거를 부착할 테이블
    for each row
begin
	insert into backup_singer values(OLD.mem_id,OLD.mem_name,OLD.mem_number,
    OLD.addr,'삭제',curdate(),current_user());
end $$
delimiter ;

update singer set addr = '영국' where mem_id = 'BLK';
delete from singer where mem_number >= 7;

select * from backup_singer;

truncate table singer; -- 이거 무냐 시발

select * from backup_singer;






















































