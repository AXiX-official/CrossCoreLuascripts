local conf = {
	["filename"] = 'j-军演.xlsx',
	["sheetname"] = '军演积分奖励',
	["types"] = {
'int','string','int','int','int'
},
	["names"] = {
'id','key','nGetScore','nDiffMin','nDiffMax'
},
	["data"] = {
{'1',	'1',	'16',	'-999999',	'-150'},
{'2',	'2',	'17',	'-150',	'-100'},
{'3',	'3',	'18',	'-100',	'-50'},
{'4',	'4',	'20',	'-50',	'50'},
{'5',	'5',	'21',	'50',	'75'},
{'6',	'6',	'22',	'75',	'100'},
{'7',	'7',	'23',	'100',	'125'},
{'8',	'8',	'24',	'125',	'150'},
{'9',	'9',	'26',	'150',	'200'},
{'10',	'10',	'28',	'200',	'99999999999'},
},
}
--cfgCfgPracticeScore = conf
return conf