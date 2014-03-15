SHK_pos

Author: Shuko (shuko@quakenet, miika@miikajarvinen.fi)
Version 0.21
Forum: http://forums.bistudio.com/showthread.php?t=89376

Marker Based Selection
  Required Parameters:
    0 String   Area marker's name.
    
  Optional Parameters:
    1 Boolean           Allow water positions? Default is false.
    2 Array or String   One or multiple blacklist area markers which are excluded from the main marker area.

Position Based Selection
  Required Parameters:
    0 Object or Position  Anchor point from where the relative position is calculated from.
    1 Array or Number     Distance from anchor.
    
  Optional Parameters:
    2 Array of Number     Direction from anchor. Default is random between 0 and 360.
    3 Boolean             Water position allowed? Default is false.
                            false    Allow water positions.
                            true     Find closest land. Search outwards 360 degrees (20 degree steps) and 20m steps.
    4 Array               Road positions.
                            0  Number  Road position forcing. Default is 0.
                                 0    Do not search for road positions.
                                 1    Find closest road position. Return the generated random position if none found.
                                 2    Find closest road position. Return empty array if none found.
                            1  Number   Road search range. Default is 200m.
  
Usage:
  Preprocess the file in init.sqf:
    call compile preprocessfile "SHK_pos\shk_pos_init.sqf";
  
  Actually getting the position:
    pos = [parameters] call SHK_pos;
