local conf = {
	["filename"] = 'j-基地配置表.xlsx',
	["sheetname"] = '全局电量配置表',
	["types"] = {
'int','string','string','int','int','int','int','int','int','int','bool','string'
},
	["names"] = {
'id','key','name','min','max','productPercent','tradeOrderPer','expeditionPer','combineOrderPer','remouldOrderPer','running','icon'
},
	["data"] = {
{'1',	'1',	'电荷超载',	'-10000',	'-1000',	'-20',	'-20',	'0',	'0',	'0',	'0',	'runIcon1'},
{'2',	'2',	'满载负荷',	'-999',	'0',	'-20',	'-10',	'-10',	'-10',	'-10',	'1',	'runIcon2'},
{'3',	'3',	'正常负载',	'1',	'19',	'0',	'0',	'0',	'0',	'0',	'1',	'runIcon3'},
{'4',	'4',	'电力充裕',	'20',	'1000',	'20',	'10',	'10',	'10',	'10',	'1',	'runIcon4'},
},
}
--cfgCfgBGobalPower = conf
return conf
