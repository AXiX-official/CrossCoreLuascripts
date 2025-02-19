local conf = {
	["filename"] = 'd-电子宠物.xlsx',
	["sheetname"] = '宠物状态',
	["types"] = {
'int','string','string','string','int[]','int','int','int','int[]'
},
	["names"] = {
'id','key','name','icon','attribute','judge','value','stateType','effect'
},
	["data"] = {
{'1',	'1',	'饥饿',	'img_07_04',	'3',	'5',	'20',	'',	''},
{'2',	'2',	'饱腹',	'img_07_06',	'3',	'2',	'83',	'',	''},
{'3',	'3',	'肮脏',	'img_07_05',	'2',	'5',	'20',	'3',	'1'},
{'4',	'4',	'心情低落',	'img_07_03',	'1',	'5',	'20',	'1',	'1'},
{'5',	'5',	'高兴',	'img_07_02',	'1,3',	'2',	'70',	'2',	'5,2'},
},
}
--cfgCfgPetState = conf
return conf
