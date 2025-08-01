local conf = {
	["filename"] = 'z-章节表.xlsx',
	["sheetname"] = '章节星星累计奖励',
	["types"] = {
'int','string','int','int','int','table#6','int','int','json','string','string','int'
},
	["names"] = {
'id','key','starIx','group','type','arr','index','starNum','rewards','boxIcon','rewardIcon','quality'
},
	["data"] = {
{'101',	'101',	'101',	'1',	'1',	'',	'',	'',	'',	'',	'',	''},
{'101',	'101',	'101',	'',	'',	'',	'1',	'8',	'[[10003,5000,2],[10001,5000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'101',	'101',	'101',	'',	'',	'',	'2',	'16',	'[[10003,10000,2],[10001,10000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'101',	'101',	'101',	'',	'',	'',	'3',	'24',	'[[10003,15000,2],[10001,15000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'102',	'102',	'102',	'2',	'1',	'',	'',	'',	'',	'',	'',	''},
{'102',	'102',	'102',	'',	'',	'',	'1',	'10',	'[[10003,20000,2],[10001,20000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'102',	'102',	'102',	'',	'',	'',	'2',	'20',	'[[10003,20000,2],[10001,20000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'102',	'102',	'102',	'',	'',	'',	'3',	'30',	'[[10003,30000,2],[10001,30000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'102',	'102',	'102',	'',	'',	'',	'4',	'45',	'[[10003,30000,2],[10001,30000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'102',	'102',	'102',	'',	'',	'',	'5',	'60',	'[[10003,40000,2],[10001,40000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'102',	'102',	'102',	'',	'',	'',	'6',	'75',	'[[10003,40000,2],[10001,40000,2],[10002,360,2]]',	'Chip_test',	'Chip_test',	'5'},
{'103',	'103',	'103',	'3',	'1',	'',	'',	'',	'',	'',	'',	''},
{'103',	'103',	'103',	'',	'',	'',	'1',	'11',	'[[10003,30000,2],[10001,30000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'103',	'103',	'103',	'',	'',	'',	'2',	'22',	'[[10003,30000,2],[10001,30000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'103',	'103',	'103',	'',	'',	'',	'3',	'33',	'[[10003,40000,2],[10001,40000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'103',	'103',	'103',	'',	'',	'',	'4',	'44',	'[[10003,40000,2],[10001,40000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'103',	'103',	'103',	'',	'',	'',	'5',	'55',	'[[10003,50000,2],[10001,50000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'103',	'103',	'103',	'',	'',	'',	'6',	'66',	'[[10003,50000,2],[10001,50000,2],[10002,360,2]]',	'Chip_test',	'Chip_test',	'5'},
{'104',	'104',	'104',	'4',	'1',	'',	'',	'',	'',	'',	'',	''},
{'104',	'104',	'104',	'',	'',	'',	'1',	'9',	'[[10003,40000,2],[10001,40000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'104',	'104',	'104',	'',	'',	'',	'2',	'21',	'[[10003,40000,2],[10001,40000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'104',	'104',	'104',	'',	'',	'',	'3',	'30',	'[[10003,50000,2],[10001,50000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'104',	'104',	'104',	'',	'',	'',	'4',	'39',	'[[10003,50000,2],[10001,50000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'104',	'104',	'104',	'',	'',	'',	'5',	'51',	'[[10003,60000,2],[10001,60000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'104',	'104',	'104',	'',	'',	'',	'6',	'63',	'[[10003,60000,2],[10001,60000,2],[10002,360,2]]',	'Chip_test',	'Chip_test',	'5'},
{'105',	'105',	'105',	'5',	'1',	'',	'',	'',	'',	'',	'',	''},
{'105',	'105',	'105',	'',	'',	'',	'1',	'11',	'[[10003,40000,2],[10001,40000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'105',	'105',	'105',	'',	'',	'',	'2',	'22',	'[[10003,40000,2],[10001,40000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'105',	'105',	'105',	'',	'',	'',	'3',	'33',	'[[10003,50000,2],[10001,50000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'105',	'105',	'105',	'',	'',	'',	'4',	'44',	'[[10003,50000,2],[10001,50000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'105',	'105',	'105',	'',	'',	'',	'5',	'55',	'[[10003,60000,2],[10001,60000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'105',	'105',	'105',	'',	'',	'',	'6',	'66',	'[[10003,60000,2],[10001,60000,2],[10002,420,2]]',	'Chip_test',	'Chip_test',	'5'},
{'106',	'106',	'106',	'6',	'1',	'',	'',	'',	'',	'',	'',	''},
{'106',	'106',	'106',	'',	'',	'',	'1',	'11',	'[[10003,40000,2],[10001,40000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'106',	'106',	'106',	'',	'',	'',	'2',	'22',	'[[10003,40000,2],[10001,40000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'106',	'106',	'106',	'',	'',	'',	'3',	'33',	'[[10003,50000,2],[10001,50000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'106',	'106',	'106',	'',	'',	'',	'4',	'44',	'[[10003,50000,2],[10001,50000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'106',	'106',	'106',	'',	'',	'',	'5',	'55',	'[[10003,60000,2],[10001,60000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'106',	'106',	'106',	'',	'',	'',	'6',	'66',	'[[10003,60000,2],[10001,60000,2],[10002,420,2]]',	'Chip_test',	'Chip_test',	'5'},
{'201',	'201',	'201',	'1',	'2',	'',	'',	'',	'',	'',	'',	''},
{'201',	'201',	'201',	'',	'',	'',	'1',	'8',	'[[10003,10000,2],[10001,10000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'201',	'201',	'201',	'',	'',	'',	'2',	'16',	'[[10003,20000,2],[10001,20000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'201',	'201',	'201',	'',	'',	'',	'3',	'24',	'[[10003,30000,2],[10001,30000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'202',	'202',	'202',	'2',	'2',	'',	'',	'',	'',	'',	'',	''},
{'202',	'202',	'202',	'',	'',	'',	'1',	'10',	'[[10003,40000,2],[10001,40000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'202',	'202',	'202',	'',	'',	'',	'2',	'20',	'[[10003,40000,2],[10001,40000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'202',	'202',	'202',	'',	'',	'',	'3',	'30',	'[[10003,50000,2],[10001,50000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'202',	'202',	'202',	'',	'',	'',	'4',	'45',	'[[10003,50000,2],[10001,50000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'202',	'202',	'202',	'',	'',	'',	'5',	'60',	'[[10003,60000,2],[10001,60000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'202',	'202',	'202',	'',	'',	'',	'6',	'75',	'[[10003,60000,2],[10001,60000,2],[10002,360,2]]',	'Chip_test',	'Chip_test',	'5'},
{'203',	'203',	'203',	'3',	'2',	'',	'',	'',	'',	'',	'',	''},
{'203',	'203',	'203',	'',	'',	'',	'1',	'11',	'[[10003,60000,2],[10001,60000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'203',	'203',	'203',	'',	'',	'',	'2',	'22',	'[[10003,60000,2],[10001,60000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'203',	'203',	'203',	'',	'',	'',	'3',	'33',	'[[10003,70000,2],[10001,70000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'203',	'203',	'203',	'',	'',	'',	'4',	'44',	'[[10003,70000,2],[10001,70000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'203',	'203',	'203',	'',	'',	'',	'5',	'55',	'[[10003,80000,2],[10001,80000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'203',	'203',	'203',	'',	'',	'',	'6',	'66',	'[[10003,80000,2],[10001,80000,2],[10002,360,2]]',	'Chip_test',	'Chip_test',	'5'},
{'204',	'204',	'204',	'3',	'2',	'',	'',	'',	'',	'',	'',	''},
{'204',	'204',	'204',	'',	'',	'',	'1',	'9',	'[[10003,60000,2],[10001,60000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'204',	'204',	'204',	'',	'',	'',	'2',	'21',	'[[10003,60000,2],[10001,60000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'204',	'204',	'204',	'',	'',	'',	'3',	'30',	'[[10003,70000,2],[10001,70000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'204',	'204',	'204',	'',	'',	'',	'4',	'39',	'[[10003,70000,2],[10001,70000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'204',	'204',	'204',	'',	'',	'',	'5',	'51',	'[[10003,80000,2],[10001,80000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'204',	'204',	'204',	'',	'',	'',	'6',	'63',	'[[10003,80000,2],[10001,80000,2],[10002,360,2]]',	'Chip_test',	'Chip_test',	'5'},
{'205',	'205',	'205',	'5',	'2',	'',	'',	'',	'',	'',	'',	''},
{'205',	'205',	'205',	'',	'',	'',	'1',	'11',	'[[10003,60000,2],[10001,60000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'205',	'205',	'205',	'',	'',	'',	'2',	'22',	'[[10003,60000,2],[10001,60000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'205',	'205',	'205',	'',	'',	'',	'3',	'33',	'[[10003,70000,2],[10001,70000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'205',	'205',	'205',	'',	'',	'',	'4',	'44',	'[[10003,70000,2],[10001,70000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'205',	'205',	'205',	'',	'',	'',	'5',	'55',	'[[10003,80000,2],[10001,80000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'205',	'205',	'205',	'',	'',	'',	'6',	'66',	'[[10003,80000,2],[10001,80000,2],[10002,420,2]]',	'Chip_test',	'Chip_test',	'5'},
{'206',	'206',	'206',	'6',	'2',	'',	'',	'',	'',	'',	'',	''},
{'206',	'206',	'206',	'',	'',	'',	'1',	'11',	'[[10003,60000,2],[10001,60000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'206',	'206',	'206',	'',	'',	'',	'2',	'22',	'[[10003,60000,2],[10001,60000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'206',	'206',	'206',	'',	'',	'',	'3',	'33',	'[[10003,70000,2],[10001,70000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'206',	'206',	'206',	'',	'',	'',	'4',	'44',	'[[10003,70000,2],[10001,70000,2],[10002,180,2]]',	'Chip_test',	'Chip_test',	'5'},
{'206',	'206',	'206',	'',	'',	'',	'5',	'55',	'[[10003,80000,2],[10001,80000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'206',	'206',	'206',	'',	'',	'',	'6',	'66',	'[[10003,80000,2],[10001,80000,2],[10002,420,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1601',	'1601',	'1601',	'1',	'1',	'',	'',	'',	'',	'',	'',	''},
{'1601',	'1601',	'1601',	'',	'',	'',	'1',	'3',	'[[10011,30,2],[10001,40000,2],[10003,20000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1601',	'1601',	'1601',	'',	'',	'',	'2',	'6',	'[[10011,30,2],[10001,40000,2],[10003,20000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1601',	'1601',	'1601',	'',	'',	'',	'3',	'9',	'[[10011,30,2],[10001,40000,2],[10003,20000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1601',	'1601',	'1601',	'',	'',	'',	'4',	'12',	'[[10011,30,2],[10001,40000,2],[10003,20000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1601',	'1601',	'1601',	'',	'',	'',	'5',	'15',	'[[10011,30,2],[10001,40000,2],[10003,20000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1601',	'1601',	'1601',	'',	'',	'',	'6',	'18',	'[[10011,30,2],[10001,40000,2],[10003,20000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1602',	'1602',	'1602',	'1',	'1',	'',	'',	'',	'',	'',	'',	''},
{'1602',	'1602',	'1602',	'',	'',	'',	'1',	'3',	'[[2000401,4,2],[10011,80,2],[10001,60000,2],[10003,30000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1602',	'1602',	'1602',	'',	'',	'',	'2',	'6',	'[[2000401,4,2],[10011,80,2],[10001,60000,2],[10003,30000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1602',	'1602',	'1602',	'',	'',	'',	'3',	'9',	'[[2000401,6,2],[10011,90,2],[10001,80000,2],[10003,40000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1602',	'1602',	'1602',	'',	'',	'',	'4',	'12',	'[[2000401,6,2],[10011,90,2],[10001,80000,2],[10003,40000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1602',	'1602',	'1602',	'',	'',	'',	'5',	'15',	'[[2000401,8,2],[10011,100,2],[10001,100000,2],[10003,50000,2]]',	'Chip_test',	'Chip_test',	'5'},
{'1602',	'1602',	'1602',	'',	'',	'',	'6',	'18',	'[[2000401,8,2],[10011,100,2],[10001,100000,2],[10003,50000,2]]',	'Chip_test',	'Chip_test',	'5'},
},
}
--cfgCfgSectionStarReward = conf
return conf
