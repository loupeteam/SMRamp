/* Automation Studio generated header file */
/* Do not edit ! */
/* SpdEstLib 1.0.0 */

#ifndef _SPDESTLIB_
#define _SPDESTLIB_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _SpdEstLib_VERSION
#define _SpdEstLib_VERSION 1.0.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef struct SpeedEst
{
	/* VAR_INPUT (analog) */
	signed long Position;
	float T;
	float tf;
	signed long deadband;
	float K;
	/* VAR_OUTPUT (analog) */
	float Speed_est;
	/* VAR (analog) */
	float Speed_est_old;
	signed long Position_old;
	signed long Delta;
	float omega_fast;
	float omega_slow;
	float omega_slow_old;
	signed long Position_est;
	signed long Position_err;
	float Position_est_ff;
	signed long Position_est_int;
	signed long Position_est_int_old;
} SpeedEst_typ;

typedef struct SpeedEst_INT
{
	/* VAR_INPUT (analog) */
	signed short Position;
	float T;
	float tf;
	signed short deadband;
	float K;
	/* VAR_OUTPUT (analog) */
	float Speed_est;
	/* VAR (analog) */
	float Speed_est_old;
	signed short Position_old;
	signed short Delta;
	float omega_fast;
	float omega_slow;
	float omega_slow_old;
	signed short Position_est;
	signed short Position_err;
	float Position_est_ff;
	signed short Position_est_int;
	signed short Position_est_int_old;
} SpeedEst_INT_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void SpeedEst(struct SpeedEst* inst);
_BUR_PUBLIC void SpeedEst_INT(struct SpeedEst_INT* inst);


/* Constants */
#ifdef _REPLACE_CONST
 #define SPDEST_ZERO 1e-06f
#else
 _GLOBAL_CONST float SPDEST_ZERO;
#endif




#ifdef __cplusplus
};
#endif
#endif /* _SPDESTLIB_ */

