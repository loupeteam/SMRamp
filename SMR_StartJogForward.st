(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: SMRamp
 * File: SMR_StartJogForward.st
 * Author: David
 * Created: April 18, 2011
 ********************************************************************
 * Implementation of library SMRamp
 ********************************************************************) 


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
