create database registracija_vozila


use registracija_vozila
go

create table vlasnikVozila
(
	vlasnikID int not null,
	jmbg nvarchar(13) not null,
	ime nvarchar(50) not null,
	prezime nvarchar(100) not null,
	drzavaID int not null,
	gradID int not null,
	voziloID int not null,
	saobracajna_dozvola_ID int not null,
	vozacka_dozvola_id int not null,
	datumRodjenja date not null,
	mjestoRodjenja nvarchar(100) not null,
	drzavljanstvo nvarchar(50) not null,
	constraint pk_vlasnik primary key (vlasnikID)
)

create table drzave
(
	drzavaID int not null,
	naziv nvarchar(40),
	constraint pk_drzave primary key(drzavaID)
)

create table gradovi
(
	gradID int not null,
	drzavaID int not null,
	postanski_broj nvarchar(30) not null
	constraint pk_gradovi primary key (gradID)
)

create table vozila
(
	voziloID int not null,
	broj_sasije nvarchar(17) not null,
	registarska_oznakaID int not null,
	polisa_osiguranjaID int not null,
	tehnicki_pregledID int not null,
	stikerID int not null,
	marka_vozila nvarchar(40) not null,
	model_vozila nvarchar(40) not null,
	constraint pk_vozilo primary key (voziloID)
)

create table registarske_oznake1
(
	registarska_oznakaID int not null,
	broj_registarske_oznake nvarchar(20) not null,
	drzavaID int not null,
	constraint registarske_oznake primary key (registarska_oznakaID)
)


create table saobracajne_dozvole
(
	saobracajna_dozvolaID int not null,
	datum_izdavanja_saobracajne_dozvole date not null,
	datum_isteka_saobracajne_dozvole date not null,
	constraint pk_sabrocajne_dozvole primary key (saobracajna_dozvolaID)
)

create table vozacke_dozvole
(
	vozacka_dozvolaID int not null,
	kategorija nvarchar(3) not null,
	datum_izdavanja_vozacke_dozvole date not null,
	datum_isteka_vozacke_dozvole date not null,
	constraint pk_vozacke_dozvole primary key (vozacka_dozvolaID)
)

create table polise_osiguranja
(
	polisa_osiguranjaID int not null,
	datum_izdavanja_polise_osiguranja date not null,
	datum_isteka_polise_osiguranja date not null,
	bonus decimal not null,
	malus decimal not null,
	constraint pk_polise_osiguranja primary key (polisa_osiguranjaID)
)

create table tehnicki_pregledi
(
	tehnicki_pregledID int not null,
	datum_pregleda date not null,
	redovnost nvarchar(20) not null,
	ispravnost bit not null,
	napomena nvarchar(200) not null,
	constraint pk_tehnicki_pregledi primary key (tehnicki_pregledID)
)

create table stikeri
(
	stikerID int not null,
	serijski_broj nvarchar(8) not null,
	constraint pk_stikeri primary key (stikerID)
)


alter table vlasnikVozila 
with check
add constraint fk_vlasnici_grad foreign key (gradID) references gradovi(gradID)
go
alter table vlasnikVozila
check constraint fk_vlasnici_grad
go
alter table vlasnikVozila
add constraint df_vlasni_jmbg_ch check (len(jmbg) = 13)
go
alter table vlasnikVozila
check constraint df_vlasni_jmbg_ch
go

alter table vlasnikVozila 
with check
add constraint fk_vlasnici_drzava foreign key (drzavaID) references drzave(drzavaID)
go
alter table vlasnikVozila
check constraint fk_vlasnici_drzava
go

alter table vlasnikVozila 
with check
add constraint fk_vlasnici_vozilo foreign key (voziloID) references vozila(voziloID)
go
alter table vlasnikVozila
check constraint fk_vlasnici_vozilo
go

alter table vlasnikVozila 
with check
add constraint fk_vlasnici_vozacka_dozvola foreign key (vozacka_dozvola_id) 
references vozacke_dozvole(vozacka_dozvolaID)
go
alter table vlasnikVozila
check constraint fk_vlasnici_vozacka_dozvola
go

alter table vlasnikVozila 
with check
add constraint fk_vlasnici_saobracajna_dozvola foreign key (saobracajna_dozvola_ID) 
references saobracajne_dozvole(saobracajna_dozvolaID)
go
alter table vlasnikVozila
check constraint fk_vlasnici_saobracajna_dozvola
go

alter table gradovi
with check
add constraint fk_gradovi_drzave foreign key (drzavaID) references drzave(drzavaID)
go
alter table gradovi
check constraint fk_gradovi_drzave
go

alter table vozila
with check
add constraint fk_vozila_reg_oznake foreign key (registarska_oznakaID) 
references registarske_oznake1(registarska_oznakaID)
go
alter table vozila
check constraint fk_vozila_reg_oznake
go
alter table vozila
add constraint df_vozila_sasija_ch check (len(broj_sasije) = 17)
alter table vozila
check constraint df_vozila_sasija_ch
go


alter table vozila
with check
add constraint fk_vozila_polisa_osiguranja foreign key (polisa_osiguranjaID) 
references polise_osiguranja(polisa_osiguranjaID)
go
alter table vozila
check constraint fk_vozila_polisa_osiguranja
go



alter table vozila
with check
add constraint fk_vozila_tehnicki_pregledi foreign key (tehnicki_pregledID) 
references tehnicki_pregledi(tehnicki_pregledID)
go
alter table vozila
check constraint fk_vozila_tehnicki_pregledi
go

alter table vozila
with check 
add constraint fk_vozila_stikeri foreign key (stikerID)
references stikeri(stikerID)
go
alter table vozila
check constraint fk_vozila_stikeri
go

alter table stikeri
add constraint df_stikeri_ch check (len(serijski_broj) = 8)


alter table vozila
add datum_kreiranja_zapisa datetime default getdate()
alter table vozila
add datum_modifikovanja_zapisa datetime default null


alter table vozacke_dozvole
add datum_kreiranja_zapisa datetime default getdate()
alter table vozacke_dozvole
add datum_modifikovanja_zapisa datetime default null


alter table vlasnikVozila
add datum_kreiranja_zapisa datetime default getdate()
alter table vlasnikVozila
add datum_modifikovanja_zapisa datetime default null


alter table tehnicki_pregledi
add datum_kreiranja_zapisa datetime default getdate()
alter table tehnicki_pregledi
add datum_modifikovanja_zapisa datetime default null


alter table stikeri
add datum_kreiranja_zapisa datetime default getdate()
alter table stikeri
add datum_modifikovanja_zapisa datetime default null


alter table saobracajne_dozvole
add datum_kreiranja_zapisa datetime default getdate()
alter table saobracajne_dozvole
add datum_modifikovanja_zapisa datetime default null


alter table registarske_oznake1
add datum_kreiranja_zapisa datetime default getdate()
alter table registarske_oznake1
add datum_modifikovanja_zapisa datetime default null


alter table polise_osiguranja
add datum_kreiranja_zapisa datetime default getdate()
alter table polise_osiguranja
add datum_modifikovanja_zapisa datetime default null


alter table gradovi
add datum_kreiranja_zapisa datetime default getdate()
alter table gradovi
add datum_modifikovanja_zapisa datetime default null


alter table drzave
add datum_kreiranja_zapisa datetime default getdate()
alter table drzave
add datum_modifikovanja_zapisa datetime default null



