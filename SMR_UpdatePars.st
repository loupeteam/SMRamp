(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: SMRamp
 * File: SMR_UpdatePars.st
 * Author: David
 * Created: March 29, 2011
 ********************************************************************
 * Implementation of library SMRamp
 ********************************************************************) 


(********************************************************************)
(* Update motion parameters if they change	 						*)
(********************************************************************)


(* Disable Acyclic Write			DONE and TESTED DFB 20110404 *)
	(* Disable FUBs					DONE and TESTED DFB 20110404 *)
	(* Set ParsOK					DONE and TESTED DFB 20110404 *)
	(* Return						DONE and TESTED DFB 20110404 *)
	
	
(* Checking invalid pars			DONE and TESTED DFB 20110404 *)
	(* Accel						DONE and TESTED DFB 20110404 *)
	(* Decel						DONE and TESTED DFB 20110404 *)
	(* StopDecel					DONE and TESTED DFB 20110404 *)
	
		
(* Update Velocity					DONE and TESTED DFB 20110404 *)
	
	(* Check for changes			DONE and TESTED DFB 20110404 *)
		(* DisAccWrite transition	DONE and TESTED DFB 20110404 *)
		(* Busy						DONE and TESTED DFB 20110404 *)
		(* Error					DONE and TESTED DFB 20110404 *)
		(* Not Busy or Error		DONE and TESTED DFB 20110404 *)
	
	(* AccWrite						DONE and TESTED DFB 20110404 *)
		(* FUB done					DONE and TESTED DFB 20110404 *)
		(* No Error					DONE and TESTED DFB 20110404 *)
		(* Error					DONE and TESTED DFB 20110404 *)


(* Update Acceleration				DONE and TESTED DFB 20110404 *)
	
	(* Check for changes			DONE and TESTED DFB 20110404 *)
		(* DisAccWrite transition	DONE and TESTED DFB 20110404 *)
		(* Busy						DONE and TESTED DFB 20110404 *)
		(* Error					DONE and TESTED DFB 20110404 *)
		(* Not Busy or Error		DONE and TESTED DFB 20110404 *)
	
	(* AccWrite						DONE and TESTED DFB 20110404 *)
		(* FUB done					DONE and TESTED DFB 20110404 *)
		(* No Error					DONE and TESTED DFB 20110404 *)
		(* Error					DONE and TESTED DFB 20110404 *)


(* Update Deceleration				DONE and TESTED DFB 20110404 *)
	
	(* Check for changes			DONE and TESTED DFB 20110404 *)
		(* DisAccWrite transition	DONE and TESTED DFB 20110404 *)
		(* Stopping					DONE and TESTED DFB 20110404 *)
			(* Busy					DONE and TESTED DFB 20110404 *)
			(* Error				DONE and TESTED DFB 20110404 *)
			(* Not Busy or Error	DONE and TESTED DFB 20110404 *)
		(* Not stopping				DONE and TESTED DFB 20110404 *)
			(* Busy					DONE and TESTED DFB 20110404 *)
			(* Error				DONE and TESTED DFB 20110404 *)
			(* Not Busy or Error	DONE and TESTED DFB 20110404 *)
	
	(* AccWrite						DONE and TESTED DFB 20110404 *)
		(* Proper decel value		DONE and TESTED DFB 20110404 *)
			(* Stopping				DONE and TESTED DFB 20110404 *)
			(* Not stopping			DONE and TESTED DFB 20110404 *)
		(* FUB done					DONE and TESTED DFB 20110404 *)
		(* No Error					DONE and TESTED DFB 20110404 *)
		(* Error					DONE and TESTED DFB 20110404 *)
		
		
(* Setting ParsOK					DONE and TESTED DFB 20110404 *)


FUNCTION SMR_UpdatePars


(********************************************************************)
(* Set return value to get rid of compiler warning					*)
(********************************************************************)

SMR_UpdatePars:=	FALSE;


(********************************************************************)
(* Check DisableAcyclicWrite										*)
(********************************************************************)

IF( pAxis.IN.CFG.DisableAcyclicWrite )THEN
	
	
	(* Disable FUBs *)
	
	pAxis.Internal.UpdateVel.AccWrite.enable:=	0;
	pAxis.Internal.UpdateAcc.AccWrite.enable:=	0;
	pAxis.Internal.UpdateDec.AccWrite.enable:=	0;
	
	
	(* Set ParsOK *)
	
	pAxis.Internal.ParsOK:=	1;
	
	
	(* Return *)
	
	RETURN;

END_IF


(********************************************************************)
(* Check Accel and Decel PARs										*)
(********************************************************************)

IF( pAxis.IN.PAR.Acceleration = 0 ) THEN
		

	(* Disable FUBs *)
	
	pAxis.Internal.UpdateVel.AccWrite.enable:=	0;
	pAxis.Internal.UpdateAcc.AccWrite.enable:=	0;
	pAxis.Internal.UpdateDec.AccWrite.enable:=	0;
	
	
	(* Grab error info *)
		
	pAxis.Internal.Error:=			1;
	pAxis.OUT.STAT.ErrorID:=		SMR_ERR_INVALIDPAR_ACC;
	pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
	
	pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
	
	
	(* Reset ParsOK *)
	
	pAxis.Internal.ParsOK:=	0;
	
	
	(* Return *)
	
	RETURN;

		
END_IF


IF( pAxis.IN.PAR.Deceleration = 0 ) THEN
		

	(* Disable FUBs *)
	
	pAxis.Internal.UpdateVel.AccWrite.enable:=	0;
	pAxis.Internal.UpdateAcc.AccWrite.enable:=	0;
	pAxis.Internal.UpdateDec.AccWrite.enable:=	0;
	
	
	(* Grab error info *)
		
	pAxis.Internal.Error:=			1;
	pAxis.OUT.STAT.ErrorID:=		SMR_ERR_INVALIDPAR_DEC;
	pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
	
	pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
	
	
	(* Reset ParsOK *)
	
	pAxis.Internal.ParsOK:=	0;
	
	
	(* Return *)
	
	RETURN;

		
END_IF


IF( pAxis.IN.PAR.StopDeceleration = 0 ) THEN
		

	(* Disable FUBs *)
	
	pAxis.Internal.UpdateVel.AccWrite.enable:=	0;
	pAxis.Internal.UpdateAcc.AccWrite.enable:=	0;
	pAxis.Internal.UpdateDec.AccWrite.enable:=	0;
	
	
	(* Grab error info *)
		
	pAxis.Internal.Error:=			1;
	pAxis.OUT.STAT.ErrorID:=		SMR_ERR_INVALIDPAR_STOPDEC;
	pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
	
	pAxis.Internal.EnableState:=	SMR_STEN_ERROR;
	
	
	(* Reset ParsOK *)
	
	pAxis.Internal.ParsOK:=	0;
	
	
	(* Return *)
	
	RETURN;

		
END_IF


(********************************************************************)
(* Velocity															*)
(********************************************************************)

IF( (pAxis.IN.PAR.Velocity <> pAxis.Internal.UpdateVel.CurrValue)
	AND NOT(pAxis.OUT.STAT.Busy)
	AND NOT(pAxis.OUT.STAT.Error)
	)THEN
	
	pAxis.Internal.UpdateVel.Update:=	1;

END_IF


IF( pAxis.Internal.UpdateVel.Update )THEN	

	
	(* Handle Acyclic write *)
	
	pAxis.Internal.UpdateVel.AccWrite.enable:=		1;
	pAxis.Internal.UpdateVel.AccWrite.pDeviceName:=	ADR(pAxis.IN.CFG.ModuleINADeviceName);
	
	
	(* Set channel name based on motor index *)
	
	CASE pAxis.IN.CFG.MotorIndex OF

		1:		pAxis.Internal.UpdateVel.AccWrite.pChannelName:=	ADR('MaxSpeed01pos');
		2:		pAxis.Internal.UpdateVel.AccWrite.pChannelName:=	ADR('MaxSpeed02pos');
		3:		pAxis.Internal.UpdateVel.AccWrite.pChannelName:=	ADR('MaxSpeed03pos');
		4:		pAxis.Internal.UpdateVel.AccWrite.pChannelName:=	ADR('MaxSpeed04pos');
		ELSE	pAxis.Internal.UpdateVel.AccWrite.pChannelName:=	ADR('badname');

	END_CASE				
	 
	pAxis.Internal.UpdateVel.AccWrite.value:=	pAxis.IN.PAR.Velocity;
	
	
	(* Check Status *)
	 
	IF( pAxis.Internal.UpdateVel.AccWrite.status < SMR_STAT_DISABLED ) THEN
		
		
		(* FUB finished, disable *)
			
		pAxis.Internal.UpdateVel.AccWrite.enable:=	0;
		
		
		(* Reset CMD *)
		
		pAxis.Internal.UpdateVel.Update:=	0;
			
		
		(* Check for error *)
		
		IF( pAxis.Internal.UpdateVel.AccWrite.status = 0 ) THEN
				
			
			(* Set CurrValue to input *)
			
			pAxis.Internal.UpdateVel.CurrValue:=	UDINT_TO_UINT(pAxis.Internal.UpdateVel.AccWrite.value);
			
		
		ELSE
			
			
			(* Grab error info and go to error state *)
			
			pAxis.Internal.Error:=			1;
			pAxis.OUT.STAT.Error:=			1;
			pAxis.OUT.STAT.ErrorID:=		pAxis.Internal.UpdateVel.AccWrite.status;
			pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
			
			pAxis.Internal.EnableState:=	SMR_STEN_ERROR;

			
		END_IF (* Status check *)

	END_IF (* FUB finished *)

END_IF (* Update *)


(********************************************************************)
(* Acceleration														*)
(********************************************************************)

IF( (pAxis.IN.PAR.Acceleration <> pAxis.Internal.UpdateAcc.CurrValue)
	AND NOT(pAxis.OUT.STAT.Busy)
	AND NOT(pAxis.OUT.STAT.Error)
	)THEN
	
	pAxis.Internal.UpdateAcc.Update:=	1;

END_IF


IF( pAxis.Internal.UpdateAcc.Update )THEN	

	
	(* Handle Acyclic write *)
	
	pAxis.Internal.UpdateAcc.AccWrite.enable:=		1;
	pAxis.Internal.UpdateAcc.AccWrite.pDeviceName:=	ADR(pAxis.IN.CFG.ModuleINADeviceName);
	
	
	(* Set channel name based on motor index *)
	
	CASE pAxis.IN.CFG.MotorIndex OF

		1:		pAxis.Internal.UpdateAcc.AccWrite.pChannelName:=	ADR('MaxAcc01');
		2:		pAxis.Internal.UpdateAcc.AccWrite.pChannelName:=	ADR('MaxAcc02');
		3:		pAxis.Internal.UpdateAcc.AccWrite.pChannelName:=	ADR('MaxAcc03');
		4:		pAxis.Internal.UpdateAcc.AccWrite.pChannelName:=	ADR('MaxAcc04');
		ELSE	pAxis.Internal.UpdateAcc.AccWrite.pChannelName:=	ADR('badname');

	END_CASE				
	 
	pAxis.Internal.UpdateAcc.AccWrite.value:=	pAxis.IN.PAR.Acceleration;
	
	
	(* Check Status *)
	 
	IF( pAxis.Internal.UpdateAcc.AccWrite.status < SMR_STAT_DISABLED ) THEN
		
		
		(* FUB finished, disable *)
			
		pAxis.Internal.UpdateAcc.AccWrite.enable:=	0;
		
		
		(* Reset CMD *)
		
		pAxis.Internal.UpdateAcc.Update:=	0;
			
		
		(* Check for error *)
		
		IF( pAxis.Internal.UpdateAcc.AccWrite.status = 0 ) THEN
				
			
			(* Set CurrValue to input *)
			
			pAxis.Internal.UpdateAcc.CurrValue:=	UDINT_TO_UINT(pAxis.Internal.UpdateAcc.AccWrite.value);
			
		
		ELSE
			
			
			(* Grab error info and go to error state *)
			
			pAxis.Internal.Error:=			1;
			pAxis.OUT.STAT.Error:=			1;
			pAxis.OUT.STAT.ErrorID:=		pAxis.Internal.UpdateAcc.AccWrite.status;
			pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
			
			pAxis.Internal.EnableState:=	SMR_STEN_ERROR;

			
		END_IF (* Status check *)

	END_IF (* FUB finished *)

END_IF (* Update CMD *)


(********************************************************************)
(* Deceleration														*)
(********************************************************************)

(* Parameter checking is different for Stop condition and normal operation *)

IF( pAxis.IN.CMD.Stop )THEN


	IF( (pAxis.IN.PAR.StopDeceleration <> pAxis.Internal.UpdateDec.CurrValue)
		AND NOT(pAxis.OUT.STAT.Error)
		)THEN
	
		pAxis.Internal.UpdateDec.Update:=	1;
	
	END_IF
		 

ELSE

	
	IF( (pAxis.IN.PAR.Deceleration <> pAxis.Internal.UpdateDec.CurrValue)
		AND NOT(pAxis.OUT.STAT.Busy)
		AND NOT(pAxis.OUT.STAT.Error)
		)THEN
	
		pAxis.Internal.UpdateDec.Update:=	1;
	
	END_IF

		 
END_IF


IF( pAxis.Internal.UpdateDec.Update )THEN	

	
	(* Handle Acyclic write *)
	
	pAxis.Internal.UpdateDec.AccWrite.enable:=		1;
	pAxis.Internal.UpdateDec.AccWrite.pDeviceName:=	ADR(pAxis.IN.CFG.ModuleINADeviceName);
	
	
	(* Set channel name based on motor index *)
	
	CASE pAxis.IN.CFG.MotorIndex OF

		1:		pAxis.Internal.UpdateDec.AccWrite.pChannelName:=	ADR('MaxDec01');
		2:		pAxis.Internal.UpdateDec.AccWrite.pChannelName:=	ADR('MaxDec02');
		3:		pAxis.Internal.UpdateDec.AccWrite.pChannelName:=	ADR('MaxDec03');
		4:		pAxis.Internal.UpdateDec.AccWrite.pChannelName:=	ADR('MaxDec04');
		ELSE	pAxis.Internal.UpdateDec.AccWrite.pChannelName:=	ADR('badname');

	END_CASE				
	 
	IF( pAxis.IN.CMD.Stop )THEN

		pAxis.Internal.UpdateDec.AccWrite.value:=	pAxis.IN.PAR.StopDeceleration;
	
	ELSE
		
		pAxis.Internal.UpdateDec.AccWrite.value:=	pAxis.IN.PAR.Deceleration;
	
	END_IF
	
	
	(* Check Status *)
	 
	IF( pAxis.Internal.UpdateDec.AccWrite.status < SMR_STAT_DISABLED ) THEN
		
		
		(* FUB finished, disable *)
			
		pAxis.Internal.UpdateDec.AccWrite.enable:=	0;
		
		
		(* Reset CMD *)
		
		pAxis.Internal.UpdateDec.Update:=	0;
			
		
		(* Check for error *)
		
		IF( pAxis.Internal.UpdateDec.AccWrite.status = 0 ) THEN
				
			
			(* Set CurrValue to input *)
			
			pAxis.Internal.UpdateDec.CurrValue:=	UDINT_TO_UINT(pAxis.Internal.UpdateDec.AccWrite.value);
			
		
		ELSE
			
			
			(* Grab error info and go to error state *)
			
			pAxis.Internal.Error:=			1;
			pAxis.OUT.STAT.Error:=			1;
			pAxis.OUT.STAT.ErrorID:=		pAxis.Internal.UpdateDec.AccWrite.status;
			pAxis.OUT.STAT.ErrorState:=		pAxis.Internal.EnableState;
			
			pAxis.Internal.EnableState:=	SMR_STEN_ERROR;

			
		END_IF (* Status check *)

	END_IF (* FUB finished *)

END_IF (* Update CMD *)


(********************************************************************)
(* Set ParsOK appropriately											*)
(********************************************************************)

(* ParsOK is not checked on a stop condition, so, it does not need to depend on the Stop CMD 
	or the StopDeceleration *)
	
IF( 	(pAxis.Internal.UpdateVel.CurrValue = pAxis.IN.PAR.Velocity)
	AND (pAxis.Internal.UpdateAcc.CurrValue = pAxis.IN.PAR.Acceleration)
	AND (pAxis.Internal.UpdateDec.CurrValue = pAxis.IN.PAR.Deceleration)
	)THEN
 
	pAxis.Internal.ParsOK:=	1;
	
ELSE
		
	pAxis.Internal.ParsOK:=	0;
	
END_IF


END_FUNCTION
