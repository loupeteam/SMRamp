(*
* File: SMR_CheckHomePAR.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of SMRamp, licensed under the MIT License.
*
*)

(*Function which checks homing parameters.  Returns TRUE if pars are OK.*)


(* Parameter checking			DONE and TESTED DFB 20090914 *)


FUNCTION SMR_CheckHomePAR


(* Reset internal Error variable.  Will be set below if there is an error *)

Error:=	0;


(* Check HomingMode *)

IF( 	(pAxis.IN.PAR.HomingMode <> SMR_HOMEMODE_DIRECT)		
	AND (pAxis.IN.PAR.HomingMode <> SMR_HOMEMODE_SWITCH_GATE)
	AND	(pAxis.IN.PAR.HomingMode <> SMR_HOMEMODE_ABS_SWITCH)
	AND	(pAxis.IN.PAR.HomingMode <> SMR_HOMEMODE_END_SWITCH)	
	)THEN
 
 	Error:=	1;
	
END_IF	
	

(* Check HomingVelocity *)

IF( pAxis.IN.PAR.HomingVelocity = 0 )THEN
 
 	Error:=	1;
	
END_IF


(* Check HomingStartDir *)

IF( 	(pAxis.IN.PAR.HomingStartDir <> SMR_POS)
	AND (pAxis.IN.PAR.HomingStartDir <> SMR_NEG)	
	)THEN
 
 	Error:=	1;
	
END_IF	
	

(* Check HomingEdgeSw *)

IF( 	(pAxis.IN.PAR.HomingEdgeSw <> SMR_POS)
	AND	(pAxis.IN.PAR.HomingEdgeSw <> SMR_NEG)
	)THEN
 
 	Error:=	1;
	
END_IF	
	

(* Check HomingTriggDir *)

IF( 	(pAxis.IN.PAR.HomingTriggDir <> SMR_POS)
	AND	(pAxis.IN.PAR.HomingTriggDir <> SMR_NEG)	
	)THEN
 
 	Error:=	1;
	
END_IF	
	

IF( Error )THEN

	SMR_CheckHomePAR:=	0;
	
ELSE
	
	SMR_CheckHomePAR:=	1;
	
END_IF
	


END_FUNCTION
