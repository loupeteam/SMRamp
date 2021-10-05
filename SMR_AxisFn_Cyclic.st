(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Library: SMRamp
 * File: SMR_Cyclic.st
 * Author: blackburnd
 * Created: August 31, 2009
 ********************************************************************
 * Implementation of library SMRamp
 ********************************************************************) 


(********************************************************************)
(* This function handles cyclic motion on the Ramp Mode axis. 		*)
(********************************************************************)


(* Handling TEST interface						DONE and TESTED DFB 20110512 *)
	(* CMD, PAR									DONE and TESTED DFB 20110511 *)
	(* STAT										DONE and TESTED DFB 20110512 *)

(* Handling Quickstop							see SMR_SetMpGenControl.st *)

(* Getting appropriate values of DIGIN			DONE and TESTED DFB 20110906 *)
	(* based on default active levels - HomeSw active High, all others active Low *)
	(* Configurable active levels are easily implementable in the future *)

(* Getting status								see SMR_GetDriveStatus.st *)

(* Setting machine state						see SMR_SetState.st *)

(* Setting Control Bits							see SMR_SetMpGenControl.st *)
	(* SwOn, Enable	Setting						DONE and TESTED DFB 20110906 *)

(* Operation when enabled						DONE and TESTED DFB 20091006 *)

	(* ReadyForCMD handling						DONE and TESTED DFB 20091006 *)
	
	(* Internal CMD handling					DONE and TESTED DFB 20110404 *)
		(* Setting								DONE and TESTED DFB 20110404 *)
		(* Resetting							DONE and TESTED DFB 20110419 *)
		(* Screening commands					DONE and TESTED DFB 20110404 *)
			(* Home								DONE and TESTED DFB 20110404 *)
			(* MoveAbsolute						DONE and TESTED DFB 20110404 *)
			(* MoveAdditive						DONE and TESTED DFB 20110404 *)
			(* MoveVelocity						DONE and TESTED DFB 20110404 *)
			(* TrackSetPosition					DONE and TESTED DFB 20110404 *)
			(* Jog								DONE and TESTED DFB 20110419 *)
			
	
	(*************************************************************************)
	(* Moves																 *)
	(*************************************************************************)

	(* MoveAbs									DONE and TESTED DFB 20110404 *)
		(* Setting CurrTargetPos				DONE and TESTED DFB 20110404 *)
		(* Finding CurrDirection				DONE and TESTED DFB 20110404 *)
		(* Setting SetState						DONE and TESTED DFB 20110404 *)
		(* Checking for parameter changes		DONE and TESTED DFB 20110404 *)
		(* Changing State						DONE and TESTED DFB 20110404 *)
		(* Setting AbsPos and Mode				DONE and TESTED DFB 20110906 *)
	
	(* MoveAdd									DONE and TESTED DFB 20110404 *)
		
		(* Setting CurrTargetPos				DONE and TESTED DFB 20110404 *)
			(* After enable						DONE and TESTED DFB 20110404 *)
			(* After MoveAbs					DONE and TESTED DFB 20110404 *)
			(* After MoveAdd					DONE and TESTED DFB 20110404 *)
			(* After MoveVel					DONE and TESTED DFB 20110404 *)
			(* After Home						DONE and TESTED DFB 20110404 *)
			(* After Stop						DONE and TESTED DFB 20110404 *)
			(* After Jog						DONE and TESTED DFB 20110419 *)
			(* After error						DONE and TESTED DFB 20110404 *)

		(* Finding CurrDirection				DONE and TESTED DFB 20110404 *)
		(* Setting SetState						DONE and TESTED DFB 20110404 *)
		(* Checking for parameter changes		DONE and TESTED DFB 20110404 *)
		(* Changing State						DONE and TESTED DFB 20110404 *)
		(* Setting AbsPos and Mode				DONE and TESTED DFB 20110906 *)
	
	(* MoveVel									DONE and TESTED DFB 20110404 *)
		(* Finding CurrDirection				DONE and TESTED DFB 20110404 *)
		(* Setting SetState						DONE and TESTED DFB 20110404 *)
		(* Checking for parameter changes		DONE and TESTED DFB 20110404 *)
		(* Changing State						DONE and TESTED DFB 20110404 *)
		(* Setting AbsPos and Mode				DONE and TESTED DFB 20110906 *)
		
	(* TrackSetPos								DONE and TESTED DFB 20110404 *)
		(* Setting CurrTargetPos				DONE and TESTED DFB 20110404 *)
		(* Finding CurrDirection				DONE and TESTED DFB 20110404 *)
		(* Setting SetState						DONE and TESTED DFB 20110404 *)
		(* Checking for parameter changes		DONE and TESTED DFB 20110404 *)
		(* Changing State						DONE and TESTED DFB 20110404 *)
		(* Setting AbsPos and Mode				DONE and TESTED DFB 20110906 *)
	
	(* JogForward								DONE and TESTED DFB 20110419 *)
		(* Setting CurrDirection				DONE and TESTED DFB 20110419 *)
		(* Setting SetState						DONE and TESTED DFB 20110419 *)
		(* Checking for parameter changes		DONE and TESTED DFB 20110419 *)
		(* Changing State						DONE and TESTED DFB 20110419 *)
		(* Setting AbsPos and Mode				DONE and TESTED DFB 20110906 *)
		(* Stopping after CMD					DONE and TESTED DFB 20110419 *)
		(* Handling Stop CMD					DONE and TESTED DFB 20110419 *)
		
	(* JogReverse								DONE and TESTED DFB 20110419 *)
		(* Setting CurrDirection				DONE and TESTED DFB 20110419 *)
		(* Setting SetState						DONE and TESTED DFB 20110419 *)
		(* Checking for parameter changes		DONE and TESTED DFB 20110419 *)
		(* Changing State						DONE and TESTED DFB 20110419 *)
		(* Setting AbsPos and Mode				DONE and TESTED DFB 20110906 *)
		(* Stopping after CMD					DONE and TESTED DFB 20110419 *)
		(* Handling Stop CMD					DONE and TESTED DFB 20110419 *)
		
	(* Stop										DONE and TESTED DFB 20110404 *)
		(* Setting SetState						DONE and TESTED DFB 20110404 *)
		(* Changing State						DONE and TESTED DFB 20110404 *)
		(* Setting AbsPos and Mode				DONE and TESTED DFB 20110906 *)
	
	(* Home										see SMR_Home.st *)
		(* Set invalid direction				DONE and TESTED DFB 20110404 *)
		(* Reset HomingOk						DONE and TESTED DFB 20110404 *)
		(* Initializing Homing Pars				DONE and TESTED DFB 20110404 *)
		(* Setting SetState						DONE and TESTED DFB 20110404 *)
		(* Checking for parameter change		DONE and TESTED DFB 20110404 *)
		(* Homing								see SMR_Home.st *)
		(* State change							see SMR_Home.st *)
		
	
	(*************************************************************************)
	(* Writing Parameters													 *)
	(*************************************************************************)

	(* Writing parameters						see SMR_UpdatePars.st
		(* State changing						DONE and TESTED DFB 20110404 *)
		
	
	(*************************************************************************)
	(* Error handling														 *)
	(*************************************************************************)

	(* Checking invalid parameters				DONE and TESTED DFB 20110404 *)
		(* Accel, Decel, StopDecel				see SMR_UpdatePars.st *)
		(* Direction							DONE and TESTED DFB 20090918 *)
		(* Homing pars							see SMR_Home.st *)

	(* Motor stops in error state				DONE not tested *)
		
	(* Resetting internal faults				DONE and TESTED DFB 20110405 *)
		(* STEN_ERROR							DONE and TESTED DFB 20090911 *)
		(* ST_RDYTOSWON							DONE and TESTED DFB 20110405 *)
		
	(* Handling motor faults					DONE and TESTED DFB 20110906 *)
		(* TC < 25ms							DONE and TESTED DFB 20110906 *)
		(* TC = 25ms							DONE and TESTED DFB 20110906 *)
		(* TC > 25ms							DONE and TESTED DFB 20110906 *)


	(*************************************************************************)
	(* Limit Switch handling												 *)
	(*************************************************************************)

	(* Limit Switch handling					DONE and TESTED DFB 20110906 *)
	
		(* Stopping during a move				DONE and TESTED DFB 20110405 *)
			(* During MoveAbsolute				DONE and TESTED DFB 20110405 *)
			(* During MoveAdditive				DONE and TESTED DFB 20110906 *)
			(* During MoveVelocity				DONE and TESTED DFB 20110405 *)
			(* During Jog						DONE and TESTED DFB 20110419 *)
			(* During Home						see SMR_Home.st *)
			
		(* Preventing new moves in lim dir		DONE and TESTED DFB 20110405 *)
			(* MoveAbsolute						DONE and TESTED DFB 20110405 *)
			(* MoveAdditive						DONE and TESTED DFB 20110405 *)
			(* MoveVelocity						DONE and TESTED DFB 20110405 *)
			(* During Jog						DONE and TESTED DFB 20110419 *)
			(* Home								see SMR_Home.st *)

		(* Allowing new moves not in lim dir	DONE and TESTED DFB 20110405 *)
			(* MoveAbsolute						DONE and TESTED DFB 20110405 *)
			(* MoveAdditive						DONE and TESTED DFB 20110405 *)
			(* MoveVelocity						DONE and TESTED DFB 20110405 *)
			(* During Jog						DONE and TESTED DFB 20110419 *)
			(* Home								see SMR_Home.st *)
			
		(* Setting error status					DONE and TESTED DFB 20110405 *)
		
	
	(*************************************************************************)
	(* Busy, Done, Error													 *)
	(*************************************************************************)
	
	(* Busy, Done								DONE and TESTED DFB 20110405 *)
		(* ST_NOTRDYTOSWON						DONE and TESTED DFB 20110405 *)
		(* ST_SWONDISABLED						DONE and TESTED DFB 20110405 *)
		(* ST_RDYTOSWON							DONE and TESTED DFB 20110405 *)
		(* ST_SWON								DONE and TESTED DFB 20110405 *)
		(* ST_ENABLED							see SMR_SetBusyDone.st *)
		(* ST_QUICKSTOPACTIVE					DONE and TESTED DFB 20110405 *)
		(* ST_FAULTRXNACTIVE					DONE and TESTED DFB 20110405 *)
		(* ST_FAULT								DONE and TESTED DFB 20110405 *)
		
	(* Error									DONE and TESTED DFB 20110405 *)
	

	(*************************************************************************)
	(* Inverting Direction													 *)
	(*************************************************************************)

	(* YOU MUST STOP BEFORE CHANGING THE VALUE OF INVERTDIRECTION.			 *)
	(* OTHERWISE, THE MOTOR MAY MOVE, DEPENDING ON THE LAST COMMAND!!!		 *)
			
	(* Inverting Direction						DONE and TESTED DFB 20090921 *)
		(* Getting ActPos feedback				DONE and TESTED DFB 20110906 *)
		(* Moves								DONE and TESTED DFB 20090918 *)
			(* MoveAbs							DONE and TESTED DFB 20090918 *)
			(* MoveAdd							DONE and TESTED DFB 20090918 *)
			(* MoveVel							DONE and TESTED DFB 20090918 *)
		(* Homing								DONE and TESTED DFB 20090921 *)

(* Estimating speed								DONE and TESTED DFB 20110517 *)
	(* InvertDirection = 0						DONE and TESTED DFB 20110517 *)
	(* InvertDirection = 1						DONE and TESTED DFB 20110517 *)

FUNCTION SMR_AxisFn_Cyclic


(************************************************************************************)
(* Set return value to get rid of compiler warning									*)
(************************************************************************************)

SMR_AxisFn_Cyclic:=	FALSE;


(****************************************************)
(* Handle TEST interface							*)
(****************************************************)

IF( pAxis.TEST.Enable )THEN


	(* Overwrite IN.CMDs and IN.PARs while in TEST mode *)

	pAxis.IN.CMD:=	pAxis.TEST.CMD;
	pAxis.IN.PAR:=	pAxis.TEST.PAR;	

ELSE


    (* Clear TEST.CMDs and load TEST.PARs from machine while not in TEST mode *)
	
	brsmemset( ADR(pAxis.TEST.CMD), 0, SIZEOF(pAxis.TEST.CMD));
	pAxis.TEST.PAR:=	pAxis.IN.PAR;

END_IF


(************************************************************************************)
(* Reset ReadyForCMD - this is set in SMR_STEN_WAIT state							*)
(************************************************************************************)

pAxis.OUT.STAT.ReadyForCMD:=	0;


(************************************************************************************)
(* Get Internal DIGIN values														*)
(************************************************************************************)

(* Right now, use default levels for inputs.
	Then, later, it is possible to add configurable signal levels *)
	
pAxis.Internal.DIGIN.HomeSw:=		pAxis.IOMap.IN.HomeSw;
pAxis.Internal.DIGIN.PosLimitSw:=	NOT(pAxis.IOMap.IN.PosLimitSw);
pAxis.Internal.DIGIN.NegLimitSw:=	NOT(pAxis.IOMap.IN.NegLimitSw);
pAxis.Internal.DIGIN.QuickStop:=	pAxis.IOMap.IN.QuickStop;


(************************************************************************************)
(* Set MpGenControl UINT accordingly												*)
(************************************************************************************)

SMR_SetMpGenControl( pAxis );


(************************************************************************************)
(* Get DriveStatus BOOLs from MpGenStatus UINT										*)
(************************************************************************************)

SMR_GetDriveStatus( pAxis.IOMap.IN.MpGenStatus, pAxis.OUT.STAT.DriveStatus );


(************************************************************************************)
(* Get Internal and Status AbsPosActVal based on InvertDirection					*)
(************************************************************************************)

IF( pAxis.IN.CFG.InvertDirection ) THEN

	pAxis.OUT.STAT.ActualPosition:=	-1 * pAxis.IOMap.IN.AbsPosActVal;
	pAxis.Internal.AbsPosActVal:=	-1 * pAxis.IOMap.IN.AbsPosActVal;
	
ELSE
	
	pAxis.OUT.STAT.ActualPosition:=	pAxis.IOMap.IN.AbsPosActVal;
	pAxis.Internal.AbsPosActVal:=	pAxis.IOMap.IN.AbsPosActVal;
	
END_IF


(************************************************************************************)
(* Reset Internal CMDs																*)
(************************************************************************************)

IF( NOT(pAxis.IN.CMD.Home) ) THEN

	pAxis.Internal.CMD.Home:=	0;

END_IF


IF( NOT(pAxis.IN.CMD.MoveAbsolute) ) THEN

	pAxis.Internal.CMD.MoveAbsolute:=	0;

END_IF


IF( NOT(pAxis.IN.CMD.MoveAdditive) ) THEN

	pAxis.Internal.CMD.MoveAdditive:=	0;

END_IF


IF( NOT(pAxis.IN.CMD.MoveVelocity) ) THEN

	pAxis.Internal.CMD.MoveVelocity:=	0;

END_IF


IF( NOT(pAxis.IN.CMD.TrackSetPosition) ) THEN

	pAxis.Internal.CMD.TrackSetPosition:=	0;

END_IF


IF( NOT(pAxis.IN.CMD.JogForward) ) THEN

	pAxis.Internal.CMD.JogForward:=	0;

END_IF


IF( NOT(pAxis.IN.CMD.JogReverse) ) THEN

	pAxis.Internal.CMD.JogReverse:=	0;

END_IF


(************************************************************************************)
(* Main State Machine																*)
(************************************************************************************)


(* Set State based on DriveStatus *)

SMR_SetState( pAxis.OUT.STAT );


CASE pAxis.OUT.STAT.State OF

	
	SMR_ST_NOTRDYTOSWON:
		

		(* Set Busy, Done *)
					
		pAxis.OUT.STAT.Busy:=	1;
		pAxis.OUT.STAT.Done:=	0;
	
	
	SMR_ST_SWONDISABLED:
	

		(* Set Busy, Done *)
					
		pAxis.OUT.STAT.Busy:=	0;
		pAxis.OUT.STAT.Done:=	0;
	
	
	SMR_ST_RDYTOSWON:
	
	
		(* Set Busy, Done *)
					
		pAxis.OUT.STAT.Busy:=	0;
		pAxis.OUT.STAT.Done:=	0;
	
		
		(* Reset internal errors if AcknowledgeError CMD *)
		
		IF( pAxis.IN.CMD.AcknowledgeError ) THEN
						
			pAxis.Internal.Error:=			0;
			pAxis.OUT.STAT.ErrorID:=		0;
			pAxis.OUT.STAT.ErrorState:=		0;
			
		END_IF
	
	
		(* If powered, set SwOn bit and Busy *)
		
		IF( pAxis.IN.CMD.Power ) THEN
  			
			pAxis.OUT.STAT.Busy:=	1;
		
			pAxis.IOMap.OUT.MpGenControl:=	BIT_SET(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_SWON);
   
		END_IF			
	
	
	SMR_ST_SWON:
	
	
		(* Set Busy, Done *)
					
		pAxis.OUT.STAT.Busy:=	1;
		pAxis.OUT.STAT.Done:=	0;
	
	
		(* If powered, set EnableOp bit and reset EnableState to default *)
		
		IF( pAxis.IN.CMD.Power ) THEN
  			
			pAxis.IOMap.OUT.MpGenControl:=	BIT_SET(pAxis.IOMap.OUT.MpGenControl, SMR_CTRLBIT_ENABLEOPERATION);
			
			pAxis.Internal.EnableState:=	SMR_STEN_WAIT;
			
			
			(* Grab ActPos and send it to SetPos to prevent position jumps *)
			(* Also set mode to position *)
			
			pAxis.Internal.AbsPos:=			pAxis.Internal.AbsPosActVal;
			pAxis.Internal.CurrTargetPos:=	pAxis.Internal.AbsPosActVal;
			pAxis.IOMap.OUT.MpGenMode:=		SMR_MODE_POSITION;
			
   
		END_IF
	
	
	SMR_ST_ENABLED:
	
		
		(* Update motion parameters if necessary *)
		
		SMR_UpdatePars( pAxis );
		
		
		(********************************************************)
		(* Enabled State Machine								*)
		(********************************************************)

		CASE pAxis.Internal.EnableState OF
  	
			
			SMR_STEN_WAIT:
			
				
				(* If all of the internal commands are false, 
					then a new command can be handled *)
				
				IF( 	NOT(pAxis.Internal.CMD.Home)
					AND	NOT(pAxis.Internal.CMD.MoveAbsolute)
					AND	NOT(pAxis.Internal.CMD.MoveAdditive)
					AND	NOT(pAxis.Internal.CMD.MoveVelocity)
					)THEN
									
					pAxis.OUT.STAT.ReadyForCMD:=	1;
					
				END_IF


				(* For all commands, check to see if the command has already been 
					handled.  
					
					If it is a "new" command, then the IN.CMD value will
					be TRUE, and the Internal.CMD value will be false.
					
					If this combination occurs, then you need to handle the command
					and set the Internal.CMD value to TRUE.  
					
					Then, when the IN.CMD value	is reset, the Internal.CMD value 
					is reset as well.
					
					This allows you to discriminate between "old" and "new" commands. *)
					
				
				(****************************)
				(* Home 					*)
				(****************************)
				
				IF( pAxis.IN.CMD.Home AND NOT(pAxis.Internal.CMD.Home) ) THEN
				
					SMR_StartHome( pAxis );
					
				END_IF				


				(****************************)
				(* MoveAbsolute				*)
				(****************************)
				
				IF( pAxis.IN.CMD.MoveAbsolute AND NOT(pAxis.Internal.CMD.MoveAbsolute) ) THEN
				
					SMR_StartMoveAbsolute( pAxis );
												
				END_IF				


				(****************************)
				(* MoveAdditive				*)
				(****************************)
				
				IF( pAxis.IN.CMD.MoveAdditive AND NOT(pAxis.Internal.CMD.MoveAdditive) ) THEN
				
					SMR_StartMoveAdditive( pAxis );
				
				END_IF
				
				
				(****************************)
				(* MoveVelocity				*)
				(****************************)
				
				IF( pAxis.IN.CMD.MoveVelocity AND NOT(pAxis.Internal.CMD.MoveVelocity) ) THEN
				
					SMR_StartMoveVelocity( pAxis );
					
				END_IF
				
				
				(****************************)
				(* TrackSetPosition			*)
				(****************************)
				
				IF( pAxis.IN.CMD.TrackSetPosition AND NOT(pAxis.Internal.CMD.TrackSetPosition) ) THEN
				
					SMR_StartTrackSetPosition( pAxis );
					
				END_IF				


				(****************************)
				(* Jog						*)
				(****************************)
				
				IF( pAxis.IN.CMD.JogForward AND NOT(pAxis.Internal.CMD.JogForward) ) THEN
				
					SMR_StartJogForward( pAxis );
					
				END_IF				


				IF( pAxis.IN.CMD.JogReverse AND NOT(pAxis.Internal.CMD.JogReverse) ) THEN
				
					SMR_StartJogReverse( pAxis );
					
				END_IF				


				(****************************)
				(* Stop 					*)
				(****************************)
				
				IF( pAxis.IN.CMD.Stop ) THEN
				
					
					(* Set the target state as SETSTOP *)
					
					pAxis.Internal.SetState:=		SMR_STEN_SETSTOP;
				
					
					(* Set Busy, Done *)
					
					pAxis.OUT.STAT.Busy:=	1;
					pAxis.OUT.STAT.Done:=	0;
					
					
					(* Go to SetState *)
					
					pAxis.Internal.EnableState:=	pAxis.Internal.SetState;

				
				END_IF
			
			
			(************************************************************************************)
			(* Wait for PAR update																*)
			(************************************************************************************)
			
			SMR_STEN_PARWRITE:
			
				
				(* If ParsOK, move on *)
				
				IF( pAxis.Internal.ParsOK )THEN
	
					
					(* Set Busy, Done *)

					pAxis.OUT.STAT.Busy:=	1;
					pAxis.OUT.STAT.Done:=	0;

					pAxis.Internal.EnableState:=	pAxis.Internal.SetState;
					
				END_IF
			
			
			(************************************************************************************)
			(* Homing States																	*)
			(************************************************************************************)
			
				
			SMR_STEN_HOME:
			
			
				SMR_Home( pAxis );
			
			
			(************************************************************************************)
			(* Set Mode and AbsPos States														*)
			(************************************************************************************)
			
			SMR_STEN_JOGFWD:
			
				
				(* Set Mode to Velocity mode and set position to CurrTargetVel *)
				
				pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
				pAxis.Internal.AbsPos:=		pAxis.Internal.CurrTargetVel;
				
				
				(* Check for Stop CMD or no Jog CMD *)
								
				IF( pAxis.IN.CMD.Stop ) THEN
				
					
					(* Set the target state as SETSTOP *)
					
					pAxis.Internal.SetState:=	SMR_STEN_SETSTOP;
				
					
					(* Set Busy, Done *)
					
					pAxis.OUT.STAT.Busy:=	1;
					pAxis.OUT.STAT.Done:=	0;
					
					
					(* Go to SetState *)
					
					pAxis.Internal.EnableState:=	pAxis.Internal.SetState;

				
				ELSIF( NOT(pAxis.IN.CMD.JogForward) )THEN
					
					
					(* Set target speed to 0 *)
					
					pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
					pAxis.Internal.AbsPos:=		0;
					
					
					(* Return to STEN_WAIT *)
					
					pAxis.Internal.EnableState:=	SMR_STEN_WAIT;
					
					
				END_IF
			
			
			SMR_STEN_JOGREV:
			
				
				(* Set Mode to Velocity mode and set position to CurrTargetVel *)
				
				pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
				pAxis.Internal.AbsPos:=		pAxis.Internal.CurrTargetVel;
				
				
				(* Check for Stop CMD and no Jog CMD *)
								
				IF( pAxis.IN.CMD.Stop ) THEN
				
					
					(* Set the target state as SETSTOP *)
					
					pAxis.Internal.SetState:=		SMR_STEN_SETSTOP;
				
					
					(* Set Busy, Done *)
					
					pAxis.OUT.STAT.Busy:=	1;
					pAxis.OUT.STAT.Done:=	0;
					
					
					(* Go to SetState *)
					
					pAxis.Internal.EnableState:=	pAxis.Internal.SetState;

				
				ELSIF( NOT(pAxis.IN.CMD.JogReverse) )THEN
					
					
					(* Set target speed to 0 *)
					
					pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
					pAxis.Internal.AbsPos:=		0;
					
					
					(* Return to STEN_WAIT *)
					
					pAxis.Internal.EnableState:=	SMR_STEN_WAIT;
					
					
				END_IF
			
			
			SMR_STEN_TRACKSETPOS:
			
				
				(* Call the SMR_StartTrackSetPosition fn to set the target position, direction, 
					and check for motion PAR updates *)
					
				SMR_StartTrackSetPosition( pAxis );
				
				
				(* Set Mode to Position mode and set position to CurrTargetPos *)
				
				pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_POSITION;
				pAxis.Internal.AbsPos:=		pAxis.Internal.CurrTargetPos;
				
				
				(* Return to wait state if CMD is cleared or Stop CMD *)
				
				IF( NOT(pAxis.IN.CMD.TrackSetPosition)
					OR pAxis.IN.CMD.Stop
					)THEN
				
					pAxis.Internal.EnableState:=	SMR_STEN_WAIT;
					
				END_IF
				
			
			SMR_STEN_SETPOS:
			
				
				(* Set Mode to Position mode and set position to CurrTargetPos *)
				
				pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_POSITION;
				pAxis.Internal.AbsPos:=		pAxis.Internal.CurrTargetPos;
				
				
				(* Return to wait state *)
				
				pAxis.Internal.EnableState:=	SMR_STEN_WAIT;
			
			
			SMR_STEN_SETVEL:
			
				
				(* Set Mode to Velocity mode and set position to CurrTargetVel *)
				
				pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
				pAxis.Internal.AbsPos:=		pAxis.Internal.CurrTargetVel;
				
				
				(* Return to wait state *)
								
				pAxis.Internal.EnableState:=	SMR_STEN_WAIT;
			
			
			SMR_STEN_SETSTOP:
			
				
				(* Set Mode to Velocity mode and set position to 0 *)
				
				pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
				pAxis.Internal.AbsPos:=		0;
				
				
				(* If stop command goes away, then go back to wait state *)
				
				IF( NOT(pAxis.IN.CMD.Stop) ) THEN
				
					pAxis.Internal.EnableState:=	SMR_STEN_WAIT;
				
				END_IF				
				
			
			(************************************************************************************)
			(* Error State																		*)
			(************************************************************************************)
			
			SMR_STEN_ERROR:
			
				
				(* Set Mode to Velocity mode and set position to 0 to stop motor *)
				
				pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
				pAxis.Internal.AbsPos:=		0;
				
				
				IF( pAxis.IN.CMD.AcknowledgeError )THEN
					
					pAxis.Internal.Error:=			0;
					pAxis.OUT.STAT.ErrorID:=		0;
					pAxis.OUT.STAT.ErrorState:=		0;
					
					pAxis.Internal.EnableState:=	SMR_STEN_WAIT;
				
				END_IF				
			
		
		
		END_CASE
		
		
		(* Set Busy, Done *)
		
		SMR_SetBusyDone( pAxis );
		
	
	SMR_ST_QUICKSTOPACTIVE:
	
		
		(* Set Busy, Done *)
					
		pAxis.OUT.STAT.Busy:=	1;
		pAxis.OUT.STAT.Done:=	0;
	
	
	SMR_ST_FAULTRXNACTIVE:
	
	
		(* Set Busy, Done *)
					
		pAxis.OUT.STAT.Busy:=	0;
		pAxis.OUT.STAT.Done:=	0;
	
	
	SMR_ST_FAULT:
	
	
		(* Set Busy, Done *)
					
		pAxis.OUT.STAT.Busy:=	0;
		pAxis.OUT.STAT.Done:=	0;
	
	
END_CASE


(************************************************************************************)
(* Check Limit Switches																*)
(************************************************************************************)

SMR_CheckLimitSw( pAxis );


(************************************************************************************)
(* Set AbsPos based on InvertDirection												*)
(************************************************************************************)

IF( pAxis.IN.CFG.InvertDirection ) THEN

	pAxis.IOMap.OUT.AbsPos:=	-1 * pAxis.Internal.AbsPos;
	
ELSE
	
	pAxis.IOMap.OUT.AbsPos:=	pAxis.Internal.AbsPos;
	
END_IF


(********************************************************************)
(* Handle speed estimation											*)
(********************************************************************)


(* RTInfo to get cycle time *)

pAxis.Internal.RTInfo.enable:=	1;

pAxis.Internal.RTInfo();


(* SpdEst to estimate speed *)
(* Use internal AbsPosActVal to properly account for InvertDirection *)

pAxis.Internal.SpdEst.Position:=	pAxis.Internal.AbsPosActVal;
pAxis.Internal.SpdEst.T:=			UDINT_TO_REAL(pAxis.Internal.RTInfo.cycle_time) / 1000000.0;


(* Default tf to 0.1 if none is entered *)

IF( pAxis.IN.CFG.SpeedEstimator.tf = 0 )THEN

	pAxis.Internal.SpdEst.tf:=			0.1;
	
ELSE
	
	pAxis.Internal.SpdEst.tf:=			pAxis.IN.CFG.SpeedEstimator.tf;

END_IF

pAxis.Internal.SpdEst.deadband:=	pAxis.IN.CFG.SpeedEstimator.deadband;
pAxis.Internal.SpdEst.K:=			pAxis.IN.CFG.SpeedEstimator.K;

pAxis.Internal.SpdEst();


(* Set ActualVelocity *)

pAxis.OUT.STAT.ActualVelocity:=	pAxis.Internal.SpdEst.Speed_est;


(****************************)
(* Set Error Status			*)
(****************************)

pAxis.OUT.STAT.Error:=	pAxis.OUT.STAT.DriveStatus.Fault OR pAxis.Internal.Error;

SMR_SetErrorString( pAxis.OUT.STAT.ErrorID, pAxis.OUT.STAT.ErrorString );


(********************************************************************)
(* Call AccWrite FUBs 												*)
(********************************************************************)

pAxis.Internal.UpdateVel.AccWrite();
pAxis.Internal.UpdateAcc.AccWrite();
pAxis.Internal.UpdateDec.AccWrite();


(* Reset AcknowledgeError CMDs *)

pAxis.IN.CMD.AcknowledgeError:=		0;
pAxis.TEST.CMD.AcknowledgeError:=	0;


(********************************************************************)
(* Map TEST.STAT items												*)
(********************************************************************)

pAxis.TEST.STAT.Busy:=				pAxis.OUT.STAT.Busy;
pAxis.TEST.STAT.Done:=				pAxis.OUT.STAT.Done;
pAxis.TEST.STAT.Error:=				pAxis.OUT.STAT.Error;
pAxis.TEST.STAT.ErrorID:=			pAxis.OUT.STAT.ErrorID;
pAxis.TEST.STAT.ErrorString:=		pAxis.OUT.STAT.ErrorString;
pAxis.TEST.STAT.ActualPosition:=	pAxis.OUT.STAT.ActualPosition;
pAxis.TEST.STAT.ActualVelocity:=	pAxis.OUT.STAT.ActualVelocity;
pAxis.TEST.STAT.State:=				pAxis.OUT.STAT.State;
pAxis.TEST.STAT.DriveFault:=		pAxis.OUT.STAT.DriveStatus.Fault;
pAxis.TEST.STAT.VoltageEnabled:=	pAxis.OUT.STAT.DriveStatus.VoltageEnabled;
pAxis.TEST.STAT.HomingOk:=			pAxis.OUT.STAT.DriveStatus.HomingOk;


END_FUNCTION
