local conf = {
	["filename"] = 'e-枚举定义表.xlsx',
	["sheetname"] = '日常本枚举',
	["types"] = {
'int','string','string','string','string','string'
},
	["names"] = {
'id','key','sName','eName','desc','icon'
},
	["data"] = {
{'1',	'1',	'资源采集',	'RESOURCE\nACQUISITION',	'// 星币、技术点、训练数据等',	'bg1'},
{'2',	'2',	'芯片嵌合',	'CHIP\nEMBEDDING',	'// 各类型芯片',	'bg2'},
{'3',	'3',	'跃升行动',	'UPDATE\nACTION',	'//小队跃升材料',	'bg3'},
},
}
--cfgCfgDailyEnum = conf
return conf
