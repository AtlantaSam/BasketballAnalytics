
%macro din(input,output,season);
proc import datafile="c:\data\nba\csv\&input"
   dbms=csv
   out=temp0
   replace;
   getnames=yes;
run;

data temp1;
   set work.temp0 (rename=('2P'n=_2Pa '2PA'n=_2PAa '2P%'n=_2PPa 
                           '3P'n=_3Pa '3PA'n=_3PAa '3P%'n=_3PPa 
                           'FG%'n=FGPa 'FT%'n=FTPa team=team0
                            ORB=ORBa DRB=DRBa TRB=TRBa AST=ASTa
                            STL=STLa BLK=BLKa TOV=TOVc PF=PFa PTS=PTSa));
run;

data temp2;
   set work.temp1;
   if index(team0,'*') then Playoff=1; else Playoff=0;
   Team=compress(team0,'*');
   Season=&season;
run;

data temp3;
   retain Season Team Playoff;
   set work.temp2 (drop=team0 Rk);
run;

data nba.&output;
   set work.temp3;
run;
%mend;

%din(Opponent_stats_2011.csv,OpponentStats2011,2011);
%din(Opponent_stats_2012.csv,OpponentStats2012,2012);
%din(Opponent_stats_2013.csv,OpponentStats2013,2013);
%din(Opponent_stats_2014.csv,OpponentStats2014,2014);
%din(Opponent_stats_2015.csv,OpponentStats2015,2015);
%din(Opponent_stats_2016.csv,OpponentStats2016,2016);
%din(Opponent_stats_2017.csv,OpponentStats2017,2017);
%din(Opponent_stats_2018.csv,OpponentStats2018,2018);
%din(Opponent_stats_2019.csv,OpponentStats2019,2019);
%din(Opponent_stats_2020.csv,OpponentStats2020,2020);

data TeamStop;
   set nba.OpponentStats20:;
   if season=2020 and team='Minnesota Timberwolve' then do;
      team='Minnesota Timberwolves';
   end;
   if season=2020 and team='Portland Trail Blazer' then do;
      team='Portland Trail Blazers';
   end;
run;
proc sort; by team season; run;
proc contents data=work.TeamStop order=varnum; run;

proc freq data=work.TeamStop; table team / list; run;
proc freq data=work.TeamStop; table team*season / list; run;

proc sql;
   create table work.TeamStop as
   select a.*,
          b.Teamcode
   from work.TeamStop a,
        nba.Teamcode b
   where a.team=b.team;
quit;
proc freq; table team*teamcode / list; run;

data nba.TeamStop;
   retain Season Team TeamCode;
   set work.teamStop;
   FGAPGa=fga/G;
   FTPGa=ft/G;
   FTAPGa=fta/G;
   _2pga=_2p/G;
   _2apga=_2pa/G;
   _3pga=_3p/G;
   _3apga=_3pa/G;
   PPGA=PTSa/g;
   APGa=asta/G;
   BPGa=blka/G;
   DRPGa=drba/G;
   ORPGa=orba/G;
   TRPGa=orba/G;
   TOPGC=tovc/G;     *** How many Turnovers are you creating? ***;
   FTAPGa=fta/G;    *** How often are you putting teams on the line? ***;
run;
proc sort; by season teamcode; run;