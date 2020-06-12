
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

%din(team_per_100_poss_stats_2011.csv,TeamPossStats2011,2011);
%din(team_per_100_poss_stats_2012.csv,TeamPossStats2012,2012);
%din(team_per_100_poss_stats_2013.csv,TeamPossStats2013,2013);
%din(team_per_100_poss_stats_2014.csv,TeamPossStats2014,2014);
%din(team_per_100_poss_stats_2015.csv,TeamPossStats2015,2015);
%din(team_per_100_poss_stats_2016.csv,TeamPossStats2016,2016);
%din(team_per_100_poss_stats_2017.csv,TeamPossStats2017,2017);
%din(team_per_100_poss_stats_2018.csv,TeamPossStats2018,2018);
%din(team_per_100_poss_stats_2019.csv,TeamPossStats2019,2019);
%din(team_per_100_poss_stats_2020.csv,TeamPossStats2020,2020);


data TeamGo100;
   set nba.TeamPossStats20:;
run;
proc sort; by team season; run;
proc contents data=work.TeamGo100 order=varnum; run;

proc freq data=work.TeamGo100; table season*team / list; run;

proc sql;
   create table work.TeamGo100 as
   select a.*,
          b.Teamcode
   from work.TeamGo100 a,
        nba.Teamcode b
   where a.team=b.team;
quit;
proc freq; table team*teamcode / list; run;

data nba.TeamGo100;
   retain Season Team TeamCode;
   set work.teamGo100;
run;
proc sort; by season teamcode; run;

