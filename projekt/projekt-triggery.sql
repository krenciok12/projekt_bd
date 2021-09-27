Delimiter //
drop trigger if exists DodajZawieszenie1//
create trigger DodajZawieszenie1 after insert on Kartki
for each row
begin
	if (new.rodzaj = 'czerwona') then
		Insert into Zawieszenia values (new.Zawodnik, null , 'czerwona kartka');
    end if;
    if (new.rodzaj = 'zolta' and (select count(*) from Kartki where Mecz=new.Mecz and Zawodnik=new.Zawodnik and new.Rodzaj=Rodzaj)=2 ) then
		Insert into Zawieszenia values (new.Zawodnik, null , 'dwie zolte kartki');
	end if;
end//
Delimiter ;

Delimiter //
drop trigger if exists CzyMeczSieOdbylGole//
create trigger CzyMeczSieOdbylGole before insert on Gole
for each row
begin
	if not ((Select MeczSieOdbyl from mecze where new.mecz=id)='tak') then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
end//
Delimiter ;

Delimiter //
drop trigger if exists CzyMeczSieOdbylGoleSamobojcze//
create trigger CzyMeczSieOdbylGoleSamobojcze before insert on GoleSamobojcze
for each row
begin
	if not ((Select MeczSieOdbyl from mecze where new.mecz=id)='tak') then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
end//
Delimiter ;

Delimiter //
drop trigger if exists CzyMeczSieOdbylKartki//
create trigger CzyMeczSieOdbylKartki before insert on Kartki
for each row
begin
	if not ((Select MeczSieOdbyl from mecze where new.mecz=id)='tak') then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
    if ((Select count(*) from wystepyzawodnikow where mecz=new.mecz and zawodnik=new.Zawodnik and new.rodzaj='zolta')>1) then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
    if ((Select count(*) from wystepyzawodnikow where mecz=new.mecz and zawodnik=new.Zawodnik and new.rodzaj='zczerwona')>0) then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
end//
Delimiter ;

Delimiter //
drop trigger if exists CzyMeczSieOdbylWystepy//
create trigger CzyMeczSieOdbylWystepy before insert on wystepyzawodnikow
for each row
begin
	if not ((Select MeczSieOdbyl from mecze where new.mecz=id)='tak') then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
    if ((Select count(*) from wystepyzawodnikow where mecz=new.mecz and zawodnik=new.Zawodnik)>0) then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
end//
Delimiter ;

Delimiter //
drop trigger if exists OdbyteZawieszenieDlaMeczu//
create trigger OdbyteZawieszenieDlaMeczu after update on Mecze
for each row
begin
	if (new.MeczSieOdbyl='tak' and old.MeczSieOdbyl='nie') then
	update Zawieszenia set mecz=new.id where mecz is null and 
		zawodnik in (Select (Zawodnik) from zespolzawodnik where zespol in (Select zespol from zespolmecz where mecz=1 ) and  Datazakonczenia is null);
	
	end if;
end//
Delimiter ;

Delimiter //
drop trigger if exists SprawdzZawieszenie1//
create trigger SprawdzZawieszenie1 after insert on wystepyzawodnikow
for each row
begin

	if (new.zawodnik in (select zawodnik from zawieszenia where mecz=new.mecz)) then
		if ((Select Zespol from zespolmecz where Mecz=new.Mecz and `gospodarz/gosc`='Gospodarz')
        =(Select Zespol from zespolzawodnik where zawodnik=new.zawodnik and  Datazakonczenia is null)) then
			update Mecze set Walkower='Gospodarz',
				komentarz='walkower',
                PunktyGospodarza=0,
                PunktyGoscia=3,
                GoleGospodarza=0,
                Golegoscia=3
                where Id=new.mecz;
		else
			update Mecze set Walkower='Gosc',
				komentarz='walkower',
                PunktyGospodarza=3,
                PunktyGoscia=0,
                GoleGospodarza=3,
                Golegoscia=0
                where Id=new.mecz;
		end if;
    end if;
end//
Delimiter ;

Delimiter //
drop trigger if exists DodanieDoZespolMecz//
create trigger DodanieDoZespolMecz after insert on Mecze
for each row

begin
	insert into zespolmecz values (new.Gospodarz,new.Id,'Gospodarz');
    insert into zespolmecz values (new.Gosc,new.Id,'Gosc');
end//
Delimiter ;

Delimiter //
drop trigger if exists CzyMozePodpisacNowy//
create trigger CzyMozePodpisacNowy before insert on zespolzawodnik
for each row

begin
	if ((Select count(*) from zespolzawodnik where zespolzawodnik.Zawodnik=new.zawodnik and Datazakonczenia is null) > 0) then 
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
end//
Delimiter ;