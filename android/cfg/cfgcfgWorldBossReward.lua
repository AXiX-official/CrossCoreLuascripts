local conf = {
	["filename"] = 'b-世界boss表.xlsx',
	["sheetname"] = 'boss排行奖励',
	["types"] = {
'int','string','string','table#3','int','int[]','json','table#3','int','int','json'
},
	["names"] = {
'id','key','name','tRankReward','index','nRank','tReward','tDamageReward','index','nDamage','tReward'
},
	["data"] = {
{'1001',	'',	'BOSS1排行奖励',	'',	'',	'',	'',	'',	'',	'',	''},
{'1001',	'',	'',	'',	'1',	'1,10',	'[[11002,1],[10002,200]]',	'',	'1',	'10000',	'[[11002,1],[10002,200]]'},
{'1001',	'',	'',	'',	'2',	'11,20',	'[[11002,1],[10002,200]]',	'',	'2',	'20000',	'[[11002,1],[10002,200]]'},
{'1001',	'',	'',	'',	'3',	'21,30',	'[[11002,1],[10002,200]]',	'',	'',	'',	''},
},
}
--cfgcfgWorldBossReward = conf
return conf
