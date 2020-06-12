
data EvalPlayers;
   set nba.PlayerAdvstats;
   where G gt 40 and
		 season eq 2019;
   mpg=mp/g;
run;
/*
proc freq; table pos; run;
proc means mean median p75; var mpg; run;
*/
 
%macro AS(p,m1,m2,m3,m4);
/* Can we find players relative to the Four Factors */
data eval;
   set work.EvalPlayers;
   where pos="&p";
   *if mpg ge 29;
run;
proc rank data=work.eval (keep=PlayerID player age season mpg tm &m1) 
         out=rank_&m1._&p groups=10;
   var &m1;
   ranks rank&m1;
run;
proc sort; by playerID; run;
proc rank data=work.eval (keep=PlayerID player season tm &m2) 
         out=rank_&m2._&p groups=10 descending;
   var &m2;
   ranks rank&m2;
run;
proc sort; by playerID; run;
proc rank data=work.eval (keep=PlayerID player season tm &m3) 
         out=rank_&m3._&p groups=10;
   var &m3;
   ranks rank&m3;
run;
proc sort; by playerID; run;
proc rank data=work.eval (keep=PlayerID player season tm &m4) 
         out=rank_&m4._&p groups=10;
   var &m4;
   ranks rank&m4;
run;
title "&m4";
proc sort; by playerID; run;
%mend;
%AS(SG,eFGP,TOV,ORB,FTF);
%AS(SF,eFGP,TOV,ORB,FTF);
%AS(PG,eFGP,TOV,ORB,FTF);
%AS(PF,eFGP,TOV,ORB,FTF);
%AS(C,eFGP,TOV,ORB,FTF);

%macro posit(p);
data &p (drop=season playerid);
   retain player tm mpg;
   merge work.rank_EFGP_&p
         work.rank_TOV_&p
	     work.rank_ORB_&p
	     work.rank_FTF_&p;
   by playerID;
   if last.playerID;
   asm=.4*rankEFGP+
       .25*rankTOV+
       .2*rankORB+
       .15*rankFTF;
run;
proc sort; by descending asm efgp TOV descending orb descending ftf;
%mend;
%posit(SG);
%posit(SF);
%posit(PG);
%posit(PF);
%posit(C);

title 'Top 10 Shooting Guards (SG)';
proc print data=work.sg (obs=10); format mpg 4.1; run;

title 'Top 10 Shooting Forwards (SF)';
proc print data=work.sf (obs=10); format mpg 4.1; run;

title 'Top 10 Point Guards (PG)';
proc print data=work.pg (obs=10); format mpg 4.1; run;

title 'Top 10 Power Forwards (PF)';
proc print data=work.pf (obs=10); format mpg 4.1; run;

title 'Top 10 Centers (C)';
proc print data=work.c (obs=10); format mpg 4.1; run;





