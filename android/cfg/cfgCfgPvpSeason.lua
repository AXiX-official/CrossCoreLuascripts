local conf = {
	["filename"] = 'j-军演限时.xlsx',
	["sheetname"] = '军演赛季',
	["types"] = {
'int','string','string','string','string','string','string','int','int','string','int[]'
},
	["names"] = {
'id','key','pvpName','startTime','endTime','showTime','img','startBattleTime','endBattleTime','battleTime','pvpBan'
},
	["data"] = {
{'1',	'1',	'第一赛季',	'2025/6/24 00:00:00',	'2025/10/29 00:00:00',	'2025/6/24-2025/10/29',	'img10_14',	'10',	'20',	'10:00-20:00开启',	'10220,30500'},
},
}
--cfgCfgPvpSeason = conf
return conf
