local conf = {
	["filename"] = 'j-基地配置表.xlsx',
	["sheetname"] = '建筑耐久配置',
	["types"] = {
'int','string','string','int','int','int','int','string'
},
	["names"] = {
'id','key','name','min','max','powrPercent','productPercent','icon'
},
	["data"] = {
{'1',	'1',	'细微损坏',	'80',	'100',	'0',	'0',	'damage1'},
{'2',	'2',	'轻度损坏',	'50',	'79',	'-20',	'-20',	'damage2'},
{'3',	'3',	'中度损坏',	'20',	'49',	'-50',	'-50',	'damage3'},
{'4',	'4',	'重度损坏',	'0',	'19',	'-100',	'-100',	'damage4'},
},
}
--cfgCfgBHp = conf
return conf
