local conf = {
	["filename"] = 'r-任务配置表.xlsx',
	["sheetname"] = '新年阶段奖励',
	["types"] = {
'int','string','int','string','string','string','string','int','int[]','json','int'
},
	["names"] = {
'id','key','nStage','sOpenTime','sCloseTime','sName','sDescription','nTransferPath','aFinishIds','jAwardId','nIsHide'
},
	["data"] = {
{'21101',	'',	'1',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关任意关卡5次',	'通关任意关卡5次',	'30001',	'1100101',	'[[58032,1,2],[10003,5000,2]]',	''},
{'21102',	'',	'1',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'在原料交易所完成1次订单',	'在原料交易所完成1次订单',	'150003',	'1100102',	'[[58032,1,2],[60106,1,2]]',	''},
{'21103',	'',	'1',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'累计消耗1个芯片进行强化',	'累计消耗1个芯片进行强化',	'80002',	'1100103',	'[[58032,1,2],[2000101,2,2]]',	''},
{'21104',	'',	'1',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关碎星虚影1次',	'通关碎星虚影1次',	'11000',	'1100104',	'[[58032,1,2],[10001,5000,2]]',	''},
{'21105',	'',	'1',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'镜像竞技胜利3次',	'镜像竞技胜利3次',	'30003',	'1100105',	'[[58032,1,2],[15001,2,2]]',	''},
{'21106',	'',	'2',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关任意关卡10次',	'通关任意关卡10次',	'30001',	'1100106',	'[[58032,1,2],[10003,7500,2]]',	''},
{'21107',	'',	'2',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'基地挖掘矿场收获3次',	'基地挖掘矿场收获3次',	'150002',	'1100107',	'[[58032,1,2],[60106,1,2]]',	''},
{'21108',	'',	'2',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'芯片重塑3次',	'芯片重塑3次',	'150004',	'1100108',	'[[58032,1,2],[2000101,3,2]]',	''},
{'21109',	'',	'2',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'累计消耗星币150000',	'累计消耗星币150000',	'140006',	'1100109',	'[[58032,1,2],[10001,7500,2]]',	''},
{'21110',	'',	'2',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关拟真演训普通模式',	'通关拟真演训普通模式',	'13001',	'1100110',	'[[58032,1,2],[15001,3,2]]',	''},
{'21111',	'',	'3',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关任意关卡15次',	'通关任意关卡15次',	'30001',	'1100111',	'[[58032,1,2],[10003,10000,2]]',	''},
{'21112',	'',	'3',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'在原料交易所完成3次订单',	'在原料交易所完成3次订单',	'150003',	'1100112',	'[[58032,1,2],[60106,2,2]]',	''},
{'21113',	'',	'3',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'累计消耗15个芯片进行强化',	'累计消耗15个芯片进行强化',	'80002',	'1100113',	'[[58032,1,2],[2000101,4,2]]',	''},
{'21114',	'',	'3',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关碎星虚影2次',	'通关碎星虚影2次',	'11000',	'1100114',	'[[58032,1,2],[10001,10000,2]]',	''},
{'21115',	'',	'3',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'镜像竞技胜利6次',	'镜像竞技胜利6次',	'30003',	'1100115',	'[[58032,1,2],[15001,4,2]]',	''},
{'21116',	'',	'4',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关任意关卡20次',	'通关任意关卡20次',	'30001',	'1100116',	'[[58032,1,2],[10003,12500,2]]',	''},
{'21117',	'',	'4',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'基地挖掘矿场收获10次',	'基地挖掘矿场收获10次',	'150002',	'1100117',	'[[58032,1,2],[60106,2,2]]',	''},
{'21118',	'',	'4',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'芯片重塑6次',	'芯片重塑6次',	'150004',	'1100118',	'[[58032,1,2],[2000201,4,2]]',	''},
{'21119',	'',	'4',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'累计消耗星币500000',	'累计消耗星币500000',	'140006',	'1100119',	'[[58032,1,2],[10001,12500,2]]',	''},
{'21120',	'',	'4',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关碎星虚影3次',	'通关碎星虚影3次',	'11000',	'1100120',	'[[58032,1,2],[10001,15000,2]]',	''},
{'21121',	'',	'5',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关任意关卡25次',	'通关任意关卡25次',	'30001',	'1100121',	'[[58032,1,2],[10003,15000,2]]',	''},
{'21122',	'',	'5',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'在原料交易所完成6次订单',	'在原料交易所完成6次订单',	'150003',	'1100122',	'[[58032,1,2],[60106,3,2]]',	''},
{'21123',	'',	'5',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'累计消耗30个芯片进行强化',	'累计消耗30个芯片进行强化',	'80002',	'1100123',	'[[58032,1,2],[2000201,5,2]]',	''},
{'21124',	'',	'5',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'镜像竞技胜利12次',	'镜像竞技胜利12次',	'30003',	'1100124',	'[[58032,1,2],[15002,3,2]]',	''},
{'21125',	'',	'5',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关碎星虚影4次',	'通关碎星虚影4次',	'11000',	'1100125',	'[[58032,1,2],[15002,4,2]]',	''},
{'21126',	'',	'6',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关任意关卡30次',	'通关任意关卡30次',	'30001',	'1100126',	'[[58032,1,2],[10003,17500,2]]',	''},
{'21127',	'',	'6',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'基地挖掘矿场收获15次',	'基地挖掘矿场收获15次',	'150002',	'1100127',	'[[58032,1,2],[60106,3,2]]',	''},
{'21128',	'',	'6',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'芯片重塑9次',	'芯片重塑9次',	'150004',	'1100128',	'[[58032,1,2],[2000201,5,2]]',	''},
{'21129',	'',	'6',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'累计消耗星币1000000',	'累计消耗星币1000000',	'140006',	'1100129',	'[[58032,1,2],[10001,17500,2]]',	''},
{'21130',	'',	'6',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关拟真演训困难模式',	'通关拟真演训困难模式',	'13002',	'1100130',	'[[58032,1,2],[15002,2,2]]',	''},
{'21131',	'',	'7',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关任意关卡40次',	'通关任意关卡40次',	'30001',	'1100131',	'[[58032,1,2],[10003,20000,2]]',	''},
{'21132',	'',	'7',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'累计消耗50个芯片进行强化',	'累计消耗50个芯片进行强化',	'80002',	'1100132',	'[[58032,1,2],[60106,4,2]]',	''},
{'21133',	'',	'7',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关碎星虚影5次',	'通关碎星虚影5次',	'11000',	'1100133',	'[[58032,1,2],[2000201,6,2]]',	''},
{'21134',	'',	'7',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'镜像竞技胜利30次',	'镜像竞技胜利30次',	'30003',	'1100134',	'[[58032,1,2],[10001,20000,2]]',	''},
{'21135',	'',	'7',	'2024/2/07 10:00:00',	'2024/2/21 3:00:00',	'通关拟真演训困难模式5次',	'通关拟真演训困难模式5次',	'13002',	'1100135',	'[[58032,1,2],[15002,5,2]]',	''},
},
}
--cfgCfgNewYearTask = conf
return conf
