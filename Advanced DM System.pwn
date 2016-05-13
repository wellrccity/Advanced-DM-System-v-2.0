/* Advanced Dm Fs By Sreyas V 2.0 Forum Account http://forum.sa-mp.com/member.php?u=268427
________________________________________________________________________________
Please Dont Remove Credits
Author:Sreyas
---------------------------------------------
||||||||||||||||||Change LOGS||||||||||||||||||||||||||||||||
------------------------------------------------------------|
Version 2.0                                                 |
*Added 6 more dm zones (now total 10 zones)                 |
*Added Dilaog with player list                              |
*Added Headshot system can be switched by rcon admins       |
*Added Hitsound Feature can be switched by Players          |
*Added Textdraws for Showing Current Mode                   |
*Optmised the code much                                     |
*Making Dms are now is Hell Easy                            |
*Added Feature for Blocking CMDS in DM                      |
*Added Musics for each dm                                   |
*Added DM chat.Now players in DM can chat prefixing '#'     |
*Added Killstreak System                                    |
*and more features                                          |
*Fixed all Bugs in previous version                         |
                                                            |
------------------------------------------------------------|
Version 1.0                                                 |
*Simple system                                              |
*4 dm zones                                                 |
*command dialogs                                            |
*Random spawns                                              |
------------------------------------------------------------|
*/

#define FILTERSCRIPT


#include<a_samp>
#include<zcmd>


#define RED "{FF0000}"
#define GREY "{C0C4C4}"
#define ORANGE "{F07F1D}"
#define WHITE "{FFFFFF}"
#define DIALOG_DM 345
enum dminfo
{
	indm,
	dmzone,
	DMScore,
}
new hshot=0;
new hsound[MAX_PLAYERS];
new Text:Textdraw0;
new Text:Textdraw1[MAX_PLAYERS];
new killstreak[MAX_PLAYERS];
new Info[MAX_PLAYERS][dminfo];

public OnFilterScriptInit()
{
	
	printf("----------------------------------------------");
	printf("|  Advanced Dm system v 2.0 By Sreyas Loaded |");
	printf("----------------------------------------------");
	
	Textdraw0 = TextDrawCreate(350.000000, 420.000000, "CurrentMode");
	TextDrawBackgroundColor(Textdraw0, 255);
	TextDrawFont(Textdraw0, 3);
	TextDrawLetterSize(Textdraw0, 0.500000, 1.200000);
	TextDrawColor(Textdraw0, -65281);
	TextDrawSetOutline(Textdraw0, 1);
	TextDrawUseBox(Textdraw0, 1);
	TextDrawBoxColor(Textdraw0, 255);
	TextDrawTextSize(Textdraw0, 658.000000, 278.000000);
	
	
	
	return 1;
}

public OnFilterScriptExit()
{
	printf("----------------------------------------------");
	printf("|Advanced Dm system v 2.0 By Sreyas Unloaded |");
	printf("----------------------------------------------");
	TextDrawHideForAll(Textdraw0);
	TextDrawDestroy(Textdraw0);
	
	return 1;
}

public OnPlayerSpawn(playerid)
{
	
	if (Info[playerid][indm] == 1)
	{
		respawnindm(playerid);
	}
	return 1;
}


public OnPlayerCommandReceived(playerid, cmdtext[])
{
	
	if(Info[playerid][indm] == 1 )
	{
		//ADD "ALLOWED" CMDS BELOW!!--------------------------------------------------------------------------------
		if(!strfind(cmdtext, "/leave")) return 1;
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
 		else if(!strfind(cmdtext, "/hitsound")) return 1;
  		else if(!strfind(cmdtext, "/headshot")) return 1;
		//---------------------------------------------------------------------------------------------------------
		GameTextForPlayer(playerid, "~w~You are not in Freeroam ~r~/leave ~w~to Exit", 5000, 5);
		
		return 0;
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_DM)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:return cmd_de(playerid);
				case 1:return cmd_rw(playerid);
				case 2:return cmd_sos(playerid);
				case 3:return cmd_snipedm(playerid);
				case 4:return cmd_sos2(playerid);
				case 5:return cmd_snipedm2(playerid);
				case 6:return cmd_shotdm(playerid);
				case 7:return cmd_mini(playerid);
				case 8:return cmd_wz(playerid);
				case 9:return cmd_shipdm(playerid);
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	
	if(text[0] == '#' && Info[playerid][indm] == 1)
	{
		new str[128], name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		format(str, sizeof(str), ""RED"[DM CHAT]"ORANGE" %s: "WHITE"%s", name, text[1]);
		
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(!IsPlayerConnected(i)) continue;
			if(Info[i][indm] == 0 )continue;
			
			SendClientMessage(i, -1, str);
		}
		
		return 0;
	}
	return 1;
}


public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	
	if(hsound[issuerid] != 0)
	{
		PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
	}
	if (hshot ==1 && Info[playerid][indm] == 1)
	{
		if(weaponid == 24 || weaponid == 34)
		{
			if(bodypart == 9)
			{
				SetPlayerHealth(playerid, 0);
				GameTextForPlayer(issuerid,"~r~Headshot",2000,3);
				GameTextForPlayer(playerid,"~r~Headshot",2000,3);
				PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
				PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
			}
		}
	}
	return 1;
}

public OnPlayerDeath(playerid,killerid,reason)
{
	new str[128];
	new name[32];
	GetPlayerName(killerid,name,32);
	if(Info[playerid][indm] == 1)
	{
		respawnindm(playerid);
		killstreak[killerid]++;
		killstreak[playerid] = 0;
	}
	
	switch(killstreak[killerid])
	{
		
		case 3:
		{
			
			format(str,sizeof(str),""RED"[DM]"ORANGE" %s "GREY"is now "WHITE"Killing Spree"GREY"!!",name);
			SendClientMessageToAll(-1,str);
		}
		case 5:
		{
			format(str,sizeof(str),""RED"[DM]"ORANGE" %s "GREY"is now "WHITE"Dominating!!"GREY"!!",name);
			SendClientMessageToAll(-1,str);
		}
		case 6:
		{
			format(str,sizeof(str),""RED"[DM]"ORANGE" %s "GREY"is now "WHITE"UnStoppable!!"GREY"!!",name);
			SendClientMessageToAll(-1,str);
		}
		case 7:
		{
			format(str,sizeof(str),""RED"[DM]"ORANGE" %s "GREY"is now "WHITE"Wicked Sick!!"GREY"!!",name);
			SendClientMessageToAll(-1,str);
		}
		case 8:
		{
			format(str,sizeof(str),""RED"[DM]"ORANGE" %s "GREY"is now "WHITE"Monster like!!"GREY"!!",name);
			SendClientMessageToAll(-1,str);
		}
		case 9:
		{
			format(str,sizeof(str),""RED"[DM]"ORANGE" %s "GREY"is now "WHITE"GOD LIKE!!"GREY"!!",name);
			SendClientMessageToAll(-1,str);
		}
		case 10:
		{
			format(str,sizeof(str),""RED"[DM]"ORANGE" %s "GREY"is now "WHITE"Immortal!!"GREY"!!",name);
			SendClientMessageToAll(-1,str);
			SetPlayerArmour(killerid,100);
		}
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	
	createtext(playerid,"Freeroam");
	
	hsound[playerid] = 0;
	TextDrawShowForPlayer(playerid, Textdraw0);
	TextDrawShowForPlayer(playerid, Textdraw1[playerid]);
	Info[playerid][indm] = 0;
	killstreak[playerid] = 0;
	return 1;
}

new Float:RandomSpawnsDE[][] =
{
	
	{242.5503,176.5623,1003.0300,93.6148},
	{240.5619,195.8680,1008.1719,91.7114},
	{253.4729,190.7446,1008.1719,115.2117},
	{288.745971, 169.350997, 1007.171875}
	
	
};

new Float:RandomSpawnsRW[][] =
{
	{1360.0864,-21.3368,1007.8828,183.3211},
	{1402.2295,-33.9128,1007.8819,273.5619},
	{253.4729,190.7446,1008.1719,115.2117}, 
	{1361.5745,-47.8980,1000.9238,104.6970}
	
};

new Float:RandomSpawnsSOS[][] =
{
	{-1053.9221,1022.5436,1343.1633,286.6894},
	{-975.975708,1060.983032,1345.671875},
	{-1131.4167,1042.4703,1345.7369,230.2888}
};


new Float:RandomSpawnsSNIPE[][] =
{
	{-2640.762939, 1406.682006, 906.460937},
	{-2664.6062,1392.3625,912.4063,60.4372},    
	{-2670.5549,1425.4402,912.4063,179.1681}
};


new Float:RandomSpawnsSOS2[][] =
{
	{1322.2629,2753.8525,10.8203,67.4993},
	{1197.6454,2795.0579,10.8203,13.2921},
	{1365.6454,2809.0579,10.8203,13.2921}
	
};

new Float:RandomSpawnsSHOT[][] =
{
	{2205.2983,1553.3098,1008.3852,275.1326},
	{2172.6226,1577.2854,999.9670,186.4819},
	{2188.4739,1619.3770,999.9766,0.0467},
	{2218.1841,1615.2228,999.9827,334.6665}
};

new Float:RandomSpawnsSNIPE2[][] =
{
	{2209.0427,1063.0984,71.3284,328.9798 },
	{2217.0649,1091.5931,29.5850,346.5500 },
	{2286.3674,1171.7701,85.9375,151.3414 },
	{2289.5737,1054.5160,26.7031,240.9556 }
};


new Float:RandomSpawnsMINI[][] =
{
	{-2356.9077,1539.1139,26.0469,84.7713 },
	{-2367.2000,1541.5798,17.3281,10.1972  },
	
	{-2388.3159,1543.0730,26.0469,185.8829 },
	{-2411.0122,1547.8350,26.0469,280.8965 },
	{-2423.4104,1547.9592,23.1406,96.9681},
	{-2434.5415,1544.7043,8.3984,289.0432},
	{-2392.1448,1548.3545,2.1172,183.7622 },
	{-2435.7583,1538.8330,11.7656,274.9664},
	{-2373.3687,1551.5563,2.1172,133.3617},
	{-2372.2913,1537.6198,10.8209,28.3940}
};

new Float:RandomSpawnsWZ[][] =
{
	{241.3928,1873.1758,11.4531,273.7038},
	{254.0595,1861.3322,8.7578,140.2225},
	{253.7986,1817.8022,4.7175,82.2553},
	{243.0909,1802.6503,7.4141,45.5949},
	{217.8072,1823.2727,6.4141,246.4435},
	{264.9873,1843.3636,7.5076,50.9452},
	{245.5841,1824.6747,7.5547,280.2840},
	{314.2634,1847.7885,7.7266,284.6707},
	{261.1926,1883.6488,8.4375,272.7639},
	{271.4502,1878.3483,-2.4125,41.3287},
	{267.2027,1878.4490,-22.9237,358.2578},
	{268.9091,1883.4457,-30.0938,224.7766},
	{273.5457,1855.9456,8.7649,61.2620},
	{274.8059,1871.2070,8.7578,227.9569},
	{296.7946,1865.6255,8.6411,223.1364}
};

new Float:RandomSpawnsSHIP[][] =
{
	{-1334.0657,512.9581,11.1953,51.5368},
	{-1342.2621,498.1203,11.1953,274.9456},
	{-1296.5226,505.3504,11.1953,133.9676},
	{-1368.6232,517.2023,11.1971,44.0400},
	{-1396.0570,498.9916,11.2026,322.5726}
};

CMD:de(playerid)
{
	
	PlayAudioStreamForPlayer(playerid, "https://api.soundcloud.com/tracks/92808996/stream?client_id=6fe9ed8a7148a74c9cedcb2e11c0639b");
	new Random = random(sizeof(RandomSpawnsDE));
	createdm(playerid,RandomSpawnsDE[Random][0], RandomSpawnsDE[Random][1], RandomSpawnsDE[Random][2], RandomSpawnsDE[Random][3],3,1,1,24,25,100,"~r~DEAGLE DM");
	createtext(playerid,"Deagle DM");
	
	return 1;
}

CMD:rw(playerid)
{
	PlayAudioStreamForPlayer(playerid,"https://api.soundcloud.com/tracks/81448034/stream?client_id=6fe9ed8a7148a74c9cedcb2e11c0639b");
	new Random = random(sizeof(RandomSpawnsRW));
	createdm(playerid,RandomSpawnsRW[Random][0], RandomSpawnsRW[Random][1], RandomSpawnsRW[Random][2], RandomSpawnsRW[Random][3],1,2,2,26,28,100,"~r~Running Weapons DM!");
	createtext(playerid,"Running Dm");
	return 1;
}

CMD:sos(playerid)
{
	PlayAudioStreamForPlayer(playerid,"http://cache.glujar.com/1724_4958_O104_8958_79/prometheus-rising-(immediate-music).mp3");
	new Random = random(sizeof(RandomSpawnsSOS));
	createdm(playerid,RandomSpawnsSOS[Random][0], RandomSpawnsSOS[Random][1], RandomSpawnsSOS[Random][2], RandomSpawnsSOS[Random][3],10,3,3,26,32,100,"~r~Sawn-Off DM!");
	createtext(playerid,"Sawnoff DM");
	return 1;
}

CMD:snipedm(playerid)
{
	
	PlayAudioStreamForPlayer(playerid,"https://api.soundcloud.com/tracks/58313369/stream?client_id=6fe9ed8a7148a74c9cedcb2e11c0639b");
	new Random = random(sizeof(RandomSpawnsSNIPE));
	createdm(playerid,RandomSpawnsSNIPE[Random][0], RandomSpawnsSNIPE[Random][1], RandomSpawnsSNIPE[Random][2], RandomSpawnsSNIPE[Random][3],3,4,4,25,34,100,"~r~Sniper DM!");
	createtext(playerid,"Sniper DM");
	return 1;
}

CMD:sos2(playerid)
{
	PlayAudioStreamForPlayer(playerid,"http://c.mp3fly.in/get.php?id=d1MijkVrf50&name=Bleach+OST+-+Quincys+Craft+%5BHQ%5D+%5BExtended%5D&hash=9841f31eb9bccfd7b187dec7b0bb21ac3d006d0e&expire=1460101802");
	new Random = random(sizeof(RandomSpawnsSOS2));
	createdm(playerid,RandomSpawnsSOS2[Random][0], RandomSpawnsSOS2[Random][1], RandomSpawnsSOS2[Random][2], RandomSpawnsSOS2[Random][3],0,5,5,26,0,100, "~r~Sawn Off DM 2");
	createtext(playerid,"Sawn off 2 DM");
	return 1;
}

CMD:shotdm(playerid)
{
	
	PlayAudioStreamForPlayer(playerid,"https://api.soundcloud.com/tracks/81448034/stream?client_id=6fe9ed8a7148a74c9cedcb2e11c0639b");
	new Random = random(sizeof(RandomSpawnsSHOT));
	createdm(playerid,RandomSpawnsSHOT[Random][0], RandomSpawnsSHOT[Random][1], RandomSpawnsSHOT[Random][2], RandomSpawnsSHOT[Random][3],1,6,6,27,0,100, "~r~Shot GUN DM");
	createtext(playerid,"Shotgun DM");
	return 1;
}

CMD:snipedm2(playerid)
{
	PlayAudioStreamForPlayer(playerid,"http://a.tumblr.com/tumblr_me4ljiCUkS1qcbq9jo1.mp3");
	new Random = random(sizeof(RandomSpawnsSNIPE2));
	createdm(playerid,RandomSpawnsSNIPE2[Random][0], RandomSpawnsSNIPE2[Random][1], RandomSpawnsSNIPE2[Random][2], RandomSpawnsSNIPE2[Random][3],0,7,7,34,0,100,"~r~Sniper Off DM 2");
	createtext(playerid,"Sniper 2 DM");
	return 1;
}

CMD:mini(playerid)
{
	
	PlayAudioStreamForPlayer(playerid,"https://api.soundcloud.com/tracks/131876344/stream?client_id=6fe9ed8a7148a74c9cedcb2e11c0639b");
	new Random = random(sizeof(RandomSpawnsMINI));
	createdm(playerid,RandomSpawnsMINI[Random][0], RandomSpawnsMINI[Random][1], RandomSpawnsMINI[Random][2], RandomSpawnsMINI[Random][3],0,8,8,38,0,100,"~r~MINIGUN DM");
	createtext(playerid,"MiniGun DM");
	return 1;
}
CMD:wz(playerid)
{
	PlayAudioStreamForPlayer(playerid,"http://216.227.134.162/ost/bleach-original-soundtrack-i/ghoerkxghd/20-storm-center.mp3");
	new Random = random(sizeof(RandomSpawnsWZ));
	createdm(playerid,RandomSpawnsWZ[Random][0], RandomSpawnsWZ[Random][1], RandomSpawnsWZ[Random][2], RandomSpawnsWZ[Random][3],0,9,9,31,16,100,"~r~War Zone");
	createtext(playerid,"Warzone DM");
	return 1;
}

CMD:shipdm(playerid)
{
	PlayAudioStreamForPlayer(playerid,"https://api.soundcloud.com/tracks/114534810/stream?client_id=6fe9ed8a7148a74c9cedcb2e11c0639b");
	new Random = random(sizeof(RandomSpawnsSHIP));
	createdm(playerid,RandomSpawnsSHIP[Random][0], RandomSpawnsSHIP[Random][1], RandomSpawnsSHIP[Random][2], RandomSpawnsSHIP[Random][3],0,10,10,23,29,100,"~r~Ship DM");
	createtext(playerid,"Ship DM");
	return 1;
}
CMD:leave ( playerid )
{
	
	
	
	if ( Info[playerid][indm] == 0 )
	{
		SendClientMessage(playerid, -1, ""RED"ERROR: "GREY"You are not in a deathmatch arena!" );
		return 1;
	}
	if ( Info[playerid][indm] == 1 )
	{
		
		Info[playerid][indm] = 0;
		Info[playerid][dmzone] = 0;
		
		
		SetPlayerVirtualWorld(playerid, 0);
		SpawnPlayer(playerid);
		
		SetPlayerInterior(playerid,0);
		SendClientMessage(playerid, -1, ""RED"[DM] "GREY"You have left the deathmatch arena!" );
		
		StopAudioStreamForPlayer(playerid);
		
		SetCameraBehindPlayer(playerid);
		createtext(playerid,"Freeroam");
		return 1;
	}
	
	return 1;
}



CMD:dm(playerid)
{
	new string[900],pde,prw,psos,psnipe,psos2,psnipe2,pshot,pmini,pwz,pship;
	
	for(new i=0;i<MAX_PLAYERS;i++)//sorry for using for loop some bug appeared in foreach thats why
	{
		if(IsPlayerConnected(i))
		{
			switch(Info[i][dmzone])
			{
				
				case 1:pde++;
				case 2:prw++;
				case 3:psos++;
				case 4:psnipe++;
				case 5:psos2++;
				case 6:pshot++;
				case 7:psnipe2++;
				case 8:pmini++;
				case 9:pwz++;
				case 10:pship++;
			}
		}
	}
	
	format(string,sizeof(string),
	""ORANGE"Map\t"ORANGE"Players\n\
	"WHITE"Deagle (/de)\t%d\n\
	Running Weapons (/rw)\t%d\n\
	Sawn-Off Shotgun (/sos)\t%d\n\
	Sniper (/sniperdm)\t%d\n\
	Sawn-Off Shotgun 2(/sos2)\t%d\n\
	Sniper DM 2 (/snipedm2)\t%d\n\
	ShotGun DM (/shotdm)\t%d\n\
	MiniGun DM (/mini)\t%d\n\
	War Zone (/wz)\t%d\n\
	Ship DM (/shipdm)\t%d\n",pde,prw,psos,psnipe,psos2,psnipe2,pshot,pmini,pwz,pship);
	printf("pde = %d",pde);
	printf("indm = %d",Info[playerid][indm]);
	printf("zone = %d",Info[playerid][dmzone]);
	ShowPlayerDialog(playerid, DIALOG_DM,  DIALOG_STYLE_TABLIST_HEADERS, ""RED"BFE Deathmatch",string, "Select","Cancel");
	return 1;
}


CMD:headshot(playerid)
{
	if(!IsPlayerAdmin(playerid))return  SendClientMessage(playerid,-1,""RED"You are not Authorised to use this Command! ");
	if(hshot == 1)
	{
		hshot = 0;
		SendClientMessageToAll(-1,""RED"Headshot Turned OFF By Admin ");
		return 1;
	}
	
	if(hshot == 0)
	{
		hshot=1;
		SendClientMessageToAll(-1,""RED"Headshot Turned ON By Admin ");
		return 1;
	}
	return 1;
}


CMD:hitsound(playerid)
{
	if(hsound[playerid] == 0)
	{
		SendClientMessage(playerid,-1,""ORANGE"HITSOUND TURNED "RED"ON");
		hsound[playerid] = 1;
		return 1;
	}
	if(hsound[playerid] == 1)
	{
		SendClientMessage(playerid,-1,""ORANGE"HITSOUND TURNED "RED"OFF");
		hsound[playerid] = 0;
		return 1;
	}
	return 1;
}



SetPlayerPosition (playerid, Float:X, Float:Y, Float:Z, Float:A)
{
	SetPlayerPos(playerid, X, Y, Z);
	SetPlayerFacingAngle(playerid, A);
}

createdm(playerid,Float:X,Float:Y,Float:Z,Float:A,interior,virtualworld,zone,weapon1,weapon2,health,text[])
{
	
	Info[playerid][indm] = 1;
	Info[playerid][dmzone] = zone;
	
	
	
	if (IsPlayerInAnyVehicle(playerid))
	{
		RemovePlayerFromVehicle(playerid);
	}
	SetPlayerPosition(playerid, X,Y,Z,A);
	SetPlayerInterior(playerid, interior);
	ResetPlayerWeapons(playerid);
	GameTextForPlayer(playerid, text, 2000, 3);
	SetPlayerFacingAngle(playerid, A);
	SetPlayerHealth(playerid, health);
	GivePlayerWeapon(playerid, weapon1, 100000);
	GivePlayerWeapon(playerid, weapon2, 100000);
	SetPlayerVirtualWorld(playerid, virtualworld);
	
	return 1;
}


respawnindm(playerid)
{
	switch (Info[playerid][dmzone])
	
	{
		
		case 1:
		{
			new Random = random(sizeof(RandomSpawnsDE));
			createdm(playerid,RandomSpawnsDE[Random][0], RandomSpawnsDE[Random][1], RandomSpawnsDE[Random][2], RandomSpawnsDE[Random][3],3,1,1,24,25,100,"");
			
		}
		
		case 2:
		{
			new Random = random(sizeof(RandomSpawnsRW));
			createdm(playerid,RandomSpawnsRW[Random][0], RandomSpawnsRW[Random][1], RandomSpawnsRW[Random][2], RandomSpawnsRW[Random][3],1,2,2,26,28,100,"");
			return 1;
		}
		
		case 3:
		{
			new Random = random(sizeof(RandomSpawnsSOS));
			createdm(playerid,RandomSpawnsSOS[Random][0], RandomSpawnsSOS[Random][1], RandomSpawnsSOS[Random][2], RandomSpawnsSOS[Random][3],10,3,3,26,32,100,"");
		}
		
		case 4:
		{
			new Random = random(sizeof(RandomSpawnsSNIPE));
			createdm(playerid,RandomSpawnsSNIPE[Random][0], RandomSpawnsSNIPE[Random][1], RandomSpawnsSNIPE[Random][2], RandomSpawnsSNIPE[Random][3],3,4,4,25,34,100,"");
		}
		case 5:
		{
			new Random = random(sizeof(RandomSpawnsSOS2));
			createdm(playerid,RandomSpawnsSOS2[Random][0], RandomSpawnsSOS2[Random][1], RandomSpawnsSOS2[Random][2], RandomSpawnsSOS2[Random][3],0,5,5,31,16,100,"");
		}
		
		case 6:
		{
			new Random = random(sizeof(RandomSpawnsSHOT));
			createdm(playerid,RandomSpawnsSHOT[Random][0], RandomSpawnsSHOT[Random][1], RandomSpawnsSHOT[Random][2], RandomSpawnsSHOT[Random][3],1,6,6,27,0,100, "");
		}
		
		case 7:
		{
			new Random = random(sizeof(RandomSpawnsSNIPE2));
			createdm(playerid,RandomSpawnsSNIPE2[Random][0], RandomSpawnsSNIPE2[Random][1], RandomSpawnsSNIPE2[Random][2], RandomSpawnsSNIPE2[Random][3],0,7,7,34,0,100,"");
		}
		case 8:
		{
			new Random = random(sizeof(RandomSpawnsMINI));
			createdm(playerid,RandomSpawnsMINI[Random][0], RandomSpawnsMINI[Random][1], RandomSpawnsMINI[Random][2], RandomSpawnsMINI[Random][3],0,8,8,38,0,100,"");
		}
		case 9:
		{
			new Random = random(sizeof(RandomSpawnsWZ));
			createdm(playerid,RandomSpawnsWZ[Random][0], RandomSpawnsWZ[Random][1], RandomSpawnsWZ[Random][2], RandomSpawnsWZ[Random][3],0,9,9,31,16,100,"");
		}
		case 10:
		{
			new Random = random(sizeof(RandomSpawnsSHIP));
			createdm(playerid,RandomSpawnsSHIP[Random][0], RandomSpawnsSHIP[Random][1], RandomSpawnsSHIP[Random][2], RandomSpawnsSHIP[Random][3],0,10,10,23,29,100,"");
		}
	}
	return 1;
}


createtext(playerid,te[])
{
	
	TextDrawHideForPlayer(playerid, Textdraw1[playerid]);
	
	
	Textdraw1[playerid] = TextDrawCreate(469.000000, 420.000000, te);
	TextDrawBackgroundColor(Textdraw1[playerid], 255);
	TextDrawFont(Textdraw1[playerid], 2);
	TextDrawLetterSize(Textdraw1[playerid], 0.519998, 1.200000);
	TextDrawColor(Textdraw1[playerid], -16776961);
	TextDrawSetOutline(Textdraw1[playerid], 0);
	TextDrawSetProportional(Textdraw1[playerid], 1);
	TextDrawSetShadow(Textdraw1[playerid], 1);
	
	TextDrawShowForPlayer(playerid, Textdraw1[playerid]);
	
	return 1;
}
