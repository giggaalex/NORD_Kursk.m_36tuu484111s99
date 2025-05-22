if (side player == civilian) exitWith {};

_arsArray = [
	obrtro127_ars,
	obrmp36_ars,
	ombr72_ars,
	ombr53_ars,
	magura_ombr47_ars,
	opspn8_ars,
	opspn3_ars,
	espaniola88_ars,
	sparta80_ars,
	obrspn24_ars,
	omsbr15_ars,
	arbat_bsn_ars,
	somali_60omb_ars,
	veterani_ars,
	oshbr3_ars,
	pdp51_ars
];

_myArs = missionNamespace getVariable ((missionNamespace getVariable "groupNamesByCallsigns" get (groupID (group player))) + "_ars");
_arsArray = _arsArray - [_myArs];

{
	[_x, false] call ace_arsenal_fnc_removeBox; 
	_x lockInventory true;
} forEach _arsArray;