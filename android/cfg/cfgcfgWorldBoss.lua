local conf = {
	["filename"] = 'b-世界boss表.xlsx',
	["sheetname"] = '世界boss',
	["types"] = {
'int','string','string','int','float','int[]','int','int','string','string','string','string'
},
	["names"] = {
'id','key','name','nMonsterGroupID','fHpMultiple','reward','killReward','nActivityReward','nBeginTime','nEndTime','nDailyBeginTime','nDailyEndTime'
},
	["data"] = {
{'1001',	'',	'碎星BOSS1',	'999911',	'4',	'10001,10002,10003',	'30001',	'1001',	'2019/10/10 10:00:00',	'2022/10/11 10:00:00',	'10:00:00',	'19:00:00'},
{'1002',	'',	'碎星BOSS2',	'999911',	'4',	'10001,10002,10004',	'30001',	'1001',	'2019/10/10 10:00:00',	'2019/10/11 10:00:00',	'10:00:00',	'12:00:00'},
},
}
--cfgcfgWorldBoss = conf
return conf
