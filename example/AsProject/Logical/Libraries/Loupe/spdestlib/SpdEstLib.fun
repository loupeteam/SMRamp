(********************************************************************
 * COPYRIGHT -- Automation Resources Group
 ********************************************************************
 * Library: SpdEstLib
 * File: SpdEstLib.fun
 * Author: blackburnd
 * Created: May 19, 2010
 ********************************************************************
 * Functions and function blocks of library SpdEstLib
 ********************************************************************)

FUNCTION_BLOCK SpeedEst (*Estimate speed based on sampled position data.*)
	VAR_INPUT
		Position : DINT; (*Current position (Counts)*)
		T : REAL; (*Sampling period (s)*)
		tf : REAL; (*"Slow" differentiator filter time (s)*)
		deadband : DINT; (*"Fast" differentiator deadband (Counts)*)
		K : REAL; (*"Fast" differentiator gain (1/s)*)
	END_VAR
	VAR_OUTPUT
		Speed_est : REAL; (*Estimated speed (cts/s)*)
	END_VAR
	VAR
		Speed_est_old : REAL; (*Estimated speed delayed by one cycle (cts/s)*)
		Position_old : DINT; (*Position delayed by one cycle (Counts)*)
		Delta : DINT; (*Position difference between two cycles, corrected for INT or DINT rollover (Counts)*)
		omega_fast : REAL; (*"Fast" estimated speed (cts/s)*)
		omega_slow : REAL; (*"Slow" estimated speed (cts/s)*)
		omega_slow_old : REAL; (*"Slow" estimated speed delayed by one cycle (cts/s)*)
		Position_est : DINT; (*Total estimated position (Counts)*)
		Position_err : DINT; (*Difference between actual and estimated position (Counts)*)
		Position_est_ff : REAL; (*Feedforward component of estimated position (Counts)*)
		Position_est_int : DINT; (*Integrated component of estimated position (Counts)*)
		Position_est_int_old : DINT; (*Integrated component of estimated position delayed by one cycle (Counts)*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK SpeedEst_INT (*Estimate speed based on sampled position data.*)
	VAR_INPUT
		Position : INT; (*Current position (Counts)*)
		T : REAL; (*Sampling period (s)*)
		tf : REAL; (*"Slow" differentiator filter time (s)*)
		deadband : INT; (*"Fast" differentiator deadband (Counts)*)
		K : REAL; (*"Fast" differentiator gain (1/s)*)
	END_VAR
	VAR_OUTPUT
		Speed_est : REAL; (*Estimated speed (cts/s)*)
	END_VAR
	VAR
		Speed_est_old : REAL; (*Estimated speed delayed by one cycle (cts/s)*)
		Position_old : INT; (*Position delayed by one cycle (Counts)*)
		Delta : INT; (*Position difference between two cycles, corrected for INT or DINT rollover (Counts)*)
		omega_fast : REAL; (*"Fast" estimated speed (cts/s)*)
		omega_slow : REAL; (*"Slow" estimated speed (cts/s)*)
		omega_slow_old : REAL; (*"Slow" estimated speed delayed by one cycle (cts/s)*)
		Position_est : INT; (*Total estimated position (Counts)*)
		Position_err : INT; (*Difference between actual and estimated position (Counts)*)
		Position_est_ff : REAL; (*Feedforward component of estimated position (Counts)*)
		Position_est_int : INT; (*Integrated component of estimated position (Counts)*)
		Position_est_int_old : INT; (*Integrated component of estimated position delayed by one cycle (Counts)*)
	END_VAR
END_FUNCTION_BLOCK
