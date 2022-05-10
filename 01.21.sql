use market_db;

select * from member where mem_number = 4;

select mem_id, mem_name
	from member
	where height <= 162;
    
select mem_name, height, mem_number
	from member
    where height>=165 and mem_number > 6;
    
select mem_name, height, mem_number
	from member
    where height>=165 or mem_number > 6;
    
select mem_name, height
	from member
    where height>=165 and height <=165;
    
select mem_name, height
	from member
    where height between 163 and 165;
    
select mem_name, addr
	from member
    where addr = '경기' or addr='전남' or addr= '경남';
    
select mem_name, addr
	from member
    where addr in('경기','전남','경남');
    
select *
	from member
    where mem_name like '우%';
    
select *
	from member
    where mem_name like '__핑크';

-- 8강
select mem_id, mem_name, debut_date
	from member
    order by debut_date; -- asc
    
select mem_id, mem_name, debut_date
	from member
    order by debut_date desc; -- 내림차순
    
select mem_id, mem_name, debut_date
	from member
    where height >= 164
    order by debut_date desc;
    
select mem_id, mem_name, debut_date
	from member
    where height >= 164
    order by height desc, debut_date asc;
    
select *
	from member
    limit 3 ; -- 3개 행만 봄
    
 select *
	from member
    order by debut_date
    limit 3 ; -- 3개 행만 봄
       
select *
	from member
    order by height desc
    limit 3,2 ; -- 3번째 부터 2개 행만 봄	

select addr from member;

select addr from member order by addr;

select distinct addr from member; -- 중복된건 하나만

select mem_id, sum(amount) from buy group by mem_id;

select mem_id "회원 아이디", sum(amount) "총 구매 개수"  from buy group by mem_id;

select mem_id "회원 아이디", sum(price*amount) "총 구매 개수"  from buy group by mem_id;

select avg(amount) "평균 구매 개수" from buy;

select mem_id, avg(amount) "평균 구매 개수" 
	from buy
    group by mem_id;
    
select count(phone1) "연락처가 있는 회원" from member; -- 값이 있는 값만 카운트

select mem_id '회원 아이디', sum(price*amount) "총 구매 금액"
	from buy
    group by mem_id
	having sum(price*amount) > 1000; 
    
select mem_id '회원 아이디', sum(price*amount) "총 구매 금액"
	from buy
    group by mem_id
	having sum(price*amount) > 1000
    order by sum(price*amount) desc;

-- 8강


    
    