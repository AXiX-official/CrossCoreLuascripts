local conf = {
	["filename"] = 'w-玩家.xlsx',
	["sheetname"] = '玩家能力',
	["types"] = {
'int','string','string','string','string','int[]','int[]','int[]','int','int','int','bool','int','string'
},
	["names"] = {
'id','key','name','oldName','desc','pos','prev_id','next_id','type','active_id','cost_num','can_reset','open_lv','icon'
},
	["data"] = {
{'1',	'1',	'续行战术',	'复活战术',	'解锁可在战斗中使用的<color=#FFC432>【续行战术】</color>技能组',	'2,1',	'',	'2',	'1',	'1003',	'50',	'1',	'1',	'203'},
{'2',	'2',	'作战整备1',	'副本开场能量值',	'战斗开始时，额外增加<color=#FFC432>5能量值</color>',	'2,2',	'1',	'3',	'2',	'23',	'50',	'1',	'1',	'101'},
{'3',	'3',	'经验加成1',	'经验加成',	'作战探索中，额外增加<color=#FFC432>5%</color>技术点',	'2,3',	'2',	'4,5,6',	'2',	'29',	'50',	'1',	'1',	'103'},
{'4',	'4',	'作战整备2',	'副本开场能量值',	'战斗开始时，额外增加<color=#FFC432>5能量值</color>',	'2,4',	'3',	'10',	'2',	'23',	'50',	'1',	'1',	'101'},
{'5',	'5',	'经验加成2',	'经验加成',	'作战探索中，额外增加<color=#FFC432>5%</color>技术点',	'1,4',	'3',	'7',	'2',	'29',	'50',	'1',	'1',	'103'},
{'6',	'6',	'星币加成1',	'星币加成',	'作战探索中，额外增加<color=#FFC432>5%</color>星币',	'3,4',	'3',	'11',	'2',	'30',	'50',	'1',	'1',	'107'},
{'7',	'7',	'伤害增幅1',	'副本伤害',	'作战探索中，额外增加<color=#FFC432>2%</color>造成伤害',	'1,5',	'5',	'8',	'2',	'21',	'50',	'1',	'1',	'106'},
{'8',	'8',	'机动战术',	'控条战术',	'解锁可在战斗中使用的<color=#FFC432>【机动战术】</color>技能组',	'2,6',	'7,10,11',	'9',	'1',	'1002',	'50',	'1',	'1',	'202'},
{'9',	'9',	'星币加成2',	'星币加成',	'作战探索中，额外增加<color=#FFC432>5%</color>星币',	'2,7',	'8',	'12',	'2',	'30',	'50',	'1',	'1',	'107'},
{'10',	'10',	'伤害增幅2',	'副本伤害',	'作战探索中，额外增加<color=#FFC432>2%</color>造成伤害',	'2,5',	'4',	'8',	'2',	'21',	'50',	'1',	'1',	'106'},
{'11',	'11',	'伤害增幅3',	'副本伤害',	'作战探索中，额外增加<color=#FFC432>2%</color>造成伤害',	'3,5',	'6',	'8',	'2',	'21',	'50',	'1',	'1',	'106'},
{'12',	'12',	'经验加成3',	'经验加成',	'作战探索中，额外增加<color=#FFC432>5%</color>技术点',	'2,8',	'9',	'13',	'2',	'29',	'50',	'1',	'1',	'103'},
{'13',	'13',	'速攻战术',	'速攻战术',	'解锁可在战斗中使用的<color=#FFC432>【速攻战术】</color>技能组',	'2,9',	'12',	'14,15,16',	'1',	'1001',	'50',	'1',	'1',	'201'},
{'14',	'14',	'伤害增幅4',	'副本伤害',	'作战探索中，额外增加<color=#FFC432>2%</color>造成伤害',	'2,10',	'13',	'17',	'2',	'21',	'50',	'1',	'1',	'106'},
{'15',	'15',	'星币加成3',	'星币加成',	'作战探索中，额外增加<color=#FFC432>5%</color>星币',	'1,10',	'13',	'19',	'2',	'30',	'50',	'1',	'1',	'107'},
{'16',	'16',	'经验加成4',	'经验加成',	'作战探索中，额外增加<color=#FFC432>5%</color>技术点',	'3,10',	'13',	'20',	'2',	'29',	'50',	'1',	'1',	'103'},
{'17',	'17',	'星币加成4',	'星币加成',	'作战探索中，额外增加<color=#FFC432>5%</color>星币',	'2,11',	'14',	'18',	'2',	'30',	'50',	'1',	'1',	'107'},
{'18',	'18',	'爆发战术',	'爆发战术',	'解锁可在战斗中使用的<color=#FFC432>【爆发战术】</color>技能组',	'2,12',	'17',	'21',	'1',	'1004',	'50',	'1',	'1',	'204'},
{'19',	'19',	'伤害增幅5',	'副本伤害',	'作战探索中，额外增加<color=#FFC432>2%</color>造成伤害',	'1,11',	'15',	'',	'2',	'21',	'50',	'1',	'1',	'106'},
{'20',	'20',	'伤害增幅6',	'副本伤害',	'作战探索中，额外增加<color=#FFC432>2%</color>造成伤害',	'3,11',	'16',	'',	'2',	'21',	'50',	'1',	'1',	'106'},
{'21',	'21',	'削弱战术',	'削弱战术',	'解锁可在战斗中使用的<color=#FFC432>【削弱战术】</color>技能组',	'2,13',	'18',	'22,23',	'1',	'1005',	'50',	'1',	'1',	'205'},
{'22',	'22',	'星币加成5',	'星币加成',	'作战探索中，额外增加<color=#FFC432>5%</color>星币',	'1,14',	'21',	'',	'2',	'30',	'50',	'1',	'1',	'107'},
{'23',	'23',	'经验加成5',	'经验加成',	'作战探索中，额外增加<color=#FFC432>5%</color>技术点',	'3,14',	'21',	'',	'2',	'29',	'50',	'1',	'1',	'103'},
},
}
--cfgCfgPlrAbility = conf
return conf
