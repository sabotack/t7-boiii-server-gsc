# BOIII: Dedicated ZM Server GSC Scripts
These scripts are made for a private dedicated BOIII ZM server.

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
> Client Data is not requested and `sv_iw4madmin_in` dvar is manually reset to avoid crashes

## Disclaimer
These scripts have been created purely for the purposes of academic research. Project maintainers are not responsible or liable for misuse of the software. Use responsibly.
