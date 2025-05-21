local conf = {
	["filename"] = 's-商店配置.xlsx',
	["sheetname"] = '商品多时段上架',
	["types"] = {
'int','int','table#3','int','string','string'
},
	["names"] = {
'id','key','infos','index','begTime','endTime'
},
	["data"] = {
{'1001',	'1001',	'',	'',	'',	''},
{'1001',	'1001',	'',	'1',	'2025-05-21 10:00:00',	'2025-05-25 23:59:00'},
{'1001',	'1001',	'',	'2',	'2025-06-04 12:00:00',	'2025-06-08 23:59:00'},
},
}
--cfgCfgSplitTime = conf
return conf
