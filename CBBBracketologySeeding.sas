title; 

proc contents data=ncaab.cbb order=varnum; run;

%let vars=
ADJOE
ADJDE
BARTHAG
EFG_O
EFG_D
TOR
TORD
ORB
DRB
FTR
FTRD
_2PO
_2PD
_3PO
_3PD
ADJ_T
WAB
;

proc reg data=ncaab.cbb;
   model seed=&vars;
   code file='c:\data\nba\seed.sas';
run;

data cbb00;
   set ncaab.cbb;
   %include 'c:\data\nba\seed.sas';
   estSeed=P_seed;
   if seed=17 then seed=.;
   drop p_seed;
run;
proc sort; by year estSeed; run;
proc freq data=work.cbb00; table PostSeason; run;

/*** Review Seed estimate in JMP ***/


/* Build the 'target' variable */
data cbb01;
   set work.cbb00;
   if PostSeason='R68' then wins=0;
   else if PostSeason='R64' then wins=0;
   else if PostSeason='R32' then wins=1;
   else if PostSeason='S16' then wins=2;
   else if PostSeason='E8' then wins=3;
   else if PostSeason='F4' then wins=4;
   else if PostSeason='2ND' then wins=5;
   else if PostSeason='Champions' then wins=6;
run;
proc freq; table PostSeason*Wins / list; run;

data ncaab.CBBADS;
   set work.cbb01;
run;






