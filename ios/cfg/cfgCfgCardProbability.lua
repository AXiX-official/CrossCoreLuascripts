local conf = {
	["filename"] = 'k-卡牌建造置表.xlsx',
	["sheetname"] = '卡池概率',
	["types"] = {
'int','int','int','string','float','string'
},
	["names"] = {
'id','group','cardid','desc','probability','procolor'
},
	["data"] = {
{'1001001',	'1001',	'10010',	'<color=#FFCC00>期间限定！！</color>',	'0.002',	'FFCC00'},
{'1001002',	'1001',	'20010',	'',	'0.0018',	''},
{'1001003',	'1001',	'30010',	'<color=#FFCC00>期间限定！！</color>',	'0.0009',	'FFCC00'},
{'1001004',	'1001',	'30050',	'',	'0.0018',	''},
{'1001005',	'1001',	'40010',	'',	'0.0009',	''},
{'1001006',	'1001',	'50010',	'',	'0.0018',	''},
{'1001007',	'1001',	'70010',	'',	'0.0018',	''},
{'1001008',	'1001',	'60010',	'',	'0.0018',	''},
{'1001009',	'1001',	'60190',	'',	'0.0018',	''},
{'1001010',	'1001',	'70030',	'',	'0.0018',	''},
{'1001011',	'1001',	'30180',	'',	'0.0018',	''},
{'1001012',	'1001',	'70050',	'',	'0.0018',	''},
{'1001013',	'1001',	'10030',	'',	'0.0183',	''},
{'1001014',	'1001',	'20020',	'',	'0.0173',	''},
{'1001015',	'1001',	'30120',	'',	'0.0173',	''},
{'1001016',	'1001',	'30200',	'',	'0.0173',	''},
{'1001017',	'1001',	'40140',	'',	'0.0173',	''},
{'1001018',	'1001',	'50030',	'<color=#FFCC00>期间限定！！</color>',	'0.0087',	'FFCC00'},
{'1001019',	'1001',	'50060',	'',	'0.0173',	''},
{'1001020',	'1001',	'50080',	'',	'0.0173',	''},
{'1001021',	'1001',	'50140',	'',	'0.0173',	''},
{'1001022',	'1001',	'60110',	'',	'0.0173',	''},
{'1001023',	'1001',	'70070',	'',	'0.0173',	''},
{'1001024',	'1001',	'70130',	'',	'0.0173',	''},
{'1001025',	'1001',	'10190',	'',	'0.065',	''},
{'1001026',	'1001',	'20090',	'',	'0.055',	''},
{'1001027',	'1001',	'30080',	'',	'0.055',	''},
{'1001028',	'1001',	'40290',	'',	'0.055',	''},
{'1001029',	'1001',	'50180',	'',	'0.055',	''},
{'1001030',	'1001',	'60080',	'',	'0.055',	''},
{'1001031',	'1001',	'20150',	'',	'0.055',	''},
{'1001032',	'1001',	'30100',	'',	'0.055',	''},
{'1001033',	'1001',	'20040',	'',	'0.055',	''},
{'1001034',	'1001',	'10110',	'',	'0.055',	''},
{'1001035',	'1001',	'10180',	'',	'0.055',	''},
{'1001036',	'1001',	'30020',	'',	'0.055',	''},
{'1001037',	'1001',	'40050',	'',	'0.055',	''},
{'1001038',	'1001',	'60140',	'',	'0.055',	''},
{'1002001',	'1002',	'10010',	'',	'0.0025',	''},
{'1002002',	'1002',	'30010',	'',	'0.0025',	''},
{'1002003',	'1002',	'30050',	'',	'0.0025',	''},
{'1002004',	'1002',	'70010',	'<color=#FFCC00>期间UP！！</color>',	'0.0075',	'FFCC00'},
{'1002005',	'1002',	'70030',	'',	'0.0025',	''},
{'1002006',	'1002',	'70130',	'',	'0.0025',	''},
{'1002007',	'1002',	'20020',	'<color=#FFCC00>期间UP！！</color>',	'0.035',	'FFCC00'},
{'1002008',	'1002',	'50030',	'',	'0.033',	''},
{'1002009',	'1002',	'50060',	'',	'0.033',	''},
{'1002010',	'1002',	'50140',	'',	'0.033',	''},
{'1002011',	'1002',	'50180',	'',	'0.033',	''},
{'1002012',	'1002',	'70070',	'',	'0.033',	''},
{'1002013',	'1002',	'90370',	'<color=#FFCC00>期间UP！！</color>',	'0.007',	'FFCC00'},
{'1002014',	'1002',	'90380',	'<color=#FFCC00>期间UP！！</color>',	'0.007',	'FFCC00'},
{'1002015',	'1002',	'90410',	'',	'0.003',	''},
{'1002016',	'1002',	'90420',	'',	'0.003',	''},
{'1002017',	'1002',	'90430',	'',	'0.003',	''},
{'1002018',	'1002',	'90440',	'',	'0.003',	''},
{'1002019',	'1002',	'90450',	'',	'0.003',	''},
{'1002020',	'1002',	'90460',	'',	'0.003',	''},
{'1002021',	'1002',	'30080',	'',	'0.012',	''},
{'1002022',	'1002',	'30120',	'',	'0.012',	''},
{'1002023',	'1002',	'30200',	'',	'0.012',	''},
{'1002024',	'1002',	'90260',	'',	'0.0125',	''},
{'1002025',	'1002',	'90270',	'',	'0.0125',	''},
{'1002026',	'1002',	'90280',	'',	'0.0125',	''},
{'1002027',	'1002',	'90290',	'',	'0.0125',	''},
{'1002028',	'1002',	'90310',	'',	'0.025',	''},
{'1002029',	'1002',	'90330',	'',	'0.025',	''},
{'1003001',	'1003',	'10010',	'',	'0.0021428571428571',	''},
{'1003002',	'1003',	'10020',	'',	'0.0021428571428571',	''},
{'1003003',	'1003',	'10030',	'',	'0.0021428571428571',	''},
{'1003004',	'1003',	'10040',	'',	'0.0021428571428571',	''},
{'1003005',	'1003',	'10050',	'',	'0.0021428571428571',	''},
{'1003006',	'1003',	'10060',	'',	'0.0021428571428571',	''},
{'1003007',	'1003',	'10070',	'',	'0.0021428571428571',	''},
{'1003008',	'1003',	'10080',	'',	'0.0021428571428571',	''},
{'1003009',	'1003',	'10090',	'<color=#FFCC00>期间限定！！</color>',	'0.0010714285714286',	'FFCC00'},
{'1003010',	'1003',	'10100',	'',	'0.0021428571428571',	''},
{'1003011',	'1003',	'10110',	'',	'0.0021428571428571',	''},
{'1003012',	'1003',	'10120',	'',	'0.0021428571428571',	''},
{'1003013',	'1003',	'10130',	'<color=#FFCC00>期间限定！！</color>',	'0.0010714285714286',	'FFCC00'},
{'1003014',	'1003',	'10140',	'',	'0.0021428571428571',	''},
{'1003015',	'1003',	'10150',	'',	'0.0021428571428571',	''},
{'1003016',	'1003',	'20010',	'',	'0.0041666666666667',	''},
{'1003017',	'1003',	'20020',	'',	'0.0041666666666667',	''},
{'1003018',	'1003',	'20030',	'',	'0.0041666666666667',	''},
{'1003019',	'1003',	'20040',	'',	'0.0041666666666667',	''},
{'1003020',	'1003',	'20050',	'',	'0.0041666666666667',	''},
{'1003021',	'1003',	'20060',	'<color=#FFCC00>期间限定！！</color>',	'0.0020833333333333',	'FFCC00'},
{'1003022',	'1003',	'20070',	'',	'0.0041666666666667',	''},
{'1003023',	'1003',	'20080',	'<color=#FFCC00>期间限定！！</color>',	'0.0020833333333333',	'FFCC00'},
{'1003024',	'1003',	'20090',	'',	'0.0041666666666667',	''},
{'1003025',	'1003',	'20100',	'',	'0.0041666666666667',	''},
{'1003026',	'1003',	'20110',	'',	'0.0041666666666667',	''},
{'1003027',	'1003',	'20120',	'',	'0.0041666666666667',	''},
{'1003028',	'1003',	'20130',	'',	'0.0041666666666667',	''},
{'1003029',	'1003',	'20140',	'<color=#FFCC00>期间限定！！</color>',	'0.0020833333333333',	'FFCC00'},
{'1003030',	'1003',	'20150',	'',	'0.0041666666666667',	''},
{'1003031',	'1003',	'20160',	'',	'0.0041666666666667',	''},
{'1003042',	'1003',	'30010',	'',	'0.037826086956522',	''},
{'1003043',	'1003',	'30020',	'',	'0.037826086956522',	''},
{'1003044',	'1003',	'30030',	'',	'0.037826086956522',	''},
{'1003045',	'1003',	'30040',	'',	'0.037826086956522',	''},
{'1003046',	'1003',	'30050',	'',	'0.037826086956522',	''},
{'1003047',	'1003',	'30060',	'',	'0.037826086956522',	''},
{'1003048',	'1003',	'30070',	'',	'0.037826086956522',	''},
{'1003049',	'1003',	'30080',	'',	'0.037826086956522',	''},
{'1003050',	'1003',	'30090',	'',	'0.037826086956522',	''},
{'1003051',	'1003',	'30100',	'',	'0.037826086956522',	''},
{'1003052',	'1003',	'30110',	'',	'0.037826086956522',	''},
{'1003053',	'1003',	'30120',	'',	'0.037826086956522',	''},
{'1003054',	'1003',	'30130',	'',	'0.037826086956522',	''},
{'1003055',	'1003',	'30140',	'<color=#FFCC00>期间限定！！</color>',	'0.018913043478261',	'FFCC00'},
{'1003056',	'1003',	'30150',	'<color=#FFCC00>期间限定！！</color>',	'0.018913043478261',	'FFCC00'},
{'1003057',	'1003',	'30160',	'',	'0.037826086956522',	''},
{'1003058',	'1003',	'30170',	'<color=#FFCC00>期间限定！！</color>',	'0.018913043478261',	'FFCC00'},
{'1003059',	'1003',	'30180',	'',	'0.037826086956522',	''},
{'1003060',	'1003',	'30190',	'',	'0.037826086956522',	''},
{'1003061',	'1003',	'30200',	'',	'0.037826086956522',	''},
},
}
--cfgCfgCardProbability = conf
return conf
