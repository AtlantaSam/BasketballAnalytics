*****************************************;
** SAS Scoring Code for PROC REG;
*****************************************;

label P_W = 'Predicted: W' ;
drop _LMR_BAD;
_LMR_BAD=0;

*** Check interval variables for missing values;
if nmiss(eFGP,TOVP,ORBP,FTFGA,oeFGP,oTOVP,DRBP,oFTFGA) then do;
   _LMR_BAD=1;
   goto _SKIP_000;
end;

*** Compute Linear Predictors;
drop _LP0;
_LP0 = 0;

*** Effect: eFGP;
_LP0 = _LP0 + (390.752556571117) * eFGP;
*** Effect: TOVP;
_LP0 = _LP0 + (-3.83889262388051) * TOVP;
*** Effect: ORBP;
_LP0 = _LP0 + (1.08208284354419) * ORBP;
*** Effect: FTFGA;
_LP0 = _LP0 + (69.1649729627951) * FTFGA;
*** Effect: oeFGP;
_LP0 = _LP0 + (-387.720210367696) * oeFGP;
*** Effect: oTOVP;
_LP0 = _LP0 + (2.9766607193969) * oTOVP;
*** Effect: DRBP;
_LP0 = _LP0 + (0.78251374596002) * DRBP;
*** Effect: oFTFGA;
_LP0 = _LP0 + (-79.3498359183137) * oFTFGA;

*** Predicted values;
_LP0 = _LP0 +    -32.6965507296228;
_SKIP_000:
if _LMR_BAD=1 then do;
   P_W = .;
end;
else do;
   P_W = _LP0;
end;
