if (isServer) then {
	_clientMapFPS = createHashMap;
	missionNamespace setVariable ["_clientMapFPS", _clientMapFPS, true];

	missionNamespace setVariable ["PKP_DELTA", 20, true]; //В СЕКУНДАХ, КУЛДАУН МЕЖДУ ОТКРЫТИЯМИ ПКП
	missionNamespace setVariable ["PKP_DURATION", 10, true]; //В СЕКУНДАХ, ДЛИТЕЛЬНОСТЬ ПКП
	missionNamespace setVariable ["EAST_pkpUsesLeft", 2, true]; //Количество волн для РФ; Хочется без ограничений - въебите 100+
	missionNamespace setVariable ["WEST_pkpUsesLeft", 2, true]; //Количество волн для ВСУ; Хочется без ограничений - въебите 100+
	missionNamespace setVariable ["EAST_lastOpenPKP", serverTime, true]; //технический параметр, не менять
	missionNamespace setVariable ["WEST_lastOpenPKP", serverTime, true]; //технический параметр, не менять
	missionNamespace setVariable ["CIV_pkpOpen", false, true]; //технический параметр, не менять
	missionNamespace setVariable ["EAST_pkpOpen", false, true]; //открыт ли ПКП РФ на старте миссии (не минусует волну)
	missionNamespace setVariable ["WEST_pkpOpen", false, true]; //открыт ли ПКП ВСУ на старте миссии (не минусует волну)
	missionNamespace setVariable ["EAST_canOpenPKP", true, true]; //ВСЕГДА ставьте противоположное значение от EAST_pkpOpen
	missionNamespace setVariable ["WEST_canOpenPKP", true, true]; //ВСЕГДА ставьте противоположное значение от WEST_pkpOpen

	_groupNamesMap = createHashMapFromArray [
		["47 ОМБР","magura_ombr47"],
		["8 ОПСпН","opspn8"],
		["73 МЦСО","mcso73"],
		["95 ОДШБР","odshbr95"],
		["82 одшбр","odshbr82"],
		["3 ОШБр","oshbr3"],
		["72 ОМБр","ombr72"],
		["36 ОБрМП","obrmp36"],
		["104 ДШП","dshp104"],
		["810 обрмп","obrmp810"],
		["24 ОБрСпН","obrspn24"],
		["КНА","kna"],
		["РШБ Прага","praga"],
		["155 ОБРМП","obrmp155"],
		["60 ОМБ Сомали","somali_60omb"],
		["51 ПДП","pdp51"]
	];
	
	missionNamespace setVariable ["groupNamesByCallsigns", _groupNamesMap, true];

	["zen_modules_moduleCreateTeleporter_PKP", [gate_baseRF, getPosATL gate_baseRF, "BASE_RF"]] call CBA_fnc_serverEvent;
	["zen_modules_moduleCreateTeleporter_PKP", [gate_baseVSU, getPosATL gate_baseVSU, "BASE_VSU"]] call CBA_fnc_serverEvent;

	save_var_hohol = 1;
	clean_var_hohol = 1;
	[] execVM "scripts\ehKillCrew.sqf";
	[] execVM "sherpa_scripts\detectHeight.sqf";
	[] spawn {
		execVM "sherpa_scripts\ini_markerFPS.sqf"
	};
	[] execVM "sherpa_scripts\ini_zeus.sqf";
	[] execVM "scripts\arsenals.sqf";
	
		sherpa_event_kill_fix = addMissionEventHandler ["EntityKilled", {
			params ["_killed", "_killer", "_instigator"];      
					if ((_killed isKindOf "CAManBase")) then {
						_killed unassignItem "B_UavTerminal";
						_killed removeItem "B_UavTerminal";
						_killed unassignItem "O_UavTerminal";
						_killed removeItem "O_UavTerminal";
						if (side player == EAST) then {
							player addItem "O_UavTerminal";
							player assignItem "O_UavTerminal";
						};
						if (side player == WEST) then {
							player addItem "B_UavTerminal";
							player assignItem "B_UavTerminal";
						};
					};
			        _dubeKiller = name _killer;     
			        if (_killer == _killed) then {
				_killer = _killed getVariable ["ace_medical_lastDamageSource", _killer];      
				            if ((_killed isKindOf "CAManBase")) then {
					if (([side group _killed, side group _killer] call BIS_fnc_sideIsEnemy)) then {
						_killer addPlayerScores [1, 0, 0, 0, 0];
					};
				};
			} else {
				_killer
			};     
			        if (isNull _instigator) then {
				_instigator = UAVControl vehicle _killer select 0
			};      
			        if (isNull _instigator) then {
				_instigator = _killer
			};
		}]; 
		sherpa_event_respawn_gps = addMissionEventHandler ["EntityRespawned", {
		    params ["_unit", "_corpse"];

		    if (_unit isKindOf "CAManBase" && {side _unit in [EAST, WEST]}) then {
		        _unit addItem "ItemGPS";
				_unit assignItem "ItemGPS";
		    };
		}];
		sherpa_event_removeforma = addMissionEventHandler ["EntityRespawned", {
            params ["_unit", "_corpse"];

		    if (_unit isKindOf "CAManBase" && {isPlayer _unit}) then {
            removeUniform _unit;
            };
		}];
		publicVariableServer "sherpa_event_removeforma";
		publicVariableServer "sherpa_event_respawn_gps";
		publicVariableServer "sherpa_event_kill_fix";
		missionNamespace setVariable ["isEvent", false, true];
	};

	