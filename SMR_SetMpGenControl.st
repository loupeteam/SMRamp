(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Library: SMRamp
 * File: SMR_SetMpGenControl.st
 * Author: blackburnd
 * Created: September 01, 2009
 ********************************************************************
 * Implementation of library SMRamp
 ********************************************************************) 

(*This function sets the bits in the control word based on the axis input values.*)


(* SwOn, EnableOperation					DONE and TESTED DFB 20110906 *)
	(* Setting								see SMR_Cyclic.st *)
	(* Resetting							DONE and TESTED DFB 20110906 *)

(* VoltageEnable							DONE and TESTED DFB 20110906 *)
				
(* QuickStop								DONE and TESTED DFB 20110906 *)
				
(* FaultReset, WarningReset					DONE and TESTED DFB 20110906 *)
	(* Set									DONE and TESTED DFB 20110906 *)
	(* Reset								DONE and TESTED DFB 20110906 *)

(* UnderCurrentDetection					DONE and TESTED DFB 20110906 *)
(* ABRSynsAsync								DONE and TESTED DFB 20110906 *)
(* StallDetection							DONE and TESTED DFB 20110906 *)
				

FUNCTION SMR_SetMpGenControl


(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_SetMpGenControl:=	FALSE;


(* Switch On and Enable Operation control bits are set in the state machine  *)
(* They are reset here *)

IF( NOT(pAxis.IN.CMD.Power) ) THEN

	pAxis.IOMap.OUT.MpGenControl:=	BIT_CLR(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_SWON);
	pAxis.IOMap.OUT.MpGenControl:=	BIT_CLR(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_ENABLEOPERATION);

END_IF


(* Set VoltageEnable bit always TRUE *)

pAxis.IOMap.OUT.MpGenControl:=	BIT_SET(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_ENABLEVOLTAGE);


(* Set quickstop control bit accordingly *)

IF( pAxis.Internal.DIGIN.QuickStop ) THEN

	pAxis.IOMap.OUT.MpGenControl:=	BIT_SET(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_QUICKSTOP);

ELSE

	pAxis.IOMap.OUT.MpGenControl:=	BIT_CLR(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_QUICKSTOP);
	
END_IF


(* Set Fault Reset and warning reset control bits according to CMD  *)

IF( pAxis.IN.CMD.AcknowledgeError ) THEN


	(* Reset latch timer *)
	
	pAxis.Internal.AckResetTimer.IN:=	0;

	
	(* Set bits *)
	
	pAxis.IOMap.OUT.MpGenControl:=	BIT_SET(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_FAULTRESET);
	pAxis.IOMap.OUT.MpGenControl:=	BIT_SET(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_WARNINGRESET);


ELSE

	
	(* Set latch timer *)
	
	pAxis.Internal.AckResetTimer.IN:=	1;
	
	
	(* If latch timer expires, reset bits *)
	
	IF( pAxis.Internal.AckResetTimer.Q )THEN

		pAxis.IOMap.OUT.MpGenControl:=	BIT_CLR(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_FAULTRESET);
		pAxis.IOMap.OUT.MpGenControl:=	BIT_CLR(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_WARNINGRESET);
		
	END_IF
	
	
END_IF


(* Handle AckResetTimer *)

pAxis.Internal.AckResetTimer.PT:=	T#25ms;

pAxis.Internal.AckResetTimer();


(* Set configuration control bits according to CFG  *)

IF( pAxis.IN.CFG.UnderCurrentDetection ) THEN

	pAxis.IOMap.OUT.MpGenControl:=	BIT_SET(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_UNDERCURRENT);

ELSE

	pAxis.IOMap.OUT.MpGenControl:=	BIT_CLR(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_UNDERCURRENT);
	
END_IF


IF( pAxis.IN.CFG.ABRCtrSyncAsync ) THEN

	pAxis.IOMap.OUT.MpGenControl:=	BIT_SET(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_SYNCPOS);

ELSE

	pAxis.IOMap.OUT.MpGenControl:=	BIT_CLR(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_SYNCPOS);
	
END_IF


IF( pAxis.IN.CFG.StallDetection ) THEN

	pAxis.IOMap.OUT.MpGenControl:=	BIT_SET(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_STALLDETECT);

ELSE

	pAxis.IOMap.OUT.MpGenControl:=	BIT_CLR(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_STALLDETECT);
	
END_IF


END_FUNCTION
