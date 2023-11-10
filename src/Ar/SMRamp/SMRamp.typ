(*
* File: SMRamp.typ
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of SMRamp, licensed under the MIT License.
*
*)

TYPE
	SMR_Axis_Int_ParUpdate_typ : 	STRUCT 
		Update : BOOL;
		CurrValue : UINT;
		AccWrite : AsIOAccWrite;
	END_STRUCT;
	SMR_Axis_Int_Homing_typ : 	STRUCT 
		State : UINT;
		CurrDirection : SINT; (*Current direction of travel*)
		HomeSwOld : BOOL; (*Previous value of HomeSw input for edge detection*)
		RisingEdge : BOOL; (*A rising edge was detected (not dependent on direction of travel)*)
		FallingEdge : BOOL; (*A falling edge was detected (not dependent on direction of travel)*)
		PosEdge : BOOL; (*A "Positive" edge was detected (depends on direction of travel)*)
		NegEdge : BOOL; (*A "Negative" edge was detected (depends on direction of travel)*)
		PosLimitSwOld : BOOL; (*Previous value of PosLimitSw for edge detection*)
		PosLimitSwRisingEdge : BOOL; (*An edge was detected for the PosLimitSw*)
		PosLimitSwFallingEdge : BOOL; (*An edge was detected for the PosLimitSw*)
		NegLimitSwOld : BOOL; (*Previous value of NegLimitSw for edge detection*)
		NegLimitSwRisingEdge : BOOL; (*An edge was detected for the NegLimitSw*)
		NegLimitSwFallingEdge : BOOL; (*An edge was detected for the NegLimitSw*)
		TargetReachedTimer : TON; (*Timer to ensure that TargetReached is true for long enough (takes care of timing issues, but makes homing slightly slower (100-200ms)).*)
	END_STRUCT;
	SMR_Axis_Internal_typ : 	STRUCT 
		CMD : SMR_Axis_IN_CMD_typ; (*Internal CMD structure for discriminating between new and old commands.*)
		DIGIN : SMR_Axis_IOMap_IN_typ; (*Holds logical values of digital inputs (for future expansion)*)
		AbsPos : DINT;
		AbsPosActVal : DINT;
		CurrTargetPos : DINT;
		CurrTargetVel : DINT;
		CurrDirection : SINT;
		EnableState : UINT;
		SetState : UINT;
		Error : BOOL; (*Internal code error*)
		TargetReachedTimer : TON; (*Timer to ensure that TargetReached is true for long enough. Used to set Busy and Done in velocity mode.*)
		AckResetTimer : TON; (*Timer to ensure that the hardware fault acknowledge bits are high for long enough to be seen*)
		Homing : SMR_Axis_Int_Homing_typ;
		UpdateVel : SMR_Axis_Int_ParUpdate_typ;
		UpdateAcc : SMR_Axis_Int_ParUpdate_typ;
		UpdateDec : SMR_Axis_Int_ParUpdate_typ;
		ParsOK : BOOL; (*All motion parameters are up to date*)
		RTInfo : RTInfo; (*RTInfo block to get cycle time*)
		SpdEst : SpeedEst; (*SpdEst block to estimate speed*)
	END_STRUCT;
	SMR_Axis_IOMap_OUT_typ : 	STRUCT 
		AbsPos : DINT;
		MpGenControl : UINT;
		MpGenMode : SINT;
	END_STRUCT;
	SMR_Axis_IOMap_IN_typ : 	STRUCT 
		HomeSw : BOOL;
		PosLimitSw : BOOL;
		NegLimitSw : BOOL;
		QuickStop : BOOL;
		AbsPosActVal : DINT;
		MpGenStatus : UINT;
	END_STRUCT;
	SMR_Axis_IOMap_typ : 	STRUCT 
		IN : SMR_Axis_IOMap_IN_typ;
		OUT : SMR_Axis_IOMap_OUT_typ;
	END_STRUCT;
	SMR_Axis_TEST_STAT_typ : 	STRUCT 
		Busy : BOOL;
		Done : BOOL;
		Error : BOOL; (*Motor Fault or InternalError exists*)
		ErrorID : UINT;
		ErrorString : STRING[SMR_STRLEN_ERROR];
		ActualPosition : DINT;
		ActualVelocity : REAL; (*NOT IMPLEMENTED YET*)
		State : UINT;
		DriveFault : BOOL;
		VoltageEnabled : BOOL;
		HomingOk : BOOL;
	END_STRUCT;
	SMR_Axis_TEST_typ : 	STRUCT 
		Enable : BOOL;
		CMD : SMR_Axis_IN_CMD_typ;
		PAR : SMR_Axis_IN_PAR_typ;
		STAT : SMR_Axis_TEST_STAT_typ;
	END_STRUCT;
	SMR_Axis_OUT_STAT_DriveStat_typ : 	STRUCT 
		RdyToSwOn : BOOL;
		SwOn : BOOL;
		OpEnabled : BOOL;
		Fault : BOOL;
		VoltageEnabled : BOOL;
		QuickStop : BOOL;
		SwOnDisabled : BOOL;
		Warning : BOOL;
		Remote : BOOL;
		TargetReached : BOOL;
		IntLimitActive : BOOL;
		MotorLoad0 : BOOL;
		MotorLoad1 : BOOL;
		MotorLoad2 : BOOL;
		HomingOk : BOOL;
	END_STRUCT;
	SMR_Axis_OUT_STAT_typ : 	STRUCT 
		ReadyForCMD : BOOL;
		Busy : BOOL;
		Done : BOOL;
		Error : BOOL; (*Motor Fault or InternalError exists*)
		ErrorID : UINT;
		ErrorString : STRING[SMR_STRLEN_ERROR];
		ErrorState : UINT;
		ActualPosition : DINT;
		ActualVelocity : REAL; (*Velocity in usteps/s or cts/s, depending on IN.CFG.ABRCtrSyncAsync. THIS WILL NOT MATCH VELOCITY INPUT BECAUSE OF DIFFERENT UNITS.*)
		DriveStatus : SMR_Axis_OUT_STAT_DriveStat_typ;
		State : UINT;
	END_STRUCT;
	SMR_Axis_OUT_typ : 	STRUCT 
		STAT : SMR_Axis_OUT_STAT_typ;
	END_STRUCT;
	SMR_Axis_IN_CFG_SpdEst_typ : 	STRUCT 
		tf : REAL;
		deadband : DINT;
		K : REAL;
	END_STRUCT;
	SMR_Axis_IN_CFG_typ : 	STRUCT 
		DisableAcyclicWrite : BOOL;
		ModuleINADeviceName : STRING[80];
		MotorIndex : USINT;
		UnderCurrentDetection : BOOL;
		ABRCtrSyncAsync : BOOL;
		StallDetection : BOOL;
		InvertDirection : BOOL;
		SpeedEstimator : SMR_Axis_IN_CFG_SpdEst_typ;
	END_STRUCT;
	SMR_Axis_IN_PAR_typ : 	STRUCT 
		HomingPosition : DINT;
		HomingMode : SINT;
		HomingVelocity : UINT;
		HomingStartDir : SINT;
		HomingEdgeSw : SINT;
		HomingTriggDir : SINT;
		Position : DINT;
		Direction : SINT;
		Velocity : UINT;
		Acceleration : UINT;
		Deceleration : UINT;
		JogVelocity : UINT;
		StopDeceleration : UINT;
	END_STRUCT;
	SMR_Axis_IN_CMD_typ : 	STRUCT 
		Power : BOOL;
		Home : BOOL;
		MoveAbsolute : BOOL;
		MoveAdditive : BOOL;
		MoveVelocity : BOOL;
		JogForward : BOOL;
		JogReverse : BOOL;
		TrackSetPosition : BOOL;
		Stop : BOOL;
		AcknowledgeError : BOOL;
	END_STRUCT;
	SMR_Axis_IN_typ : 	STRUCT 
		CMD : SMR_Axis_IN_CMD_typ;
		PAR : SMR_Axis_IN_PAR_typ;
		CFG : SMR_Axis_IN_CFG_typ;
	END_STRUCT;
	SMR_Axis_typ : 	STRUCT 
		IN : SMR_Axis_IN_typ;
		OUT : SMR_Axis_OUT_typ;
		TEST : SMR_Axis_TEST_typ;
		IOMap : SMR_Axis_IOMap_typ;
		Internal : SMR_Axis_Internal_typ;
	END_STRUCT;
END_TYPE
