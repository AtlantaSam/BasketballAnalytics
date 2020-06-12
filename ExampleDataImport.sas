/* INTRODUCTION TO SAS CODE */

title;

libname nba 'c:\data\nba';

proc import datafile="c:\data\nba\csv\example.csv"
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
   Season=2018;
run;

data temp3;
   retain Season Team Playoff;
   set work.temp2 (drop=team0 Rk);
run;

data nba.example;
   set work.temp3;
run;

proc contents data=nba.example order=varnum; run;



