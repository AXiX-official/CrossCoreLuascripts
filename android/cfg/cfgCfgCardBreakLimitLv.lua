local conf = {
	["filename"] = 'k-卡牌核心突破.xlsx',
	["sheetname"] = '跃升卡牌等级限制',
	["types"] = {
'int','string','int','int','string','string'
},
	["names"] = {
'id','key','limitLv','MaxLv','Unlockdes1','Unlockdes2'
},
	["data"] = {
{'1',	'1',	'20',	'40',	'卡牌等级达到20级',	'跃升等级达到1级'},
{'2',	'2',	'40',	'60',	'卡牌等级达到40级',	'跃升等级达到2级'},
{'3',	'3',	'60',	'70',	'卡牌等级达到60级',	'跃升等级达到3级'},
{'4',	'4',	'70',	'80',	'卡牌等级达到70级',	'跃升等级达到4级'},
},
}
--cfgCfgCardBreakLimitLv = conf
return conf
