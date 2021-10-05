(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Library: SMRamp
 * File: HomeFindEdge.st
 * Author: blackburnd
 * Created: September 14, 2009
 ********************************************************************
 * Implementation of library SMRamp
 ********************************************************************) 


(*Function to find edges for homing.*)


(* Rising edges			DONE and TESTED DFB 20090914 *)
(* Falling edges		DONE and TESTED DFB 20090914 *)

(* Positive edges		DONE and TESTED DFB 20090914 *)
(* Negative edges		DONE and TESTED DFB 20090914 *)

(* PosLimitSw edges		DONE and TESTED DFB 20090916 *)
(* NegLimitSw edges		DONE and TESTED DFB 20090916 *)


FUNCTION SMR_HomeFindEdge


(****************************************************************************************)
(* Set return value to get rid of compiler warning										*)
(****************************************************************************************)

SMR_HomeFindEdge:=	FALSE;


(****************************************************************************************)
(* Map pointer to internal homing variables 											*)
(****************************************************************************************)

t ACCESS ADR(pAxis.Internal.Homing);


(****************************************************************************************)
(* HomeSw																				*)
(****************************************************************************************)


(* Find rising and falling edges (only depends on level of switch) *)

t.RisingEdge:=	pAxis.Internal.DIGIN.HomeSw AND NOT(t.HomeSwOld);

t.FallingEdge:=	t.HomeSwOld AND NOT(pAxis.Internal.DIGIN.HomeSw);


(* Find Positive and Negative edges ( depends on direction of travel) *)

IF( t.RisingEdge ) THEN


	IF( t.CurrDirection = SMR_DIR_POS ) THEN
		
		t.PosEdge:=	1;
		t.NegEdge:=	0;
		 
 	ELSIF( t.CurrDirection = SMR_DIR_NEG ) THEN
		
		t.PosEdge:=	0;
		t.NegEdge:=	1;
 
 	ELSE
		
		t.PosEdge:=	0;
		t.NegEdge:=	0;
	 	
	END_IF


ELSIF( t.FallingEdge ) THEN


	IF( t.CurrDirection = SMR_DIR_POS ) THEN
		
		t.PosEdge:=	0;
		t.NegEdge:=	1;
		 
 	ELSIF( t.CurrDirection = SMR_DIR_NEG ) THEN
		
		t.PosEdge:=	1;
		t.NegEdge:=	0;
 
 	ELSE
		
		t.PosEdge:=	0;
		t.NegEdge:=	0;
	 	
	END_IF
	
	
ELSE
	
	t.PosEdge:=	0;
	t.NegEdge:=	0;

END_IF


(* Save value of HomeSw *)

t.HomeSwOld:=	pAxis.Internal.DIGIN.HomeSw;


(****************************************************************************************)
(* PosLimitSw																			*)
(****************************************************************************************)


(* Check for edge on PosLimitSw *)

t.PosLimitSwRisingEdge:=	pAxis.Internal.DIGIN.PosLimitSw AND NOT(t.PosLimitSwOld);

t.PosLimitSwFallingEdge:=	t.PosLimitSwOld AND NOT(pAxis.Internal.DIGIN.PosLimitSw);


(* Save value of PosLimitSw *)

t.PosLimitSwOld:=	pAxis.Internal.DIGIN.PosLimitSw;


(****************************************************************************************)
(* NegLimitSw																			*)
(****************************************************************************************)

(* Check for edge on NegLimitSw *)

t.NegLimitSwRisingEdge:=	pAxis.Internal.DIGIN.NegLimitSw AND NOT(t.NegLimitSwOld);

t.NegLimitSwFallingEdge:=	t.NegLimitSwOld AND NOT(pAxis.Internal.DIGIN.NegLimitSw);


(* Save value of PosLimitSw *)

t.NegLimitSwOld:=	pAxis.Internal.DIGIN.NegLimitSw;


END_FUNCTION
