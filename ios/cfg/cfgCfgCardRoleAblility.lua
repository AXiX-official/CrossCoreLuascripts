local conf = {
	["filename"] = 'j-卡牌角色.xlsx',
	["sheetname"] = '角色能力信息',
	["types"] = {
'string','string','int','int[]'
},
	["names"] = {
'id','key','type','vals'
},
	["data"] = {
{'1001',	'1001',	'1',	'10'},
{'1002',	'1002',	'1',	'20'},
{'2001',	'2001',	'2',	'10,15'},
},
}
cfgCfgCardRoleAblility = conf
return conf
