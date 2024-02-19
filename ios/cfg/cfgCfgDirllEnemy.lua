local conf = {
	["filename"] = 'x-训练表.xlsx',
	["sheetname"] = '敌兵训练组',
	["types"] = {
'int','string','string','string','string','int','int'
},
	["names"] = {
'id','key','name','desc','icon','groupID','groupType'
},
	["data"] = {
{'1',	'1',	'同调型造物',	'辅助我方进行同调测试的造物。',	'90050_Common_TrapBomb_N',	'2007',	'3'},
{'2',	'2',	'火力测试型造物',	'移除了行动能力，专门用来进行火力测试的造物。',	'90050_Common_TrapBomb_N',	'2001',	'1'},
{'3',	'3',	'实战用造物',	'荷枪实弹的实战训练，敌人会用上一切攻击手段。',	'90260_Common_Sentry_N',	'2002',	'1'},
{'4',	'4',	'减益型造物',	'敌人会使用技能削弱我方战斗能力。',	'90200_Common_SlowTrap_N',	'2003',	'1'},
{'5',	'5',	'增益型造物',	'敌人会使用技能提高自身战斗能力。',	'90160_Common_BarrierDevice_N',	'2004',	'1'},
{'6',	'6',	'牵制型造物',	'敌人会使用控制技能牵制我方。',	'90110_Common_FreezeBomb_N',	'2005',	'1'},
{'7',	'7',	'诱饵型造物',	'我方造物有着吸引敌方火力的效果。',	'90620_Common_Predator_N',	'2006',	'2'},
},
}
--cfgCfgDirllEnemy = conf
return conf
