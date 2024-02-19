local conf = {
	["filename"] = 'h-活动入口开放.xlsx',
	["sheetname"] = '活动表',
	["types"] = {
'int','string','string','int','int','int','string','int','int[]','string','string','string','string','string','string','int','int','string'
},
	["names"] = {
'id','key','name','type','mainShow','sort','mainBtn','period','days','begTime','hardBegTime','exBegTime','battleendTime','endTime','config','nConfigID','JumpID','desc'
},
	["data"] = {
{'1',	'1',	'拂晓之战',	'1',	'0',	'4',	'mainbtn_2001',	'',	'',	'2023/02/23 10:00:00',	'',	'',	'2023/10/31 10:00:00',	'2023/11/10 10:00:00',	'CfgBattleField',	'1000',	'14001',	'通关\n<color=#ffc146>1-20漆黑</color>\n开启'},
{'2',	'2',	'真假惊魂夜',	'2',	'1',	'2',	'mainbtn_3001',	'',	'',	'2023/11/23 10:00:00',	'2024/01/24 12:00:00',	'',	'2024/02/07 03:00:00',	'2024/02/10 03:00:00',	'CfgDungeonPlot',	'2000',	'12001',	'通关\n<color=#ffc146>剧0-8</color>\n开启'},
{'3',	'3',	'拟真演训',	'3',	'1',	'1',	'mainbtn_4001',	'',	'',	'2024/02/07 10:00:00',	'',	'',	'2024/02/21 03:00:00',	'2024/02/21 03:00:00',	'CfgDungeonTaoFa',	'3000',	'13001',	'通关\n<color=#ffc146>剧0-8</color>\n开启'},
{'4',	'4',	'迷城蛛影',	'2',	'0',	'3',	'mainbtn_3001',	'',	'',	'2023/02/23 10:00:00',	'',	'',	'2023/10/31 10:00:00',	'2023/11/10 10:00:00',	'CfgDungeonPlot',	'2001',	'12001',	'通关\n<color=#ffc146>1-20漆黑</color>\n开启'},
},
}
--cfgCfgActiveEntry = conf
return conf
