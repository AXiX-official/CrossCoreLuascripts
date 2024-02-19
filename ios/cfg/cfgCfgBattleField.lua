local conf = {
	["filename"] = 'h-活动入口开放.xlsx',
	["sheetname"] = '战场系统',
	["types"] = {
'int','string','string','int','int[]','string','int','int','int','int','int'
},
	["names"] = {
'id','key','name','nInitCount','arrEnemy','desc','nBossTime','nBossID','nBossHp','nRankRewardGroup','sectionID'
},
	["data"] = {
{'1000',	'1000',	'拂晓之战',	'10000',	'11001,11002,11003,11004',	'1.出击可进入',	'180',	'11005',	'1000000000',	'1',	'2001'},
},
}
--cfgCfgBattleField = conf
return conf
