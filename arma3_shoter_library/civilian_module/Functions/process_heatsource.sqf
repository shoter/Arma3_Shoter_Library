private [];
private [ "_i", "_source", "_index", "_type", "_time", "_range", "_value", "_independent",  "_position", "_delay", "_decay", "_updated" ];

for [ {_i=0} , {_i < count A3L_CM_HeatSources} , {_i=_i+1} ] do
{
	_index = _i;

	_x = A3L_CM_HeatSources select _index;

	_source      = _x select 0;
	_type        = _x select 1;
	_time        = _x select 2;
	_range       = _x select 3;
	_value       = _x select 4;
	_independent = _x select 5;
	
	if(isnil '_independent' ) then
	{
	sleep 5;
	};

	_position = [ _source ] call A3L_GetPos;
	
	[ _position, _type, _range, _value, _independent ] call A3L_CM_CreateHeat;

	if( _time != "CONST" ) then
	{
		
		_delay = _time select 0;
		_decay = _time select 1;
		_delay = _delay - (_decay / 60);
		_time = [ _delay, _decay ];
		
		//TODO : DELETE WHEN TOO OLD
		
	};

	_updated = [ _source, _type, _time, _range, _value, _independent  ];

	A3L_CM_HeatSources set [ _index, _updated ];
}


