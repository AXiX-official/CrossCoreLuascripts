local conf = {
	["filename"] = 'G-关卡组配置.xlsx',
	["sheetname"] = '讨伐活动分组',
	["types"] = {
'int','int','int','string','int','int[]','string','string','string','int'
},
	["names"] = {
'id','key','group','name','type','dungeonGroups','bg','video','img','showType'
},
	["data"] = {
{'12001',	'12001',	'4001',	'奇美拉1',	'1',	'12001',	'bg1',	'',	'',	'1'},
{'12002',	'12002',	'4001',	'奇美拉2',	'1',	'12002',	'',	'dungeon_activity_2',	'',	'2'},
{'12003',	'12003',	'4001',	'奇美拉3',	'1',	'12003',	'',	'dungeon_activity_2',	'img1',	'3'},
{'12101',	'12101',	'4002',	'尤弥尔1',	'1',	'12101',	'bg2',	'dungeon_activity_2',	'img1',	'1'},
{'12102',	'12102',	'4002',	'尤弥尔2',	'1',	'12102',	'',	'dungeon_activity_92280',	'img1',	'2'},
{'12103',	'12103',	'4002',	'尤弥尔3',	'1',	'12103',	'',	'dungeon_activity_92280',	'img1',	'3'},
{'12104',	'12104',	'4002',	'尤弥尔4',	'1',	'12104,12105,12106,12107,12108',	'',	'dungeon_activity_92280',	'img1',	'3'},
},
}
--cfgDungeonGroup4 = conf
return conf
