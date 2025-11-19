local conf = {
	["filename"] = 'j-军演限时.xlsx',
	["sheetname"] = '排行榜奖励',
	["types"] = {
'int','string','int[]','string','json','int'
},
	["names"] = {
'id','key','rankNum','rankShowNum','jAward','mailId'
},
	["data"] = {
{'1',	'1',	'1,1',	'1',	'',	'15001'},
{'2',	'2',	'2,10',	'2~10',	'',	'15002'},
{'3',	'3',	'11,50',	'11~50',	'',	'15003'},
{'4',	'4',	'51,100',	'51~100',	'',	'15004'},
{'5',	'5',	'101,1000',	'101~1000',	'',	'15005'},
{'6',	'6',	'1001,999999',	'1000+',	'',	'15006'},
},
}
--cfgCfgPvpRanklistReward = conf
return conf
