--]]
return {
"\
CURRENT REVISION:\
Revision 400 Version 2.5: | July 9, 2019\
\ \
This is the last update of Discover! Management Console.\
You know, after making DMC since 2017 and making it\
open source in 2018, it felt to me that each Roblox update\
would cause some potential issues with DMC to a point\
of a massive reconstruction to its foundation.\
\ \
This also motivates me to make a better, advanced\
admin system along with an anti-exploit to go along\
with it which was not possible with the current\
code with Discover! Management Console.\
\ \
I've been hard at work, making Discover! Endpoint\
which not only serves as a modern admin, but also\
a built in anti-exploit system to prevent exploits from\
happening.\
\ \
Discover! Endpoint will be used with our games\
because I do not feel like open sourcing Discover!\
Endpoint anytime soon. It's our own unique and\
original admin system plus our anti-exploit system\
to keep our games fun for everyone.\
\ \
As with this done, DMC will NO LONGER receive\
any new updates, commands or fixes. In fact,\
starting next year in 2020, DMC will no longer\
be obtained from the Roblox Site. Anyone\
who still have DMC will continue to work,\
but no longer maintained. If a Roblox issue\
breaks DMC to a point of being irreparable,\
I won't fix it. In later 2019, all Discover!\
games will come shipped with Discover!\
Endpoint as a replacement of DMC and\
Discover! Endpoint Protection (current\
anti-exploit system).\
\ \
If you wish to work on DMC and make your\
admin system via this code, you are welcome\
to do so. DMC is now licensed under a MIT\
License that grants you permission to build\
upon the admin system and come up with\
your ideas by using DMC code made in 2017.\
\ \
I wish the best for what Roblox give developers\
in the future. Thanks for using DMC through\
the years of development and support!\
\ \
Yours Truly,\
TechnologicalByte\
\ \
What's new\
* Removed conflicting commands due to being broken,\
or doesn't work in general.\
* Added to command to easily teleport to someone without\
typing in tp 'player' 'player to'.\
* Added watch command to watch someone.\
* Updated F3X Tools.\
\ \
What's fixed\
* Fixed issue where text gets cut off by the GUI scroll bar.\
* Due to ROBLOX lighting system, the UI blur effects has \
been removed.\
* Fixed issue where an deprecated message appeared when\
executing place command to teleport someone to said game.\
* Fixed visual bug where closing gui did not fade the close\
button.\
* Fxied issue where loading DMC caused a warning message\
about something tried to move the parent module to NIL.\
* Fixed issue where sometimes, an error about GetProductInfo\
appears when executing some commands.\
\ \
OLD REVISIONS:\
Revision 301 Version 2.4_1: | February 3, 2019\
\ \
* Minor under-the-hood improvements and fixes.\
\ \
Revision 300 Version 2.4: | December 1, 2018\
\ \
What's changed:\
* The nuke shouldn't remain for a long time when it's fully\
expanded.\
* The musiclist command has been removed, as ROBLOX\
had disabled the songs in the musiclist.\
* Using the command syntax: me, or all, will now return as yourself\
(for the me syntax), or everyone (for the all syntax).\
* Executing a command that doesn't exist will now alert you via\
hint, instead of message box.\
\ \
What's fixed:\
* Resolved an issue where some commands would display\
a beta like DMC Command error rather than the current\
error that we are used today.\
* Resolved an issue where obtaining a gear by using the\
gearlist command would return a DMC error.\
* The unlock command is back. I have no clue on how that\
command got removed from DMC.\
* As with the new Command Bar, executing the Command Bar\
command would not  re-animate the Command Bar UI; We also\
resolved the issue where executing the Command Bar command\
would reblur the UI causing UI visual glitches.\
* Resolved the issue where using the invisible command on a player\
whose name got changed, did not make the fake head invisible.\
* Executing the settings command should not trigger a placeholder\
error.\
* Resolved an issue where some users who are admin, got a\
permission error, even though said user(s) are added to admin\
list.\
* Resolved an issue where teleporting someone would teleport\
the player above the said target.\
* Resolved an issue where many users who are admin, did not get\
admin, and for those who doesn't have admin, gets admin.\
\ \
Revision 270 Version 2.2_2:\
\ \
What's new:\
* There are no new features in this Revision.\
\ \
What's changed:\
* Executing some commands should be quicker.\
* Getting hit by a nuke shouldn't glitch your camera,\
or make you disappear upon respawn.\
* You should no longer respawn when someone\
unpunish you.\
* You should no longer see errors in developer console about\
music failed to play etc.\
\ \
What's fixed:\
* Fixed an issue where using the name command; Some\
R15 character's head would appear as a rectangle rather\
than a Mesh.\
* Fixed an issue where using the invisible command didn't\
hide everything from the character's parent.\
* Fixed typo 'Occurred' in some commands.\
\ \
Revision 267 Version 2.2_1:\
\ \
What's changed:\
* ROBLOX discontinued HopperBin tool. To prevent DMC from\
breaking, we've removed HopperBin functionality. RIP Hopperbin.\
\ \
What's fixed:\
* Fixed an issue where typing in gearlist would give you\
a standard scrolling frame with no content.\
* Fixed an issue where some commands displayed a\
place holder text instead of the actual text.\
\ \
Revision 265 Version 2.2:\
\ \
What's new:\
* DMC will now detect correct music IDs to be played, without\
being buffered.\
* Improved UI; Changed color, and clicking on another scroll\
GUI will make it active, bringing all elements on top instead\
of overlapping.\
* Loop command added. Loop any command with loop 'seconds'\
'command'\
* Added nuke command. Can be executed for people who are\
SuperAdmins.\
* Removed old commands that either does not work\
due to ROBLOX update, or has been depreciated.\
* DMC now uses TweenService! GUI animations, and\
some commands will appear smoother!\
\ \
What's fixed:\
* Fixed an major issue where typing in cmds after executing\
the command 'm' would severely lag the server and display\
a Game Script timeout error. (This issue existed 3 revisions\
old). Sorry about that\
* The fling command should now work. This was broken\
due to ROBLOX physics update.\
* Fixed an issue where typing in biggerhead would change the\
player's head color.\
* Fixed an issue where executing the name command,\
wouldn't filter any filtered words.\
* Fixed an issue where typing in the command, and adding\
random at then end wouldn't randomize the player.\
* Fixed a visual glitch where messages without description\
appear clipped.\
* Fixed an issue where whispering someone caused an\
unknown command to appear.\
* Fixed an issue where using the give command, would\
cause a DMC error.\
* Fixed a visual glitch where the scroll GUI contents\
would overlap the content description for a brief second.\
\ \
Revision 238 Version 2.1:\
\ \
What's new:\
* New command, charrain. Have a specific character rain all\
over you!\
* Hate typing in ID to change character? You can now type in the\
person's name instead of their character ID!\
* Improved the discoverability for close buttons.\
* Added description for logs command.\
* Descriptions shown in scroll GUI is now bold.\
* Any scroll GUI without contents, will not show the scroll\
bar, and instead display a no content available string.\
* Improved music buffering algorithm.\
\ \
Other things:\
* Fixed a critical issue where some parts of DMC would\
lag the server, resulting in an error of script timeout.\
* Fixed an issue where if someone requests multiple\
music at once, would cause DMC to error as 'AdmiMusic\
is not a valid member of Workspace.'\
* Fixed an issue where scrolling using mouse button would\
cause the scrolling GUI to be dragged along with scrolling.\
* Fixed an issue where sometimes, a recoverable error were to \
occur due to a VersionMetadata error.\
* Fixed description text that was being cut-off by not enough\
space.\
* Fixed a visual glitch when closing cmdbar.\
* Fixed an issue where the whisper command was visible in\
commands.\
* Fixed animation glitches with access denied messages.\
* Changed command 'promptpurchase' to 'sell'.\
* Fixed a typo in Invalid Music/Prefix message.\
* Reduced the amount of whitespace of the top of the scroll\
GUI. The Scrolling GUI should look more organized.\
* Fixed an issue where opening explorer caused slight latency.\
* Reduced the amount of whitespace in error log GUI.\
* Reduced the amount of whitespace at the bottom of scroll\
GUI.\
* Fixed an issue where DMC would display 'table: 3223AD84'\
in the developer console after executing changelogs.\
* Removed shootingstars, and rekt commands from DMC since\
it's not even complete, and is full of bugs.\
\ \
Revision 225 Version 2: \
\ \
What's new:\
* Introducing a brand new UI look across the admin system!\
* Descriptions in some UI wont animate, instead by\
fading in.\
* Teleportation message will go away in a couple of\
seconds instead of 30.\
* Changed AssetID to now show as ID.\
* When someone says help, it doesn't trigger the Commands\
command.\
* Added more commands to the admin system.\
* Whenever DMC encounters an error, it now logs the specific\
error, to the errors command.\
* Chatlogs should be able to pick up the last chat said by\
said player.\
* Any DMC Revisions that is unstable will be warned when\
a player joins. This is to keep in mind that the revision\
of DMC will be reverted back to the stable release.\
\ \
What's fixed:\
* Fixed an issue where the place teleportation UI would\
animate twice instead of once.\
* Fixed an issue where typing in cmds, or commands opened the\
Commands UI twice.\
* Fixed an issue where it was possible to set time past 24,\
or with a negative number which causes an\
unexpected DMC error.\
* Fixed an issue where typing in point, or wave caused\
an unknown command UI to show up, even though\
it's a ROBLOX core command.\
\ \
Revision 175 Version 1.3: \
\ \
* Reduced the GUI white space, by reducing the size of the\
scroll GUI. Specifically the bottom GUI.\
* Whoever executed commands silently, displayed a [WITH /E]\
string in the logs. It has been changed to [SILENT EXECUTION]\
instead.\
* Changed log string, such as cmdbar, etc.\
* Changed the command error, and console error title.\
* During hint countdown, when a number reaches below 2, its string\
is changed into second, rather than seconds.\
* Changed the Scrolling Frame animation, so each text animate\
in one time as an entire object.\
* Removed some core commands, I have no clue how that\
ended up there.\
* Fixed the gear command being switched to gear 'ID' 'player'\
it has now been reverted back to the original command.\
* Fixed a bug where adding string after the countdown number,\
such as /countdown 5 seconds, or /hcountdown 5 seconds\
resulted in visual glitches by having the second string being\
visible, with the countdown number.\
* Added stop command; Use it to abort looping commands,\
shutdown, or stopping countdowns.\
* Scroll GUI now have descriptions that remain on top, without\
being affected by scrolling. (Some Scroll GUI that has a\
description will show).\
\ \
Revision 153 Version 1.1:\
\ \
* Fixed an issue where displaying cmds displayed a debugging\
message.\
* Fixed a visual glitch where text would appear cut off at the\
bottom.\
* Fixed an issue where using the char command didn't change\
the characteristics, due to ROBLOX API change.\
* Fixed an issue where ROBLOX chat commands displayed an\
unknown command, such as toggling chat help, team chat, etc.\
* Fixed a visual glitch where chat logs texts were unexpectily\
big.\
* Fixed an issue where using DMC with Adonis caused players\
to be kicked unexpectly.\
* Fixed an issue where if developers turned off\
ResetGuiOnRespawn caused the fly/noclip script\
to no longer function whenever the player\
resets their character.\
* You can now execute commands silently! Use /e and then the\
command after it. It doesn't require a prefix to\
be used.\
* Fixed an issue where requesting music caused an error, such as AdmiMusic\
is not a valid member of... etc.\
\ \
Revision 105 Version 1:\
\ \
What's new:\
* Made the topbar (hint) display longer rather than 3 seconds.\
* Fixed topbar rotation bug when executing some commands.\
* Fixed visual issue with command bar.\
* The now playing text shows the song's asset ID.\
* Made the UI a bit darker.\
* Changed icons in some GUIs.\
* Removed debugging messages found in the developer\
console.\
* Fixed many exploit vulnerabilities.\
* Users without admin cannot view admin list, chat logs, ban list,\
and execute cmdbar.\
* Fixed an issue where the Private Message dialog box appear\
when PM'ing someone.\
* Improved music buffering algorithmn (now 70% quicker).\
* Fixed an issue where changing ambient color were impossible\
and buggy.\
\ \
Revision: 95\
\ \
What's new:\
* Requesting music is quicker.\
* UI Fixes.\
* Made the scroll bar thicker.\
* Made the topbar (hint message) display longer.\
* Made the Console Error window easier to read\
but remaning its funny rotation.\
* Cmdbar added!\
* Explorer has been added! Thanks to whoever\
made Dex_Explorer!\
* [Exploit Vulnerability]: Fixed an issue where hackers can\
remove, or modify the DMC UI Handler script. The parent is to\
remain locked.\
* [Exploit Vulnerability]: Fixed an issue where clients can\
use :FireServer() on any events without a decryption code\
resulting in a crash, and ban.\
* Unknown command UI has a different color.\
* Removed 'e', 'console', and 'clear' from the command\
list, because it's all roblox functions, and not DMC's.\
\ \
Revision: 88\
\ \
What's new:\
*Chatlogs has been added!\
*Improved kick/ban messages.\
*Fixed typo 'Adminsed' when superadmining someone.\
*Fixed grammar for the char command, now it shows up\
as 'Changed the characteristics of..' rather than characters.\
*Changing characteristics no longer respawns you, instead\
you will be at the exact location.\
*Fixed an issue where typing /tryme will show a small GUI,\
and not play the animation, resulting in a error in the dev\
console.\
*Added filtering to console logs.\
*Fixed an issue where if someone would to request a song\
quickly, would result in the song fading in-out rapidly.\
*You will no longer see this text 'Blur effects disabled;\
Visual effects are enabled.' when visualizer is enabled.\
in the developer console.\
*Fixed an issue where pressing q while nocliping resulted\
in inverted controls.\
*UI Animation made smoother, and tweaked.\
*Fixed an issue where if you were to unban someone\
rather than showing its name, it showed up as a number.\
*More songs added to preset. You're welcome.\
*New scrolling method! No more scroll buttons!\
*Improved music buffering algorithm.\
\ \
Revision: 72\
\ \
What's new:\
*More songs added to music preset.\
*When someone requests a song to be played, it will\
first buffer the requested song before stopping the\
current song.\
*Fixed an issue where the examples seen in Commands\
didn't use the correct user-set prefix, instead it shows up\
as a slash.\
*Fixed a visual glitch where the blur effect in the GUIs would\
glitch if you were to drag the UI under a terrain.\
*Fixed an issue where the char command didn't work as\
expected.\
*Fixed an issue where typing in chatlogs, errors the console.\
*Fixed an issue where if you were to type in place 'PlayerName'\
without any game ID will result in an error.\
*If a console error occurred, a new UI color has been added.\
*UI animations tweaked\
*Fixed a visual glitch with the topbar being 100% transparent\
if someone triggers the topbar again, specifically the hint\
command.\
*Added changelogs.\
\ \
Revision: 65\
\ \
What's new:\
*Fixed an issue where if you were to type in /songinfo without any\
music playing, will result in a error to the console.\
*Fixed an issue where DMC wouldn't load its UI correctly.\
*Filtering has been added to comply with ROBLOX rules.\
"
}
