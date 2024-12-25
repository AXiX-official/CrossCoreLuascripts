local conf = {
	["filename"] = 'b-绑定活动.xlsx',
	["sheetname"] = '绑定活动配置',
	["types"] = {
'int','int','string','int','int','int[]','json','string','int','string','int','int','int','table#4','int','json','int','int'
},
	["names"] = {
'id','key','name','desc','needPlrNum','bindTypes','reward','startTime','preTime','endTime','applyLimit','recvLimit','applyResetCycle','infos','index','taskRewardLimit','shopid','codePrefix'
},
	["data"] = {
{'1',	'1',	'',	'',	'2',	'2,3',	'[[11002,1,2]]',	'2024/12/25 03:00:00',	'1440',	'2025/1/20 03:00:00',	'100',	'100',	'30',	'',	'',	'',	'',	''},
{'1',	'1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'2',	'[[0,10403,0]]',	'2002',	'60028'},
{'1',	'1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'3',	'[[0,10404,0]]',	'2003',	'60029'},
},
}
--cfgCfgBindActive = conf
return conf
