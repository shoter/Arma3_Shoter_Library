private [ "_position", "_type", "_range" , "_value" , "_independent" ];
private [ "_i", "_found", "_xposition", "_xtype", "_xrange","_xvalue", "_nvalue", "_nrange", "_nposition", "_heat" ];

if( count _this != 5) exitWith { hint "CreateHeat not enough args" ; };

_position    = _this select 0;
_type        = _this select 1;
_range       = _this select 2;
_value       = _this select 3;
_independent = _this select 4;


//hint format [ "CreateHeat - pos %1  | type %2 | range %3 | value %4 ", _position, _type, _range, _value ];

_heat = [ _position, _type, _range, _value, _independent ];
_found = false;
if(not _independent ) then
{
	for [ {_i=0}, {
	//FOR CHECK

	switch( _type ) do
			{
				case "W" :
				{
					_i < count A3L_CM_WHeat;
				};

				case "E" :
				{
					_i < count A3L_CM_EHeat;
				};
				
				case "C" :
				{
					_i < count A3L_CM_CHeat;
				};
				
				case "P" :
				{
					_i < count A3L_CM_PHeat;
				};
			};


	} , {_i=_i+1} ] do
	{
	   _x = nil;
	   
		   
			 switch( _type ) do
				{
					case "W" :
					{
						_x = A3L_CM_WHeat select _i;
					};

					case "E" :
					{
						_x = A3L_CM_EHeat select _i;
					};
					
					case "C" :
					{
						_x = A3L_CM_CHeat select _i;
					};
					
					case "P" :
					{
						_x = A3L_CM_PHeat select _i;
					};
				};
		   
		   //hint format [ "%1/%2", _i , count A3L_CM_HEAT];
		   
		  _xposition    = _x select 0;
		  _xtype        = _x select 1;
		  _xrange       = _x select 2;
		  _xvalue       = _x select 3;
		  _xindependent = _this select 4;
		  
		  
		if( not _xindependent ) then
	   {
		  
		  _dist = _position distance _xposition;
		  
		  if(_xtype == _type && _dist < (_range/1.5 + _xrange/2) ) then {
			_nvalue = _value + _xvalue;
			_nrange = _range + _xrange;
			_nposition = [0,0,0];
			_x = _position select 0;
			_y = _position select 1;
			_z = _position select 2;
			
			_xx = _xposition select 0;
			_xy = _xposition select 1;
			_xz = _xposition select 2;
			
			_nx = (_x + _xx) / 2;
			_ny = (_y + _xy) / 2;
			_nz = (_z + _xz) / 2;
			
			_nposition = [ _nx, _ny, _nz ];
			_heat = [ _nposition, _type, _nrange, _nvalue ];
			
			switch( _type ) do
			{
				case "W" :
				{
					A3L_CM_WHeat set [ _i, -1 ];
					A3L_CM_WHeat = A3L_CM_WHeat - [-1];
				};

				case "E" :
				{
					A3L_CM_EHeat set [ _i, -1 ];
					A3L_CM_EHeat = A3L_CM_EHeat - [-1];
				};
				
				case "C" :
				{
					A3L_CM_CHeat set [ _i, -1 ];
					A3L_CM_CHeat = A3L_CM_CHeat - [-1];
				};
				
				case "P" :
				{
					A3L_CM_PHeat set [ _i, -1 ];
					A3L_CM_PHeat = A3L_CM_PHeat - [-1];
				};
			};
			
			_i = _i-1;
			_found = true;
			
			[ _nposition, _type, _nrange, _nvalue, _xindependent ] call A3L_CM_CreateHeat;
			
			
		  }; 
		  
		  if( _found ) exitWith { };
	  };

	};
};

if( not _found ) then
{
	switch( _type ) do
	{
		case "W" :
		{
			A3L_CM_WHeat = A3L_CM_WHeat + [ _heat ];
		};

		case "E" :
		{
			A3L_CM_EHeat = A3L_CM_EHeat + [ _heat ];
		};
		
		case "C" :
		{
			A3L_CM_CHeat = A3L_CM_CHeat + [ _heat ];
		};
		
		case "P" :
		{
			A3L_CM_PHeat = A3L_CM_PHeat + [ _heat ];
		};
	};
};
