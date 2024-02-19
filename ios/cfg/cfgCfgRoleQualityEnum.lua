local conf = {
	["filename"] = 'e-枚举定义表.xlsx',
	["sheetname"] = '角色品质类型',
	["types"] = {
'int','string','int','string'
},
	["names"] = {
'id','key','nQuality','sName'
},
	["data"] = {
{'1',	'1',	'1',	'N'},
{'2',	'2',	'2',	'NH'},
{'3',	'3',	'3',	'R'},
{'4',	'4',	'4',	'SR'},
{'5',	'5',	'5',	'SSR'},
{'6',	'6',	'6',	'UR'},
},
}
cfgCfgRoleQualityEnum = conf
return conf
