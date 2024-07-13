create database giuaki
use giuaki

create table chitietdonhang(
	giadonhang int,
	soluong int,
	madonhang varchar(30),
	ngaydathang date,
	primary key (giadonhang,soluong,madonhang)
)

create table donhang(
	madonhang varchar(30),
	macuahang varchar(30),
	giadonhang int,
	stt int,
	primary key (madonhang)
)

create table cuahang(
	macuahang varchar(30),
	diachi varchar(30),
	sofax int,
	primary key (macuahang)
)

create table khohang(
	mamathang varchar(30),
	macuahang varchar(30),
	soluongmh int,
	primary key (mamathang)
)

create table spnoithat(
	masanpham varchar(30),
	macuahang varchar(30),
	gia int,
	malinhkien varchar(30),
	primary key (masanpham)
)

create table hangtonkho(
	masanpham varchar(30),
	soluonghang int,
	primary key (masanpham,soluonghang)
)

create table linhkien(
	malinhkien varchar(30),
	giasx int,
	primary key (malinhkien)
)

create table linhkienchitiet(
	malinhkien varchar(30),
	loailinhkien char(5),
	soluong int,
	primary key(malinhkien,loailinhkien)
)

alter table chitietdonhang with nocheck
add constraint lkchitiet 
foreign key(madonhang)
references donhang(madonhang)

alter table donhang with nocheck
add constraint lkdonhang
foreign key(macuahang)
references cuahang(macuahang)

alter table khohang with nocheck
add constraint lkkhohang
foreign key(macuahang)
references cuahang(macuahang)

alter table spnoithat with nocheck
add constraint lkspnoithat1
foreign key(macuahang)
references cuahang(macuahang)

alter table spnoithat with nocheck
add constraint lkspthat2
foreign key(malinhkien)
references linhkien(malinhkien)

alter table hangtonkho with nocheck
add constraint lkhangtonkho
foreign key(masanpham)
references spnoithat(masanpham)

alter table linhkienchitiet with nocheck
add constraint lklinhkienchitiet
foreign key(malinhkien)
references linhkien(malinhkien)

insert into chitietdonhang
values (17000,10,'abc1','01/01/2019'),
	   (19000,10,'abc2','10/11/2019'),
	   (21000,10,'abc3','02/19/2020')

insert into donhang
values ('abc2','ch01',190000,1),
       ('abc1','ch02',170000,2),
	   ('abc3','ch03',210000,3)

insert into cuahang
values ('ch01','201 duong 3/2 q.10 tpHCM',0981213461),
	   ('ch02','21A9 duong nguyen oanh/go vap',0121315461),
	   ('ch03','73 duong nguyen kiem/phu nhuan',0987323461)

insert into khohang
values ('bo sofa','ch01',36),
	   ('ban lam viec','ch02',45),
	   ('ghe sofa','ch03',69)

insert into spnoithat
values ('bsf','ch01',3900000,'all'),
	   ('gsf','ch02',2900000,'all'),
	   ('blv','ch03',2100000,'all - vai')

insert into hangtonkho
values ('bsf',32),
	   ('gsf',36),
	   ('blv',50)

insert into linhkien
values ('loxo',3000),
	   ('vai',3500),
	   ('chan',5000),
	   ('dinhvit',2000),
	   ('banle',2500),
	   ('all',16000),
	   ('all - vai',12500)


insert into linhkienchitiet
values ('loxo','loai1',72),
       ('loxo','loai2',45),
	   ('vai','loai1',70),
	   ('vai','loai2',27),
	   ('chan','loai1',45),
	   ('chan','loai2',47),
	   ('dinhvit','loai1',100),
	   ('dinhvit','loai2',120),
	   ('banle','loai1',90),
	   ('banle','loai2',97)


--cau1: tim cac ma linh kien co sl >50
SELECT malinhkien,loailinhkien
FROM linhkienchitiet
WHERE soluong > 50

--cau2: tinh gia cho tung san pham biet thue la 20%
select masanpham, gia*1.2 as giasau
from spnoithat

--cau3: tim chi tiet don hang nao co ngay dat hang tu 12/12/2019 tro di
select *
from chitietdonhang
where (MONTH(ngaydathang)>0) and (YEAR(ngaydathang)>2019)

--cau4: tim malk ma voi gia sx lon hon 2500d
select malinhkien
from linhkien
where giasx > 2500

--cau5: tim gia cua tung masp
select gia, masanpham
from spnoithat sp,linhkien lk
where sp.malinhkien = lk.malinhkien

--cau6: hien ro thong tin gia san xuat va so luong cua tung ma loai linh kien	
select lk.malinhkien,giasx, loailinhkien
from linhkienchitiet lkct,linhkien lk
where lkct.malinhkien = lk.malinhkien

--cau7: hien tat ca thong cua linhkienchitiet voi loai la 1
select *
from linhkienchitiet
where loailinhkien='loai1'

--cau 8: tim tong gia duoc liet ke trong spnoithat
select sum(gia) as tatca1bo
from spnoithat

--cau9 : tim trung binh gia do noi that
select avg(gia) as TBmoibo
from spnoithat

--cau10: hien masp, gia sp va giasx = gia linh kien * 70 cua sanpham
select sp.masanpham, sp.gia, lk.giasx*70 as giasxsp
from spnoithat sp join linhkien lk on sp.malinhkien = lk.malinhkien
group by sp.malinhkien, lk.giasx,sp.gia,sp.masanpham

--cau11: tim gia lon nhat cua spnoithat
select max (gia) as spgiacaonhat
from spnoithat

--cau12: hien ma va giasx tung linh kien voi malinhkien = ma linh kien cua san pham
select malinhkien, giasx
from linhkien
where malinhkien in (select sp.malinhkien
					   from spnoithat sp, hangtonkho htk
					   where htk.masanpham = sp.masanpham)

--cau13: tim linhkien voi gia re nhat
select min(giasx) as lkrenhat
from linhkien

--cau14: hien sdt va dia chi cua 3 cua hang
select sofax, diachi
from cuahang
where macuahang in (select dh.macuahang
                    from donhang dh, chitietdonhang ct
					where dh.giadonhang = ct.giadonhang*ct.soluong)

--cau15: hien tat ca chitietcuahang voi giadonhang > 17000
select *
from chitietdonhang
where giadonhang >17000

--cau16: dia chi cua hang voi ma cua hang ch01
select diachi
from cuahang
where macuahang='ch01'

--cau17: so san pham va gia ban cua tung cua voi muc gia san pham > 2500000
select sp.macuahang,sp.masanpham,sp.gia
from spnoithat sp, cuahang ch
group by sp.gia,sp.macuahang,sp.masanpham
having (sp.gia)> 2500000;

--cau18: cho biet ma san pham va so luong cua chung
select *
from hangtonkho

--cau19: cho biet ma san pham va ma linh kien lam ra chung
select masanpham, malinhkien
from spnoithat

--cau20: tinh tong so tien de thanh ly cho tung sp trong hang ton kho
select htk.masanpham , gia*soluonghang as tongchiphi
from hangtonkho htk, spnoithat sp
where htk.masanpham=sp.masanpham

--cau21: tinh tong so tien de thanh ly cho tat ca sp trong hang ton kho
select sum (gia*soluonghang) as tongchiphi
from hangtonkho htk, spnoithat sp
where htk.masanpham=sp.masanpham

--cau22: trung binh tong so tien de thanh ly cho tat ca sp trong hang ton kho
select avg (gia*soluonghang) as TBtongchiphi
from hangtonkho htk, spnoithat sp
where htk.masanpham=sp.masanpham

--cau23: hien chi phi don hang, stt va ngay dat hang cua tung don hang
select dh.stt,dh.madonhang, dh.giadonhang ,ctdh.ngaydathang 
from donhang dh, chitietdonhang ctdh
where dh.madonhang=ctdh.madonhang

--cau24: tinh tong so luong ban le co trong linh kien chi tiet
select lk.malinhkien, ctlk.loailinhkien ,ctlk.soluong*lk.giasx as tongchiphi
from linhkienchitiet ctlk, linhkien lk
where lk.malinhkien=ctlk.malinhkien

--cau25: cho ten sp va ma sp va gia tien tung loai
select kh.mamathang, sp.gia as giatien
from khohang kh join spnoithat sp on sp.macuahang = kh.macuahang
group by kh.mamathang, sp.gia

--cau26: cho ten sp va ma sp va tong gia tien tung loai
select kh.mamathang, kh.soluongmh ,kh.soluongmh*sp.gia as giatien
from khohang kh join spnoithat sp on sp.macuahang = kh.macuahang
group by kh.mamathang, kh.soluongmh , sp.gia

--cau27: cho biet chi tiet ve linh kien nao sap het trong chitietlk (biet gan het thi so luong <30)
select *
from linhkienchitiet lkct
where lkct.soluong < 30

--cau28: tim dia chi cua hang cua tung loai don hang ma cua hang da ban
select ch.macuahang, dh.madonhang, dh.giadonhang, ch.diachi
from cuahang ch, donhang dh
where ch.macuahang = dh.macuahang

--cau29: tim cua hang nao chu yeu ban ve bo sofa
select kh.macuahang, ch.diachi, kh.mamathang
from khohang kh join cuahang ch on kh.macuahang = ch.macuahang
where kh.mamathang = 'bo sofa'

--cau30: dem xem co bao nhieu linh kien ma he thong ban
select count (lk.malinhkien) as soloailinhkien
from linhkien lk
where lk.malinhkien != 'all' and lk.malinhkien !='all - vai'