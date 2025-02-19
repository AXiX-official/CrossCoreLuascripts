local conf = {
	["filename"] = 'r-任务配置表.xlsx',
	["sheetname"] = '角斗场赛季任务',
	["types"] = {
'int','string','int','string','string','int','int[]','json','int','int'
},
	["names"] = {
'id','key','nGroup','sName','sDescription','nTransferPath','aFinishIds','jAwardId','nIsHide','mailId'
},
	["data"] = {
{'1',	'',	'2',	'随机模式累计获得500星',	'随机模式累计获得500星',	'290001',	'120114',	'[[10407,800,2]]',	'2',	'9001'},
{'2',	'',	'2',	'随机模式累计获得600星',	'随机模式累计获得600星',	'290001',	'120115',	'[[10407,800,2]]',	'2',	'9001'},
{'3',	'',	'2',	'随机模式累计获得800星',	'随机模式累计获得800星',	'290001',	'120116',	'[[10407,1500,2],[29048,1,2]]',	'2',	'9001'},
},
}
--cfgcfgColosseumSeasonMission = conf
return conf
