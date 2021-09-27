Create user 'user'@'localhost' identified by 'user1';
Grant select on liga_pilkarska. * to 'user'@'localhost';

Create user 'sedzia1'@'localhost' identified by 'sedzia1';
Grant select,insert,update,delete on liga_pilkarska. * to 'sedzia1'@'localhost';
Create user 'sedzia2'@'localhost' identified by 'sedzia2';
Grant select on liga_pilkarska. * to 'sedzia2'@'localhost';

Create user 'admin1'@'localhost' identified by 'admin1';
Grant Super,SELECT, SHOW VIEW, RELOAD, REPLICATION CLIENT, EVENT, TRIGGER on *. * to 'admin1'@'localhost';