local conf = {
	["filename"] = 'r-任务配置表.xlsx',
	["sheetname"] = '十二星宫',
	["types"] = {
'int','string','int','int','string','string','int','int','string','string','int','int[]','json','int'
},
	["names"] = {
'id','key','nGroup','index','sName','sDescription','nOpenLevel','nCloseLevel','sOpenTime','sCloseTime','nTransferPath','aFinishIds','jAwardId','nIsHide'
},
	["data"] = {
{'11101',	'',	'',	'1',	'十二宫1',	'通关波拉克斯简单模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104001',	'[[10102,100,2]]',	''},
{'11102',	'',	'',	'2',	'十二宫2',	'通关波拉克斯普通模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104002',	'[[10102,100,2]]',	''},
{'11103',	'',	'',	'3',	'十二宫3',	'通关波拉克斯困难模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104003',	'[[10102,100,2]]',	''},
{'11104',	'',	'',	'4',	'十二宫4',	'通关波拉克斯地狱模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104004',	'[[10102,100,2]]',	''},
{'11105',	'',	'',	'5',	'十二宫5',	'通关卡斯托简单模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104005',	'[[10102,100,2]]',	''},
{'11106',	'',	'',	'6',	'十二宫6',	'通关卡斯托普通模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104006',	'[[10102,100,2]]',	''},
{'11107',	'',	'',	'7',	'十二宫7',	'通关卡斯托困难模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104007',	'[[10102,100,2]]',	''},
{'11108',	'',	'',	'8',	'十二宫8',	'通关卡斯托地狱模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104008',	'[[10102,100,2]]',	''},
{'11109',	'',	'',	'9',	'十二宫9',	'通关双子座简单模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104009',	'[[10102,100,2]]',	''},
{'11110',	'',	'',	'10',	'十二宫10',	'通关双子座普通模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104010',	'[[10102,100,2]]',	''},
{'11111',	'',	'',	'11',	'十二宫11',	'通关双子座困难模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104011',	'[[10102,100,2]]',	''},
{'11112',	'',	'',	'12',	'十二宫12',	'通关双子座地狱模式',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104012',	'[[10102,100,2]]',	''},
{'11113',	'',	'',	'13',	'十二宫13',	'获得探查票据500个',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104013',	'[[10102,100,2]]',	''},
{'11114',	'',	'',	'14',	'十二宫14',	'获得探查票据1000个',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104014',	'[[10102,100,2]]',	''},
{'11115',	'',	'',	'15',	'十二宫15',	'获得探查票据1500个',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104015',	'[[10102,100,2]]',	''},
{'11116',	'',	'',	'16',	'十二宫16',	'获得探查票据2000个',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104016',	'[[10102,100,2]]',	''},
{'11117',	'',	'',	'17',	'十二宫17',	'获得探查票据2500个',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104017',	'[[10102,100,2]]',	''},
{'11118',	'',	'',	'18',	'十二宫18',	'获得探查票据3000个',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104018',	'[[10102,100,2]]',	''},
{'11119',	'',	'',	'19',	'十二宫19',	'获得探查票据3500个',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104019',	'[[10102,100,2]]',	''},
{'11120',	'',	'',	'20',	'十二宫20',	'获得探查票据4000个',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104020',	'[[10102,100,2]]',	''},
{'11121',	'',	'',	'21',	'十二宫21',	'获得探查票据5000个',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104021',	'[[10102,100,2]]',	''},
{'11122',	'',	'',	'22',	'十二宫22',	'通关波拉克斯积分达到160000',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104022',	'[[10102,100,2]]',	''},
{'11123',	'',	'',	'23',	'十二宫23',	'通关波拉克斯积分达到500000',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104023',	'[[10102,100,2]]',	''},
{'11124',	'',	'',	'24',	'十二宫24',	'通关波拉克斯积分达到1000000',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104024',	'[[10102,100,2]]',	''},
{'11125',	'',	'',	'25',	'十二宫25',	'通关卡斯托积分达到160000',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104025',	'[[10102,100,2]]',	''},
{'11126',	'',	'',	'26',	'十二宫26',	'通关卡斯托积分达到500000',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104026',	'[[10102,100,2]]',	''},
{'11127',	'',	'',	'27',	'十二宫27',	'通关卡斯托积分达到1000000',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104027',	'[[10102,100,2]]',	''},
{'11128',	'',	'',	'28',	'十二宫28',	'通关双子座积分达到160000',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104028',	'[[10102,100,2]]',	''},
{'11129',	'',	'',	'29',	'十二宫29',	'通关双子座积分达到500000',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104029',	'[[10102,100,2]]',	''},
{'11130',	'',	'',	'30',	'十二宫30',	'通关双子座积分达到1000000',	'',	'',	'2024/2/7 10:00:01',	'2024/8/19 03:00:00',	'13039',	'104030',	'[[10102,100,2]]',	''},
},
}
--cfgCfgTotalBattleTask = conf
return conf