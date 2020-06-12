
/*** IMPORT CBB20 ***/
proc import datafile="c:\data\NCAAB\kaggle\cbb20.csv"
   dbms=csv
   out=temp0
   replace;
   getnames=yes;
run;
data temp1;
   set work.temp0 (rename=('2P_O'n=_2PO '2P_D'n=_2PD '3P_O'n=_3PO '3P_D'n=_3PD));
   Year=2020;
run;
data ncaab.cbb20;
   set work.temp1;
run;


/*** Observe the error below with PostSeason ***/
/*** IMPORT CBB15-CBB19 ***/
proc import datafile="c:\data\NCAAB\kaggle\cbb.csv"
   dbms=csv
   out=temp0
   replace;
   getnames=yes;
run;
data temp1;
   set work.temp0 (rename=('2P_O'n=_2PO '2P_D'n=_2PD '3P_O'n=_3PO '3P_D'n=_3PD));
run;
data cbbx;
   set work.temp1 (rename=(seed=seed0));
   if seed0='NA' then seed0='17';
   seed=seed0+0;
   drop seed0;
run;
proc sort; by year seed; run;








