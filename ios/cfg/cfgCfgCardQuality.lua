local conf = {
	["filename"] = 'e-枚举定义表.xlsx',
	["sheetname"] = '角色品质类型',
	["types"] = {
'int','string','string','int','string','string','string','json'
},
	["names"] = {
'id','key','sName','nQuality','sCreate_bg','sDesc1','sDesc2','sortIcon'
},
	["data"] = {
{'1',	'1',	'1星',	'1',	'white_ash',	'w_ordinary',	'NORMAL',	''},
{'2',	'2',	'2星',	'2',	'white_ash',	'w_ordinary',	'NORMAL',	''},
{'3',	'3',	'3星',	'3',	'blue',	'w_rare',	'RERE',	''},
{'4',	'4',	'4星',	'4',	'red',	'w_super_rare',	'SUPER RARE',	''},
{'5',	'5',	'5星',	'5',	'yellow',	'w_premium_rare',	'SUPERIOR\nSUPER RARE',	''},
{'6',	'6',	'6星',	'6',	'yellow',	'w_premium_rare',	'SUPERIOR\nSUPER RARE',	''},
},
}
--cfgCfgCardQuality = conf
return conf
