local conf = {
	["filename"] = 'p-配置表关联表.xlsx',
	["sheetname"] = '主键关联检测表',
	["types"] = {
'int','string','string','string','string','string'
},
	["names"] = {
'id','key','cfgName','cfgFieldKey','cfgFieldKey2','relevance'
},
	["data"] = {
{'1',	'1',	'MainLine',	'reward',	'',	'RewardInfo'},
{'2',	'2',	'MonsterGroup',	'stage',	'monsters',	'MonsterData'},
{'3',	'3',	'CardData',	'halo',	'',	'cfgHalo'},
{'4',	'4',	'CardData',	'tTransfo',	'',	'CardData'},
{'5',	'5',	'CardData',	'coreItemId',	'',	'ItemInfo'},
{'6',	'6',	'CfgFurniture',	'itemId',	'',	'ItemInfo'},
{'7',	'7',	'CfgClothes',	'itemId',	'',	'ItemInfo'},
{'8',	'8',	'CfgGifts',	'itemId',	'',	'ItemInfo'},
{'9',	'9',	'CfgGifts',	'infos',	'index',	'CfgCardRole'},
{'10',	'10',	'CfgTeamBoss',	'bossId',	'',	'MonsterData'},
},
}
--cfgConfigPrimaryKey = conf
return conf
