private [ "_who" , "_target", "_lost_radius" ];
hint "IDE!";

_who         = _this select 0;
_target      = _this select 1;
_lost_radius = _this select 2;

_position = [_target, [5,15]] call SHK_pos;

_action = [ "GOTO-OBJECT" , [ _target, _position, _lost_radius] ];

_civ_info  = _who getVariable "civ_info";
_civ_info set [1, [_action] ];
_who setVariable [ "civ_info", _civ_info, false ];

_group = group _who;

_wp = _group addWaypoint [ _position, 5];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "LIMITED";
_group setCurrentWaypoint _wp;

if( A3L_CM_debug ) then
{
	_id = _who getVariable "id";
	if( isNil "_debugWPMarker" ) then
	{
			_markerstr = createMarker [format["CWP%1", _id], _position];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "mil_dot";
			_markerstr setmarkercolor "colororange";
			_markerstr setMarkerText format["C - %1", _id];
	} else {
			format["CWP%1", _id] setMarkerPos _position;
	};
	format["CIV%1", _id] setMarkerText format [ "%1 G", _id ]; 

};

{_x doMove (getpos _x)} foreach units group _who;
