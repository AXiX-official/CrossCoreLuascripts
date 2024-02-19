local conf = {
	["filename"] = 'j-卡牌角色.xlsx',
	["sheetname"] = '宿舍剧情事件',
	["types"] = {
'int','string','string','string','int','bool','int','json'
},
	["names"] = {
'id','key','sDesc','icon','weight','story','addExp','gets'
},
	["data"] = {
{'1',	'1',	'“叹号”',	'event_1',	'10',	'1',	'',	''},
{'2',	'2',	'“心情”',	'event_2',	'100',	'0',	'10',	'[[10010,100,2,300],[10010,100,2,300]]'},
{'3',	'3',	'“家具币”',	'event_3',	'50',	'0',	'10',	'[[10010,100,2,500]]'},
},
}
--cfgCfgRoleDormitoryEvents = conf
return conf
