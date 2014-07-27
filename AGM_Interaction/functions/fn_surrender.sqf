// by commy2

private ["_unit", "_state"];

_unit = _this select 0;
_state = _this select 1;

if (!local _unit) then {[_this, _fnc_scriptName, _unit] call AGM_Core_fnc_execRemoteFnc};

if (_state) then {
	if (_unit getVariable ["AGM_isSurrender", false]) exitWith {};

	_unit setVariable ["AGM_isSurrender", true, true];
	[_unit, "AGM_Surrendered", true] call AGM_Interaction_fnc_setCaptivityStatus;

	_unit spawn {
		// fix for lowered rifle animation glitch
		if (currentWeapon _this == primaryWeapon _this && {weaponLowered _this} && {stance _this == "STAND"}) then {
			_this playMove "amovpercmstpsraswrfldnon";
		};

		while {_this getVariable ["AGM_isSurrender", false]} do {
			sleep 0.001; //sleep in UI
			_this playMove "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon";

			if (!alive _this || {_this getVariable ["AGM_Unconscious", false]}) then {
				_this setVariable ["AGM_isSurrender", false, true];
			};
		};
		if !(_this getVariable ["AGM_Unconscious", false]) then {
			_this playMoveNow "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
		};

		[_this, "AGM_Surrendered", false] call AGM_Interaction_fnc_setCaptivityStatus;
	};
} else {
	_unit setVariable ["AGM_isSurrender", false, true];
};