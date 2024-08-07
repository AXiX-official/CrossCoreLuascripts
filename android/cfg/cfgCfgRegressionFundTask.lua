local conf = {
	["filename"] = 'r-任务配置表.xlsx',
	["sheetname"] = '回归基金任务',
	["types"] = {
'int','string','int','int','int','string','string','int','int','int','int','string','string','int','int[]','json','int'
},
	["names"] = {
'id','key','nGroup','fundId','index','sName','sDescription','nOpenLevel','nCloseLevel','nOppssId','nPreTaskId','sOpenTime','sCloseTime','nTransferPath','aFinishIds','jAwardId','nIsHide'
},
	["data"] = {
{'70001',	'',	'1',	'71001',	'',	'登陆一次',	'登陆一次',	'',	'',	'',	'',	'',	'',	'',	'103004',	'[[10001,50000,2]]',	'2'},
{'70002',	'',	'1',	'71002',	'',	'芯片重塑15次',	'芯片重塑15次',	'',	'',	'',	'',	'',	'',	'150004',	'29201',	'[[10001,50000,2]]',	'2'},
{'70003',	'',	'1',	'71003',	'',	'在原料交易所完成18次订单',	'在原料交易所完成18次订单',	'',	'',	'',	'',	'',	'',	'150003',	'103001',	'[[10001,50000,2]]',	'2'},
{'70004',	'',	'1',	'71004',	'',	'通关任意关卡90次',	'通关任意关卡90次',	'',	'',	'',	'',	'',	'',	'30001',	'103002',	'[[10001,50000,2]]',	'2'},
{'70005',	'',	'1',	'71005',	'',	'累计消耗星币1200000',	'累计消耗星币1200000',	'',	'',	'',	'',	'',	'',	'140006',	'29203',	'[[10001,50000,2]]',	'2'},
{'70006',	'',	'1',	'71006',	'',	'通关碎星虚影20次',	'通关碎星虚影20次',	'',	'',	'',	'',	'',	'',	'30004',	'29204',	'[[10001,50000,2]]',	'2'},
{'70007',	'',	'1',	'71007',	'',	'镜像竞技胜利80次',	'镜像竞技胜利80次',	'',	'',	'',	'',	'',	'',	'30003',	'29205',	'[[10001,100000,2]]',	'2'},
{'70008',	'',	'1',	'71008',	'',	'累计消耗6000燃料',	'累计消耗6000燃料',	'',	'',	'',	'',	'',	'',	'30001',	'29206',	'[[10001,100000,2]]',	'2'},
{'71001',	'',	'1',	'',	'',	'登陆一次',	'登陆一次',	'',	'',	'',	'',	'',	'',	'',	'103004',	'[[10040,300,2]]',	'2'},
{'71002',	'',	'1',	'',	'',	'芯片重塑15次',	'芯片重塑15次',	'',	'',	'',	'',	'',	'',	'150004',	'29201',	'[[10040,300,2]]',	'2'},
{'71003',	'',	'1',	'',	'',	'在原料交易所完成18次订单',	'在原料交易所完成18次订单',	'',	'',	'',	'',	'',	'',	'150003',	'103001',	'[[10040,300,2]]',	'2'},
{'71004',	'',	'1',	'',	'',	'通关任意关卡90次',	'通关任意关卡90次',	'',	'',	'',	'',	'',	'',	'30001',	'103002',	'[[10040,300,2]]',	'2'},
{'71005',	'',	'1',	'',	'',	'累计消耗星币1200000',	'累计消耗星币1200000',	'',	'',	'',	'',	'',	'',	'140006',	'29203',	'[[10040,300,2]]',	'2'},
{'71006',	'',	'1',	'',	'',	'通关碎星虚影20次',	'通关碎星虚影20次',	'',	'',	'',	'',	'',	'',	'30004',	'29204',	'[[10040,300,2]]',	'2'},
{'71007',	'',	'1',	'',	'',	'镜像竞技胜利80次',	'镜像竞技胜利80次',	'',	'',	'',	'',	'',	'',	'30003',	'29205',	'[[10040,450,2]]',	'2'},
{'71008',	'',	'1',	'',	'',	'累计消耗6000燃料',	'累计消耗6000燃料',	'',	'',	'',	'',	'',	'',	'30001',	'29206',	'[[10040,450,2]]',	'2'},
},
}
--cfgCfgRegressionFundTask = conf
return conf
