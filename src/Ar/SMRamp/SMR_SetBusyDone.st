(*
* File: SMR_SetBusyDone.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of SMRamp, licensed under the MIT License.
*
*)


(********************************************************************)
(* Function to set Busy and Done in the ST_ENABLED state 			*)
(********************************************************************)


(* WAIT						DONE and TESTED DFB 20110405 *)
	(* No CMD				DONE and TESTED DFB 20110405 *)
	(* Home					DONE and TESTED DFB 20110405 *)
	(* MoveAbsolute			DONE and TESTED DFB 20110405 *)
	(* MoveAdditive			DONE and TESTED DFB 20110405 *)
	(* MoveVelocity			DONE and TESTED DFB 20110405 *)
	(* TrackSetPosition		DONE and TESTED DFB 20110405 *)
	(* Stop					DONE and TESTED DFB 20110405 *)
	(* Other mode			DONE and TESTED DFB 20110405 *)

(* PARWRITE					DONE and TESTED DFB 20110404 *)
(* HOME						DONE and TESTED DFB 20110404 *)
(* JOGFWD					DONE and TESTED DFB 20110419 *)
(* JOGREV					DONE and TESTED DFB 20110419 *)
(* TRACKSETPOS				DONE and TESTED DFB 20110405 *)
(* SETPOS					DONE and TESTED DFB 20110405 *)
(* SETVEL					DONE and TESTED DFB 20110405 *)
(* SETSTOP					DONE and TESTED DFB 20110405 *)
(* ERROR					DONE and TESTED DFB 20110405 *)


FUNCTION SMR_SetBusyDone


(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_SetBusyDone:=	FALSE;


(********************************************************************)
(* Reset TargetReachedTimer. It is set below where needed			*)
(********************************************************************)

pAxis.Internal.TargetReachedTimer.IN:=	0;


(********************************************************************)
(* Set Busy and Done based on EnableState 							*)
(********************************************************************)

CASE pAxis.Internal.EnableState OF
	
	
	SMR_STEN_WAIT:
	
		
		(* If waiting, Busy and Done are complex *)
		
		
		(* If no commands are present, reset Busy and Done *)

		IF( 	NOT(pAxis.IN.CMD.Home)
			AND	NOT(pAxis.IN.CMD.MoveAbsolute)
			AND	NOT(pAxis.IN.CMD.MoveAdditive)
			AND	NOT(pAxis.IN.CMD.MoveVelocity)
			AND	NOT(pAxis.IN.CMD.TrackSetPosition)
			AND	NOT(pAxis.IN.CMD.Stop)
			)THEN
			
					
			pAxis.OUT.STAT.Busy:=	0;
			pAxis.OUT.STAT.Done:=	0;
		
		
		ELSE
				
				
			(* Otherwise, set Busy and Done based on MpGenMode *)
				
			CASE pAxis.IOMap.OUT.MpGenMode OF
		 	
			
				SMR_MODE_POSITION:
				
					(* Position mode is active for 
						MoveAbsolute, MoveAdditive, Home (done homing) *)
					
					(* Set Busy and Done based on actual and set positions *)
					
					IF( pAxis.Internal.AbsPosActVal = pAxis.Internal.CurrTargetPos )THEN
		   
		   				pAxis.OUT.STAT.Busy:=	0;
						pAxis.OUT.STAT.Done:=	1;
						
					ELSE
						
						pAxis.OUT.STAT.Busy:=	1;
						pAxis.OUT.STAT.Done:=	0;
										
					END_IF
					
					
				SMR_MODE_VELOCITY:
				
					(* Velocity mode is active for
						MoveVelocity, if a limit switch is active *)
						
					(* Set Busy and Done based on a TargetReached timer *)
					
					pAxis.Internal.TargetReachedTimer.IN:=	pAxis.OUT.STAT.DriveStatus.TargetReached;
					
					pAxis.OUT.STAT.Busy:=	NOT(pAxis.Internal.TargetReachedTimer.Q);
					pAxis.OUT.STAT.Done:=	pAxis.Internal.TargetReachedTimer.Q;
					
					
				ELSE
			
					(* These modes are active outside of this library *)
						
					(* Reset Busy and Done *)
					
					pAxis.OUT.STAT.Busy:=	0;
					pAxis.OUT.STAT.Done:=	0;
			
			
			END_CASE
		
		END_IF


	SMR_STEN_PARWRITE:
	
		
		(* Reset Busy to allow Par updates *)
		
		pAxis.OUT.STAT.Busy:=	0;
		pAxis.OUT.STAT.Done:=	0;


	SMR_STEN_HOME:
	
	
		(* If homing, Busy *)
		
		pAxis.OUT.STAT.Busy:=	1;
		pAxis.OUT.STAT.Done:=	0;


	SMR_STEN_JOGFWD..SMR_STEN_JOGREV:
	
		
		(* Set Busy and Done based on a TargetReached timer *)
		
		pAxis.Internal.TargetReachedTimer.IN:=	pAxis.OUT.STAT.DriveStatus.TargetReached;
					
		pAxis.OUT.STAT.Busy:=	NOT(pAxis.Internal.TargetReachedTimer.Q);
		pAxis.OUT.STAT.Done:=	pAxis.Internal.TargetReachedTimer.Q;
		
	
	SMR_STEN_TRACKSETPOS:
	
		
		(* If tracking set position, set Busy and Done based on actual and set positions *)
		
		IF( pAxis.Internal.AbsPosActVal = pAxis.Internal.CurrTargetPos )THEN

			pAxis.OUT.STAT.Busy:=	0;
			pAxis.OUT.STAT.Done:=	1;
		
		ELSE
		
			pAxis.OUT.STAT.Busy:=	1;
			pAxis.OUT.STAT.Done:=	0;
						
		END_IF


	SMR_STEN_SETPOS..SMR_STEN_SETVEL:


		(* If setting control variables, Busy *)
		
		pAxis.OUT.STAT.Busy:=	1;
		pAxis.OUT.STAT.Done:=	0;


	SMR_STEN_SETSTOP:
	
		
		(* If stopped, set Busy and Done based on a TargetReached timer *)
					
		pAxis.Internal.TargetReachedTimer.IN:=	pAxis.OUT.STAT.DriveStatus.TargetReached;
					
		pAxis.OUT.STAT.Busy:=	NOT(pAxis.Internal.TargetReachedTimer.Q);
		pAxis.OUT.STAT.Done:=	pAxis.Internal.TargetReachedTimer.Q;
					
					
	SMR_STEN_ERROR:


		(* If Error, reset Busy and Done *)
		
		pAxis.OUT.STAT.Busy:=	0;
		pAxis.OUT.STAT.Done:=	0;


END_CASE


(********************************************************************)
(* Handle TargetReachedTimer 										*)
(********************************************************************)

pAxis.Internal.TargetReachedTimer.PT:=	T#100ms;
					
pAxis.Internal.TargetReachedTimer();
					


END_FUNCTION
