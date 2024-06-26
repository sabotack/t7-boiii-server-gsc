# BOIII: Dedicated ZM Server GSC Scripts
These scripts are made for a private dedicated BOIII ZM server.

## Usage
1. Either compile the project yourself using [t7-compiler](https://github.com/shiversoftdev/t7-compiler) or copy the pre-compiled `_clientids.gsc` to your server so you have the following structure: `boiii/scripts/zm/gametypes/_clientids.gsc`
2. Copy `GameInterface.js` to the `Plugins` folder of your IW4MAdmin installation (replace the existing file).

## Features
- Partial IW4MAdmin Integration
- Origins Tank Crash Hotfix
- Hitmarkers (red on kill)
- No perk limit (set to 9 which is max number of perks on official maps)

- Implemented IW4MAdmin client commands
  - GiveWeapon
  - TakeWeapons
  - Hide
  - Alert
  - Kill
  - SetSpectator
  - AdjustPoints
  - CEGO5050 (helper for custom IW4MAdmin plugin)

## Partial IW4MAdmin Integration
Integration with IW4MAdmin only works partially.
Could be due to errors in BOIII client binary or my limited GSC knowledge. 
- Not working (might fix in future):
  - Console logging
  - Client Data
  - Resetting `sv_iw4madmin_in` on certain request types
> Client Data is not requested and `sv_iw4madmin_in` dvar is manually reset for affected request types to avoid crashes
