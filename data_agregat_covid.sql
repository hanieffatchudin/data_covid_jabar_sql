create table data_agregat_covid(
	tanggal date NULL,
	nama_kab_kota varchar(23) NULL,
	kode_kab_kota varchar NULL,
	konfirmasi_total int4 NULL,
	konfirmasi_sembuh int4 NULL,
	konfirmasi_meninggal int4 NULL,
	konfirmasi_aktif int4 NULL,
	med_level float8 NULL,
	avg_delay float8 NULL,
	avg_speed_kmh float8 NULL,
	med_total_records float8 NULL
);




truncate table public.data_agregat_covid ;
insert into public.data_agregat_covid (tanggal, nama_kab_kota, kode_kab_kota, konfirmasi_total,konfirmasi_sembuh,
	konfirmasi_meninggal,konfirmasi_aktif,med_level,avg_delay,avg_speed_kmh,med_total_records)
select kkj.tanggal, kkj.nama_kab_kota , kkj.kode_kab_kota ,kkj.konfirmasi_total,kkj.konfirmasi_sembuh ,
	kkj.konfirmasi_meninggal ,kkj.konfirmasi_aktif ,a.med_level, a.avg_delay, a.avg_speed_kmh, a.med_total_records
from kasus_konfirmasi_juli kkj 
	join 
(select *, concat(split_part(kemendagri_kabupaten_kode ,'.' , 1),split_part(kemendagri_kabupaten_kode ,'.' , 2)) as kode_area
from aggregate_jams_cities_june_july_2020 ajcjj ) as a
on a.kode_area = kkj.kode_kab_kota
where a.date = kkj.tanggal - integer '6';