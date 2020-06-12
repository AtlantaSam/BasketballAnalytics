
%macro din(input,output,season);
proc import datafile="c:\data\nba\csv\&input"
   dbms=csv
   out=temp0
   replace;
   getnames=yes;
run;

data temp1;
   set work.temp0 (rename=('2P'n=_2P '2PA'n=_2PA '2P%'n=_2PP 
                           '3P'n=_3P '3PA'n=_3PA '3P%'n=_3PP 
                           'FG%'n=FGP 'FT%'n=FTP team=team0));
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

%din(team_stats_2011.csv,TeamStats2011,2011);
%din(team_stats_2012.csv,TeamStats2012,2012);
%din(team_stats_2013.csv,TeamStats2013,2013);
%din(team_stats_2014.csv,TeamStats2014,2014);
%din(team_stats_2015.csv,TeamStats2015,2015);
%din(team_stats_2016.csv,TeamStats2016,2016);
%din(team_stats_2017.csv,TeamStats2017,2017);
%din(team_stats_2018.csv,TeamStats2018,2018);
%din(team_stats_2019.csv,TeamStats2019,2019);
%din(team_stats_2020.csv,TeamStats2020,2020);

data TeamGo;
   set nba.TeamStats20:;
run;
proc sort; by season team; run;
proc contents data=work.TeamGo order=varnum; run;

proc freq data=work.TeamGo; table season*team / list; run;

proc sql;
   create table work.TeamGo as
   select a.*,
          b.Teamcode
   from work.TeamGo a,
        nba.Teamcode b
   where a.team=b.team;
quit;
proc freq; table team*teamcode / list; run;

data nba.TeamGo;
   retain Season Team TeamCode;
   set work.teamGo;
   FGPG=fg/G;
   FGAPG=fga/G;
   FTPG=ft/G;
   FTAPG=fta/G;
   _2pg=_2p/G;
   _2apg=_2pa/G;
   _3pg=_3p/G;
   _3apg=_3pa/G;
   PPG=pts/G;
   APG=ast/G;
   BPG=blk/G;
   SPG=stl/G;
   DRPG=drb/G;
   ORPG=orb/G;
   TRPG=trb/G;
   TOPG=tov/G;
run;
proc sort; by season teamcode; run;





