(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Library: SMRamp
 * File: SMRamp.fun
 * Author: blackburnd
 * Created: August 31, 2009
 ********************************************************************
 * Functions and function blocks of library SMRamp
 ********************************************************************)

FUNCTION SMR_AxisFn_Cyclic : BOOL (*This function handles cyclic motion on the Ramp Mode axis.*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_SetMpGenControl : BOOL (*This function sets the bits in the control word based on the axis input values*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_GetDriveStatus : BOOL (*This is an internal function that maps out the status from the status UINT*)
	VAR_INPUT
		MpGenStatus : UINT; (*MpGenStatus input*)
	END_VAR
	VAR_IN_OUT
		DriveStatus : SMR_Axis_OUT_STAT_DriveStat_typ; (*Drive status structure*)
	END_VAR
END_FUNCTION

FUNCTION SMR_SetState : BOOL (*This function sets the state based on the status bits*)
	VAR_IN_OUT
		t : SMR_Axis_OUT_STAT_typ; (*Pointer to the Output Status*)
	END_VAR
END_FUNCTION

FUNCTION SMR_Home : BOOL (*Function to perform homing functionality*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
	VAR
		t : REFERENCE TO SMR_Axis_Int_Homing_typ; (*Pointer to the homing variables*)
	END_VAR
END_FUNCTION

FUNCTION SMR_HomeFindEdge : BOOL (*Function to find edges for homing*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
	VAR
		t : REFERENCE TO SMR_Axis_Int_Homing_typ; (*Pointer to the homing variables*)
	END_VAR
END_FUNCTION

FUNCTION SMR_CheckHomePAR : BOOL (*Function which checks homing parameters.  Returns TRUE if pars are OK.*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
	VAR
		Error : BOOL; (*Error exists with a homing parameter*)
	END_VAR
END_FUNCTION

FUNCTION SMR_StartHome : BOOL (*Start a homing move*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_StartMoveAbsolute : BOOL (*Start an absolute move*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_StartMoveAdditive : BOOL (*Start an additive move*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_StartMoveVelocity : BOOL (*Start a velocity move*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_StartTrackSetPosition : BOOL (*Starts a TrackSetPosition move*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_StartJogForward : BOOL (*Starts a JogForward move*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_StartJogReverse : BOOL (*Starts a JogReverse move*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_SetBusyDone : BOOL (*Function to set Busy and Done in the ST_ENABLED state*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_CheckLimitSw : BOOL (*Check limit switches*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_UpdatePars : BOOL (*Update motion parameters if they change*)
	VAR_IN_OUT
		pAxis : SMR_Axis_typ; (*SMRamp Axis object*)
	END_VAR
END_FUNCTION

FUNCTION SMR_SetErrorString : BOOL (*Set the error string based on the error ID*)
	VAR_INPUT
		ErrorID : UINT;
	END_VAR
	VAR_IN_OUT
		ErrorString : STRING[SMR_STRLEN_ERROR];
	END_VAR
END_FUNCTION
