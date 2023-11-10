![Automation Resources Group](http://automationresourcesgroup.com/images/arglogo254x54.png)

#SpdEstLib Library
The SpdEstLib library provides function blocks for estimating speed based on sampled position data, such as an encoder position. The estimator consists of a filtered differentiator with a corrective term designed to react quickly to changing speeds. The result is a speed estimate with good noise rejection at steady speed and good tracking during speed changes.

#Usage
The SpdEstLib library consists of two function blocks, **SpeedEst** for 32-bit (DINT) position values, and **SpeedEst_INT** for 16-bit (INT) positions. For an example of how to use this in a project, please see the ARG Automation Studio Starter Project at [https://github.com/autresgrp/StarterProject](https://github.com/autresgrp/StarterProject).

##Initialization
No initialization is required to use the speed estimation function blocks. It is possible to set the function block parameters in the INIT routine of your program, however. 

The sampling period, **T**, is in seconds and should be set to the cycle time of the task class in which the function block is called. The task class cycle time can be obtained using the **RTInfo** function block from the brsystem library. Note that the **RTInfo** function block returns the cycle time in microseconds, and the speed estimation function blocks expect a value in seconds. The sampling of the position data should also be synchronized to the task class system. 

The first order filter time constant, **tf**, is in seconds and should be set based on the level of noise rejection desired. It should be set to a value greater than or equal to 0 s.

The **deadband** parameter determines how quickly the corrective term kicks in. It has the same units as the sampled position. Smaller values of **deadband** lead to a more aggressive corrective term, and larger values lead to a less aggressive corrective term. **DEADBAND SHOULD NOT BE SET TO 0 UNLESS K IS ALSO SET TO 0.**

**K** is the gain of the corrective term in units of 1/s. Smaller values of **K** lead to a less aggressive corrective term, and larger values lead to a more aggressive corrective term. If **K** is set too low, then the reaction of the corrective term can become too slow. If **K** is set too high, then the corrective term can become unstable. A good starting point for **K** is the sampling frequency, 1/**T**. The corrective term can be disabled by setting **K** to 0.

	RTInfo_0.enable:=		1;
	RTInfo_0();
	
	SpeedEst_0.T:=			UDINT_TO_REAL(RTInfo_0.cycle_time) / 1000000.0;
	SpeedEst_0.tf:=			0.200;
	SpeedEst_0.deadband:=	20;
	SpeedEst_0.K:=			20;

##Cyclic Operation
To estimate speed, the function block must be called in the CYCLIC routine of your program, once every scan, unconditionally. The function block should not be called more than once per scan. The sampled position should be entered in the function block **Position** input every scan.

	SpeedEst_0.Position:=	SampledPosition;
	
	SpeedEst_0();
	
	EstimatedSpeed:=	SpeedEst_0.Speed_est;