(*
* File: SMR_GetDriveStatus.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of SMRamp, licensed under the MIT License.
*
*)



(*This is an internal function that maps out the status from the status UINT.*)

(* Getting status			DONE and TESTED DFB 20110329 *)


FUNCTION SMR_GetDriveStatus


(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_GetDriveStatus:=	FALSE;


(* Get status BOOLs out of status UINT *)

DriveStatus.RdyToSwOn:=			BIT_TST(MpGenStatus, 0);
DriveStatus.SwOn:=				BIT_TST(MpGenStatus, 1);
DriveStatus.OpEnabled:=			BIT_TST(MpGenStatus, 2);
DriveStatus.Fault:=				BIT_TST(MpGenStatus, 3);
DriveStatus.VoltageEnabled:=	BIT_TST(MpGenStatus, 4);
DriveStatus.QuickStop:=			BIT_TST(MpGenStatus, 5);
DriveStatus.SwOnDisabled:=		BIT_TST(MpGenStatus, 6);
DriveStatus.Warning:=			BIT_TST(MpGenStatus, 7);

DriveStatus.Remote:=			BIT_TST(MpGenStatus, 9);
DriveStatus.TargetReached:=		BIT_TST(MpGenStatus, 10);
DriveStatus.IntLimitActive:=	BIT_TST(MpGenStatus, 11);

DriveStatus.MotorLoad0:=		BIT_TST(MpGenStatus, 13);
DriveStatus.MotorLoad1:=		BIT_TST(MpGenStatus, 14);
DriveStatus.MotorLoad2:=		BIT_TST(MpGenStatus, 15);


END_FUNCTION
