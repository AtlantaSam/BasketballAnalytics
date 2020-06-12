title;

/* Data Check */
proc contents data=nba.teamgo order=varnum; run;
proc freq data=nba.teamGo; table season; run;
proc freq data=nba.teamgo; table team*teamcode / list; run;
proc means data=nba.teamgo nonobs n nmiss mean min max; var _numeric_; run;

proc contents data=nba.miscstats order=varnum; run;

/* EDA */
proc means data=nba.teamgo min max;
   class season;
   var G;
run;

data eda;
   merge nba.teamgo
         nba.miscstats (keep=season teamcode w l);
   by season teamcode;
   where season not in (2012,2020);
run;

/* HOW MANY WINS DOES IT TAKE TO GET INTO THE PLAYOFFS? */
proc means data=eda nonbs mean min max;
   class Playoff;
   var W;
run;

/* WHO WERE THE EXTREME TEAMS? */
data playoffs;
   set work.eda;
   where playoff=1 and w=37;
run;
proc print; var season team; run;

data playoffs2;
   set work.eda;
   where playoff=0 and w=48;
run;
proc print; var season team; run;

/* WHAT IS A SAFE NUMBER OF WINS (TO GET INTO THE PLAYOFFS) */
proc freq data=work.eda;
   table w*playoff;
run;


/* WHAT IS AN ELITE TEAM */
proc means data=eda nonobs mean min max p90 p95 p99;
   where playoff=1;
   var w;
run;

data elite;
   set work.eda;
   where Playoff=1 and 
         w ge 60;
run;
proc print; var season team w; run;



