local conf = {
	["filename"] = 'k-卡牌配置表.xlsx',
	["sheetname"] = '强化经验暴击配置',
	["types"] = {
'int','string','int','float','string'
},
	["names"] = {
'id','key','weight','rand','describe'
},
	["data"] = {
{'1',	'1',	'1000',	'1',	'不暴击'},
{'2',	'2',	'0',	'1.25',	'小暴击'},
{'3',	'3',	'0',	'1.5',	'大暴击'},
{'4',	'4',	'0',	'2',	'超暴击'},
},
}
--cfgCardExpAddRand = conf
return conf
