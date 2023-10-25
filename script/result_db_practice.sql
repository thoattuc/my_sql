use db_practice;

-- INSERT INTO ten_bang (cot1, cot2, ...) VALUES (gia_tri1, gia_tri2, ...);
-- UPDATE ten_bang SET cot1 = gia_tri1, cot2 = gia_tri2, ... WHERE dieu_kien;
-- SELECT cot1, cot2, ... FROM ten_bang WHERE dieu_kien ORDER BY cot_sap_xep ASC/DESC;
-- DELETE FROM ten_bang WHERE dieu_kien;

insert into roles (name, created_at) value ('testRole', current_timestamp());

update roles 
SET name = 'testUpdate' 
where id = 7;

select * from roles where name = "admin";

select id as idRole
from roles
where name = 'testUpdate';

delete from roles
where name = "testUpdate";

-- Join
-- SELECT t1.cot1, t2.cot2, ... FROM ten_bang1 AS t1 INNER JOIN ten_bang2 AS t2 ON t1.cot_chung = t2.cot_chung;

SELECT u.id, u.name, u.status , r.name AS role FROM users as u INNER JOIN roles AS r ON u.idRole = r.id;

-- 1 lay thong tin user
select users.id as idUser, users.name as username, users.status, roles.name as role
from users
inner join roles 
on users.idRole = roles.id
order by username ASC;

-- 2 lay thong tin hoa don va ten tai khoan mua hang
select hoa_don.*, users.name as username from hoa_don
inner join users
on hoa_don.idUser = users.id;

-- 3 Lấy thông tin đơn hàng: Mã đơn hàng 87 và 88: 
-- Tên người mua hàng, ngày đặt hàng, tên tài khoản mua hàng, tên sản phẩm đơn hàng, giá sản phẩm, số lượng  mua & Thành tiền ((100-discount)*giá/100*Số lượng)
DELIMITER $$
CREATE FUNCTION total_cost(price DECIMAL(10, 2), quantity INT)
RETURNS DECIMAL(10, 2)
BEGIN
  DECLARE total DECIMAL(10, 2);
  SET total = price * quantity;
  RETURN total;
END $$
DELIMITER ;

select 	hd.tenKH as'Tên người mua', hd.created_at as 'ngày đặt hàng', users.name as 'username', p.name as 'sản phẩm',
		p.price as 'Giá', hd_detail.soLuong as 'Số lượng', total_cost(p.price, hd_detail.soLuong) as 'Thành tiền'
from hoa_don as hd
inner join hoa_don_chi_tiet as hd_detail on hd.id = hd_detail.idHD
inner join products as p on hd_detail.idSP = p.id
inner join users on hd.idUser = users.id
where hd.id = 87 OR hd.id = 88;