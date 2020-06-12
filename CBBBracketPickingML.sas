
data temp;
   set ncaab.cbbads;
   if 1<=seed<=16;
   %include 'C:\Data\NCAAB\BracketScoreCode2\score.sas';
run;
proc sort; by year descending p_wins; run;
data temp2;
   set temp;
   rank+1;
   by year;
   if first.year then rank=1;
run;
proc print data=temp2 noobs;
   by year;
   var rank team p_wins;
run;



data seed2020;
   set ncaab.cbb20;
   %include 'c:\data\nba\seed.sas';
   Seed0=P_seed;
   drop p_seed;
   l=g-w;
run;
proc sort; by seed0; run;
data tourn2020;
   set seed2020;
   seed+1;
   by year;
   if first.year then seed=1;
   if seed le 68;
run;
proc print noobs ;
   by year;
   var Seed team conf w l;
run;

proc sort data=work.tourn2020; by team; run;
proc sort data=ncaab.cbb20; by team; run;


data temp;
   merge ncaab.cbb20
         work.tourn2020 (keep=team Seed);
   by team;
   estSeed=seed;
   %include 'C:\Data\NCAAB\BracketScoreCode2\score.sas';
run;
proc sort; by year descending p_wins; run;
data temp2;
   set temp;
   rank+1;
   by year;
   if first.year then rank=1;
run;
proc print noobs;
   by year;
   var rank team p_wins;
run;