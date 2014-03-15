private ["_object"];
_object = _this select 0;

if( typename _object == "ARRAY" ) then {
		_object;
	} else {
		position _object;
	}
