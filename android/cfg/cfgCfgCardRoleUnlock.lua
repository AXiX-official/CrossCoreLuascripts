local conf = {
	["filename"] = 'j-卡牌角色.xlsx',
	["sheetname"] = '剧情解锁条件',
	["types"] = {
'int','string','string','int'
},
	["names"] = {
'id','key','sDesc','value'
},
	["data"] = {
{'1',	'1',	'好感度到达10级开启',	'10'},
{'2',	'2',	'好感度到达30级开启',	'30'},
{'3',	'3',	'好感度到达60级开启',	'60'},
{'4',	'4',	'好感度到达80级开启',	'80'},
{'5',	'5',	'好感度到达100级开启',	'100'},
},
}
--cfgCfgCardRoleUnlock = conf
return conf
