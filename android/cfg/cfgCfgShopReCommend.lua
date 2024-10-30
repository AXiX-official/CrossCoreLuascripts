local conf = {
	["filename"] = 's-商店配置.xlsx',
	["sheetname"] = '商城推荐配置',
	["types"] = {
'int','string','int','int','int','string','int','int','string','string','int'
},
	["names"] = {
'id','key','group','showType','sort','img','commID','sJumpID','startTime','endTime','changeTimer'
},
	["data"] = {
{'1001',	'',	'101',	'1',	'5',	'L_Skin06',	'',	'140008',	'',	'',	'5'},
{'1007',	'',	'201',	'2',	'1',	'M_Packs01',	'30023',	'140105',	'',	'',	''},
{'1008',	'',	'301',	'2',	'1',	'ST_Packs01',	'30016',	'140106',	'',	'',	''},
{'1009',	'',	'301',	'2',	'2',	'ST_Packs02',	'30015',	'140107',	'',	'',	''},
{'1010',	'',	'401',	'1',	'1',	'SD_Packs01',	'30001',	'140108',	'',	'',	''},
},
}
--cfgCfgShopReCommend = conf
return conf
