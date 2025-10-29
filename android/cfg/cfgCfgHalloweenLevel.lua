local conf = {
	["filename"] = 'w-万圣节活动.xlsx',
	["sheetname"] = '关卡配置',
	["types"] = {
'int','string','int','int','int','int','json','table#5','int','int','json','int','float'
},
	["names"] = {
'id','key','baseTime','maxTime','hp','playerSpeed','rewardInfo','infos','index','startTime','itemInfo','speed','interval'
},
	["data"] = {
{'1',	'1',	'60',	'80',	'5',	'1000',	'{"trigger":6,"ids":[1,2,3],"time": 10,"speed":850,"interval":0.5}',	'',	'',	'',	'',	'',	''},
{'1',	'1',	'',	'',	'',	'',	'',	'',	'1',	'0',	'[[1,90],[2,5],[3,5]]',	'500',	'1'},
{'1',	'1',	'',	'',	'',	'',	'',	'',	'2',	'20',	'[[1,60],[2,20],[3,10],[5,10]]',	'650',	'0.8'},
{'1',	'1',	'',	'',	'',	'',	'',	'',	'3',	'40',	'[[1,10],[2,40],[3,30],[4,5],[5,15]]',	'850',	'0.5'},
},
}
--cfgCfgHalloweenLevel = conf
return conf
