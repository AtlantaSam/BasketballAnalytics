title;

/* teams most likely to win 6 games */
data temp;
   set ncaab.cbbads;
   if 1<=seed<=16;
   %include 'C:\Data\NCAAB\BracketScoreCode\score.sas';
run;
proc sort; by year descending p_wins6; run;
data temp2;
   set temp;
   rank+1;
   by year;
   if first.year then rank=1;
run;
proc print noobs;
   by year;
   var rank team p_wins6;
run;

/* teams most likely to win 5 games */
data temp;
   set ncaab.cbbads;
   if 1<=seed<=16;
   %include 'C:\Data\NCAAB\BracketScoreCode\score.sas';
run;
proc sort; by year descending p_wins5; run;
data temp2;
   set temp;
   rank+1;
   by year;
   if first.year then rank=1;
run;
proc print noobs;
   by year;
   var rank team p_wins5;
run;


data temp;
   set ncaab.cbbads;
   if 1<=seed<=16;
   %include 'C:\Data\NCAAB\BracketScoreCode\score.sas';
run;
proc sort; by year descending p_wins4; run;
data temp2;
   set temp;
   rank+1;
   by year;
   if first.year then rank=1;
run;
proc print noobs;
   by year;
   var rank team p_wins4;
run;


data temp;
   set ncaab.cbbads;
   if 1<=seed<=16;
   %include 'C:\Data\NCAAB\BracketScoreCode\score.sas';
run;
proc sort; by year descending p_wins3; run;
data temp2;
   set temp;
   rank+1;
   by year;
   if first.year then rank=1;
run;
proc print noobs;
   by year;
   var rank team p_wins3;
run;


data temp;
   set ncaab.cbbads;
   if 1<=seed<=16;
   %include 'C:\Data\NCAAB\BracketScoreCode\score.sas';
run;
proc sort; by year descending p_wins1; run;
data temp2;
   set temp;
   rank+1;
   by year;
   if first.year then rank=1;
run;
proc print noobs;
   by year;
   var rank team p_wins1;
run;








