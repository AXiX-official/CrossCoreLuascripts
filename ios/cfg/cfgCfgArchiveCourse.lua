local conf = {
	["filename"] = 't-图鉴表.xlsx',
	["sheetname"] = '图鉴教程',
	["types"] = {
'int','string','int','string','string','string','int[]'
},
	["names"] = {
'id','key','type','name','eName','small_id','icons'
},
	["data"] = {
{'1005',	'1005',	'1',	'自动战斗',	'Auto Battle',	'Course_1106',	'1106,1107'},
{'1006',	'1006',	'1',	'伤害减免',	'Damage Reduction',	'Course_1701',	'1701'},
{'1007',	'1007',	'1',	'削减伤害',	'Cut Damage',	'Course_1702',	'1702,1703'},
{'1008',	'1008',	'1',	'削减层数',	'Reduce Layers',	'Course_1704',	'1704'},
{'2004',	'2004',	'2',	'武装芯片',	'Armed Chip',	'Course_1006',	'1006,1007'},
{'5001',	'5001',	'3',	'基础信息',	'Basic Information',	'Course_1601',	'1601'},
{'5002',	'5002',	'3',	'电力相关',	'Electricity',	'Course_1602',	'1602'},
{'7002',	'7002',	'4',	'补给/货箱',	'Supplies/Containers',	'Course_1303',	'1303'},
{'7003',	'7003',	'4',	'雷击',	'Lightning Strike',	'Course_1307',	'1307'},
{'7004',	'7004',	'4',	'冰面',	'Ice',	'Course_1305',	'1305'},
{'7005',	'7005',	'4',	'冰冻捕夹',	'Freeze Trap',	'Course_1306',	'1306'},
{'7006',	'7006',	'4',	'裁决之雷',	'Thunder of Judgment',	'Course_1304',	'1304'},
{'7007',	'7007',	'4',	'屏蔽力场',	'',	'Course_1308',	'1308'},
{'7008',	'7008',	'4',	'探视天眼',	'',	'Course_1309',	'1309'},
{'7009',	'7009',	'4',	'泄止阀',	'',	'Course_1310',	'1310'},
},
}
--cfgCfgArchiveCourse = conf
return conf
