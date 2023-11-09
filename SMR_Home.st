(*
* File: SMR_Home.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of SMRamp, licensed under the MIT License.
*
*)

(*Function to perform homing functionality.*)


(* Stop during home										DONE and TESTED DFB 20110404 *)
	(* Setting SetState									DONE and TESTED DFB 20110404 *)
	(* Changing State									DONE and TESTED DFB 20110404 *)


(* Checking parameters									see CheckHomePAR.st *)
	(* Finding bad parameters							see CheckHomePAR.st *)
	(* Reacting to bad parameters						DONE and TESTED DFB 20090918 *)

(* Finding events										see HomeFindEdge.st *)

(* Starting Homing - change state based on mode			DONE and TESTED DFB 20090918 *)


(* Homing Modes											DONE and TESTED DFB 20090921 *)

	
	(* Direct											DONE and TESTED DFB 20090918 *)

	
	(* Switch gate mode									DONE and TESTED DFB 20090918 *)
		
		(* StartDir = Positive							DONE and TESTED DFB 20090918 *)
				
			(* EdgeSw = Positive						DONE and TESTED DFB 20090918 *)
				(* TriggDir = Positive					DONE and TESTED DFB 20090918 *)
				(* TriggDir = Negative					DONE and TESTED DFB 20090918 *)
		
			(* EdgeSw = Negative						DONE and TESTED DFB 20090918 *)
				(* TriggDir = Positive					DONE and TESTED DFB 20090918 *)
				(* TriggDir = Negative					DONE and TESTED DFB 20090918 *)
		
		(* StartDir = Negative							DONE and TESTED DFB 20090918 *)
			
			(* EdgeSw = Positive						DONE and TESTED DFB 20090918 *)
				(* TriggDir = Positive					DONE and TESTED DFB 20090918 *)
				(* TriggDir = Negative					DONE and TESTED DFB 20090918 *)
			
			(* EdgeSw = Negative						DONE and TESTED DFB 20090918 *)
				(* TriggDir = Positive					DONE and TESTED DFB 20090918 *)
				(* TriggDir = Negative					DONE and TESTED DFB 20090918 *)
					
		
	(* Abs Switch mode									DONE and TESTED DFB 20090918 *)
	
		(* EdgeSw = Positive							DONE and TESTED DFB 20090918 *)
			(* TriggDir = Positive						DONE and TESTED DFB 20090918 *)
			(* TriggDir = Negative						DONE and TESTED DFB 20090918 *)
			
		(* EdgeSw = Negative							DONE and TESTED DFB 20090918 *)
			(* TriggDir = Positive						DONE and TESTED DFB 20090918 *)
			(* TriggDir = Negative						DONE and TESTED DFB 20090918 *)


	(* End switch										DONE and TESTED DFB 20090921 *)
	
		(* EdgeSw = Positive							DONE and TESTED DFB 20090921 *)
			(* TriggDir = Positive						DONE and TESTED DFB 20090921 *)
			(* TriggDir = Negative						DONE and TESTED DFB 20090921 *)
			
		(* EdgeSw = Negative							DONE and TESTED DFB 20090921 *)
			(* TriggDir = Positive						DONE and TESTED DFB 20090921 *)
			(* TriggDir = Negative						DONE and TESTED DFB 20090921 *)


(* Finishing homing										DONE and TESTED DFB 20090918 *)

	(* Setting ActPos to HomeOffset						DONE and TESTED DFB 20090918 *)
		(* Mode and AbsPos setting						DONE and TESTED DFB 20110906 *)

	(* Timing on TargetReached							DONE and TESTED DFB 20090918 *)
		(* 5ms TC										DONE and TESTED DFB 20090918 *)
		(* 25ms TC										DONE and TESTED DFB 20090918 *)
		(* 50ms TC										DONE and TESTED DFB 20090918 *)
		
	(* Being at HomeOffset after homing					DONE and TESTED DFB 20090918 *)
		(* Mode and AbsPos setting						DONE and TESTED DFB 20110906 *)
		
	(* Setting HomingComplete 							DONE and TESTED DFB 20090918 *)


FUNCTION SMR_Home


(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_Home:=	FALSE;


(* Map pointer to internal homing variables *)

t ACCESS ADR(pAxis.Internal.Homing);


(********************************************************************)
(* Reset TargetReachedTimer.  It will be set below when appropriate	*)
(********************************************************************)

t.TargetReachedTimer.IN:=	0;

				
(********************************************************************)
(* Stop command can interrupt a home move 							*)
(********************************************************************)
				
IF( pAxis.IN.CMD.Stop ) THEN

	
	(* Set the target state as SETSTOP *)
					
	pAxis.Internal.SetState:=		SMR_STEN_SETSTOP;

	
	(* Set Busy, Done *)
	
	pAxis.OUT.STAT.Busy:=	1;
	pAxis.OUT.STAT.Done:=	0;
	
	
	(* Go to SetState *)
	
	pAxis.Internal.EnableState:=	pAxis.Internal.SetState;

	RETURN;
	
END_IF


(********************************************************************)
(* Check Homing Parameters											*)
(********************************************************************)

IF( SMR_CheckHomePAR( pAxis ) = FALSE ) THEN

	
	(* Error - set internal error and go to error state *)
			
	pAxis.Internal.Error:=			1;
	pAxis.OUT.STAT.ErrorID:=		SMR_ERR_HOME_INVALIDPAR;
	pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
	
	pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
	
	RETURN;


END_IF


(********************************************************************)
(* Find edges 														*)
(********************************************************************)

SMR_HomeFindEdge( pAxis );


(********************************************************************)
(* Main State Machine												*)
(********************************************************************)

CASE t.State OF
	
	
	(********************************************************************)
	(* Starting Homing													*)
	(********************************************************************)
	
	SMR_STHOME_CHECKMODE:
	
		
		(* Stop motor when homing is initiated *)
		
		pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
		pAxis.Internal.AbsPos:=		0;
		
		
		(* Change state based on homing mode *)
		
		IF( pAxis.IN.PAR.HomingMode = SMR_HOMEMODE_DIRECT ) THEN
  			
			
			(* If direct home, set homeoffset directly after motor is stopped *)
			
			t.State:=	SMR_STHOME_STOPPING;
							
  		ELSIF( pAxis.IN.PAR.HomingMode = SMR_HOMEMODE_SWITCH_GATE ) THEN
			
			t.State:=	SMR_STHOME_SG_START;	

  		ELSIF( pAxis.IN.PAR.HomingMode = SMR_HOMEMODE_ABS_SWITCH ) THEN

			t.State:=	SMR_STHOME_ABS_START;
			
  		ELSIF( pAxis.IN.PAR.HomingMode = SMR_HOMEMODE_END_SWITCH ) THEN
	
			t.State:=	SMR_STHOME_END_START;
		
		END_IF
		
	
	(********************************************************************)
	(* Switch Gate mode													*)
	(********************************************************************)
	
	SMR_STHOME_SG_START:
	
		
		IF( pAxis.IN.PAR.HomingStartDir = SMR_POS ) THEN
		
			IF( pAxis.Internal.DIGIN.PosLimitSw ) THEN
  
   				t.CurrDirection:=	SMR_DIR_NEG;

			ELSE

				t.CurrDirection:=	SMR_DIR_POS;

			END_IF
		
		ELSIF( pAxis.IN.PAR.HomingStartDir = SMR_NEG ) THEN
			
			IF( pAxis.Internal.DIGIN.NegLimitSw ) THEN
  
   				t.CurrDirection:=	SMR_DIR_POS;

			ELSE

				t.CurrDirection:=	SMR_DIR_NEG;

			END_IF

		END_IF		

		
		(* Change state *)
		
		t.State:=	SMR_STHOME_SG_MOVE;
		
		
		(* Set mode and velocity *)
		
		pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
		pAxis.Internal.AbsPos:=		UINT_TO_DINT(pAxis.IN.PAR.HomingVelocity) * t.CurrDirection;


	SMR_STHOME_SG_MOVE:
		
		
		(* Check all possible events and react accordingly *)
		
		
		(****************************************************)
		(* NegLimitSw *)
		
		IF( pAxis.Internal.DIGIN.NegLimitSw ) THEN
  		
			
			(************************************************)
			(* NegLimitSw, NegDir *)
			
			IF( t.CurrDirection = SMR_DIR_NEG ) THEN
   
   
   				IF( pAxis.IN.PAR.HomingStartDir = SMR_POS ) THEN
				
				
					(* Stop, error *)
				
					t.CurrDirection:=	SMR_DIR_STOP;
				
					pAxis.Internal.Error:=			1;
					pAxis.OUT.STAT.ErrorID:=		SMR_ERR_HOME_ERR;
					pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
			
					pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
				
			      
	   			ELSIF( pAxis.IN.PAR.HomingStartDir = SMR_NEG ) THEN
   				
				
					(* Turn around to look for switch *)
				
					t.CurrDirection:=	SMR_DIR_POS;
						
				END_IF (* HomeStartDir *)
   
   
   			END_IF (* CurrDirection *)			
			   
			   
		(****************************************************)
		(* PosLimitSw *)

		ELSIF( pAxis.Internal.DIGIN.PosLimitSw ) THEN
			
			
			(************************************************)
			(* PosLimitSw, PosDir *)
			
			IF( t.CurrDirection = SMR_DIR_POS ) THEN
			  		
				
				IF( pAxis.IN.PAR.HomingStartDir = SMR_POS ) THEN
				
				
					(* Turn around to look for switch *)
				
					t.CurrDirection:=	SMR_DIR_NEG;
				
			      
	   			ELSIF( pAxis.IN.PAR.HomingStartDir = SMR_NEG ) THEN
   				
				
					(* Stop, error *)
				
					t.CurrDirection:=	SMR_DIR_STOP;
				
					pAxis.Internal.Error:=			1;
					pAxis.OUT.STAT.ErrorID:=		SMR_ERR_HOME_ERR;
					pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
			
					pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
				
						
				END_IF (* HomeStartDir *)
				   
			
			END_IF (* CurrDirection *)
		
		
		(****************************************************)
		(* PosEdge *)

		ELSIF( t.PosEdge ) THEN
  
  
  			(************************************************)
			(* PosEdge, PosDir *)
			
			IF( t.CurrDirection = SMR_DIR_POS ) THEN
   				
				
				IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
					
					
					IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
	 					
						
						(* Stop, done *)
						
						t.CurrDirection:=	SMR_DIR_STOP;
						
						t.State:=			SMR_STHOME_STOPPING;
						
						
	 				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
	 					
						
						(* Go negative *)
						
						t.CurrDirection:=	SMR_DIR_NEG;
						
						
	 				END_IF (* HomeTriggDir *)									
					
					
				ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN
					
					
					(* Find negative edge *)
					
					t.CurrDirection:=	SMR_DIR_POS;
					
				END_IF (* HomeEdgeSw *)							
				
				
   			(************************************************)
			(* PosEdge, NegDir *)
			
			ELSIF( t.CurrDirection = SMR_DIR_NEG ) THEN
   				
				
				IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
					
					
					IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
	 					
						
						(* Go positive *)
						
						t.CurrDirection:=	SMR_DIR_POS;
						
						
	 				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
	 					
						
						(* Stop, done *)
						
						t.CurrDirection:=	SMR_DIR_STOP;
						
						t.State:=			SMR_STHOME_STOPPING;
						
						
	 				END_IF (* HomeTriggDir *)										
					
					
				ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN
					
					
					(* Find negative edge *)
					
					t.CurrDirection:=	SMR_DIR_POS;
					
				END_IF (* HomeEdgeSw *)
				
				
   			END_IF (* CurrDirection *)
  
  
		(****************************************************)
		(* NegEdge *)

  		ELSIF( t.NegEdge ) THEN
  
  
  			(************************************************)
			(* NegEdge, PosDir *)
			
			IF( t.CurrDirection = SMR_DIR_POS ) THEN
   				
				
				IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
					
					
					(* Find positive edge *)
					
					t.CurrDirection:=	SMR_DIR_NEG;
					
					
				ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN
					
					
					IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
	 					
						
						(* Stop, done *)
						
						t.CurrDirection:=	SMR_DIR_STOP;
						
						t.State:=			SMR_STHOME_STOPPING;
						
						
	 				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
	 					
						
						(* Go negative *)
						
						t.CurrDirection:=	SMR_DIR_NEG;
						
						
	 				END_IF (* HomeTriggDir *)
					
					
				END_IF (* HomeEdgeSw *)		
				
				
   			(************************************************)
			(* NegEdge, NegDir *)
			
			ELSIF( t.CurrDirection = SMR_DIR_NEG ) THEN
   				
				
				IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
					
					
					(* Find positive edge *)
					
					t.CurrDirection:=	SMR_DIR_NEG;
					
					
				ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN
					
					
					IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
	 					
						
						(* Go positive *)
						
						t.CurrDirection:=	SMR_DIR_POS;
						
						
	 				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
	 					
						
						(* Stop, done *)
						
						t.CurrDirection:=	SMR_DIR_STOP;
						
						t.State:=			SMR_STHOME_STOPPING;
						
						
	 				END_IF (* HomeTriggDir *)									
					
					
				END_IF (* HomeEdgeSw *)
				
				
   			END_IF (* CurrDirection *)
  
  
  		END_IF (* Events *)	
		
		
		(* Set mode and velocity *)
		
		pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
		pAxis.Internal.AbsPos:=		UINT_TO_DINT(pAxis.IN.PAR.HomingVelocity) * t.CurrDirection;
		

	(********************************************************************)
	(* Absolute Switch mode												*)
	(********************************************************************)

	SMR_STHOME_ABS_START:
	
		
		(* Start based on EdgeSw and current level of switch *)
		
		IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
  
  			
			IF( pAxis.Internal.DIGIN.HomeSw ) THEN
   
   				t.CurrDirection:=	SMR_DIR_NEG;
   
   			ELSE
			  	
				t.CurrDirection:=	SMR_DIR_POS;
				
			END_IF (* HomeSw *)
			   
  		
		ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN
  
  		
			IF( pAxis.Internal.DIGIN.HomeSw ) THEN
   
   				t.CurrDirection:=	SMR_DIR_POS;
   
   			ELSE
			  	
				t.CurrDirection:=	SMR_DIR_NEG;
				
			END_IF (* HomeSw *)
			   
  		
		END_IF (* HomeEdgeSw *)
				  
				  
		(* Change state *)
		
		t.State:=	SMR_STHOME_ABS_MOVE;
		
		
		(* Set mode and velocity *)
		
		pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
		pAxis.Internal.AbsPos:=		UINT_TO_DINT(pAxis.IN.PAR.HomingVelocity) * t.CurrDirection;


	SMR_STHOME_ABS_MOVE:
	
	
		(* Check all possible events and react accordingly *)
		
		
		(****************************************************)
		(* NegLimitSw, Negative Dir *)
		
		IF( (pAxis.Internal.DIGIN.NegLimitSw)	AND
  			(t.CurrDirection = SMR_DIR_NEG)		) THEN
  			
				
			(* Stop, error *)
			
			t.CurrDirection:=	SMR_DIR_STOP;
			
			pAxis.Internal.Error:=			1;
			pAxis.OUT.STAT.ErrorID:=		SMR_ERR_HOME_ERR;
			pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
		
			pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
	
			   
		(****************************************************)
		(* PosLimitSw, Positive Dir *)

		ELSIF(	(pAxis.Internal.DIGIN.PosLimitSw)	AND
	  			(t.CurrDirection = SMR_DIR_POS)		) THEN

		
			(* Stop, error *)
				
			t.CurrDirection:=	SMR_DIR_STOP;
			
			pAxis.Internal.Error:=			1;
			pAxis.OUT.STAT.ErrorID:=		SMR_ERR_HOME_ERR;
			pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
		
			pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
			
		
		(****************************************************)
		(* PosEdge *)

		ELSIF( t.PosEdge ) THEN
  
  
  			(************************************************)
			(* PosEdge, PosDir *)
			
			IF( t.CurrDirection = SMR_DIR_POS ) THEN
   				
				
				IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
					
					
					IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
	 					
						
						(* Stop, done *)
						
						t.CurrDirection:=	SMR_DIR_STOP;
						
						t.State:=			SMR_STHOME_STOPPING;
						
						
	 				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
	 					
						
						(* Go negative *)
						
						t.CurrDirection:=	SMR_DIR_NEG;
						
						
	 				END_IF (* HomeTriggDir *)									
					
					
				ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN
					
					
					(* Stop, error *)
				
					t.CurrDirection:=	SMR_DIR_STOP;
			
					pAxis.Internal.Error:=			1;
					pAxis.OUT.STAT.ErrorID:=		SMR_ERR_HOME_ERR;
					pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
		
					pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
				
					
				END_IF (* HomeEdgeSw *)							
				
				
   			(************************************************)
			(* PosEdge, NegDir *)
			
			ELSIF( t.CurrDirection = SMR_DIR_NEG ) THEN
   				
				
				IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
					
					
					IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
	 					
						
						(* Go positive *)
						
						t.CurrDirection:=	SMR_DIR_POS;
						
						
	 				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
	 					
						
						(* Stop, done *)
						
						t.CurrDirection:=	SMR_DIR_STOP;
						
						t.State:=			SMR_STHOME_STOPPING;
						
						
	 				END_IF (* HomeTriggDir *)										
					
					
				ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN
					
					
					(* Stop, error *)
				
					t.CurrDirection:=	SMR_DIR_STOP;
			
					pAxis.Internal.Error:=			1;
					pAxis.OUT.STAT.ErrorID:=		SMR_ERR_HOME_ERR;
					pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
		
					pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
					
					
				END_IF (* HomeEdgeSw *)
				
				
   			END_IF (* CurrDirection *)
  
  
		(****************************************************)
		(* NegEdge *)

  		ELSIF( t.NegEdge ) THEN
  
  
  			(************************************************)
			(* NegEdge, PosDir *)
			
			IF( t.CurrDirection = SMR_DIR_POS ) THEN
   				
				
				IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
					
					
					(* Stop, error *)
				
					t.CurrDirection:=	SMR_DIR_STOP;
			
					pAxis.Internal.Error:=			1;
					pAxis.OUT.STAT.ErrorID:=		SMR_ERR_HOME_ERR;
					pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
		
					pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
					
					
				ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN
					
					
					IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
	 					
						
						(* Stop, done *)
						
						t.CurrDirection:=	SMR_DIR_STOP;
						
						t.State:=			SMR_STHOME_STOPPING;
						
						
	 				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
	 					
						
						(* Go negative *)
						
						t.CurrDirection:=	SMR_DIR_NEG;
						
						
	 				END_IF (* HomeTriggDir *)
					
					
				END_IF (* HomeEdgeSw *)		
				
				
   			(************************************************)
			(* NegEdge, NegDir *)
			
			ELSIF( t.CurrDirection = SMR_DIR_NEG ) THEN
   				
				
				IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
					
					
					(* Stop, error *)
				
					t.CurrDirection:=	SMR_DIR_STOP;
			
					pAxis.Internal.Error:=			1;
					pAxis.OUT.STAT.ErrorID:=		SMR_ERR_HOME_ERR;
					pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
		
					pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
					
					
				ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN
					
					
					IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
	 					
						
						(* Go positive *)
						
						t.CurrDirection:=	SMR_DIR_POS;
						
						
	 				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
	 					
						
						(* Stop, done *)
						
						t.CurrDirection:=	SMR_DIR_STOP;
						
						t.State:=			SMR_STHOME_STOPPING;
						
						
	 				END_IF (* HomeTriggDir *)									
					
					
				END_IF (* HomeEdgeSw *)
				
				
   			END_IF (* CurrDirection *)
  
  
  		END_IF (* Events *)		
		
		
		(* Set mode and velocity *)
		
		pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
		pAxis.Internal.AbsPos:=		UINT_TO_DINT(pAxis.IN.PAR.HomingVelocity) * t.CurrDirection;


	(********************************************************************)
	(* End (Limit) Switch mode											*)
	(********************************************************************)

	SMR_STHOME_END_START:
	
		
		(* Start based on EdgeSw and current level of switches *)
		
		IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
  
  			
			IF( pAxis.Internal.DIGIN.PosLimitSw ) THEN
   
   				t.CurrDirection:=	SMR_DIR_NEG;
   
   			ELSE
			  	
				t.CurrDirection:=	SMR_DIR_POS;
				
			END_IF (* PosLimitSw *)
			   
  		
		ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN
  
  		
			IF( pAxis.Internal.DIGIN.NegLimitSw ) THEN
   
   				t.CurrDirection:=	SMR_DIR_POS;
   
   			ELSE
			  	
				t.CurrDirection:=	SMR_DIR_NEG;
				
			END_IF (* NegLimitSw *)
			   
  		
		END_IF (* HomeEdgeSw *)
		
		
		(* Change state *)
		
		t.State:=	SMR_STHOME_END_MOVE;
		
		
		(* Set mode and velocity *)
		
		pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
		pAxis.Internal.AbsPos:=		UINT_TO_DINT(pAxis.IN.PAR.HomingVelocity) * t.CurrDirection;


	SMR_STHOME_END_MOVE:
	
		
		(* Check events and react accordingly *)
		
		IF( t.PosLimitSwRisingEdge ) THEN
		
		
			IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
  			
			
				IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
   					
					
					(* Stop, done *)
						
					t.CurrDirection:=	SMR_DIR_STOP;
						
					t.State:=			SMR_STHOME_STOPPING;
						
				
				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
   
   					
					(* go neg until you see a falling edge *)
					
					t.CurrDirection:=	SMR_DIR_NEG;
					
					
	   			END_IF (* HomeTriggDir *)
			
  
	  		ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN

				
				(* Stop, error *)
			
				t.CurrDirection:=	SMR_DIR_STOP;
		
				pAxis.Internal.Error:=			1;
				pAxis.OUT.STAT.ErrorID:=		SMR_ERR_HOME_ERR;
				pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
	
				pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
					
  		
			END_IF (* HomeEdgeSw *)
			
		
		ELSIF( t.PosLimitSwFallingEdge ) THEN


			IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
  			
			
				IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
   					
					
					(* go pos until you see a rising edge *)
					
					t.CurrDirection:=	SMR_DIR_POS;
						
				
				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
   

					(* Stop, done *)
						
					t.CurrDirection:=	SMR_DIR_STOP;
						
					t.State:=			SMR_STHOME_STOPPING;
					
					
	   			END_IF (* HomeTriggDir *)
			
  
	  		ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN

				
				(* Continue in negative direction *)
				
				t.CurrDirection:=	SMR_DIR_NEG;
					
  		
			END_IF (* HomeEdgeSw *)
			  
		
		ELSIF( t.NegLimitSwRisingEdge ) THEN
		

			IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
  			
			
				(* Stop, error *)
			
				t.CurrDirection:=	SMR_DIR_STOP;
		
				pAxis.Internal.Error:=			1;
				pAxis.OUT.STAT.ErrorID:=		SMR_ERR_HOME_ERR;
				pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
	
				pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
			
  
	  		ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN

				
				IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
   					
					
					(* go pos until you see a falling edge *)
					
					t.CurrDirection:=	SMR_DIR_POS;
						
				
				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
   
	
					(* Stop, done *)
						
					t.CurrDirection:=	SMR_DIR_STOP;
						
					t.State:=			SMR_STHOME_STOPPING;
					
					
	   			END_IF (* HomeTriggDir *)
					
  		
			END_IF (* HomeEdgeSw *)
			  
		
		ELSIF( t.NegLimitSwFallingEdge ) THEN
		
		
			IF( pAxis.IN.PAR.HomingEdgeSw = SMR_POS ) THEN
  			
			
				(* Continue in positive direction *)
				
				t.CurrDirection:=	SMR_DIR_POS;
			
  
	  		ELSIF( pAxis.IN.PAR.HomingEdgeSw = SMR_NEG ) THEN

				
				IF( pAxis.IN.PAR.HomingTriggDir = SMR_POS ) THEN
   					
				
					(* Stop, done *)
						
					t.CurrDirection:=	SMR_DIR_STOP;
						
					t.State:=			SMR_STHOME_STOPPING;
						
				
				ELSIF( pAxis.IN.PAR.HomingTriggDir = SMR_NEG ) THEN
   
	
					(* go neg until you see a rising edge *)
					
					t.CurrDirection:=	SMR_DIR_NEG;
					
					
	   			END_IF (* HomeTriggDir *)
					
  		
			END_IF (* HomeEdgeSw *)

		
		END_IF (* Events *)	
		
		
		(* Set mode and velocity *)
		
		pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_VELOCITY;
		pAxis.Internal.AbsPos:=		UINT_TO_DINT(pAxis.IN.PAR.HomingVelocity) * t.CurrDirection;


	(********************************************************************)
	(* Finishing Homing													*)
	(********************************************************************)
			
	SMR_STHOME_STOPPING:
		
		
		(* If TargetReached, start the timer *)
		
		t.TargetReachedTimer.IN:=	pAxis.OUT.STAT.DriveStatus.TargetReached;
		
		
		(* If the timer expires, then TargetReached is real, not just a blip *)
		
		IF( t.TargetReachedTimer.Q ) THEN
			
			
			(* Reset timer for next state to use *)
			
			t.TargetReachedTimer.IN:=	0;

			
			(* If TargetReached, set current position to HomingPosition *)

			pAxis.IOMap.OUT.MpGenMode:=	SMR_MODE_SETACTPOS;
			pAxis.Internal.AbsPos:=		pAxis.IN.PAR.HomingPosition;
			
			t.State:=	SMR_STHOME_DONE;
			
			
		END_IF	
				

	SMR_STHOME_DONE:
		
		
		(* If TargetReached, start the timer *)
		
		t.TargetReachedTimer.IN:=	pAxis.OUT.STAT.DriveStatus.TargetReached;
		
		
		(* If the timer expires, then TargetReached is real, not just a blip *)
		
		IF( t.TargetReachedTimer.Q ) THEN
		
			
			(* Reset timer for next state to use *)
			
			t.TargetReachedTimer.IN:=	0;

			
			(* If TargetReached, change to position mode, move to HomingPosition, and return to wait state *)

			pAxis.OUT.STAT.DriveStatus.HomingOk:=	1;
			
			pAxis.IOMap.OUT.MpGenMode:=		SMR_MODE_POSITION;
			pAxis.Internal.AbsPos:=			pAxis.IN.PAR.HomingPosition;
			pAxis.Internal.CurrTargetPos:=	pAxis.IN.PAR.HomingPosition;
		
			
			(* Return to wait state *)
		
			pAxis.Internal.EnableState:=	SMR_STEN_WAIT;
			
			
		END_IF
		
				
END_CASE


(********************************************************************)
(* Call Timer FUB													*)
(********************************************************************)

t.TargetReachedTimer.PT:=	T#50ms;
t.TargetReachedTimer();


END_FUNCTION
