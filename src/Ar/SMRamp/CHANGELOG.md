3.2.1 - Migrate from AsString to AsBrStr

3.02.0 - 20120502 - Added documentation. Added SMR_HOMEMODE_LIMIT_SWITCH constant to be consistent with MC_Home FUB.
			Added ErrorString output.

3.01.0 - 20120425 - Updated to be compatible with SpdEstLib >= V0.00.8

3.00.0 - 20110811 - Release version of 2.90.1

2.90.1 - 20110811 - Reorganized IO mapping variables.
			Release version of 2.90.x should become 3.00.0
			Changed HW fault acknowledge behavior - added timer to latch hw bits for more than 25 ms.

2.04.1 - 20110531 - Reset AckError command at end of fn. - works for AccWrite errors.

2.04.0 - 20110517 - Release version of 2.03.1.

2.03.1 - 20110517 - Added speed estimation

2.03.0 - 20110512 - Release version of 2.02.1.

2.02.1 - 20110510 - Added TEST interface.

2.02.0 - 20110419 - Release version of 2.01.1.

2.01.1 - 20110418 - Added Jog commands.

2.01.0 - 20110405 - Release version with Busy, Done, and new interface structure.

2.00.1 - 20110331 - Changed motion start functionality
			Completely reworked parameter update handling

2.00.0 - 20110321 - Significant reorganization
			changed FUB names and prototypes
			changed interface structures
			changed limit switch behavior to cause an error when limit switch is hit

1.03.1 - 20110309 - Changed inputs from pointer input to IN_OUT type to be consistent with other libraries

1.02.1 - 20110308 - Changed PAR and CMD structures to be consistent with AxisLib structures (and PLCOpen)

1.01.5 - 20110308 - Added dependencies to brsystem (RTInfo) and SpdEstLib

1.01.4 - 20110218 - Added mode constants for HOMEPOS and HOMENEG

1.01.3 - 20110210 - Added scaling constants for revs and rpm and rpm/s.

1.01.2 - 2010xxxx - TrackSetPos added, but not tested; Version history started;
