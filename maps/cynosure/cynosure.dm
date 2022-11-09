#if !defined(USING_MAP_DATUM)

	#include "cynosure_areas.dm"
	#include "cynosure_defines.dm"
	#include "cynosure_jobs.dm"
	#include "cynosure_elevator.dm"
	#include "cynosure_events.dm"
	#include "cynosure_presets.dm"
	#include "cynosure_shuttles.dm"

	#include "..\offmap_vr\cyno_offmaps.dm"
	#include "..\tether\tether_jobs.dm"

//	#include "datums/random_map.dm"

	#include "turfs/outdoors.dm"
	#include "overmap/sectors.dm"

	#include "cynosure-1.dmm"
	#include "cynosure-2.dmm"
	#include "cynosure-3.dmm"
	#include "cynosure-4.dmm"
	#include "cynosure-5.dmm"
	#include "cynosure-6.dmm"
	#include "cynosure-7.dmm"

	#include "submaps/_cynosure_submaps.dm"

	#define USING_MAP_DATUM /datum/map/cynosure

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Cynosure

#endif
