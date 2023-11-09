(*
* File: SMR_StartMoveAdditive.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of SMRamp, licensed under the MIT License.
*
*)


(********************************************************************)
(* Start an additive move 											*)
(********************************************************************)


FUNCTION SMR_StartMoveAdditive


(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_StartMoveAdditive:=	FALSE;


(* Set Internal.CMD *)
					
pAxis.Internal.CMD.MoveAdditive:=	1;


(* For additive moves, CurrTargetPos depends on current motion mode *)

IF( pAxis.IOMap.OUT.MpGenMode = SMR_MODE_POSITION ) THEN
		

	(* Add input position to CurrTargetPos if already in position mode *)

	pAxis.Internal.CurrTargetPos:=	pAxis.Internal.CurrTargetPos + pAxis.IN.PAR.Position;
	
	
ELSIF( pAxis.IOMap.OUT.MpGenMode = SMR_MODE_VELOCITY ) THEN

		
	(* If currently in velocity mode, add input position to current position *)
	
	pAxis.Internal.CurrTargetPos:=	pAxis.Internal.AbsPosActVal + pAxis.IN.PAR.Position;


(* WHAT ABOUT OTHER MODES??? *)
	

END_IF


(* Set CurrDirection based on internal position and target position *)

IF( pAxis.Internal.CurrTargetPos > pAxis.Internal.AbsPosActVal ) THEN

	pAxis.Internal.CurrDirection:=	SMR_DIR_POS;
	
ELSIF( pAxis.Internal.CurrTargetPos < pAxis.Internal.AbsPosActVal ) THEN
	
	pAxis.Internal.CurrDirection:=	SMR_DIR_NEG;

ELSE
 	
	pAxis.Internal.CurrDirection:=	SMR_DIR_STOP;
	
END_IF						


(* Set the target state as SETPOS *)

pAxis.Internal.SetState:=		SMR_STEN_SETPOS;


(* Check for ParsOK *)

IF( pAxis.Internal.ParsOK ) THEN

	pAxis.Internal.EnableState:=	pAxis.Internal.SetState;					

ELSE

	pAxis.Internal.EnableState:=	SMR_STEN_PARWRITE;

END_IF		
					

END_FUNCTION
