local conf = {
	["filename"] = 'e-枚举定义表.xlsx',
	["sheetname"] = '角色排序方式',
	["types"] = {
'int','string','string','int[]','string'
},
	["names"] = {
'id','key','sName','rolePro','icon'
},
	["data"] = {
{'1',	'1',	'稀有度',	'',	''},
{'2',	'2',	'等级',	'',	''},
{'3',	'3',	'好感度',	'',	'sort_03'},
{'4',	'4',	'入手顺序',	'',	''},
{'5',	'5',	'性能',	'',	'sort_05'},
{'6',	'6',	'属性',	'2,1,3,4,5,6,7,8',	''},
},
}
--cfgCfgRoleSortEnum = conf
return conf
