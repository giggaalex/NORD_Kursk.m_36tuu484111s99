if (side player == civilian) exitWith {};

_arsArray = [
	odshbr82_ars,
	obrmp36_ars,
	ombr72_ars,
	odshbr95_ars,
	magura_ombr47_ars,
	opspn8_ars,
	mcso73_ars,
	praga_ars,
	kna_ars,
	obrspn24_ars,
	obrmp810_ars,
	obrmp155_ars,
	somali_60omb_ars,
	dshp104_ars,
	oshbr3_ars,
	pdp51_ars
];

_myArs = missionNamespace getVariable ((missionNamespace getVariable "groupNamesByCallsigns" get (groupID (group player))) + "_ars");
_arsArray = _arsArray - [_myArs];

{
	[_x, false] call ace_arsenal_fnc_removeBox; 
	_x lockInventory true;
} forEach _arsArray;