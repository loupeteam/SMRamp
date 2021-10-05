(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: SMRamp
 * File: SMR_StartMoveAbsolute.st
 * Author: David
 * Created: March 21, 2011
 ********************************************************************
 * Implementation of library SMRamp
 ********************************************************************) 


(********************************************************************)
(* Start an absolute move 											*)
(********************************************************************)


FUNCTION SMR_StartMoveAbsolute


(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_StartMoveAbsolute:=	FALSE;


(* Set Internal.CMD *)
					
pAxis.Internal.CMD.MoveAbsolute:=	1;


(* Set CurrTargetPos to input position for absolute moves *)

pAxis.Internal.CurrTargetPos:=	pAxis.IN.PAR.Position;


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
