local conf = {
	["filename"] = 'r-任务配置表.xlsx',
	["sheetname"] = '每日勘测任务',
	["types"] = {
'int','string','int','string','string','string','int','int','int','int','string','string','int','int','int[]','json','int'
},
	["names"] = {
'id','key','type','sName','sDescription','icon','nOpenLevel','nCloseLevel','nOppssId','nPreTaskId','sOpenTime','sCloseTime','nRestType','nTransferPath','aFinishIds','jAwardId','nIsHide'
},
	["data"] = {
{'39101',	'',	'1',	'每日登陆',	'每日登陆',	'1',	'',	'',	'',	'',	'',	'',	'1',	'',	'39101',	'[[10043,120,2]]',	'2'},
{'39102',	'',	'1',	'在限时贸易所任意1次购买',	'在限时贸易所任意1次购买',	'1',	'',	'',	'',	'',	'',	'',	'1',	'140006',	'39102',	'[[10043,120,2]]',	'2'},
{'39103',	'',	'1',	'累计消耗150燃料',	'累计消耗150燃料',	'1',	'',	'',	'',	'',	'',	'',	'1',	'30001',	'39103',	'[[10043,120,2]]',	'2'},
{'39104',	'',	'1',	'日常任务累计达到12星',	'日常任务累计达到12星',	'1',	'',	'',	'',	'',	'',	'',	'1',	'200001',	'39104',	'[[10043,180,2]]',	'2'},
},
}
--cfgCfgTaskDayExploration = conf
return conf
