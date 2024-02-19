local conf = {
	["filename"] = 'z-装备配置表.xlsx',
	["sheetname"] = '强化经验暴',
	["types"] = {
'int','string','int','float','string'
},
	["names"] = {
'id','key','nWeight','fRand','sDescribe'
},
	["data"] = {
{'1',	'1',	'100',	'1',	'不暴击'},
{'2',	'2',	'0',	'1.5',	'小暴击'},
{'3',	'3',	'0',	'2',	'大暴击'},
{'4',	'4',	'0',	'3',	'超暴击'},
},
}
--cfgCfgEquipExpRand = conf
return conf
