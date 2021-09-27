drop database Liga_Pilkarska;

Create database Liga_Pilkarska;
Create table Liga_Pilkarska.Zespoly (
	Id int not null auto_increment,
	Nazwa varchar(30) Not null,
	Miejscowosc varchar(30) not null,
    ZapisanyDoSezonu enum ('tak', 'nie') not null,
    Primary key (Id)
);
Create table Liga_Pilkarska.Zawodnicy(
	Id int not null auto_increment,
    Imie varchar(30) Not null,
	Nazwisko varchar(30) not null,
    DataUrodzenia date not null,
    primary key(Id)
);
create table Liga_Pilkarska.ZespolZawodnik(
	Zespol int not null,
    Zawodnik int not null,
    DataRozpoczecia date not null,
    DataZakonczenia date,
    foreign key (Zespol) references Zespoly(Id),
    foreign key (Zawodnik) references Zawodnicy(Id)

);

create table Liga_Pilkarska.Mecze (
	Id int not null auto_increment,
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
    Primary key (Id)
);

create table Liga_Pilkarska.ZespolMecz (
	Zespol int not null,
    Mecz int not null,
    `Gospodarz/Gosc` enum ('Gospodarz','Gosc'),
    foreign key (Zespol) references Zespoly(Id),
    foreign key (Mecz) references Mecze(Id)
);

Create table Liga_Pilkarska.Gole (
	Mecz int not null,
    Zawodnik int not null,
    foreign key (Mecz) references Mecze(Id),
    foreign key (Zawodnik) references Zawodnicy(Id)
);

Create table Liga_Pilkarska.GoleSamobojcze (
	Mecz int not null,
    Zawodnik int not null,
    foreign key (Mecz) references Mecze(Id),
    foreign key (Zawodnik) references Zawodnicy(Id)
);

Create table Liga_Pilkarska.WystepyZawodnikow (
	Mecz int not null,
    Zawodnik int not null,
    foreign key (Mecz) references Mecze(Id),
    foreign key (Zawodnik) references Zawodnicy(Id)
);

Create table Liga_Pilkarska.Kartki (
	Mecz int not null,
    Zawodnik int not null,
    Rodzaj enum ('zolta','czerwona'),
    foreign key (Mecz) references Mecze(Id),
    foreign key (Zawodnik) references Zawodnicy(Id)
);

Create table Liga_Pilkarska.Zawieszenia (
    Zawodnik int not null,
    Mecz int,
    Komentarz varchar(50),
    foreign key (Zawodnik) references Zawodnicy(Id)
);
