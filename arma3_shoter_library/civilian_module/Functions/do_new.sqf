private["_civilian"];
_civ                = _this select 0;
_civ_info           = _civ         getVariable "civ_info";

_action             = _civ_info    select 1; 
_actionName         = _action      select 0;
_actionParams       = _action      select 1;

_personality        = _civ_info    select 0;
_curious            = _personality select 0;
_playerMultiplayer  = _personality select 1;
_civilianMultiplier = _personality select 2;
_enemyMultiplier    = _personality select 3;
_fear               = _personality select 4;
_maxFear            = _personality select 5;

_id                 = _civ         getVariable "id";

_civCuriosity = 0;
_playerCuriosity = 0;
_enemyCuriosity = 0;
_otherCuriosity = 0;
_curiosity = 0;

_lost_radius = 50;

_rand = random 100;
if( _rand < A3L_CM_WanderChance ) then
{

};

{
	_other = _x;
	if( _other != _civ ) then 
		{
			_dist = _other distance _civ;
			_basePoints = A3L_CM_CivBaseCuriosity * _civilianMultiplier;
			_score = [_basePoints, _dist] call A3L_CM_CalculateCurio;
	
		_civCuriosity = _civCuriosity + _score;
		};
} forEach A3L_Civilians;

_curiosity = _civCuriosity + _playerCuriosity + _enemyCuriosity + _otherCuriosity;
_rand = random ( _curiosity );

//hint format [ "%1 curio %2/%3", _id, _rand, _curiosity ];

_curiosity = _civCuriosity;
_who = nil; 
if(_rand < _curiosity) then {
	_cur = 0; //current curiosity for this section
	
		{
		if( _x != _civ ) then 
			{
				_who = _x;
				
				_dist = _x distance _civ;
				_basePoints = A3L_CM_CivBaseCuriosity * _civilianMultiplier;
				_score = [_basePoints, _dist] call A3L_CM_CalculateCurio;
				_cur = _cur + _score;
			
			
			if (_cur > _curiosity ) exitWith { _lost_radius = 25; }; //it is exiting with object of our curiosity
			};
		} forEach A3L_Civilians;
	
	};

if( not isNil "_who" ) then
{	
	[_civ, _who, _lost_radius] call A3L_CM_CivilGoto;
};

sleep 1;
