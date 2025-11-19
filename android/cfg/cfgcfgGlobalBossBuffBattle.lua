local conf = {
	["filename"] = 'c-词条表.xlsx',
	["sheetname"] = '世界BOSS词条',
	["types"] = {
'int','int','int[]','int[]','int','string','string','string'
},
	["names"] = {
'id','key','skillId','buffId','target','name','desc','icon2'
},
	["data"] = {
{'1',	'5800001',	'5800001',	'',	'1',	'新世界boss新增技能1',	'dot专属：dot伤害提高100%，造成伤害时每层劣化承受伤害提高20%，敌方存在劣化效果时攻击后50%概率添加1层割裂层数+1',	''},
{'2',	'5800002',	'5800002',	'',	'1',	'新世界boss新增技能2',	'同调专属：同调后伤害提高80%，同调角色使用大招后获得15点sp，同调之后不再过热',	''},
{'3',	'5800003',	'5800003',	'',	'1',	'武装过载',	'大招技能伤害提高150%，普攻技能伤害减少30%',	'2001'},
},
}
--cfgcfgGlobalBossBuffBattle = conf
return conf
