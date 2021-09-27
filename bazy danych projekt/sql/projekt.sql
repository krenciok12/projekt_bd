Create database Liga_Piłkarska;
Create table Zespoly (
	Id int not null auto_increment,
	Nazwa varchar(30) Not null,
	Miejscowosc varchar(30) not null,
    ZapisanyDoSezonu enum ('tak', 'nie') not null,
    Primary key (Id)
);
Create table Zawodnicy(
	Id int not null auto_increment,
    Imie varchar(30) Not null,
	Nazwisko varchar(30) not null,
    DataUrodzenia date not null,
    primary key(Id)
);
create table `Zespol-Zawodnik`(
	Zespol int not null,
    Zawodnik int not null,
    DataRozpoczecia date not null,
    DataZakonczenia date,
    foreign key (Zespol) references Zespoly(Id),
    foreign key (Zawodnik) references Zawodnicy(Id)
);

create table Mecze (
	Id int not null,
    Sezon int not null,
    Kolejka int not null,
    Data date not null,
    Gospodarz int not null,
    Gosc int not null,
    MeczSieOdbyl enum ('tak','nie') not null,
    GoleGospodarza int,
    GoleGoscia int,
    PunktyGospodarza int,
    PunktyGoscia int,
    Walkower enum ('Gospodarz','Gosc','brak'),
    komentarz varchar(100),
    
);
