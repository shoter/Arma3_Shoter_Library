private ["_HeatArray"];

_HeatArray = _this select 0;

if( !A3L_CM_debug ) exitWith {  };
//hint format [ "Debug heat %1" , count _HeatArray ];
	{	
		_position = _x select 0;
		_type     = _x select 1;
		_range    = _x select 2;
		_value    = _x select 3;
		
		_markerstr = createMarker [format["HDM%1", A3L_CM_d_HeatMarkersLoop], _position];
		_markerstr setMarkerShape "ELLIPSE";
		_markerstr setMarkerAlpha 0.75;
		_markerstr setMarkerBrush "Solid";
		_markerstr setMarkerSize [ _range, _range ];
		switch( _type ) do
		{
			case 'P' :
			{
				_markerstr setmarkercolor "ColorWhite";
			};
			
			case 'W' :
			{
				_markerstr setmarkercolor "ColorBlue";
			};
			
			case 'C' :
			{
				_markerstr setmarkercolor "ColorOrange";
			};
		};
		
		_markerstr setMarkerText format["%1 %2", A3L_CM_CLOOP, _value];
		
		A3L_CM_d_HeatMarkersLoop = A3L_CM_d_HeatMarkersLoop + 1;
	
	} forEach _HeatArray;