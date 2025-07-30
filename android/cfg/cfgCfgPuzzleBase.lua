local conf = {
	["filename"] = 'p-拼图活动.xlsx',
	["sheetname"] = '基础配置',
	["types"] = {
'int','string','int','string','string','int','int','int','int','json','int','string'
},
	["names"] = {
'id','key','type','begTime','endTime','rewardId','gridCfgId','buyCfgId','drawCfgId','drawCost','taskType','bg'
},
	["data"] = {
{'1',	'1',	'1',	'2025/3/21 12:00:00',	'2025/4/7 12:00:00',	'1001',	'1001',	'',	'80001',	'[[10002,60]]',	'21001',	'img_03_01'},
{'2',	'2',	'2',	'2025/8/20 0:00:00',	'2025/9/3 3:00:00',	'1003',	'1003',	'1002',	'',	'',	'21002',	'img_03_02'},
},
}
--cfgCfgPuzzleBase = conf
return conf
