local conf = {
	["filename"] = 'e-枚举定义表.xlsx',
	["sheetname"] = '角色排序品质',
	["types"] = {
'int','string','string','int','string','string','string','json'
},
	["names"] = {
'id','key','sName','nQuality','sCreate_bg','sDesc1','sDesc2','sortIcon'
},
	["data"] = {
{'1',	'1',	'3星',	'3',	'blue',	'w_rare',	'RARE',	'[[0,"RoleCard_BG/img_01_03",0.75,0.5]]'},
{'2',	'2',	'4星',	'4',	'red',	'w_super_rare',	'SUPER RARE',	'[[0,"RoleCard_BG/img_01_04",0.75,0.5]]'},
{'3',	'3',	'5星',	'5',	'yellow',	'w_premium_rare',	'SUPERIOR\nSUPER RARE',	'[[0,"RoleCard_BG/img_01_05",0.75,0.5]]'},
{'4',	'4',	'6星',	'6',	'yellow',	'w_premium_rare',	'SUPERIOR\nSUPER RARE',	'[[0,"RoleCard_BG/img_01_06",0.75,0.5]]'},
},
}
--cfgCfgCardSortQuality = conf
return conf
