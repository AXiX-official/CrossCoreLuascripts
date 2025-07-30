local conf = {
	["filename"] = 'r-任务配置表.xlsx',
	["sheetname"] = '多队战斗入场任务',
	["types"] = {
'int','string','int','int','string','string','string','string','int','int[]','json','int','int'
},
	["names"] = {
'id','key','index','nGroup','sName','sDescription','sOpenTime','sCloseTime','nTransferPath','aFinishIds','jAwardId','nIsHide','nRestType'
},
	["data"] = {
{'1',	'1',	'1',	'1',	'累计消耗100燃料',	'累计消耗100燃料',	'2025/8/6 12:00:00',	'2025/08/13 03:00:00',	'10301',	'330001',	'[[10503,1,2]]',	'',	'1'},
{'2',	'2',	'2',	'1',	'累计消耗200燃料',	'累计消耗200燃料',	'2025/8/6 12:00:00',	'2025/08/13 03:00:00',	'10301',	'330002',	'[[10503,1,2]]',	'',	'1'},
{'3',	'3',	'3',	'1',	'累计消耗300燃料',	'累计消耗300燃料',	'2025/8/6 12:00:00',	'2025/08/13 03:00:00',	'10301',	'330003',	'[[10503,1,2]]',	'',	'1'},
},
}
--cfgCfgMultiteamEntrance = conf
return conf
