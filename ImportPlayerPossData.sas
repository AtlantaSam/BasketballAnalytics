%macro din(input,output,s);
proc import datafile="c:\data\nba\csv\&input"
   dbms=csv
   out=temp0
   replace;
   getnames=yes;
run;
proc contents order=varnum; run;

data temp1;
   set work.temp0 (rename=('2P'n=_2P '2PA'n=_2PA '2P%'n=_2PP 
                           '3P'n=_3P '3PA'n=_3PA '3P%'n=_3PP 
                           'FG%'n=FGP 'FT%'n=FTP player=player0));
run;

data temp2;
   set work.temp1;
   Player=scan(Player0, 1, '\');
   PlayerID=scan(Player0, 2, '\');
   season=&s;
run;

data temp3;
   set work.temp2 (drop=player0 rk var30);
run;
 
data nba.&output;
   retain Season Player PlayerID Tm Pos Age eFGP TOV ORB FTF;
   format eFGP FTF 4.3;
   set work.temp3;
   eFGP=(fg+.5*_3P)/fga;
   FTF=fta/fga;
run;
%mend;


%din(player_per_100_poss_stats_2011.csv,Player2011,2011);
%din(player_per_100_poss_stats_2012.csv,Player2012,2012);
%din(player_per_100_poss_stats_2013.csv,Player2013,2013);
%din(player_per_100_poss_stats_2014.csv,Player2014,2014);
%din(player_per_100_poss_stats_2015.csv,Player2015,2015);
%din(player_per_100_poss_stats_2016.csv,Player2016,2016);
%din(player_per_100_poss_stats_2017.csv,Player2017,2017);
%din(player_per_100_poss_stats_2018.csv,Player2018,2018);
%din(player_per_100_poss_stats_2019.csv,Player2019,2019);
%din(player_per_100_poss_stats_2020.csv,Player2020,2020);

data nba.PlayerAdvStats;
    set nba.Player20:;
run;
proc sort; by season playerID; run;


