local conf = {
	["filename"] = 'j-卡牌角色.xlsx',
	["sheetname"] = '卡牌角色CG',
	["types"] = {
'string','string','table#5','int','string','string','int','string'
},
	["names"] = {
'id','key','infos','index','sName','sDesc','unlock_id','cg_icon'
},
	["data"] = {
{'10010',	'1001_Alps',	'',	'',	'',	'',	'',	''},
{'10010',	'1001_Alps',	'',	'1',	'test',	'',	'',	'CG_test1'},
{'10010',	'1001_Alps',	'',	'2',	'test',	'',	'',	'CG_test2'},
{'10010',	'1001_Alps',	'',	'3',	'test',	'',	'',	'CG_test3'},
{'10010',	'1001_Alps',	'',	'4',	'test',	'',	'',	'CG_test4'},
},
}
--cfgCfgCardRoleCG = conf
return conf
