local conf = {
	["filename"] = 'j-基地配置表.xlsx',
	["sheetname"] = '合成额外奖励',
	["types"] = {
'int','string','int','int','int','int','int'
},
	["names"] = {
'id','key','minDiff','maxDiff','sPercent','rPercent','num'
},
	["data"] = {
{'1',	'1',	'',	'-21',	'30',	'0',	'0'},
{'2',	'2',	'-20',	'-1',	'80',	'0',	'0'},
{'3',	'3',	'0',	'49',	'100',	'0',	'0'},
{'4',	'4',	'50',	'99',	'100',	'30',	'1'},
{'5',	'5',	'100',	'',	'100',	'50',	'2'},
},
}
--cfgCfgBCompoundExGift = conf
return conf
