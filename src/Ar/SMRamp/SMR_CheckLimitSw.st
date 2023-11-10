(*
* File: SMR_CheckLimitSw.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of SMRamp, licensed under the MIT License.
*
*)


(********************************************************************)
(* Check limit switches 											*)
(********************************************************************)


FUNCTION SMR_CheckLimitSw


(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_CheckLimitSw:=	FALSE;


(********************************************************************)
(* Check Limit Switches												*)
(********************************************************************)


(* PosLimitSw *)

IF( (pAxis.Internal.CurrDirection = SMR_DIR_POS)
	AND	(pAxis.Internal.DIGIN.PosLimitSw)
	)THEN
	
	
	(* Set CurrDirection to STOP *)
	
	pAxis.Internal.CurrDirection:=	SMR_DIR_STOP;
	
	
	(* Set Mode to Velocity mode and set position to 0 to stop axis *)
				
	pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
	pAxis.Internal.AbsPos:=		0;
	
	
	(* Set Error info and go to Error state *)
	
	pAxis.Internal.Error:=			1;
	pAxis.OUT.STAT.ErrorID:=		SMR_ERR_POSLIMSW;
	pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
					
	pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
	
	
	(* Reset Busy and Done *)
	
	pAxis.OUT.STAT.Busy:=	0;
	pAxis.OUT.STAT.Done:=	0;


END_IF


(* NegLimitSw *)

IF( (pAxis.Internal.CurrDirection = SMR_DIR_NEG)
	AND	(pAxis.Internal.DIGIN.NegLimitSw)
	)THEN
	

	(* Set CurrDirection to STOP *)
	
	pAxis.Internal.CurrDirection:=	SMR_DIR_STOP;
	
	
	(* Set Mode to Velocity mode and set position to 0 to stop axis *)
				
	pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
	pAxis.Internal.AbsPos:=		0;
	
	
	(* Set Error info and go to Error state *)
	
	pAxis.Internal.Error:=			1;
	pAxis.OUT.STAT.ErrorID:=		SMR_ERR_NEGLIMSW;
	pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
					
	pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
	
	
	(* Reset Busy and Done *)
	
	pAxis.OUT.STAT.Busy:=	0;
	pAxis.OUT.STAT.Done:=	0;


END_IF


END_FUNCTION
