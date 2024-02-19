local conf = {
	["filename"] = 'h-活动.xlsx',
	["sheetname"] = '排名奖励',
	["types"] = {
'int','string','table#3','int','int','json'
},
	["names"] = {
'id','key','infos','index','maxRank','rewards'
},
	["data"] = {
{'2001',	'2001',	'',	'',	'',	''},
{'2001',	'2001',	'',	'1',	'3',	'[[10001,1000,2],[10002,50,2]]'},
{'2001',	'2001',	'',	'2',	'4',	'[[10001,1000,2],[10002,50,2]]'},
{'2001',	'2001',	'',	'3',	'10',	'[[10001,1000,2],[10002,50,2]]'},
},
}
--cfgCfgActiveRankReward = conf
return conf
