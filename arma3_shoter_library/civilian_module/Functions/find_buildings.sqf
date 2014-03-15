private["_gracze", "_gracz"];
private["_budynki"];

{
	_gracz = _x;
	_budynki = nearestObjects[ (getPos _gracz), A3L_CM_HouseClasses , (A3L_CM_SpawnRadius select 1) ];

	{
		if ( (_gracz distance _x) < (A3L_CM_SpawnRadius select 0)) then
			{
				_budynki = _budynki - [_x];
			};
		//Now check for other players
		_budynek = _x;
		{
			_other = _x;
			if( (_other distance _budynek) < (A3L_CM_SpawnRadius select 0) ) then
				{
					_budynki = _budynki - [_budynek];
				};
		
		}foreach A3L_PlayerList;
	} foreach _budynki; 
}foreach A3L_PlayerList;


{
A3L_CM_LOOP = A3L_CM_LOOP + 1;

_markerstr = createMarker[format["%1 - %2", A3L_CM_LOOP, typeof _x], position _x];
_markerstr setMarkerText format["", A3L_CM_LOOP, typeof _x];
_markerstr setMarkerShape "ICON";
_markerstr setMarkerType "mil_dot";
_markerstr setmarkercolor "colorblack";

} foreach _budynki;

_budynki;
