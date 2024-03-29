local conf = {
	["filename"] = 'z-自动战斗配置表.xlsx',
	["sheetname"] = '技能策略条目',
	["types"] = {
'int','string','string','string'
},
	["names"] = {
'id','key','description','skillStrategy'
},
	["data"] = {
{'1',	'',	'直接释放',	'%s'},
{'2',	'',	'系统默认',	'%s'},
{'3',	'',	'不能自动释放',	'0,%s'},
{'401',	'',	'NP大于10',	'4,1,10,%s,0'},
{'402',	'',	'NP大于20',	'4,1,20,%s,0'},
{'403',	'',	'NP大于30',	'4,1,30,%s,0'},
{'404',	'',	'NP大于40',	'4,1,40,%s,0'},
{'405',	'',	'NP大于50',	'4,1,50,%s,0'},
{'406',	'',	'NP大于60',	'4,1,60,%s,0'},
{'407',	'',	'NP大于70',	'4,1,70,%s,0'},
{'408',	'',	'NP小于81',	'4,1,80,0,%s'},
{'501',	'',	'敌方剩余人数大于0',	'5,0,%s,0'},
{'502',	'',	'敌方剩余人数大于1',	'5,1,%s,0'},
{'503',	'',	'敌方剩余人数大于2',	'5,2,%s,0'},
{'504',	'',	'敌方剩余人数大于3',	'5,3,%s,0'},
{'505',	'',	'敌方剩余人数大于4',	'5,4,%s,0'},
{'601',	'',	'我方剩余人数大于1',	'6,1,%s,0'},
{'602',	'',	'我方剩余人数大于2',	'6,2,%s,0'},
{'603',	'',	'我方剩余人数大于3',	'6,3,%s,0'},
{'604',	'',	'我方剩余人数大于4',	'6,4,%s,0'},
{'701',	'',	'持有远古咆哮效果时',	'7,3,4,30221,0,%s,0'},
{'702',	'',	'远古咆哮大于1层时',	'7,3,4,30221,1,%s,0'},
{'703',	'',	'远古咆哮为3层时',	'7,3,4,30221,2,%s,0'},
{'704',	'',	'远古咆哮小于3层时',	'7,3,4,30221,2,0,%s'},
{'711',	'',	'自身持有凝霜效果时',	'7,3,4,60111,0,%s,0'},
{'712',	'',	'自身凝霜效果大于1层时',	'7,3,4,60111,1,%s,0'},
{'713',	'',	'自身凝霜效果大于2层时',	'7,3,4,60111,2,%s,0'},
{'714',	'',	'自身凝霜效果大于3层时',	'7,3,4,60111,3,%s,0'},
{'715',	'',	'自身凝霜效果大于4层时',	'7,3,4,60111,4,%s,0'},
{'716',	'',	'自身凝霜效果小于5层时',	'7,3,4,60111,4,0,%s'},
{'721',	'',	'充能效果大于2层时',	'7,3,5,702600204,2,%s,0'},
{'722',	'',	'充能效果大于4层时',	'7,3,5,702600204,4,%s,0'},
{'723',	'',	'充能效果大于6层时',	'7,3,5,702600204,6,%s,0'},
{'724',	'',	'充能效果大于8层时',	'7,3,5,702600204,8,%s,0'},
{'801',	'',	'自身耐久低于70%',	'8,0.7,0,%s'},
{'802',	'',	'自身耐久低于50%',	'8,0.5,0,%s'},
{'803',	'',	'自身耐久低于30%',	'8,0.3,0,%s'},
{'1001',	'',	'每2回合释放',	'10,%s,0'},
{'1101',	'',	'我方队员耐久低于80%',	'11,0.8,0,%s'},
{'1102',	'',	'我方队员耐久低于60%',	'11,0.6,0,%s'},
{'1103',	'',	'我方队员耐久低于40%',	'11,0.4,0,%s'},
{'1201',	'',	'横排人数大于1',	'12,2,%s,0'},
{'1202',	'',	'横排人数大于2',	'12,3,%s,0'},
{'1301',	'',	'竖排人数大于1',	'13,2,%s,0'},
{'1302',	'',	'竖排人数大于2',	'13,3,%s,0'},
{'1401',	'',	'田字范围人数大于1',	'14,2,%s,0'},
{'1402',	'',	'田字范围人数大于2',	'14,3,%s,0'},
},
}
--cfgcfgSkillStrategyItem = conf
return conf
