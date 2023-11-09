(*
* File: SMR_SetErrorString.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of SMRamp, licensed under the MIT License.
*
*)


(********************************************************************)
(* Set the error string based on the error ID 						*)
(********************************************************************)


(* Functionality			DONE and TESTED DFB 20120503 *)


FUNCTION SMR_SetErrorString
	
	
(************************************************************)
(* Set return value to get rid of compile warning 			*)
(************************************************************)

SMR_SetErrorString:=	FALSE;


(* Set ErrorString *)

CASE ErrorID OF
	
	0:	ErrorString:=	'';
	
	30190..30196:	ErrorString:=	'Error writing parameters. Check IN.CFG.ModuleINADeviceName and IN.CFG.MotorIndex.';
	
	SMR_ERR_INVALIDPAR_ACC:		ErrorString:=	'IN.PAR.Acceleration is 0';
	SMR_ERR_INVALIDPAR_DEC:		ErrorString:=	'IN.PAR.Deceleration is 0';
	SMR_ERR_INVALIDPAR_STOPDEC:	ErrorString:=	'IN.PAR.StopDeceleration is 0';
	SMR_ERR_INVALIDPAR_DIR:		ErrorString:=	'IN.PAR.Direction is invalid';

	SMR_ERR_HOME_INVALIDPAR:	ErrorString:=	'One or more homing parameters is invalid';
	SMR_ERR_HOME_ERR:			ErrorString:=	'Error occurred while homing. Check wiring of switches and homing configuration.';

	SMR_ERR_POSLIMSW:	ErrorString:=	'Positive limit switch is active. Movement in the positive direction is not allowed.';
	SMR_ERR_NEGLIMSW:	ErrorString:=	'Negative limit switch is active. Movement in the negative direction is not allowed.';
	
	ELSE ErrorString:=	'Unknown error';
	
END_CASE


END_FUNCTION
