local conf = {
	["filename"] = 'j-基地配置表.xlsx',
	["sheetname"] = '远征等级配置',
	["types"] = {
'int','string','int','int','json','int','int','int','int[]','int','string'
},
	["names"] = {
'id','key','centerlvl','upTime','upCosts','roleLimit','powerVal','tiredType','tiredVal','teamCntLimit','effect'
},
	["data"] = {
{'1',	'1',	'2',	'10',	'[[60101,50,2],[10001,500,2]]',	'1',	'0',	'',	'432,-1',	'8',	''},
{'2',	'2',	'3',	'30',	'[[60101,100,2],[60102,15,2],[60103,15,2],[10001,2000,2]]',	'2',	'0',	'',	'432,-1',	'8',	''},
{'3',	'3',	'4',	'60',	'[[60101,200,2],[60102,30,2],[60103,30,2],[10001,4000,2]]',	'3',	'0',	'',	'432,-1',	'8',	''},
{'4',	'4',	'5',	'120',	'[[60101,300,2],[60102,50,2],[60103,50,2],[10001,5000,2]]',	'4',	'0',	'',	'432,-1',	'8',	''},
{'5',	'5',	'6',	'180',	'[[60101,500,2],[60102,100,2],[60103,100,2],[10001,8000,2]]',	'5',	'0',	'',	'432,-1',	'8',	''},
{'6',	'6',	'7',	'360',	'[[60101,800,2],[60102,120,2],[60103,120,2],[10001,10000,2]]',	'5',	'0',	'',	'432,-1',	'8',	''},
{'7',	'7',	'8',	'540',	'[[60101,1000,2],[60102,150,2],[60103,150,2],[10001,15000,2]]',	'5',	'0',	'',	'432,-1',	'8',	''},
{'8',	'8',	'9',	'720',	'[[60101,1500,2],[60102,200,2],[60103,200,2],[10001,20000,2]]',	'5',	'0',	'',	'432,-1',	'8',	''},
{'9',	'9',	'10',	'900',	'[[60101,2000,2],[60102,300,2],[60103,300,2],[10001,30000,2]]',	'5',	'0',	'',	'432,-1',	'8',	''},
{'10',	'10',	'',	'',	'',	'5',	'0',	'',	'432,-1',	'8',	''},
},
}
--cfgCfgExpeditionLvl = conf
return conf
