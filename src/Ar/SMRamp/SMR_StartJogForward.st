(*
* File: SMR_StartJogForward.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of SMRamp, licensed under the MIT License.
*
*)


(********************************************************************)
(* Starts a JogForward move 										*)
(********************************************************************)


FUNCTION SMR_StartJogForward
	
	
(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_StartJogForward:=	FALSE;


(* Set Internal.CMD *)
					
pAxis.Internal.CMD.JogForward:=	1;


(* Set the target state as SMR_STEN_JOGFWD *)

pAxis.Internal.SetState:=		SMR_STEN_JOGFWD;


(* Check for ParsOK *)

IF( pAxis.Internal.ParsOK ) THEN

	pAxis.Internal.EnableState:=	pAxis.Internal.SetState;					

ELSE

	pAxis.Internal.EnableState:=	SMR_STEN_PARWRITE;

END_IF


(* Set CurrTargetVel *)

pAxis.Internal.CurrTargetVel:=	pAxis.IN.PAR.JogVelocity;
pAxis.Internal.CurrDirection:=	SMR_DIR_POS;
	

END_FUNCTION
