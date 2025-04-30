local conf = {
	["filename"] = 'r-任务配置表.xlsx',
	["sheetname"] = '末日战线（世界BOSS）任务（日重置）',
	["types"] = {
'int','string','int','string','string','int','int[]','json','int','int'
},
	["names"] = {
'id','key','nGroup','sName','sDescription','nTransferPath','aFinishIds','jAwardId','isNeedLogin','mailId'
},
	["data"] = {
{'1',	'',	'14001',	'',	'参与3次末日战线玩法（每日重置）',	'',	'220001',	'[[10001,30000,2]]',	'',	'14001'},
{'6',	'',	'14001',	'',	'击败首领奖励（每日重置）',	'',	'220002',	'[[10001,30000,2],[10003,30000,2]]',	'1',	'14001'},
},
}
--cfgcfgWorldBossMission = conf
return conf
