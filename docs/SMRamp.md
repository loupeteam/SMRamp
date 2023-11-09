![Automation Resources Group](http://automationresourcesgroup.com/images/arglogo254x54.png)

#SMRamp Library
The SMRamp library provides a clean interface for control of stepper motors using ramp mode.

Every motion axis has a set of basic functionality in common. This includes powering and homing the axis, performing basic moves, and reading back status information. The SMRamp library bundles the most common motion control commands and status information together into one clean interface. This leads to significantly faster development of motion applications with stepper motors. 

#Usage
The SMRamp functionality can be integrated into any project using a data structure and a function call. For an example of how to use this in a project, please see the ARG Automation Studio Starter Project at [https://github.com/autresgrp/StarterProject](https://github.com/autresgrp/StarterProject).

##Initialization
To use the SMRamp functionality, a variable must be declared of type **SMR_Axis_typ**. This variable should then be initialized in the INIT routine of your program. This initialization consists of setting configuration settings and initial motion parameters.

	SMRAxis.IN.CFG.DisableAcyclicWrite:=		0;
	SMRAxis.IN.CFG.ModuleINADeviceName:=		'IF6.ST1';
	SMRAxis.IN.CFG.MotorIndex:=					1;
	
	SMRAxis.IN.CFG.UnderCurrentDetection:=		0;
	SMRAxis.IN.CFG.ABRCtrSyncAsync:=			0;
	SMRAxis.IN.CFG.StallDetection:=				0;
	
	SMRAxis.IN.CFG.InvertDirection:=			0;
	
	SMRAxis.IN.CFG.SpeedEstimator.tf:=			0;
	SMRAxis.IN.CFG.SpeedEstimator.deadband:=	0;
	SMRAxis.IN.CFG.SpeedEstimator.K:=			0;
	
	SMRAxis.IN.PAR.HomingPosition:=		0;
	SMRAxis.IN.PAR.HomingMode:=			SMR_HOMEMODE_DIRECT;
	SMRAxis.IN.PAR.HomingVelocity:=		REAL_TO_UINT(1 * SMR_RPM2VEL);
	SMRAxis.IN.PAR.HomingStartDir:=		SMR_POS;
	SMRAxis.IN.PAR.HomingEdgeSw:=		SMR_POS;
	SMRAxis.IN.PAR.HomingTriggDir:=		SMR_POS;
	
	SMRAxis.IN.PAR.Position:=			0;
	SMRAxis.IN.PAR.Direction:=			SMR_DIR_POS;
	SMRAxis.IN.PAR.Velocity:=			REAL_TO_UINT(10 * SMR_RPM2VEL);
	SMRAxis.IN.PAR.Acceleration:=		REAL_TO_UINT(100 * SMR_RPMPS2ACC);
	SMRAxis.IN.PAR.Deceleration:=		REAL_TO_UINT(100 * SMR_RPMPS2ACC);
	
	SMRAxis.IN.PAR.JogVelocity:=		REAL_TO_UINT(1 * SMR_RPM2VEL);
	
	SMRAxis.IN.PAR.StopDeceleration:=	REAL_TO_UINT(100 * SMR_RPMPS2ACC);

The interface from the SMRAxis variable to the stepper motor hardware is done via IO mappings. All necessary IO points are contained in the SMRAxis.IOMap structure. The stepper motor IO points should be mapped to the stepper module for the appropriate motor. These IO points are named consistently with the IO mapping entry names for the modules.

In addition to the required stepper motor IO points, the IOMap structure contains digital inputs for home and limit switches and a quick stop input. These digital inputs are assumed to have the most common active levels. The home switch is considered active when TRUE (active high). The limit switch and quick stop inputs are considered active when FALSE (active low). These inputs can be inverted on the input module to change these active levels. If no hardware switches are present, then the limit switch and quick stop inputs should be set to TRUE to allow motion.

##Cyclic Operation
To control the axis cyclically, the **SMR_AxisFn_Cyclic()** function must be called in the CYCLIC routine of your program, once every scan, unconditionally. This function should not be called on the same SMRAxis variable more than once per scan.

	SMR_AxisFn_Cyclic( SMRAxis );

The SMRAxis can then be used as an interface for higher level motion sequencing programs.

	CASE State OF
	
		ST_IDLE:
	
			SMRAxis.IN.CMD.Power:=	0;
	
			IF( Start )THEN
	
	  			Start:=	0;
	
	  			IF( 		SMRAxis.OUT.STAT.DriveStatus.RdyToSwOn
	   				AND NOT	SMRAxis.OUT.STAT.DriveStatus.SwOn
					)THEN
					
					State:=	ST_POWERON;
	
				END_IF
	
			END_IF
			
		ST_POWERON:
		
			SMRAxis.IN.CMD.Power:=	1;
					
			IF( SMRAxis.OUT.STAT.DriveStatus.OpEnabled )THEN
	  
				State:=	ST_HOME;
				
			END_IF
			
		ST_HOME:
		
			SMRAxis.IN.CMD.Home:=	1;
			
			IF( 	SMRAxis.OUT.STAT.Done
	  			AND	SMRAxis.OUT.STAT.DriveStatus.HomingOk
	   			)THEN						
			
				SMRAxis.IN.CMD.Home:=	0;
			
				State:=	ST_JOG;
				
			END_IF
		
		ST_JOG:
		
			SMRAxis.IN.CMD.JogForward:=	1;
				
			IF( Stop )THEN
	  			
				Stop:=	0;

	  			SMRAxis.IN.CMD.JogForward:=	0;
			
				State:=	ST_IDLE;
				
			END_IF
					
	END_CASE

#Reference

##SMRAxis Data Structure
The main data structure of the SMRamp library is the SMRAxis structure (SMR_Axis_typ datatype). This provides the interface to higher level programs and also stores all necessary internal information. It is divided into inputs (SMRAxis.IN), outputs (SMRAxis.OUT), a test interface (SMRAxis.TEST), IO points (SMRAxis.IOMap) and internals (SMRAxis.Internal).

###Inputs
The SMRAxis inputs are divided into commands (IN.CMD), parameters (IN.PAR), and configuration settings (IN.CFG). Commands are used to initiate operations, and parameters and configuration settings determine how the commands will be processed. The difference between parameters and configuration settings is that configuration settings are generally set only once, while parameters might be set any time a command is issued.

####Commands
* **Power** - Power the axis. If set to 1, the axis will be powered. If set to 0, the axis will be depowered.
* **Home** - Home the axis using the **Homing** parameters.
* **MoveAbsolute** - Perform a move to an absolute position. Uses the **Position**, **Velocity**, **Acceleration**, and **Deceleration** parameters.
* **MoveAdditive** - Perform an additive move. The **Position** parameter is added to the current target position (NOT the current actual position). Uses the **Position**, **Velocity**, **Acceleration**, and **Deceleration** parameters.
* **MoveVelocity** - Perform a velocity move. The axis accelerates to the **Velocity** parameter and continues until another command is issued. If a new velocity is desired, the **MoveVelocity** command must be toggled. Uses the **Velocity**, **Acceleration**, **Deceleration**, and **Direction** parameters.
* **JogForward** - Jog the axis forward. The axis will stop when this command is reset. Uses the **JogVelocity**, **Acceleration**, and **Deceleration** parameters.
* **JogReverse** - Jog the axis backwards. The axis will stop when this command is reset. Uses the **JogVelocity**, **Acceleration**, and **Deceleration** parameters.
* **TrackSetPosition** - Track the input position. When set to 1, the axis will continually track the input position. Uses the **Position**, **Velocity**, **Acceleration**, and **Deceleration** parameters.
* **Stop** - Stop the axis. When set to 1, all other motion commands will be ignored and the axis will remain stopped. Uses the **StopDeceleration** parameter.
* **AcknowledgeError** - Acknowledge any errors on the axis.

####Parameters
* **HomingPosition** - Actual position after homing the axis. All position parameters are entered in the native units for ramp mode, microsteps. The SMR_REV2POS constant can be used to convert from revolutions to microsteps. This constant assumes that the motor has 200 full steps per revolution. [microsteps]
* **HomingMode** - Mode with which to home the axis. Possible values are SMR_HOMEMODE_DIRECT, SMR_HOMEMODE_SWITCH_GATE, SMR_HOMEMODE_ABS_SWITCH, and SMR_HOMEMODE_LIMIT_SWITCH. These homing modes replicate some of the homing modes possible via the acp10mc PLC Open motion control library. For details on these homing modes and the following homing parameters, please see the AS online help for the MC_Home function block in the acp10mc library.
* **HomingVelocity** - Velocity for homing moves. All velocity parameters are entered in the native units for ramp mode, microsteps/25ms. The SMR_RPM2VEL constant can be used to convert from RPM to microsteps/25ms. This constant assumes that the motor has 200 full steps per revolution. [microsteps/25ms]
* **HomingStartDir** - Direction in which to start searching for the home switch. Possible values are SMR_POS and SMR_NEG.
* **HomingEdgeSw** - Edge of the home switch to home to. Possible values are SMR_POS and SMR_NEG.
* **HomingTriggDir** - Side of the home switch edge to home to. Possible values are SMR_POS and SMR_NEG.
* **Position** - Position for absolute and additive moves and for tracking set position. [microsteps]
* **Direction** - Direction for velocity moves. Possible values are SMR_DIR_POS and SMR_DIR_NEG.
* **Velocity** - Velocity for absolute, additive, and velocity moves, and for tracking set positions. [microsteps/25ms]
* **Acceleration**, **Deceleration** - Acceleration and deceleration for absolute, additive, velocity, and jog moves, and for tracking set positions. All acceleration parameters are entered in the native units for ramp mode, microsteps/25ms/25ms. The SMR_RPMPS2ACC constant can be used to convert from RPM/s to microsteps/25ms/25ms. This constant assumes that the motor has 200 full steps per revolution.  [microsteps/25ms/25ms]
* **JogVelocity** - Velocity for jog moves. [microsteps/25ms]
* **StopDeceleration** - Deceleration for stopping. [microsteps/25ms/25ms]

####Configuration Settings

* **DisableAcyclicWrite** - Specifies whether or not the **Velocity**, **Acceleration**, and **Deceleration** parameters should be written to the stepper module acyclically. If **DisableAcyclicWrite** is set to 1, these parameters cannot be changed during runtime, and must be set in the module IO configuration. **If the stepper module is behind a bus controller, acyclic writes should be disabled.** For more information on access to acyclic registers on IO modules, please see the help for the AsIOAcc library and the register description for the module in question. For modules behind bus controllers, please see the documentation for the bus controller you are using.
* **ModuleINADeviceName** - INA device name of the stepper module. This is used to address the module during acyclic writes. The INA device name can be found by right clicking the stepper module in the Physical View and selecting Properties. The INA device name is listed as the Address in the resulting window. Alternatively, the IODBLib library can be used to look up the INA device name based on a connected IO point. For details on this, please see the documentation for the IODBLib library. If acyclic writes are disabled, then this parameter does not need to be set.
* **MotorIndex** - Index of the motor to control. Possible values are 1 and 2, depending on which channel should be controlled (for X67SM4320 modules, please contact ARG for support). If acyclic writes are disabled, then this parameter does not need to be set.
* **UnderCurrentDetection** - Enables under current detection when set to 1.
* **ABRCtrSyncAsync** - Specifies which motor position should be reported. If set to 0, then the internal step counter is reported as the current position in microsteps; if set to 1, then the attached ABR encoder position is reported as the current position in counts. Note that these units are hardly ever equivalent, so conversion will be required if the encoder position is reported.
* **StallDetection** - Enables motor stall detection when set to 1. Since stall detection requires configuration based on motor parameters, it is not recommended to enable this feature without appropriate cause and expertise.
* **InvertDirection** - Inverts the motor rotation direction when set to 1. **THIS SETTING SHOULD NOT BE CHANGED WHILE THE MOTOR IS POWERED, OR UNEXPECTED MOTION COULD RESULT!**
* **SpeedEstimator** - These settings configure the internal speed estimator used to report the current motor speed. If motor speed feedback is not desired, these parameters can be set to 0. Otherwise, they can be used to tune the response of the speed estimator. For details on these parameters, please see the documentation for the SpdEstLib library.

###Outputs
The SMRAxis outputs contain status information (OUT.STAT).

* **ReadyForCMD** - The SMRAxis is ready for a new command.
* **Busy** - Operation is currently being processed.
* **Done** - Operation completed successfully. **Done** is reset when the input command is reset.
* **Error** - An error exists for the axis. **Error** is reset with the **AcknowledgeError** command.
* **ErrorID** - Current error ID number.
* **ErrorString** - Current error text.
* **ErrorState** - State in which the error occurred.
* **ActualPosition** - Current axis position. [microsteps or counts]
* **ActualVelocity** - Current axis velocity. [microsteps/s or counts/s]
* **DriveStatus** - Extended drive status information. See the ramp mode help for details.
* **State** - Current axis state.

###Test Interface
The test interface gives you direct access to the axis commands and parameters, interrupting any commands from higher level programs. This allows for easy testing of the axis during machine commissioning or servicing. **The test commands and parameters are intended for use in an Automation Studio watch window and SHOULD NOT BE SET IN PROGRAMS**.

* **Enable** - If set to 1, TEST.CMD and TEST.PAR take priority over IN.CMD and IN.PAR. If set to 0, then TEST.CMD and TEST.PAR are ignored.
* **CMD** - Test commands. See above for a full list of commands.
* **PAR** - Test parameters. See above for a full list of parameters.
* **STAT** - A reduced set of status information that is always available whether test mode is enabled or not.

##Error ID Numbers
* 30190 - 30196 - These errors are passed on from the AsIOAcc library used to write to acyclic registers on the stepper module. Check that the **ModuleINADeviceName** and **MotorIndex** configuration settings are correct. If you are using an X67SM4320 module, please contact ARG for support. For further information, please see the AS online help.
* 50000 - SMR_ERR_INVALIDPAR_ACC - **Acceleration** is 0.
* 50001 - SMR_ERR_INVALIDPAR_DEC - **Deceleration** is 0.
* 50002 - SMR_ERR_INVALIDPAR_STOPDEC - **StopDeceleration** is 0.
* 50003 - SMR_ERR_INVALIDPAR_DIR - **Direction** is invalid. Valid values are **SMR_DIR_POS** and **SMR_DIR_NEG**.
* 50004 - SMR_ERR_HOME_INVALIDPAR - One or more homing parameters are invalid.
* 50005 - SMR_ERR_HOME_ERR - An error occurred while homing. Check wiring of switches and homing configuration.
* 50006 - SMR_ERR_POSLIMSW - Positive limit switch is active. Movement in the positive direction is not allowed.
* 50007 - SMR_ERR_NEGLIMSW - Negative limit switch is active. Movement in the negative direction is not allowed.