(*
* File: SMR_StartJogReverse.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of SMRamp, licensed under the MIT License.
*
*)


(********************************************************************)
(* Starts a JogReverse move 										*)
(********************************************************************)


FUNCTION SMR_StartJogReverse
	

(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_StartJogReverse:=	FALSE;


(* Set Internal.CMD *)
					
pAxis.Internal.CMD.JogReverse:=	1;


(* Set the target state as SMR_STEN_JOGREV *)

pAxis.Internal.SetState:=		SMR_STEN_JOGREV;


(* Check for ParsOK *)

IF( pAxis.Internal.ParsOK ) THEN

	pAxis.Internal.EnableState:=	pAxis.Internal.SetState;					

ELSE

	pAxis.Internal.EnableState:=	SMR_STEN_PARWRITE;

END_IF


(* Set CurrTargetVel *)

pAxis.Internal.CurrTargetVel:=	-1 * UINT_TO_DINT( pAxis.IN.PAR.JogVelocity );
pAxis.Internal.CurrDirection:=	SMR_DIR_NEG;
	

END_FUNCTION
