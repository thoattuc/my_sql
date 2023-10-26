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

-- thêm discount: (100-discount)*giá/100*Số lượng
select 	hd.tenKH as'Tên người mua', hd.created_at as 'ngày đặt hàng', users.name as 'username', p.name as 'sản phẩm',
		p.price as 'Giá', hd_detail.soLuong as 'Số lượng', ceil((100-p.discount)*(total_cost(p.price, hd_detail.soLuong))/100) as 'Thành tiền'
from hoa_don as hd
inner join hoa_don_chi_tiet as hd_detail on hd.id = hd_detail.idHD
inner join products as p on hd_detail.idSP = p.id
inner join users on hd.idUser = users.id
where hd.id = 87 OR hd.id = 88;

-- SORT: ASC - DESC
-- YC: Sap xep thong tin tai khoan ngay tao tai khoan, DK: tang dan

SELECT * FROM hoa_don order BY created_at DESC;

-- SET điểm chặn LIMIT: ... + LIMIT + Number;
SELECT * from hoa_don  LIMIT 10;

-- count:
-- Tổng tiền += Thành tiền
select 	hoa_don_chi_tiet.idHD as 'Mã hóa đơn', count(idSP) as 'Số lượng sản phẩm',
		sum(ceil((100-products.discount)*(total_cost(products.price, hoa_don_chi_tiet.soLuong))/100)) as 'Tổng tiền'
from hoa_don_chi_tiet join products
on hoa_don_chi_tiet.idSP = products.id
where hoa_don_chi_tiet.idHD = 87;

-- 1. GROUP BY: ...+ group by + collumn + order by;
select	count(idSP) as 'Số lượng sản phẩm',
		sum(ceil((100-products.discount)*(total_cost(products.price, hoa_don_chi_tiet.soLuong))/100)) as 'Tổng tiền'
from hoa_don_chi_tiet join products
on hoa_don_chi_tiet.idSP = products.id
GROUP BY hoa_don_chi_tiet.idHD;

-- ============================================================
-- 1. Đếm số lượng tài khoản trong mỗi loại : Tên loại và số lượng:
SELECT roles.name as 'Loại tài khoản', COUNT(idRole) as 'Số lượng'
from users join roles
WHERE users.idRole = roles.id
GROUP BY roles.name;

-- 2. Đếm số lượng sản phẩm trong từng loại: Tên loại + Số lượng:
select categrories.name 'Loại hàng', COUNT(products.id) as 'Số lượng sản phẩm'
from categrories
left join products
on categrories.id = products.idCate
group by categrories.name;

-- 3. Lấy ra sản phẩm có số lượng bán cao nhất:
select	products.name as 'Sản phẩm',
		count(idSP) as 'Số lượng',
		sum(ceil((100-products.discount)*(total_cost(products.price, hoa_don_chi_tiet.soLuong))/100)) as 'Tổng tiền'
from hoa_don_chi_tiet
join products on hoa_don_chi_tiet.idSP = products.id
GROUP BY hoa_don_chi_tiet.idHD
ORDER BY count(idSP) DESC
LIMIT 1;

-- 4. Lấy ra sản phẩm có doanh thu cao nhất:
select	products.name as 'Sản phẩm',
		count(idSP) as 'Số lượng',
		sum(ceil((100-products.discount)*(total_cost(products.price, hoa_don_chi_tiet.soLuong))/100)) as 'Tổng tiền'
from hoa_don_chi_tiet
join products on hoa_don_chi_tiet.idSP = products.id
GROUP BY hoa_don_chi_tiet.idHD
ORDER BY 'Tổng tiền' DESC
LIMIT 1;

-- SELECT MAX(subquery.`Tổng tiền`) as 'Tổng tiền lớn nhất'
-- FROM (
--     SELECT
--         products.name as 'Sản phẩm',
--         count(idSP) as 'Số lượng',
--         sum(ceil((100-products.discount)*(total_cost(products.price, hoa_don_chi_tiet.soLuong))/100)) as 'Tổng tiền'
--     FROM hoa_don_chi_tiet
--     JOIN products ON hoa_don_chi_tiet.idSP = products.id
--     GROUP BY hoa_don_chi_tiet.idHD
-- ) as subquery;

-- ==========================================================
use db_practice;
-- 1. Liệt kê thông tin tài khoản : Tên tài khoản, trạng thái , ngày tạo , tên loại tài khoản
SELECT users.name, users.status, users.created_at, roles.name
from users
join roles on users.idRole = roles.id;

-- 2. Liệt kê danh sách loại tài khoản: Tên loại tài khoản , số lượng tài khoản trong loại
select roles.name, COUNT(users.id)
from roles
left join users on roles.id = users.idRole
GROUP BY roles.id;

-- 3. Liệt kê các tài khoản có mua hàng trong tháng 8
select users.name as 'Ten khach hang', COUNT(hoa_don.idUser) as 'So luong don dat', hoa_don.created_at as 'Ngay mua hang'
from users
inner join hoa_don on users.id = hoa_don.idUser
where date_format(hoa_don.created_at, '%Y-%m') = '2023-08'
GROUP BY hoa_don.idUser;

-- 4. Liệt kê các tài khoản có mua hàng vào tháng 9
select users.name as 'Ten khach hang', COUNT(hoa_don.idUser) as 'So luong don dat', hoa_don.created_at as 'Ngay mua hang'
from users
inner join hoa_don on users.id = hoa_don.idUser
where date_format(hoa_don.created_at, '%Y-%m') = '2023-09'
GROUP BY hoa_don.idUser;

-- 5. Tổng tiền hoá đơn của các tài khoản trong tháng 8
select	users.name as 'Ten khach hang',
		COUNT(hoa_don.idUser) as 'So luong don dat',
		date_format(hoa_don.created_at, '%Y-%m-%d') as 'Ngay mua hang',
        sum(ceil((100-products.discount)*(total_cost(products.price, hoa_don_chi_tiet.soLuong))/100)) as 'Tổng tiền'
from users
join hoa_don on users.id = hoa_don.idUser
join hoa_don_chi_tiet on hoa_don.id = hoa_don_chi_tiet.idHD
join products on hoa_don_chi_tiet.idSP = products.id
where date_format(hoa_don.created_at, '%Y-%m') = '2023-08'
GROUP BY hoa_don.idUser;

-- 6. Lấy ra danh sách tài khoản chưa mua hàng trong tháng 9
select users.name as 'Ten khach hang', COUNT(hoa_don.idUser) as 'So luong don dat', hoa_don.created_at as 'Ngay mua hang'
from users
inner join hoa_don on users.id = hoa_don.idUser
where NOT (date_format(hoa_don.created_at, '%Y-%m') = '2023-09')
GROUP BY hoa_don.idUser;

-- 7. Lấy ra sản phẩm có số lượng mua cao nhất:
select 	products.name,
		count(idSP) as 'So luong'
from hoa_don_chi_tiet
join products on hoa_don_chi_tiet.idSP = products.id
GROUP BY hoa_don_chi_tiet.idHD
ORDER BY count(idSP) DESC
LIMIT 1;

-- 8.
-- 9. Lấy ra sản phẩm mang lại doanh thu thấp nhất
		