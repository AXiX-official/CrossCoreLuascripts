local conf = {
	["filename"] = 'G-关卡组配置.xlsx',
	["sheetname"] = '十二星宫分组',
	["types"] = {
'int','int','int','string','int','int[]','string','string','string','string','string','int','json'
},
	["names"] = {
'id','key','group','name','type','dungeonGroups','icon','bg','video','effect','img','showType','target'
},
	["data"] = {
{'14001',	'14001',	'9001',	'双子座-波拉克斯-简单',	'1',	'30101',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'4',	'[{"pos":[-480,-205],"scale":1.4,"time":0.6}]'},
{'14002',	'14002',	'9001',	'双子座-波拉克斯-普通',	'1',	'30102',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'5',	'[{"pos":[-480,-205],"scale":1.4,"time":0.6}]'},
{'14003',	'14003',	'9001',	'双子座-波拉克斯-困难',	'1',	'30103',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'5',	'[{"pos":[-480,-205],"scale":1.4,"time":0.6}]'},
{'14004',	'14004',	'9001',	'双子座-波拉克斯-地狱',	'1',	'30104',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'5',	'[{"pos":[-480,-205],"scale":1.4,"time":0.6}]'},
{'14005',	'14005',	'9002',	'双子座-卡斯托-简单',	'1',	'30105',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'4',	'[{"pos":[262,-205],"scale":1.4,"time":0.6}]'},
{'14006',	'14006',	'9002',	'双子座-卡斯托-普通',	'1',	'30106',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'5',	'[{"pos":[262,-205],"scale":1.4,"time":0.6}]'},
{'14007',	'14007',	'9002',	'双子座-卡斯托-困难',	'1',	'30107',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'5',	'[{"pos":[262,-205],"scale":1.4,"time":0.6}]'},
{'14008',	'14008',	'9002',	'双子座-卡斯托-地狱',	'1',	'30108',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'5',	'[{"pos":[262,-205],"scale":1.4,"time":0.6}]'},
{'14009',	'14009',	'9003',	'双子座-简单',	'1',	'30109',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'4',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14010',	'14010',	'9003',	'双子座-普通',	'1',	'30110',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14011',	'14011',	'9003',	'双子座-困难',	'1',	'30111',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14012',	'14012',	'9003',	'双子座-地狱',	'1',	'30112',	'icon_02',	'',	'',	'ShuangZiZuo',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14101',	'14101',	'9004',	'狮子座-简单',	'1',	'30201',	'icon_02',	'',	'',	'ShiZiZuo',	'img1',	'4',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14102',	'14102',	'9004',	'狮子座-普通',	'1',	'30202',	'icon_02',	'',	'',	'ShiZiZuo',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14103',	'14103',	'9004',	'狮子座-困难',	'1',	'30203',	'icon_02',	'',	'',	'ShiZiZuo',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14104',	'14104',	'9004',	'狮子座-噩梦',	'1',	'30204',	'icon_02',	'',	'',	'ShiZiZuo',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14105',	'14105',	'9004',	'狮子座-地狱',	'1',	'30205',	'icon_02',	'',	'',	'ShiZiZuo',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14106',	'14106',	'9005',	'狮子座-简单',	'1',	'30206',	'icon_02',	'',	'',	'ShiZiZuo',	'img1',	'4',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14107',	'14107',	'9005',	'狮子座-普通',	'1',	'30207',	'icon_02',	'',	'',	'ShiZiZuo',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14108',	'14108',	'9005',	'狮子座-困难',	'1',	'30208',	'icon_02',	'',	'',	'ShiZiZuo',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14109',	'14109',	'9005',	'狮子座-噩梦',	'1',	'30209',	'icon_02',	'',	'',	'ShiZiZuo',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14110',	'14110',	'9005',	'狮子座-地狱',	'1',	'30210',	'icon_02',	'',	'',	'ShiZiZuo',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14201',	'14201',	'9006',	'巨蟹座-简单',	'1',	'30301',	'icon_02',	'',	'',	'Cancer',	'img1',	'4',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14202',	'14202',	'9006',	'巨蟹座-普通',	'1',	'30302',	'icon_02',	'',	'',	'Cancer',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14203',	'14203',	'9006',	'巨蟹座-困难',	'1',	'30303',	'icon_02',	'',	'',	'Cancer',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14204',	'14204',	'9006',	'巨蟹座-地狱',	'1',	'30304',	'icon_02',	'',	'',	'Cancer',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14205',	'14205',	'9006',	'巨蟹座-噩梦',	'1',	'30305',	'icon_02',	'',	'',	'Cancer',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14206',	'14206',	'9007',	'巨蟹座-简单',	'1',	'30306',	'icon_02',	'',	'',	'Cancer',	'img1',	'4',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14207',	'14207',	'9007',	'巨蟹座-普通',	'1',	'30307',	'icon_02',	'',	'',	'Cancer',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14208',	'14208',	'9007',	'巨蟹座-困难',	'1',	'30308',	'icon_02',	'',	'',	'Cancer',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14209',	'14209',	'9007',	'巨蟹座-地狱',	'1',	'30309',	'icon_02',	'',	'',	'Cancer',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
{'14210',	'14210',	'9007',	'巨蟹座-噩梦',	'1',	'30310',	'icon_02',	'',	'',	'Cancer',	'img1',	'5',	'[{"pos":[-159,-270],"scale":1.2,"time":0.4}]'},
},
}
--cfgDungeonGroup6 = conf
return conf
