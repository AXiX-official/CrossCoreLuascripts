local conf = {
	["filename"] = 'G-关卡组配置.xlsx',
	["sheetname"] = '试炼活动分组',
	["types"] = {
'int','int','int','string','int','int[]','string','string','string','string','int'
},
	["names"] = {
'id','key','group','name','type','dungeonGroups','bg','video','effect','img','showType'
},
	["data"] = {
{'13001',	'13001',	'6001',	'尤弥尔1',	'1',	'12101',	'bg2',	'dungeon_activity_2',	'',	'img1',	'1'},
{'13002',	'13002',	'6001',	'尤弥尔2',	'1',	'12102',	'',	'dungeon_activity_92280',	'',	'img1',	'2'},
{'13003',	'13003',	'6001',	'尤弥尔3',	'1',	'12103',	'',	'dungeon_activity_92280',	'',	'img1',	'3'},
{'13004',	'13004',	'6001',	'尤弥尔4',	'1',	'12104,12105,12106,12107,12108',	'',	'dungeon_activity_92280',	'',	'img1',	'3'},
},
}
--cfgDungeonGroup5 = conf
return conf
