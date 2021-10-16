#if !defined(USING_MAP_DATUM)

	#include "stellar_delight_areas.dm"
	#include "stellar_delight_defines.dm"
	#include "stellar_delight_telecomms.dm"
	#include "..\offmap_vr\common_offmaps.dm"
	
	#if !AWAY_MISSION_TEST //Don't include these for just testing away missions
		#include "stellar_delight1.dmm"
		#include "stellar_delight2.dmm"
		#include "stellar_delight3.dmm"
	#endif

	#define USING_MAP_DATUM /datum/map/stellar_delight

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Tether

#endif