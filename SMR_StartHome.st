(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: SMRamp
 * File: SMR_StartHome.st
 * Author: David
 * Created: March 21, 2011
 ********************************************************************
 * Implementation of library SMRamp
 ********************************************************************) 


(********************************************************************)
(* Start a homing move 												*)
(********************************************************************)


FUNCTION SMR_StartHome
	
	
(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_StartHome:=	FALSE;


(* Set Internal.CMD *)

pAxis.Internal.CMD.Home:=	1;


(* Set Invalid Direction to disable default limit switch monitoring *)
(* Limit switches are monitored inside of the homing procedure *)

pAxis.Internal.CurrDirection:=	SMR_DIR_INVALID;


(* Reset HomingOk *)

pAxis.OUT.STAT.DriveStatus.HomingOk:=	0;


(* Initialize Homing variables *)

pAxis.Internal.Homing.State:=			SMR_STHOME_CHECKMODE;
pAxis.Internal.Homing.CurrDirection:=	SMR_DIR_STOP;
pAxis.Internal.Homing.HomeSwOld:=		pAxis.Internal.DIGIN.HomeSw;
pAxis.Internal.Homing.PosLimitSwOld:=	pAxis.Internal.DIGIN.PosLimitSw;
pAxis.Internal.Homing.NegLimitSwOld:=	pAxis.Internal.DIGIN.NegLimitSw;


(* SetState should be SMR_STEN_HOME *)
	
pAxis.Internal.SetState:=	SMR_STEN_HOME;


(* Check for ParsOK *)

IF( pAxis.Internal.ParsOK ) THEN

	pAxis.Internal.EnableState:=	pAxis.Internal.SetState;					

ELSE

	pAxis.Internal.EnableState:=	SMR_STEN_PARWRITE;

END_IF


END_FUNCTION
