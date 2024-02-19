local conf = {
	["filename"] = 'j-基地配置表.xlsx',
	["sheetname"] = '远征任务配置表',
	["types"] = {
'int','int','string','string','int[]','int','int','int[]'
},
	["names"] = {
'id','key','sName','icon','tFlush','maxNum','per','subs'
},
	["data"] = {
{'1',	'1',	'分支探索',	'btn_37_01',	'4',	'',	'',	'1001,1002'},
{'2',	'2',	'主干探索',	'btn_38_01',	'4,12,20',	'2',	'',	'3001'},
{'3',	'3',	'危险探索',	'btn_39_01',	'4',	'10',	'10',	'4001'},
{'4',	'4',	'',	'',	'21',	'5',	'',	'2001'},
},
}
--cfgCfgExpeditionTask = conf
return conf
