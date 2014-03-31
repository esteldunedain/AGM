/*
BWA3 functions, by commy2
this code is property of the ArmA 3 Bundeswehr modification
ask us nicely at http://www.bwmod.de/ if you want to re-use any of this script
we don't support changed code based on this work
*/

BWA3_Interaction_Buttons = [];

private ["_actions", "_object", "_config", "_count", "_action", "_displayName", "_distance", "_condition", "_statement", "_dlgInteractionDialog", "_ctrlInteractionDialog"];

_actions = [];
_object = cursorTarget;
_config = configfile >> "CfgVehicles" >> typeOf _object >> "BWA3_Actions";
_count = count _config;

if (_count == 0) exitWith {};

for "_a" from 0 to (_count - 1) do {
	_action = _config select _a;
	_displayName = getText (_action >> "displayName");
	_distance = getNumber (_action >> "distance");
	_condition = compile getText (_action >> "condition");
	_statement = compile getText (_action >> "statement");

	if (player distance _object < _distance) then {
		_actions set [count _actions, [_displayName, _statement, _condition]];
	};
};

BWA3_Interaction_Buttons = _actions;
_count = count BWA3_Interaction_Buttons;

if (_count == 0) exitWith {};

closeDialog 0;
createDialog "BWA3_Interaction_Dialog";

setMousePosition [0.5, 0.5];

disableSerialization;
_dlgInteractionDialog = uiNamespace getVariable "BWA3_Interaction_Dialog";

for "_a" from 0 to (_count - 1) do {
	_action = BWA3_Interaction_Buttons select _a;

	_ctrlInteractionDialog = _dlgInteractionDialog displayCtrl (10 + _a);
	_ctrlInteractionDialog ctrlShow true;
	_ctrlInteractionDialog ctrlSetText (_action select 0);
	_ctrlInteractionDialog ctrlEnable (call (_action select 2));
};