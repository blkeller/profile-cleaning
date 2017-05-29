# profile-cleaning
## Tools for deleting user profiles & data in bulk

This a small collection of scripts I put together a while ago to clean user profiles from shared lab computers in an automated fashion.  I figured I'd publish them here in case anyone else might find them useful.

### *Warning:* every script here is designed to *delete* large quantities of data with a minimum of effort!
Don't double-click on any script here unless you understand what the code does and you intend to wipe a whole lot of user data from a computer.

Before executing these scripts, you will likely want to customize them to better match your environment.  A list of user account names that should *not* be wiped is hard-coded into each script.  If a user account is found that is not on the list, it gets removed from the system, and all data in that user's home folder gets deleted.  I recommend testing your custom list by commenting out all of the lines that perform destructive actions, running the script, and seeing if the list of would-be deleted accounts matches your expectations.

Three flavors of profile cleaning script are available:
- Windows 7
- Windows XP
- Mac OS X (written and tested on 10.9 "Mavericks")
