*****************************************;
** SAS Scoring Code for PROC REG;
*****************************************;

label P_seed = 'Predicted: seed' ;
drop _LMR_BAD;
_LMR_BAD=0;

*** Check interval variables for missing values;
if nmiss(ADJOE,ADJDE,BARTHAG,EFG_O,EFG_D,TOR,TORD,ORB,DRB,FTR,FTRD,_2PO,_2PD,
        _3PO,_3PD,ADJ_T,WAB) then do;
   _LMR_BAD=1;
   goto _SKIP_000;
end;

*** Compute Linear Predictors;
drop _LP0;
_LP0 = 0;

*** Effect: ADJOE;
_LP0 = _LP0 + (-0.8003480679085) * ADJOE;
*** Effect: ADJDE;
_LP0 = _LP0 + (0.53393234706848) * ADJDE;
*** Effect: BARTHAG;
_LP0 = _LP0 + (29.5110761187443) * BARTHAG;
*** Effect: EFG_O;
_LP0 = _LP0 + (0.72831132621432) * EFG_O;
*** Effect: EFG_D;
_LP0 = _LP0 + (0.160845552825) * EFG_D;
*** Effect: TOR;
_LP0 = _LP0 + (-0.33375096076831) * TOR;
*** Effect: TORD;
_LP0 = _LP0 + (-0.01242200644914) * TORD;
*** Effect: ORB;
_LP0 = _LP0 + (0.10914948358044) * ORB;
*** Effect: DRB;
_LP0 = _LP0 + (-0.05536320869634) * DRB;
*** Effect: FTR;
_LP0 = _LP0 + (0.06577057882817) * FTR;
*** Effect: FTRD;
_LP0 = _LP0 + (0.01232707182542) * FTRD;
*** Effect: _2PO;
_LP0 = _LP0 + (-0.23021890580126) * _2PO;
*** Effect: _2PD;
_LP0 = _LP0 + (-0.09220986525045) * _2PD;
*** Effect: _3PO;
_LP0 = _LP0 + (-0.20247081164909) * _3PO;
*** Effect: _3PD;
_LP0 = _LP0 + (-0.08269444685113) * _3PD;
*** Effect: ADJ_T;
_LP0 = _LP0 + (0.01646870203533) * ADJ_T;
*** Effect: WAB;
_LP0 = _LP0 + (-0.45359248530858) * WAB;

*** Predicted values;
_LP0 = _LP0 +     7.01406774616196;
_SKIP_000:
if _LMR_BAD=1 then do;
   P_seed = .;
end;
else do;
   P_seed = _LP0;
end;
