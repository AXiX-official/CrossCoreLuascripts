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
{'1002',	'1002',	'',	'',	'',	''},
{'1002',	'1002',	'',	'1',	'2025-06-25 10:00:00',	'2025-06-30 00:00:00'},
{'1002',	'1002',	'',	'2',	'2025-07-09 12:00:00',	'2025-07-14 00:00:00'},
{'1003',	'1003',	'',	'',	'',	''},
{'1003',	'1003',	'',	'1',	'2025-08-01 18:00:00',	'2025-08-04 00:00:00'},
{'1003',	'1003',	'',	'2',	'2025-08-22 18:00:00',	'2025-08-25 00:00:00'},
{'1004',	'1004',	'',	'',	'',	''},
{'1004',	'1004',	'',	'1',	'2025-07-14 18:00:00',	'2025-08-04 00:00:00'},
{'1004',	'1004',	'',	'2',	'2025-08-06 10:00:00',	'2025-08-09 00:00:00'},
{'1004',	'1004',	'',	'3',	'2025-08-13 10:00:00',	'2025-08-16 00:00:00'},
{'1005',	'1005',	'',	'',	'',	''},
{'1005',	'1005',	'',	'1',	'2025-07-14 18:00:00',	'2025-07-31 00:00:00'},
{'1005',	'1005',	'',	'2',	'2025-07-31 00:00:00',	'2025-08-01 00:00:00'},
{'1005',	'1005',	'',	'3',	'2025-08-01 00:00:00',	'2025-08-02 00:00:00'},
{'1005',	'1005',	'',	'4',	'2025-08-02 00:00:00',	'2025-08-03 00:00:00'},
{'1005',	'1005',	'',	'5',	'2025-08-03 00:00:00',	'2025-08-04 00:00:00'},
{'1005',	'1005',	'',	'6',	'2025-08-06 10:00:00',	'2025-08-07 00:00:00'},
{'1005',	'1005',	'',	'7',	'2025-08-07 00:00:00',	'2025-08-08 00:00:00'},
{'1005',	'1005',	'',	'8',	'2025-08-08 00:00:00',	'2025-08-09 00:00:00'},
{'1005',	'1005',	'',	'9',	'2025-08-13 10:00:00',	'2025-08-14 00:00:00'},
{'1005',	'1005',	'',	'10',	'2025-08-14 00:00:00',	'2025-08-15 00:00:00'},
{'1005',	'1005',	'',	'11',	'2025-08-15 00:00:00',	'2025-08-16 00:00:00'},
},
}
--cfgCfgSplitTime = conf
return conf
