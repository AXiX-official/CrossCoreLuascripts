local conf = {
	["filename"] = 'c-场景.xlsx',
	["sheetname"] = '场景类型',
	["types"] = {
'int','string','string','string[]','string[]'
},
	["names"] = {
'id','key','desc','res','views'
},
	["data"] = {
{'1',	'MajorCity',	'主城',	'',	'Menu'},
{'2',	'Dungeon',	'普通副本',	'',	'FightRender,CharacterInfo,FightBoss,FightTimeLine,Fight,Skill,FightSkillSkip'},
{'3',	'Other',	'其他类型',	'',	''},
},
}
--cfgscene_type = conf
return conf
