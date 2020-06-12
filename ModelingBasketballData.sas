title;

/* WHAT DO WE KNOW THAT WOULD CREATE THE 'PERFECT MODEL?' */
data StdStats;
   merge nba.teamgo
         nba.miscstats (keep=season teamcode w l );
   by season teamcode;
   where season not in (2012,2020);
run;
proc reg data=work.StdStats;
   model w = fgp topg orpg ftapg;
run;

*** Possession Stats ***;
data Stats100;                       /* if you like possession stats don't dispair ... they are the go to for comparisons ... */
   merge nba.teamgo100
         nba.miscstats (keep=season teamcode w l );
   by season teamcode;
   where season not in (2012,2020);
run;
proc reg data=work.Stats100;
	model w = fgp tov orb fta;
run;

/* Advanced Stats */
data AdvStats;
   set nba.miscstats;
   by season teamcode;
   where season not in (2012,2020);
   wp=w/(w+l);
run;
proc reg data=work.advStats;
   model w = eFGP TOVP ORBP FTFGA;
run;


/* Can we predict WP percentages using the Four Factors */
proc reg data=work.advStats;
   model w = eFGP TOVP ORBP FTFGA;
   code file='c:\data\nba\score.sas';
run;
data _2020;
   merge nba.teamgo
         nba.miscstats (keep=season teamcode w l eFGP TOVP ORBP FTFGA);
   by season teamcode;
   where season=2020;
   wp=w/(w+l);
run;
data score2020;
   set _2020;
   %include 'c:\data\nba\score.sas';
   estl=g-p_w;
   estwp=p_w/(p_w+estl);
   estW=estWP*g;
   absError=abs(estW-W);
run;
ods graphics on;
proc reg data=work.score2020 plots(only)=fit(nocli);
   model wp=estWP;
run;
ods graphics off;


/* Can we predict WP percentages using the Four Factors */
proc reg data=work.advStats;
   model w = eFGP TOVP ORBP FTFGA oeFGP oTOVP DRBP oFTFGA;
   code file='c:\data\nba\score2.sas';
run;
data _2020;
   merge nba.teamgo
         nba.miscstats (keep=season teamcode w l eFGP TOVP ORBP FTFGA oeFGP oTOVP DRBP oFTFGA);
   by season teamcode;
   where season=2020;
   wp=w/(w+l);
run;
data score2020;
   set _2020;
   %include 'c:\data\nba\score2.sas';
   estLoss=g-p_w;
   estwp=p_w/(p_w+estLoss);
   estW=estWP*g;
   absError=abs((g/82)*estW-W);
run;
ods graphics on;
proc means mean median; var absError; run;
proc reg data=work.score2020 plots(only)=fit(nocli);
   model w=estW;
run;
ods graphics off;






