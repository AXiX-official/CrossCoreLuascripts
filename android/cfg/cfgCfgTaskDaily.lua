local conf = {
	["filename"] = 'r-任务配置表.xlsx',
	["sheetname"] = '每日任务',
	["types"] = {
'int','string','int','string','string','int','int','int','int','string','string','int','int[]','int','json','int'
},
	["names"] = {
'id','key','nGroup','sName','sDescription','nOpenLevel','nCloseLevel','nOppssId','nPreTaskId','sOpenTime','sCloseTime','nTransferPath','aFinishIds','nStar','jAwardId','nIsHide'
},
	["data"] = {
{'30003',	'',	'',	'通关之路',	'通关任意关卡3次',	'',	'',	'',	'',	'',	'',	'30001',	'30003',	'3',	'',	'2'},
{'30004',	'',	'',	'通关之路',	'通关任意关卡6次',	'',	'',	'',	'',	'',	'',	'30001',	'30004',	'3',	'',	'2'},
{'30005',	'',	'',	'通关之路',	'通关任意关卡9次',	'',	'',	'',	'',	'',	'',	'30001',	'30005',	'3',	'',	'2'},
{'31001',	'',	'',	'基地交易',	'在原料交易所（基地）完成1次订单',	'',	'',	'',	'',	'',	'',	'150003',	'31001',	'1',	'',	'2'},
{'31002',	'',	'',	'基地生产',	'基地挖掘矿场收获一次',	'',	'',	'',	'',	'',	'',	'150002',	'31002',	'1',	'',	'2'},
{'31003',	'',	'',	'技能提升',	'任意技能升级1次',	'',	'',	'',	'',	'',	'',	'40001',	'31003',	'1',	'',	'2'},
{'31004',	'',	'',	'角色升级',	'任意角色使用技术点提升1级',	'',	'',	'',	'',	'',	'',	'40001',	'31004',	'1',	'',	'2'},
{'31005',	'',	'',	'每日登陆',	'每日登陆',	'',	'',	'',	'',	'',	'',	'',	'31005',	'1',	'',	'2'},
{'35001',	'',	'',	'芯片强化',	'任意芯片升级1次',	'',	'',	'',	'',	'',	'',	'80002',	'35001',	'1',	'',	'2'},
{'37001',	'',	'',	'跃升行动',	'通关跃升行动关卡1次',	'',	'',	'',	'',	'',	'',	'10402',	'37001',	'2',	'',	'2'},
{'38001',	'',	'',	'芯片嵌合',	'通关芯片嵌合关卡1次',	'',	'',	'',	'',	'',	'',	'10502',	'38001',	'2',	'',	'2'},
{'38002',	'',	'',	'技能磨砺',	'通关技能磨砺关卡1次',	'101',	'',	'',	'',	'',	'',	'10601',	'38002',	'2',	'',	'2'},
{'38003',	'',	'',	'星币开采',	'通关星币开采关卡1次',	'101',	'',	'',	'',	'',	'',	'10701',	'38003',	'2',	'',	'2'},
{'38004',	'',	'',	'技术解析',	'通关技术解析关卡1次',	'101',	'',	'',	'',	'',	'',	'10801',	'38004',	'2',	'',	'2'},
{'39001',	'',	'',	'军演胜利',	'镜像竞技胜利1次',	'',	'',	'',	'',	'',	'',	'30003',	'39001',	'2',	'',	'2'},
{'39002',	'',	'',	'商店兑换',	'在限时贸易所完成任意1次兑换或购买',	'',	'',	'',	'',	'',	'',	'140006',	'39002',	'1',	'',	'2'},
{'39003',	'',	'',	'燃料补充',	'购买燃料1次',	'',	'',	'',	'',	'',	'',	'140010',	'39003',	'1',	'',	'2'},
{'39004',	'',	'',	'点击看板',	'点击1次看板',	'',	'',	'',	'',	'',	'',	'10000',	'39004',	'1',	'',	'2'},
},
}
--cfgCfgTaskDaily = conf
return conf
