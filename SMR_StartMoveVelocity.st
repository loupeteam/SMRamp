(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: SMRamp
 * File: SMR_StartMoveVelocity.st
 * Author: David
 * Created: March 21, 2011
 ********************************************************************
 * Implementation of library SMRamp
 ********************************************************************) 


(********************************************************************)
(* Start a velocity move 											*)
(********************************************************************)


FUNCTION SMR_StartMoveVelocity


(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_StartMoveVelocity:=	FALSE;


(* Set Internal.CMD *)
					
pAxis.Internal.CMD.MoveVelocity:=	1;


(* These conditionals have a different order than MoveAdditive and MoveAbsolute.
	This is because of the error checking on direction.
	If there is a direction error, then the error state transition
	needs to override any other state transition.
	So, the direction check needs to happen after the parameter checks *)
	

(* Set the target state as SETVEL *)

pAxis.Internal.SetState:=		SMR_STEN_SETVEL;


(* Check for ParsOK *)

IF( pAxis.Internal.ParsOK ) THEN

	pAxis.Internal.EnableState:=	pAxis.Internal.SetState;					

ELSE

	pAxis.Internal.EnableState:=	SMR_STEN_PARWRITE;

END_IF


(* Set CurrTargetVel based on input velocity and direction *)

IF( pAxis.IN.PAR.Direction = SMR_DIR_POS ) THEN 
	
	pAxis.Internal.CurrTargetVel:=	pAxis.IN.PAR.Velocity;
	pAxis.Internal.CurrDirection:=	SMR_DIR_POS;
	
ELSIF( pAxis.IN.PAR.Direction = SMR_DIR_NEG ) THEN 
	
	pAxis.Internal.CurrTargetVel:=	-1 * UINT_TO_DINT(pAxis.IN.PAR.Velocity);
	pAxis.Internal.CurrDirection:=	SMR_DIR_NEG;
	
ELSE
	
	(* Invalid direction - Grab error info and abort move *)
	
	pAxis.Internal.Error:=			1;
	pAxis.OUT.STAT.ErrorID:=		SMR_ERR_INVALIDPAR_DIR;
	pAxis.OUT.STAT.ErrorState:=		SMR_STEN_WAIT;

	pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
	
END_IF


END_FUNCTION
