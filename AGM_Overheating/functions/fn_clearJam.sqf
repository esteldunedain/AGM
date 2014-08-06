// by commy2

private ["_unit", "_weapon", "_jammedWeapons"];

_unit = _this select 0;
_weapon = _this select 1;
_skipAnim = _this select 2;

_jammedWeapons = _unit getVariable ["AGM_Overheating_jammedWeapons", []];

if (_weapon in _jammedWeapons) then {
	_jammedWeapons = _jammedWeapons - [_weapon];

	_unit setVariable ["AGM_Overheating_jammedWeapons", _jammedWeapons];

	if (count _jammedWeapons == 0) then {
		_unit removeAction AGM_JammingActionID;
	};

	if !(_skipAnim) then {
		_reloadAction = getText (configFile >> "CfgWeapons" >> _weapon >> "reloadAction");
		_unit playActionNow _reloadAction;
	};

	[localize "STR_AGM_Overheating_WeaponUnjammed"] call AGM_Core_fnc_displayTextStructured;
};