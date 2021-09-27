Delimiter //
drop procedure if exists StworzTerminarz//
create procedure StworzTerminarz(nowysezon int)
Begin
	declare done int default false;
    declare number,numberOfTeams,lastTeam,i,j,a,allRounds,helper,matchsInRound int;
    declare cursor1 cursor for (Select Id from zespoly where ZapisanyDoSezonu='tak'order by rand());
    
    declare continue handler
    for not found set done = 1;
    
    if ((Select count(*) from mecze where sezon=nowysezon) <> 0) then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
    
    create table tymczasowa (
    Id int not null auto_increment,
    zespol int not null,
    Primary key (Id)
    );
    open cursor1;
    read_loop:Loop
		fetch cursor1 into number;
        if done then
			leave read_loop;
        end if;
		insert into tymczasowa (zespol) values (number);
    end loop;
    set numberOfTeams = (Select count(Id) from zespoly where ZapisanyDoSezonu='tak');
    set lastTeam=0;
    if (numberOfTeams%2=0) then
		set lastTeam= (Select zespol from tymczasowa where Id=numberOfTeams); 
        set allRounds = 2* (numberOfTeams-1);
        set a=numberOfTeams-1;
        set matchsInRound=(numberOfTeams/2)-1;
	else
		set allRounds = 2* (numberOfTeams);
        set a=numberOfTeams;
        set matchsInRound=(numberOfTeams-1)/2;
    end if;
    set i=0;
    Select * from tymczasowa;
    while (i<allRounds) do
		set j=1;
		while (j<(matchsInRound)+1) do
			if (i%2=0) then
				insert into mecze (Sezon,Kolejka,Data,Gospodarz,Gosc,MeczSieOdbyl) 
					values (nowysezon,i+1,date_Add(curdate(), interval 7*(i+1) day),
					(Select zespol from tymczasowa where id=((i+j)%a+1)),
                    (Select zespol from tymczasowa where id=((a+i-j)%a+1)),'nie');
			else
				insert into mecze (Sezon,Kolejka,Data,Gospodarz,Gosc,MeczSieOdbyl) 
					values (nowysezon,i+1,date_Add(curdate(), interval 7*(i+1) day),
                    (Select zespol from tymczasowa where id=((a+i-j)%a+1)),
					(Select zespol from tymczasowa where id=((i+j)%a+1)),'nie');
            end if;
			set j=j+1;
        end while;
        if not (lastTeam=0) then
			if (i%2=0) then
				insert into mecze (Sezon,Kolejka,Data,Gospodarz,Gosc,MeczSieOdbyl) 
					values (nowysezon,i+1,date_Add(curdate(), interval 7*(i+1) day),
					(Select zespol from tymczasowa where id=((i)%a+1)),
                    lastTeam,'nie');
			else
				insert into mecze (Sezon,Kolejka,Data,Gospodarz,Gosc,MeczSieOdbyl) 
					values (nowysezon,i+1,date_Add(curdate(), interval 7*(i+1) day),
                    lastTeam,
					(Select zespol from tymczasowa where id=((i)%a+1)),'nie');
            end if;
        end if;
        
		set i = i +1;
    end while;
    
	Set @sez = convert(nowysezon,char(10));
    
    SET @s1 = concat('create view Strzelcy',@sez,' as 
    (Select im,naz,z, count(z) from 
	(Select mecze.id as me, mecze.sezon as s, gole.zawodnik as z, zawodnicy.imie as im, zawodnicy.nazwisko as naz
		from ((mecze join gole on mecze.id=gole.Mecz) join zawodnicy on gole.zawodnik=zawodnicy.id)) as t
    where s=',@sez,' group by z)') ; 
	
	PREPARE stmt1 FROM @s1; 
	EXECUTE stmt1 ; 
	DEALLOCATE PREPARE stmt1; 
    
    SET @s2 = concat('create view KartkiZolte',@sez,' as 
    (Select im,naz,z, count(z) from 
	(Select mecze.id as me, mecze.sezon as s, kartki.zawodnik as z, zawodnicy.imie as im, zawodnicy.nazwisko as naz
		from ((mecze join kartki on mecze.id=kartki.Mecz) join zawodnicy on kartki.zawodnik=zawodnicy.id)
        where kartki.rodzaj="zolta") as t
    where s=',@sez,' group by z)') ; 
	
	PREPARE stmt2 FROM @s2; 
	EXECUTE stmt2 ; 
	DEALLOCATE PREPARE stmt2; 
    
    SET @s3 = concat('create view KartkiCzerwone',@sez,' as 
    (Select im,naz,z, count(z) from 
	(Select mecze.id as me, mecze.sezon as s, kartki.zawodnik as z, zawodnicy.imie as im, zawodnicy.nazwisko as naz
		from ((mecze join kartki on mecze.id=kartki.Mecz) join zawodnicy on kartki.zawodnik=zawodnicy.id)
        where kartki.rodzaj="czerwona") as t
    where s=',@sez,' group by z)') ; 
    
    PREPARE stmt3 FROM @s3; 
	EXECUTE stmt3 ; 
	DEALLOCATE PREPARE stmt3;
	
    
    SET @s6 = concat('
    create view Tabela',@sez,' as 
    Select zespoly.nazwa,punkty,golezd,goleut,zagrane from (
    Select zesp, sum(punk) as punkty, sum(gz) as golezd, sum(gu) as goleut, sum(tn) as zagrane from 
    (
    Select mecze.Gospodarz as zesp,mecze.Kolejka as k, ifnull(mecze.PunktyGospodarza,0) as punk, ifnull(mecze.GoleGospodarza,0) as gz, ifnull(mecze.GoleGoscia,0) as gu, case when mecze.MeczSieOdbyl="tak" then 1 else 0 end as tn from mecze where sezon=',@sez,'
    union
    Select mecze.Gosc as zesp,mecze.Kolejka as k, ifnull(mecze.PunktyGoscia,0) as punk, ifnull(mecze.GoleGoscia,0) as gz, ifnull(mecze.GoleGospodarza,0) as gu, case when mecze.MeczSieOdbyl="tak" then 1 else 0 end as tn from mecze where sezon=',@sez,'
    )as t1 group by zesp) as t2 join zespoly on zespoly.id=zesp order by punkty desc;
    ') ; 
   
	PREPARE stmt6 FROM @s6; 
	EXECUTE stmt6 ; 
	DEALLOCATE PREPARE stmt6;
    
    
    Select * from tymczasowa;
    drop table tymczasowa;
    
end//

Delimiter ;



