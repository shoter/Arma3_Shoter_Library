private ["_object"];

if( typename _object == "ARRAY" ) then {
	_object;
	} else {
	position _object;
	}