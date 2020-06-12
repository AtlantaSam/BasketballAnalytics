*****************************************;
** SAS Scoring Code for PROC REG;
*****************************************;

label P_W = 'Predicted: W' ;
drop _LMR_BAD;
_LMR_BAD=0;

*** Check interval variables for missing values;
if nmiss(eFGP,TOVP,ORBP,FTFGA) then do;
   _LMR_BAD=1;
   goto _SKIP_000;
end;

*** Compute Linear Predictors;
drop _LP0;
_LP0 = 0;

*** Effect: eFGP;
_LP0 = _LP0 + (438.327329835462) * eFGP;
*** Effect: TOVP;
_LP0 = _LP0 + (-2.68710612767967) * TOVP;
*** Effect: ORBP;
_LP0 = _LP0 + (1.51039633162878) * ORBP;
*** Effect: FTFGA;
_LP0 = _LP0 + (80.0891577416848) * FTFGA;

*** Predicted values;
_LP0 = _LP0 +    -199.403025245689;
_SKIP_000:
if _LMR_BAD=1 then do;
   P_W = .;
end;
else do;
   P_W = _LP0;
end;
