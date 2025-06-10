if (side player == civilian) exitWith{};

_group = missionNamespace getVariable "groupNamesByCallsigns" get (groupID (group player));

_donateMap = createHashMapFromArray [
	["76561198316727609", ["NMG_weapons_ppsh","71rnd_762mm_psh_nmg","NMG_weapons_pksp","NMG_silence_dtknrmini","rhs_100Rnd_762x54mmR", "ACE_optic_MRCO_2D"]], //Shamko
	//["76561198297574929", ["rhs_weap_SCARH_LB","rhs_mag_20Rnd_SCAR_762x51_m61_ap_bk","rhsusf_acc_rvg_blk","Scot_LEU_MK8_nord","rhsusf_acc_aac_762sd_silencer"]], //Giga
	//["76561198168372978", ["NMG_weapons_A762"]], // Kot
	["76561198055139490", ["NMG_weapons_A545","NMG_weapons_A545_gp"]], //cana bycha
	["76561199061768748", ["nord_tv110_stefan","lmg_MG3_rail","120Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M"]], //htefan
	["76561198201205878", ["NMG_weapons_A545","NMG_weapons_A545_gp","nord_tv110_fraer","Quebec_Cap_SS_grey","Quebec_Cap_SS_OD","Quebec_Cap_SS_tan","TOTT_Razor_110_Geissele","rhsusf_acc_compm4"]], //fraer
	["76561199287760678", ["NMG_weapons_AM17pp"]],
	["76561198268337887", ["rhs_weap_SCARH_LB","rhs_mag_20Rnd_SCAR_762x51_m61_ap_bk","rhsusf_acc_rvg_blk","Scot_LEU_MK8_nord","rhsusf_acc_aac_762sd_silencer","tsb_mag_762x51_20rnd_M61_SCARB"]],
	["76561199042520076", ["nord_tv110_ermak"]],
	["76561198908535754", ["nord_tv110_knyazi","NMG_weapons_mk47","tsb_mag_762x39_30rnd_7n23_metal"]],
	["76561198338806858", ["nord_tv110_cikada","Ltf_AEROM5_BLK","LTF_M110_20Rnd"]],
	["76561199002226480", ["nord_tv110_flamberg","NMG_weapons_A545","NMG_weapons_A545_gp"]],
	["76561198869532056", ["nord_tv110_vega","NMG_weapons_A545","NMG_weapons_mk47"]],
	["76561199543645766", ["NMG_weapons_A762","NMG_weapons_A762_gp"]], //Fil
	["76561198855517877", ["TSVL8_300","TSVL8_300_Mag","Ltf_AEROM5_TAN","Ltf_AEROM5_BLK"]], //Joker
	["76561198309019794", ["lmg_MG3_rail","120Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M"]], //Rin
	["76561198815605790", ["nord_tv110_varden","NMG_weapons_A545","NMG_weapons_A545_gp"]],
	["76561199786409092", ["afou_weap_fort221_556x45_01"]], //Baron
	["76561198029025525", ["rhs_weap_SCARH_CQC"]], //Gans Legenda
	["76561198998228174", ["rhs_weap_SCARH_CQC","tsb_mag_762x51_20rnd_m993_SCARB"]], //Chuhcbek
	["76561199168589957", ["afou_weapons_vulkan_545_m_grip_F"]] //Artist
];

_myDonate = _donateMap getOrDefault [(getPlayerUID player), []];
if (count _myDonate < 1) exitWith{};
sleep 5;
_logStr = format ["Ars: %1, added items %2; Group %3", _group + "_ars", _myDonate, _group];
diag_log _logStr;
[(missionNamespace getVariable (_group + "_ars")), _myDonate, false] call ace_arsenal_fnc_addVirtualItems;