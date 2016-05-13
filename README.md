# Advanced-DM-System-v-2.0

## New features v 2.0
* Added 6 more DM zones (now total 10 zones)
* Added Dilaog with player list
* Added Headshot system can be switched by rcon admins
* Added Hitsound Feature can be switched by Players
* Added Textdraws for Showing Current Mode
* Optmised the code much
* Making Dms are now is Hell Easy
* Added Feature for Blocking CMDS in DM
* Added Musics for each dm
* Added DM chat.Now players in DM can chat prefixing '#'
* Added Killstreak System
* and more features
* Fixed all Bugs in previous version

##DM Zones And Commands

* /de - Deagle DM
* /sos - Sawnoff DM
* /rw - Running Weapons Dm
* /snipedm - Sniper DM
* /sos2 - Sawnoff DM 2
* /snipedm2 - Sniper DM 2
* /shipdm - Ship DM
* /wz - Warzone
* /shotdm - Shot Gun DM
* /mini - Minigun DM

* /histound - turn hitsound [on/off]
* /headshot - turn headshot system [on/off] for rcon admins (Deagle and Sniper only supports) 
* /dm - shows list of dm 

Use '#' inside a dm zone to chat with players in DM
How to Allow Specified CMDS in DM

I used Zcmd callback to block the cmds in dm zone But if you want some cmds to be allowed in the Zone you can add those commands in following lines

```pawn
public OnPlayerCommandReceived(playerid, cmdtext[]) 
{ 
    if(Info[playerid][indm] == 1 ) 
    { 
        //ADD "ALLOWED" CMDS BELOW!!-------------------------------------------------------------------------------- 
        if(!strfind(cmdtext, "/leave")) return 1 
        else if(!strfind(cmdtext, "/dm")) return 1; 
        else if(!strfind(cmdtext, "/de")) return 1; 
        else if(!strfind(cmdtext, "/sos")) return 1; 
        else if(!strfind(cmdtext, "/rw")) return 1; 
        else if(!strfind(cmdtext, "/sos2")) return 1; 
        else if(!strfind(cmdtext, "/snipedm")) return 1; 
        else if(!strfind(cmdtext, "/shotdm")) return 1; 
        else if(!strfind(cmdtext, "/sniepdm2")) return 1; 
        else if(!strfind(cmdtext, "/mini")) return 1; 
        else if(!strfind(cmdtext, "/shipdm")) return 1; 
        else if(!strfind(cmdtext, "/wz")) return 1; 
        //--------------------------------------------------------------------------------------------------------- 
        GameTextForPlayer(playerid, "~w~You are not in Freeroam ~r~/leave ~w~to Exit", 5000, 5); 
        
        return 0; 
    } 
    return 1; 
  }  
  
