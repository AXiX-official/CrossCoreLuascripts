local conf = {
	["filename"] = 'j-基地配置表.xlsx',
	["sheetname"] = '催眠配置表',
	["types"] = {
'int','string','int','int','int','int','int','int','int','int[]','int'
},
	["names"] = {
'id','key','processScore','rollSpeed','perfectScore','greatScore','goodScore','missScore','exp','lvRange','timeLen'
},
	["data"] = {
{'1',	'1',	'1000',	'2600',	'100',	'80',	'50',	'0',	'5',	'1,20',	'30'},
{'2',	'2',	'2000',	'2200',	'100',	'80',	'50',	'0',	'10',	'21,60',	'30'},
{'3',	'3',	'3000',	'1800',	'100',	'80',	'50',	'0',	'20',	'61,60',	'30'},
},
}
--cfgCfgHypnosis = conf
return conf
