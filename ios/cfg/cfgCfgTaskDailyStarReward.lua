local conf = {
	["filename"] = 'r-任务配置表.xlsx',
	["sheetname"] = '每日任务星数奖励',
	["types"] = {
'int','string','int','json'
},
	["names"] = {
'id','key','star','jAwardId'
},
	["data"] = {
{'1',	'1',	'1',	'[[10013,15,2],[10036,6,2]]'},
{'2',	'2',	'2',	'[[58008,1,2],[10003,2000,2]]'},
{'3',	'3',	'3',	'[[60102,50,2],[60103,50,2]]'},
{'4',	'4',	'4',	'[[60101,400,2],[2000101,2,2]]'},
{'5',	'5',	'6',	'[[15001,2,2],[10001,8000,2]]'},
{'6',	'6',	'8',	'[[60104,1,2],[10003,8000,2]]'},
{'7',	'7',	'10',	'[[10011,20,2],[60105,1,2]]'},
{'8',	'8',	'12',	'[[10040,90,2],[60106,1,2],[10036,6,2]]'},
},
}
--cfgCfgTaskDailyStarReward = conf
return conf
