# Changelog

## v0.2.0
- Added new patch to improve performance when using with Calico
    - Calico has a performance optimization that skips updating player cosmetics when it is extraneous
    unfortunately this makes name colors propagate VERY slowly, if ever. So, this patch adds a quick title_update
    before the Calico cosmetic check, to make sure we don't get skipped and thrown out with the bath water too.

## v0.1.1
- Fixed Socks not being properly declared as a dependency of the project
- Fixed project/export file path mismatch causing crash in v0.1.0

## v0.1.0
- Hotfix delayed nameplate color for the local player
    - Your name should now have a color shortly after joining lobbies now!