local conf = {
	["filename"] = 'h-活动.xlsx',
	["sheetname"] = '活动表',
	["types"] = {
'int','string','string','int','int','int','string','string','int'
},
	["names"] = {
'id','key','name','sortIndex','type','sortDiff','begTime','endTime','score_pool_id'
},
	["data"] = {
{'1001',	'1001',	'积分活动',	'1',	'3',	'',	'2019/10/10 10:00:00',	'2019/10/31 10:00:00',	'1001'},
{'2001',	'2001',	'排名奖励',	'2',	'4',	'60',	'2019/10/10 10:00:00',	'2019/10/31 10:00:00',	''},
},
}
--cfgCfgActive = conf
return conf
