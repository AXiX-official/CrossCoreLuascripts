local conf = {
	["filename"] = 'j-基地配置表.xlsx',
	["sheetname"] = '改造池',
	["types"] = {
'int','string','table#4','int','int','json','int'
},
	["names"] = {
'id','key','arr','index','quality','costs','needTime'
},
	["data"] = {
{'1001',	'1001',	'',	'',	'',	'',	''},
{'1001',	'1001',	'',	'1',	'1',	'[[10011,1,2]]',	'10'},
{'1001',	'1001',	'',	'2',	'2',	'[[10011,5,2]]',	'30'},
{'1001',	'1001',	'',	'3',	'3',	'[[10011,30,2]]',	'600'},
{'1001',	'1001',	'',	'4',	'4',	'[[10011,300,2]]',	'14400'},
},
}
--cfgCfgBRemouldPool = conf
return conf