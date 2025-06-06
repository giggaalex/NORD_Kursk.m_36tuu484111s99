[] call compile preProcessFilelineNumbers "scripts\chat\config.sqf";
[] call compile preProcessFilelineNumbers "scripts\chat\commands.sqf";
[] execVM "scripts\zeus\opened_eh.sqf";
[] execVM "ROS_hitreaction\scripts\ROS_HitReaction.sqf";

CHVD_terrain = 3.125;
CHVD_allowNoGrass = false;

//Светлая ночь
CHBN_adjustBrightness = 1;
CHBN_adjustColor = [0.5,0.7,1];

pvpfw_chatIntercept_executeCommand = compile preProcessFilelineNumbers "scripts\chat\executeCommand.sqf";

0 enableChannel [false, true];
1 enableChannel [false, true];
2 enableChannel [false, true];
4 enableChannel [false, true];
5 enableChannel [false, true];
6 enableChannel [false, true];

// Reset and old EH IDs and scripthandles
if (!isNil "pvpfw_chatIntercept_handle")then{
	terminate pvpfw_chatIntercept_handle
};
if (!isNil "pvpfw_chatIntercept_EHID")then{
	(findDisplay 24) displayRemoveEventHandler ["KeyDown",pvpfw_chatIntercept_EHID];
	pvpfw_chatIntercept_EHID = nil;
};

if (hasInterface) then
{
	[] spawn {
		waitUntil {!isNull player};
		[player, didJIP] remoteExec ["Nord_fnc_initPlayerServer", 2];
	};
};

pvpfw_chatIntercept_handle = [] spawn {
	private["_equal","_chatArr"];
	
	while{true}do{
		pvpfw_chatString = "";
		
		waitUntil{sleep 0.22;!isNull (finddisplay 24 displayctrl 101)};
		
		pvpfw_chatIntercept_EHID = (findDisplay 24) displayAddEventHandler["KeyDown",{
			if ((_this select 1) != 28) exitWith{false};
			
			_equal = false;
			
			_chatArr = toArray pvpfw_chatString;
			//_chatArr resize 1;
			if ((_chatArr select 0) isEqualTo ((toArray pvpfw_chatIntercept_commandMarker) select 0))then{
				if (pvpfw_chatIntercept_debug)then{
					systemChat format["Intercepted: %1",pvpfw_chatString];
				};
				_equal = true;
				closeDialog 0;
				(findDisplay 24) closeDisplay 1;
				
				[_chatArr] call pvpfw_chatIntercept_executeCommand;
			};
			
			_equal
		}];
		
		waitUntil{
			if (isNull (finddisplay 24 displayctrl 101))exitWith{
				if (!isNil "pvpfw_chatIntercept_EHID")then{
					(findDisplay 24) displayRemoveEventHandler ["KeyDown",pvpfw_chatIntercept_EHID];
				};
				pvpfw_chatIntercept_EHID = nil;
				true
			};
			pvpfw_chatString = (ctrlText (finddisplay 24 displayctrl 101));
			false
		};
	};
};

addMissionEventHandler ["EntityKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	class = missionNamespace getVariable ([(getDescription _unit) select 0, 0]);
	if (class > 0) then {
		missionNamespace setVariable [(getDescription _unit) select 0, class - 1];
	};
}];

"extDB3" callExtension "9:ADD_DATABASE:Nord_DB";
"extDB3" callExtension "9:ADD_DATABASE_PROTOCOL:Nord_DB:SQL:NP";