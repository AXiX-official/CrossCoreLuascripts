local conf = {
	["filename"] = 's-宿舍.xlsx',
	["sheetname"] = '主题家具布置',
	["types"] = {
'int','string','table#7','int','int','int[]','int','int','int','int[]'
},
	["names"] = {
'id','key','infos','index','cfgID','point','planeType','rotateY','parentID','childID'
},
	["data"] = {
{'1001',	'1001',	'',	'',	'',	'',	'',	'',	'',	''},
{'1001',	'1001',	'',	'1',	'1041',	'0,0,0',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'2',	'1042',	'0,0,0',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'3',	'1001',	'4,0,-3.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'4',	'1001',	'4,0,-1.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'5',	'1003',	'6.5,0,6',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'6',	'1004',	'5.5,0,0.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'7',	'1009',	'7.5,0,2.5',	'1',	'270',	'',	''},
{'1001',	'1001',	'',	'8',	'1010',	'-7.5,0,-7.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'9',	'1011',	'7.95,2,-3',	'2',	'0',	'',	''},
{'1001',	'1001',	'',	'10',	'1013',	'1,0,0.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'11',	'1014',	'-4,0,-7.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'12',	'1040',	'0.5,0,-6',	'1',	'90',	'',	''},
{'1001',	'1001',	'',	'13',	'1046',	'-1.5,0,-3',	'1',	'270',	'',	''},
{'1001',	'1001',	'',	'14',	'1052',	'-7.5,0,-3.5',	'1',	'90',	'',	''},
{'1001',	'1001',	'',	'15',	'1045',	'4,0,2.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'16',	'1033',	'6.5,0,-0.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'17',	'1035',	'4.5,0,-6.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'18',	'1034',	'7.85,4,7',	'2',	'0',	'',	''},
{'1001',	'1001',	'',	'19',	'1034',	'7.85,4,0',	'2',	'0',	'',	''},
{'1001',	'1001',	'',	'20',	'1034',	'7.85,4,-5',	'2',	'0',	'',	''},
{'1001',	'1001',	'',	'21',	'1047',	'-3.5,0,4.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'22',	'1047',	'-6.5,0,6.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'23',	'1047',	'-6.5,0,4.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'24',	'1047',	'-3.5,0,6.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'25',	'1051',	'6.5,0,-7',	'1',	'270',	'',	''},
{'1001',	'1001',	'',	'26',	'1010',	'7.5,0,-7.5',	'1',	'270',	'',	''},
{'1001',	'1001',	'',	'27',	'1046',	'-4,0,-4.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'28',	'1005',	'-7.5,0,-1.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'29',	'1054',	'7,0,-3.5',	'1',	'270',	'',	''},
{'1001',	'1001',	'',	'30',	'1032',	'-1,0,4.5',	'1',	'270',	'',	''},
{'1001',	'1001',	'',	'31',	'1044',	'-3,0,0.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'32',	'1016',	'5.5,0,2.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'33',	'1048',	'-5,0,5.5',	'1',	'90',	'',	''},
{'1001',	'1001',	'',	'34',	'1030',	'2,0,-7.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'35',	'1037',	'-7.5,0,0.5',	'1',	'0',	'',	''},
{'1001',	'1001',	'',	'36',	'1006',	'7.5,0,-6',	'1',	'270',	'',	''},
{'2001',	'2001',	'',	'',	'',	'',	'',	'',	'',	''},
{'2001',	'2001',	'',	'1',	'2037',	'0,0,0',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'2',	'2036',	'0,0,0',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'3',	'2003',	'7.5,0,5.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'4',	'2004',	'5.5,0,2.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'5',	'2005',	'2.5,0,2',	'1',	'90',	'',	''},
{'2001',	'2001',	'',	'6',	'2006',	'-4.5,0,-7.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'7',	'2007',	'-7.5,0,1.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'8',	'2008',	'5,0,-6',	'1',	'90',	'',	''},
{'2001',	'2001',	'',	'9',	'2009',	'5.5,0,5.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'10',	'2010',	'5.5,0,-0.5',	'1',	'270',	'',	''},
{'2001',	'2001',	'',	'11',	'2011',	'-0.5,0,6.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'12',	'2012',	'-4.5,0,-2.5',	'1',	'270',	'',	''},
{'2001',	'2001',	'',	'13',	'2013',	'-4.5,0,-5.5',	'1',	'180',	'',	''},
{'2001',	'2001',	'',	'14',	'2014',	'4,0,3.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'15',	'2015',	'-7.5,0,-7.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'16',	'2016',	'5,0,-1',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'17',	'2017',	'5.5,0,0.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'18',	'2018',	'-7.5,0,4.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'19',	'2019',	'-3.5,0,1.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'20',	'2020',	'0.5,0,-7.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'21',	'2021',	'0,0,-2',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'22',	'2022',	'-7.5,0,-6.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'23',	'2023',	'7.95,2,1',	'2',	'0',	'',	''},
{'2001',	'2001',	'',	'24',	'2024',	'7.5,0,-3.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'25',	'2035',	'6,0,3.5',	'1',	'180',	'',	''},
{'2001',	'2001',	'',	'26',	'2034',	'-7.5,0,-2',	'1',	'90',	'',	''},
{'2001',	'2001',	'',	'27',	'2033',	'-0.5,0,-7.5',	'1',	'180',	'',	''},
{'2001',	'2001',	'',	'28',	'2032',	'-5.5,0,-2',	'1',	'90',	'',	''},
{'2001',	'2001',	'',	'29',	'2031',	'-3,0,-2',	'1',	'90',	'',	''},
{'2001',	'2001',	'',	'30',	'2030',	'-3.5,0,4.5',	'1',	'270',	'',	''},
{'2001',	'2001',	'',	'31',	'2029',	'-6,0,3',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'32',	'2028',	'-1,0,2.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'33',	'2027',	'1.5,0,7.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'34',	'2026',	'-2.5,0,7.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'35',	'2025',	'-6,0,5',	'1',	'180',	'',	''},
{'2001',	'2001',	'',	'36',	'2017',	'6.5,0,-0.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'37',	'2005',	'2.5,0,0',	'1',	'90',	'',	''},
{'2001',	'2001',	'',	'38',	'2020',	'1.5,0,-7.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'39',	'2020',	'6.5,0,-7.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'40',	'2015',	'7.5,0,-7.5',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'41',	'2005',	'2.5,0,7',	'1',	'90',	'',	''},
{'2001',	'2001',	'',	'42',	'2011',	'-5.5,0,5.5',	'1',	'90',	'',	''},
{'2001',	'2001',	'',	'43',	'2001',	'6.5,0,7',	'1',	'0',	'',	''},
{'2001',	'2001',	'',	'44',	'2002',	'6.5,0,-6',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'',	'',	'',	'',	'',	'',	''},
{'3001',	'3001',	'',	'1',	'3001',	'-4,0,7.5',	'1',	'270',	'',	''},
{'3001',	'3001',	'',	'2',	'3004',	'-3.5,0,-6.5',	'1',	'270',	'',	''},
{'3001',	'3001',	'',	'3',	'3005',	'-2.4,0,5.8',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'4',	'3006',	'-7,0,-6.5',	'1',	'90',	'',	''},
{'3001',	'3001',	'',	'5',	'3007',	'-7,0,-7.5',	'1',	'90',	'',	''},
{'3001',	'3001',	'',	'6',	'3008',	'-4.86,0,-3.35',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'7',	'3009',	'-5.5,0,4',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'8',	'3010',	'6,0,7',	'1',	'270',	'',	''},
{'3001',	'3001',	'',	'9',	'3011',	'4.5,0,2.5',	'1',	'90',	'',	''},
{'3001',	'3001',	'',	'10',	'3012',	'0.5,0,-3.5',	'1',	'90',	'',	''},
{'3001',	'3001',	'',	'11',	'3013',	'5,0,5',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'12',	'3014',	'-7,0,-4',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'13',	'3015',	'0.5,0,6.5',	'1',	'90',	'',	''},
{'3001',	'3001',	'',	'14',	'3017',	'-0.5,0,-7.5',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'15',	'3018',	'4.18,0,-4.12',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'16',	'3020',	'4.18,0,-4.12',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'17',	'3021',	'2.5,0,5.3',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'18',	'3022',	'-2.5,0,1.5',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'19',	'3023',	'0.5,0,-7.5',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'20',	'3024',	'6.5,0,2.5',	'1',	'270',	'',	''},
{'3001',	'3001',	'',	'21',	'3026',	'7.12,0,4.5',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'22',	'3028',	'7,0,4.4',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'23',	'3030',	'-7.12,0,-5.6',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'24',	'3031',	'-3.1,0,-4.5',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'25',	'3032',	'-7,0,0.1',	'1',	'90',	'',	''},
{'3001',	'3001',	'',	'26',	'3034',	'3.5,0,-7.5',	'1',	'270',	'',	''},
{'3001',	'3001',	'',	'27',	'3035',	'0.5,0,5.5',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'28',	'3038',	'0,0,0',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'29',	'3037',	'0,0,0',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'30',	'3003',	'4.64,0,-2.2',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'31',	'3003',	'4.64,0,-6',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'32',	'3002',	'-3.5,0,0.65',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'33',	'3016',	'1.5,0,-0.5',	'1',	'270',	'',	''},
{'3001',	'3001',	'',	'34',	'3025',	'2,0,0.5',	'1',	'90',	'',	''},
{'3001',	'3001',	'',	'35',	'3026',	'7,0,-3.81',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'36',	'3036',	'6.5,0,-6.32',	'1',	'270',	'',	''},
{'3001',	'3001',	'',	'37',	'3036',	'6.5,0,-2.5',	'1',	'270',	'',	''},
{'3001',	'3001',	'',	'38',	'3018',	'5.5,0,-0.5',	'1',	'0',	'',	''},
{'3001',	'3001',	'',	'39',	'3032',	'-5,0,0.1',	'1',	'90',	'',	''},
{'3001',	'3001',	'',	'40',	'3029',	'-0.6,3,-7.94',	'3',	'90',	'',	''},
{'3001',	'3001',	'',	'41',	'3027',	'-5,3,-7.625',	'3',	'90',	'',	''},
{'3001',	'3001',	'',	'42',	'3033',	'-7.5,0,-3.5',	'1',	'0',	'',	''},
{'4001',	'4001',	'',	'',	'',	'',	'',	'',	'',	''},
{'4001',	'4001',	'',	'1',	'4001',	'-0.5,0,-1.5',	'1',	'0',	'',	''},
{'4001',	'4001',	'',	'2',	'4002',	'7.5,0,0.5',	'1',	'0',	'',	''},
{'4001',	'4001',	'',	'3',	'4002',	'7.5,0,-0.5',	'1',	'0',	'',	''},
{'4001',	'4001',	'',	'4',	'4004',	'6,0,4',	'1',	'0',	'',	''},
{'4001',	'4001',	'',	'5',	'4004',	'6,0,6',	'1',	'0',	'',	''},
{'4001',	'4001',	'',	'6',	'4004',	'2,0,6',	'1',	'0',	'',	''},
{'4001',	'4001',	'',	'7',	'4005',	'-1.5,0,5.5',	'1',	'0',	'',	''},
{'4001',	'4001',	'',	'8',	'4006',	'2.5,0,-4.5',	'1',	'0',	'',	''},
{'4001',	'4001',	'',	'9',	'4007',	'6.5,0,-5.5',	'1',	'90',	'',	''},
{'4001',	'4001',	'',	'10',	'4008',	'-2.5,0,1.5',	'1',	'0',	'',	''},
{'4001',	'4001',	'',	'11',	'4009',	'0,0,-7',	'1',	'0',	'',	''},
{'4001',	'4001',	'',	'12',	'4010',	'-4,0,-7',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'',	'',	'',	'',	'',	'',	''},
{'5001',	'5001',	'',	'1',	'5031',	'0,0,0',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'2',	'5030',	'0,0,0',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'3',	'5009',	'-5.5,0,3.5',	'1',	'270',	'',	''},
{'5001',	'5001',	'',	'4',	'5011',	'-7.5,0,1.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'5',	'5011',	'-7.5,0,5.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'6',	'5021',	'-6,0,7.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'7',	'5029',	'-2.5,0,4',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'8',	'5013',	'-4,0,-3.5',	'1',	'90',	'',	''},
{'5001',	'5001',	'',	'9',	'5022',	'-5,0,-7.5',	'1',	'90',	'',	''},
{'5001',	'5001',	'',	'10',	'5001',	'-7.5,0,-7',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'11',	'5010',	'-2.5,0,-7.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'12',	'5010',	'3.5,0,-7.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'13',	'5020',	'-1.5,0,-3.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'14',	'5004',	'-4.5,0,1.5',	'1',	'90',	'',	''},
{'5001',	'5001',	'',	'15',	'5023',	'-3.5,0,0.5',	'1',	'90',	'',	''},
{'5001',	'5001',	'',	'16',	'5018',	'1,0,-7.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'17',	'5002',	'-7.5,0,-5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'18',	'5002',	'-7.5,0,-2',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'19',	'5014',	'5,0,-7.5',	'1',	'90',	'',	''},
{'5001',	'5001',	'',	'20',	'5024',	'1.5,0,-0.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'21',	'5024',	'1.5,0,-4.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'22',	'5024',	'5.5,0,-0.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'23',	'5024',	'5.5,0,-4.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'24',	'5010',	'7.5,0,4.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'25',	'5007',	'7.5,0,6.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'26',	'5008',	'5.5,0,4',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'27',	'5019',	'3.5,0,4',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'28',	'5032',	'7.5,0,-7.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'29',	'5033',	'7.5,0,-2.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'30',	'5034',	'7.5,0,1.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'31',	'5036',	'6.5,0,6.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'32',	'5036',	'3.5,0,6.5',	'1',	'180',	'',	''},
{'5001',	'5001',	'',	'33',	'5027',	'0.5,0,4',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'34',	'5028',	'0.5,0,7',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'35',	'5035',	'1.5,0,4',	'1',	'180',	'',	''},
{'5001',	'5001',	'',	'36',	'5035',	'-0.5,0,4',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'37',	'5035',	'1.5,0,7',	'1',	'180',	'',	''},
{'5001',	'5001',	'',	'38',	'5035',	'-0.5,0,7',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'39',	'5026',	'-4,0,-3',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'40',	'5025',	'5,0,6.5',	'1',	'0',	'',	''},
{'5001',	'5001',	'',	'41',	'5012',	'7.9,4,4.5',	'2',	'0',	'',	''},
{'5001',	'5001',	'',	'42',	'5012',	'7.9,4,-4.5',	'2',	'0',	'',	''},
{'6001',	'6001',	'',	'',	'',	'',	'',	'',	'',	''},
{'6001',	'6001',	'',	'1',	'6041',	'0,0,0',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'2',	'6043',	'0,0,0',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'3',	'6002',	'-6.5,0,-7.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'4',	'6002',	'-0.5,0,-7.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'5',	'6003',	'-4,0,4',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'6',	'6007',	'0.5,0,6.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'7',	'6008',	'6.5,0,-1.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'8',	'6010',	'-3.5,0,-3.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'9',	'6011',	'3.5,0,7',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'10',	'6013',	'5.5,0,2.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'11',	'6015',	'4.5,0,-4.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'12',	'6016',	'2.5,0,-3.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'13',	'6017',	'-6.5,0,0.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'14',	'6019',	'-6.5,0,-1.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'15',	'6020',	'-7.5,0,-4.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'16',	'6021',	'4.5,0,-1.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'17',	'6006',	'-4.5,0,7',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'18',	'6018',	'5.5,0,2.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'19',	'6023',	'0.5,0,1.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'20',	'6025',	'-2.5,0,0.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'21',	'6028',	'-5.5,0,4',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'22',	'6030',	'-3.5,0,1.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'23',	'6030',	'-4.5,0,1.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'24',	'6032',	'-4.5,0,0.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'25',	'6033',	'3.5,0,-7.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'26',	'6034',	'-7.5,0,-7.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'27',	'6038',	'-7.5,0,4.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'28',	'6037',	'-7.5,0,-2',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'29',	'6035',	'-1.5,0,-4.5',	'1',	'90',	'',	''},
{'6001',	'6001',	'',	'30',	'6024',	'0.5,0,4.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'31',	'6036',	'4,0,-4.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'32',	'6035',	'-6.5,0,-4.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'33',	'6012',	'-4,0,4',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'34',	'6027',	'7.95,0,-0.5',	'2',	'0',	'',	''},
{'6001',	'6001',	'',	'35',	'6005',	'5,3,-8',	'3',	'90',	'',	''},
{'6001',	'6001',	'',	'36',	'6001',	'6.5,0,7',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'37',	'6026',	'7.95,2,2.5',	'2',	'0',	'',	''},
{'6001',	'6001',	'',	'38',	'6029',	'7,0,2.5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'39',	'6031',	'7.95,3,7',	'2',	'0',	'',	''},
{'6001',	'6001',	'',	'40',	'6004',	'-4,4,-7.95',	'3',	'90',	'',	''},
{'6001',	'6001',	'',	'41',	'6040',	'7.5,0,-5',	'1',	'0',	'',	''},
{'6001',	'6001',	'',	'42',	'6009',	'2,3,-7.8',	'3',	'90',	'',	''},
{'6001',	'6001',	'',	'43',	'6044',	'-4,0,-7.95',	'3',	'90',	'',	''},
{'6001',	'6001',	'',	'44',	'6022',	'-3.5,0,-7.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'',	'',	'',	'',	'',	'',	''},
{'7001',	'7001',	'',	'1',	'7023',	'0,0,0',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'2',	'7022',	'0,0,0',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'3',	'7003',	'7,0,4',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'4',	'7004',	'-2.5,0,7',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'5',	'7002',	'-7.5,0,6.5',	'1',	'90',	'',	''},
{'7001',	'7001',	'',	'6',	'7006',	'-5,0,6',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'7',	'7007',	'-6.5,0,0.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'8',	'7008',	'2.5,0,7.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'9',	'7008',	'0.5,0,5.5',	'1',	'180',	'',	''},
{'7001',	'7001',	'',	'10',	'7008',	'1.5,0,7.5',	'1',	'90',	'',	''},
{'7001',	'7001',	'',	'11',	'7011',	'0,0,-7',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'12',	'7014',	'6.5,0,-2.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'13',	'7015',	'-6,3,-7.95',	'3',	'90',	'',	''},
{'7001',	'7001',	'',	'14',	'7015',	'6,3,-7.95',	'3',	'90',	'',	''},
{'7001',	'7001',	'',	'15',	'7016',	'-3.5,0,-1.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'16',	'7017',	'-2.5,0,-3.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'17',	'7017',	'4.5,0,-3.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'18',	'7018',	'-7,0,-7',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'19',	'7018',	'7,0,-7',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'20',	'7019',	'1,0,0',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'21',	'7020',	'-7.5,0,3.5',	'1',	'90',	'',	''},
{'7001',	'7001',	'',	'22',	'7021',	'-7.5,0,4.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'23',	'7024',	'-1.5,0,7.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'24',	'7027',	'2,0,6',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'25',	'7028',	'-7.5,0,-0.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'26',	'7029',	'7,0,6.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'27',	'7030',	'-4.5,0,-7.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'28',	'7031',	'-7,0,-3',	'1',	'180',	'',	''},
{'7001',	'7001',	'',	'29',	'7032',	'7.95,3,-2.5',	'2',	'0',	'',	''},
{'7001',	'7001',	'',	'30',	'7001',	'-5,0,5.5',	'1',	'90',	'',	''},
{'7001',	'7001',	'',	'31',	'7014',	'6.5,0,2.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'32',	'7013',	'-5.5,0,2.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'33',	'7025',	'4.5,0,2',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'34',	'7025',	'4.5,0,-2',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'35',	'7026',	'0.5,0,-3.5',	'1',	'90',	'',	''},
{'7001',	'7001',	'',	'36',	'7025',	'-2.5,0,2',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'37',	'7025',	'-2.5,0,-2',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'38',	'7026',	'1.5,0,3.5',	'1',	'90',	'',	''},
{'7001',	'7001',	'',	'39',	'7005',	'-5,0,3.5',	'1',	'0',	'',	''},
{'7001',	'7001',	'',	'40',	'7010',	'5.5,0,6.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'',	'',	'',	'',	'',	'',	''},
{'8001',	'8001',	'',	'1',	'8022',	'0,0,0',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'2',	'8023',	'0,0,0',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'3',	'8002',	'6.5,0,-4',	'1',	'270',	'',	''},
{'8001',	'8001',	'',	'4',	'8003',	'-2.5,0,5.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'5',	'8004',	'-2.5,0,4.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'6',	'8006',	'4.5,0,-5.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'7',	'8006',	'4.5,0,-3.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'8',	'8007',	'1.5,0,4.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'9',	'8008',	'6,0,7.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'10',	'8009',	'6.5,0,1.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'11',	'8012',	'1.5,0,5.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'12',	'8013',	'0,4,-7.95',	'3',	'90',	'',	''},
{'8001',	'8001',	'',	'13',	'8013',	'-5,4,-7.95',	'3',	'90',	'',	''},
{'8001',	'8001',	'',	'14',	'8014',	'7.95,2,4',	'2',	'0',	'',	''},
{'8001',	'8001',	'',	'15',	'8015',	'-7.5,0,4.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'16',	'8016',	'7.95,2,6.5',	'2',	'0',	'',	''},
{'8001',	'8001',	'',	'17',	'8017',	'3,0,7.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'18',	'8017',	'-3,0,-7.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'19',	'8017',	'-5,0,-7.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'20',	'8018',	'-7.5,0,-7.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'21',	'8019',	'-2.5,0,-0.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'22',	'8019',	'-7.5,0,-0.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'23',	'8024',	'-5.5,0,-6.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'24',	'8025',	'5.5,0,4.5',	'1',	'90',	'',	''},
{'8001',	'8001',	'',	'25',	'8025',	'5.5,0,3.5',	'1',	'270',	'',	''},
{'8001',	'8001',	'',	'26',	'8026',	'0.5,0,-6.5',	'1',	'270',	'',	''},
{'8001',	'8001',	'',	'27',	'8027',	'1,0,-4.5',	'1',	'270',	'',	''},
{'8001',	'8001',	'',	'28',	'8028',	'2.5,0,5.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'29',	'8029',	'2.5,0,2.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'30',	'8029',	'2.5,0,4.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'31',	'8031',	'1,0,-1.5',	'1',	'270',	'',	''},
{'8001',	'8001',	'',	'32',	'8033',	'5.5,0,2',	'1',	'270',	'',	''},
{'8001',	'8001',	'',	'33',	'8034',	'-1.5,0,-5.5',	'1',	'270',	'',	''},
{'8001',	'8001',	'',	'34',	'8007',	'3.5,0,4.5',	'1',	'180',	'',	''},
{'8001',	'8001',	'',	'35',	'8007',	'3.5,0,2.5',	'1',	'180',	'',	''},
{'8001',	'8001',	'',	'36',	'8007',	'1.5,0,2.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'37',	'8017',	'-7,0,7.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'38',	'8015',	'-7.5,0,6.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'39',	'8032',	'7.5,0,0',	'1',	'270',	'',	''},
{'8001',	'8001',	'',	'40',	'8011',	'-5,0,-3.5',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'41',	'8020',	'-5,0,2',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'42',	'8021',	'-4,0,4',	'1',	'0',	'',	''},
{'8001',	'8001',	'',	'43',	'8005',	'3,0,-4',	'1',	'90',	'',	''},
{'8001',	'8001',	'',	'44',	'8021',	'4,0,4',	'1',	'0',	'',	''},
{'9001',	'9001',	'',	'',	'',	'',	'',	'',	'',	''},
{'9001',	'9001',	'',	'1',	'9024',	'0,0,0',	'1',	'0',	'',	''},
{'9001',	'9001',	'',	'2',	'9025',	'0,0,0',	'1',	'0',	'',	''},
{'9001',	'9001',	'',	'3',	'9001',	'2,0,-4',	'1',	'180',	'',	''},
{'9001',	'9001',	'',	'4',	'9002',	'-1.5,0,-7.5',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'5',	'9004',	'7.5,0,5',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'6',	'9005',	'-2.5,0,-4',	'1',	'0',	'',	''},
{'9001',	'9001',	'',	'7',	'9006',	'0.5,0,-7.5',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'8',	'9007',	'-4,0,3.5',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'9',	'9008',	'5.5,0,5',	'1',	'90',	'',	''},
{'9001',	'9001',	'',	'10',	'9009',	'6.5,0,4.5',	'1',	'180',	'',	''},
{'9001',	'9001',	'',	'11',	'9010',	'2.5,0,5.5',	'1',	'90',	'',	''},
{'9001',	'9001',	'',	'12',	'9010',	'-6.5,0,5.5',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'13',	'9011',	'-1,2,-7.95',	'3',	'90',	'',	''},
{'9001',	'9001',	'',	'14',	'9012',	'7.5,0,0.5',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'15',	'9013',	'3,0,-7.5',	'1',	'0',	'',	''},
{'9001',	'9001',	'',	'16',	'9014',	'-7.5,0,-6.5',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'17',	'9015',	'-6.5,0,2',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'18',	'9016',	'6,3,-7.95',	'3',	'90',	'',	''},
{'9001',	'9001',	'',	'19',	'9017',	'-5,0,-2',	'1',	'0',	'',	''},
{'9001',	'9001',	'',	'20',	'9018',	'4.5,0,5',	'1',	'90',	'',	''},
{'9001',	'9001',	'',	'21',	'9019',	'7.5,0,7.5',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'22',	'9020',	'1,2,-7.95',	'3',	'90',	'',	''},
{'9001',	'9001',	'',	'23',	'9021',	'5,2,-7.95',	'3',	'90',	'',	''},
{'9001',	'9001',	'',	'24',	'9022',	'7.95,2,-5',	'2',	'0',	'',	''},
{'9001',	'9001',	'',	'25',	'9023',	'7,0,-5.5',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'26',	'9026',	'7.95,1,-2.5',	'2',	'0',	'',	''},
{'9001',	'9001',	'',	'27',	'9027',	'-5.5,0,-6.5',	'1',	'0',	'',	''},
{'9001',	'9001',	'',	'28',	'9028',	'-2,0,6',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'29',	'9029',	'5.5,0,3.5',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'30',	'9003',	'6.5,0,-0.5',	'1',	'270',	'',	''},
{'9001',	'9001',	'',	'31',	'9030',	'-3,2,-7.95',	'3',	'90',	'',	''},
{'9001',	'9001',	'',	'32',	'9030',	'-3,3,-7.95',	'3',	'90',	'',	''},
{'10001',	'10001',	'',	'',	'',	'',	'',	'',	'',	''},
{'10001',	'10001',	'',	'1',	'10028',	'0,0,0',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'2',	'10029',	'0,0,0',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'3',	'10001',	'-2.5,0,2.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'4',	'10002',	'-4.5,0,1.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'5',	'10004',	'-7.5,0,7.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'6',	'10005',	'3.5,0,-0.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'7',	'10005',	'1.5,0,-6.5',	'1',	'90',	'',	''},
{'10001',	'10001',	'',	'8',	'10006',	'6.5,0,-0.5',	'1',	'180',	'',	''},
{'10001',	'10001',	'',	'9',	'10007',	'-1.5,0,3.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'10',	'10003',	'5,0,0.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'11',	'10008',	'5,1,-7.95',	'3',	'90',	'',	''},
{'10001',	'10001',	'',	'12',	'10010',	'-4.5,0,4.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'13',	'10011',	'5.5,0,-4',	'1',	'180',	'',	''},
{'10001',	'10001',	'',	'14',	'10012',	'3.5,0,-2.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'15',	'10012',	'7.5,0,-2.5',	'1',	'180',	'',	''},
{'10001',	'10001',	'',	'16',	'10013',	'1.5,0,1',	'1',	'270',	'',	''},
{'10001',	'10001',	'',	'17',	'10014',	'-2.5,0,-4.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'18',	'10015',	'-5.5,0,-4.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'19',	'10016',	'-2.5,0,-3.5',	'1',	'270',	'',	''},
{'10001',	'10001',	'',	'20',	'10017',	'-5.5,0,-3.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'21',	'10018',	'2.5,0,1.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'22',	'10018',	'-7.5,0,-7.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'23',	'10019',	'7.95,4,7',	'2',	'0',	'',	''},
{'10001',	'10001',	'',	'24',	'10019',	'7.95,4,0',	'2',	'0',	'',	''},
{'10001',	'10001',	'',	'25',	'10019',	'7.95,4,-7',	'2',	'0',	'',	''},
{'10001',	'10001',	'',	'26',	'10020',	'-2,3,-7.95',	'3',	'90',	'',	''},
{'10001',	'10001',	'',	'27',	'10020',	'-6,3,-7.95',	'3',	'90',	'',	''},
{'10001',	'10001',	'',	'28',	'10021',	'3.5,0,2',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'29',	'10021',	'6.5,0,2',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'30',	'10021',	'6.5,0,7',	'1',	'180',	'',	''},
{'10001',	'10001',	'',	'31',	'10021',	'3.5,0,7',	'1',	'180',	'',	''},
{'10001',	'10001',	'',	'32',	'10023',	'-6.5,0,3',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'33',	'10024',	'-6.5,0,5.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'34',	'10025',	'-3.5,0,2.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'35',	'10026',	'1.5,0,3.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'36',	'10026',	'-7.5,0,0.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'37',	'10027',	'-6.5,0,-7.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'38',	'10027',	'-1.5,0,-7.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'39',	'10009',	'-4,0,-2.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'40',	'10030',	'-4,0,-1.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'41',	'10031',	'5.5,0,-5.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'42',	'10032',	'5.5,0,-2.5',	'1',	'0',	'',	''},
{'10001',	'10001',	'',	'43',	'10033',	'-4,0,-7.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'',	'',	'',	'',	'',	'',	''},
{'11001',	'11001',	'',	'1',	'11026',	'0,0,0',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'2',	'11027',	'0,0,0',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'3',	'11003',	'4,0,6',	'1',	'270',	'',	''},
{'11001',	'11001',	'',	'4',	'11003',	'4,0,2',	'1',	'270',	'',	''},
{'11001',	'11001',	'',	'5',	'11004',	'-3.5,0,-7.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'6',	'11005',	'4.5,0,-3.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'7',	'11006',	'-2.5,0,7.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'8',	'11007',	'-6,0,-6',	'1',	'270',	'',	''},
{'11001',	'11001',	'',	'9',	'11008',	'4,0,3',	'1',	'270',	'',	''},
{'11001',	'11001',	'',	'10',	'11009',	'-5,0,4.5',	'1',	'270',	'',	''},
{'11001',	'11001',	'',	'11',	'11010',	'7.5,0,1.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'12',	'11010',	'7.5,0,5.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'13',	'11010',	'7.5,0,7.5',	'1',	'180',	'',	''},
{'11001',	'11001',	'',	'14',	'11010',	'7.5,0,3.5',	'1',	'180',	'',	''},
{'11001',	'11001',	'',	'15',	'11011',	'7,0,-3',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'16',	'11012',	'-4,4,-7.95',	'3',	'90',	'',	''},
{'11001',	'11001',	'',	'17',	'11013',	'-7.5,0,-0.5',	'1',	'270',	'',	''},
{'11001',	'11001',	'',	'18',	'11014',	'-7.5,0,0.5',	'1',	'270',	'',	''},
{'11001',	'11001',	'',	'19',	'11015',	'-4.5,0,-7.5',	'1',	'90',	'',	''},
{'11001',	'11001',	'',	'20',	'11016',	'-7.5,0,-7.5',	'1',	'90',	'',	''},
{'11001',	'11001',	'',	'21',	'11017',	'-6.5,0,-4.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'22',	'11018',	'-1.5,0,-0.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'23',	'11019',	'-0.5,0,6.5',	'1',	'270',	'',	''},
{'11001',	'11001',	'',	'24',	'11020',	'-1.5,0,-7',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'25',	'11021',	'6,4,-7.95',	'3',	'90',	'',	''},
{'11001',	'11001',	'',	'26',	'11021',	'1,4,-7.95',	'3',	'90',	'',	''},
{'11001',	'11001',	'',	'27',	'11022',	'-3.5,0,-6.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'28',	'11023',	'7.95,3,2',	'2',	'0',	'',	''},
{'11001',	'11001',	'',	'29',	'11024',	'7.95,2,-1',	'2',	'0',	'',	''},
{'11001',	'11001',	'',	'30',	'11025',	'4.5,0,-6.5',	'1',	'90',	'',	''},
{'11001',	'11001',	'',	'31',	'11028',	'0.5,0,0',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'32',	'11029',	'-4,0,1.5',	'1',	'90',	'',	''},
{'11001',	'11001',	'',	'33',	'11030',	'7.5,0,-6.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'34',	'11031',	'-6,0,7.5',	'1',	'90',	'',	''},
{'11001',	'11001',	'',	'35',	'11032',	'-3.5,0,6',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'36',	'11033',	'-4.5,0,6.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'37',	'11033',	'-7.5,0,3.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'38',	'11034',	'7.5,0,6.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'39',	'11034',	'7.5,0,2.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'40',	'11035',	'-5.5,0,5.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'41',	'11036',	'-6,0,2.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'42',	'11001',	'4,0,-7.5',	'1',	'0',	'',	''},
{'11001',	'11001',	'',	'43',	'11037',	'8,3,6',	'2',	'0',	'',	''},
{'11001',	'11001',	'',	'44',	'11037',	'-6.5,3,-8',	'3',	'90',	'',	''},
{'11001',	'11001',	'',	'45',	'11002',	'-6,0,-6.5',	'1',	'90',	'',	''},
{'14001',	'14001',	'',	'',	'',	'',	'',	'',	'',	''},
{'14001',	'14001',	'',	'1',	'14017',	'0,0,0',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'2',	'14018',	'0,0,0',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'3',	'14001',	'-6,0,-5.5',	'1',	'270',	'',	''},
{'14001',	'14001',	'',	'4',	'14002',	'3,0,0',	'1',	'270',	'',	''},
{'14001',	'14001',	'',	'5',	'14004',	'-6,0,-7.5',	'1',	'90',	'',	''},
{'14001',	'14001',	'',	'6',	'14005',	'-5,0,5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'7',	'14006',	'-3.5,0,-6',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'8',	'14007',	'-2.5,0,-0.5',	'1',	'90',	'',	''},
{'14001',	'14001',	'',	'9',	'14007',	'-2.5,0,1.5',	'1',	'270',	'',	''},
{'14001',	'14001',	'',	'10',	'14007',	'-3.5,0,1.5',	'1',	'270',	'',	''},
{'14001',	'14001',	'',	'11',	'14007',	'-3.5,0,-0.5',	'1',	'90',	'',	''},
{'14001',	'14001',	'',	'12',	'14007',	'-7.5,0,1.5',	'1',	'270',	'',	''},
{'14001',	'14001',	'',	'13',	'14007',	'-6.5,0,1.5',	'1',	'270',	'',	''},
{'14001',	'14001',	'',	'14',	'14007',	'-6.5,0,-0.5',	'1',	'90',	'',	''},
{'14001',	'14001',	'',	'15',	'14007',	'-7.5,0,-0.5',	'1',	'90',	'',	''},
{'14001',	'14001',	'',	'16',	'14009',	'3,0,2.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'17',	'14012',	'-1.5,0,2.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'18',	'14013',	'-3.5,0,-7.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'19',	'14011',	'-5.5,0,7.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'20',	'14011',	'-2.5,0,7.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'21',	'14011',	'6.5,0,7.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'22',	'14011',	'3.5,0,7.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'23',	'14011',	'0.5,0,7.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'24',	'14015',	'3,0,4.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'25',	'14019',	'0,3,-7.95',	'3',	'90',	'',	''},
{'14001',	'14001',	'',	'26',	'14021',	'-3,0,5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'27',	'14022',	'7.95,2,0.5',	'2',	'0',	'',	''},
{'14001',	'14001',	'',	'28',	'14022',	'7.95,2,6.5',	'2',	'0',	'',	''},
{'14001',	'14001',	'',	'29',	'14023',	'-4.5,0,-4.5',	'1',	'270',	'',	''},
{'14001',	'14001',	'',	'30',	'14024',	'-3,0,0.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'31',	'14024',	'-7,0,0.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'32',	'14025',	'-5.5,0,5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'33',	'14020',	'-7.5,0,5',	'1',	'180',	'',	''},
{'14001',	'14001',	'',	'34',	'14003',	'4.5,0,-2.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'35',	'14008',	'4,0,-6',	'1',	'270',	'',	''},
{'14001',	'14001',	'',	'36',	'14014',	'3,0,-6',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'37',	'14008',	'2,0,-6',	'1',	'270',	'',	''},
{'14001',	'14001',	'',	'38',	'14026',	'5.5,0,-6',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'39',	'14026',	'0.5,0,-6',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'40',	'14027',	'7.5,0,-6.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'41',	'14027',	'7.5,0,-5.5',	'1',	'0',	'',	''},
{'14001',	'14001',	'',	'42',	'14016',	'-1.5,0,-6.5',	'1',	'90',	'',	''},
{'14001',	'14001',	'',	'43',	'14028',	'8,2,3.5',	'2',	'0',	'',	''},
},
}
--cfgCfgThemeLayout = conf
return conf
