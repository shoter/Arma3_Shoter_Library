//Made by Szymanowski from CFOG
private ["_jednostki","_gracze"];
_jednostki = [];
_gracze = [];
if (count playableUnits > 0) then {_jednostki = playableUnits} else {_jednostki = [player]};
{if(isPlayer _x)then{_gracze = _gracze + [_x]}} forEach _jednostki;
_gracze