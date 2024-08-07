local conf = {
	["filename"] = 'r-任务配置表.xlsx',
	["sheetname"] = '阶段任务',
	["types"] = {
'int','string','int','string','string','int','int[]','json','int'
},
	["names"] = {
'id','key','nStage','sName','sDescription','nTransferPath','aFinishIds','jAwardId','nIsHide'
},
	["data"] = {
{'20101',	'',	'1',	'任意编队人数达到<color=#f1872a> 5 </color>人',	'任意编队人数达到<color=#f1872a> 5 </color>人',	'100002',	'100101',	'[[10004,500,2],[10003,1500,2]]',	''},
{'20102',	'',	'1',	'任意1名队员达到<color=#f1872a> 20 </color>级',	'任意1名队员达到<color=#f1872a> 20 </color>级',	'40001',	'100102',	'[[10004,500,2],[10003,1500,2]]',	'1'},
{'20103',	'',	'1',	'芯片激活<color=#f1872a> 3 </color>级以上技能效果',	'芯片激活<color=#f1872a> 3 </color>级以上技能效果',	'40001',	'100103',	'[[10004,500,2],[2000101,5,2]]',	''},
{'20104',	'',	'1',	'基地建造研发中心和发电站',	'基地建造研发中心和发电站',	'150000',	'100104',	'[[10004,500,2],[60101,1000,2]]',	''},
{'20105',	'',	'1',	'通关<color=#f1872a> 剧0-8</color>【总队长的意义】',	'通关<color=#f1872a> 剧0-8</color>【总队长的意义】',	'21090',	'100105',	'[[10004,500,2],[15001,10,2]]',	''},
{'20106',	'',	'2',	'任意队员技能升级<color=#f1872a> 2 </color>次',	'任意队员技能升级<color=#f1872a> 2 </color>次',	'40001',	'100106',	'[[10004,500,2],[10001,3000,2]]',	''},
{'20107',	'',	'2',	'提升任意1名队员的特性',	'提升任意1名队员的特性',	'40001',	'100107',	'[[10004,500,2],[10003,3000,2]]',	''},
{'20108',	'',	'2',	'行星指挥部达到<color=#f1872a> 2 </color>级',	'行星指挥部达到<color=#f1872a> 2 </color>级',	'150000',	'100108',	'[[10004,500,2],[60101,1500,2]]',	''},
{'20109',	'',	'2',	'任意芯片强化<color=#f1872a> 1 </color>次',	'任意芯片强化<color=#f1872a> 1 </color>次',	'80002',	'100109',	'[[10004,500,2],[2000101,5,2]]',	''},
{'20110',	'',	'2',	'通关<color=#f1872a> 1-7</color>【炸毛】',	'通关<color=#f1872a> 1-7</color>【炸毛】',	'21107',	'100110',	'[[10004,500,2],[58001,2,2]]',	''},
{'20111',	'',	'3',	'通关任意芯片嵌合的第<color=#f1872a> 1 </color>层',	'通关任意芯片嵌合的第<color=#f1872a> 1 </color>层',	'10301',	'100111',	'[[10004,500,2],[2000101,5,2]]',	''},
{'20112',	'',	'3',	'任意队员核心跃升<color=#f1872a> 1 </color>次',	'任意队员核心跃升<color=#f1872a> 1 </color>次',	'40001',	'100112',	'[[10004,500,2],[10003,5000,2]]',	''},
{'20113',	'',	'3',	'任意3件芯片强化到<color=#f1872a> 3 </color>级',	'任意3件芯片强化到<color=#f1872a> 3 </color>级',	'80002',	'100113',	'[[10004,500,2],[10001,5000,2]]',	''},
{'20114',	'',	'3',	'任意1名角色达到<color=#f1872a> 40 </color>级',	'任意1名角色达到<color=#f1872a> 40 </color>级',	'40001',	'100114',	'[[10004,500,2],[15001,8,2]]',	''},
{'20115',	'',	'3',	'通关<color=#f1872a> 0-1</color>【泰坦环·外侧】困难',	'通关<color=#f1872a> 0-1</color>【泰坦环·外侧】困难',	'22001',	'100115',	'[[10004,500,2],[58002,1,2]]',	''},
{'20116',	'',	'4',	'成功改造<color=#f1872a> 1 </color>次芯片',	'成功改造<color=#f1872a> 1 </color>次芯片',	'150004',	'100116',	'[[10004,500,2],[2000101,10,2]]',	''},
{'20117',	'',	'4',	'基地中合成工厂达到3级',	'基地中合成工厂达到3级',	'150000',	'100117',	'[[10004,500,2],[60101,2000,2]]',	''},
{'20118',	'',	'4',	'镜像竞技累计获得<color=#f1872a> 20 </color>积分',	'镜像竞技累计获得<color=#f1872a> 20 </color>积分',	'30003',	'100118',	'[[10004,500,2],[10010,500,2]]',	''},
{'20119',	'',	'4',	'任意3名队员达到<color=#f1872a> 40 </color>级',	'任意3名队员达到<color=#f1872a> 40 </color>级',	'40001',	'100119',	'[[10004,500,2],[15002,2,2]]',	''},
{'20120',	'',	'4',	'通关<color=#f1872a> 1-20</color>【漆黑】',	'通关<color=#f1872a> 1-20</color>【漆黑】',	'21120',	'100120',	'[[10004,500,2],[11002,1,2]]',	''},
{'20121',	'',	'5',	'探索等级达到<color=#f1872a> 15 </color>级',	'探索等级达到<color=#f1872a> 15 </color>级',	'30001',	'100121',	'[[10004,500,2],[10013,100,2]]',	''},
{'20122',	'',	'5',	'任意3件芯片强化到<color=#f1872a> 6 </color>级',	'任意3件芯片强化到<color=#f1872a> 6 </color>级',	'80002',	'100122',	'[[10004,500,2],[2000101,10,2]]',	''},
{'20123',	'',	'5',	'任意1名角色达到<color=#f1872a> 50 </color>级',	'任意1名角色达到<color=#f1872a> 50 </color>级',	'40001',	'100123',	'[[10004,500,2],[10003,15000,2]]',	''},
{'20124',	'',	'5',	'宿舍舒适度达到<color=#f1872a> 100 </color>',	'宿舍舒适度达到<color=#f1872a> 100 </color>',	'150005',	'100124',	'[[10004,500,2],[10001,15000,2]]',	''},
{'20125',	'',	'5',	'通关<color=#f1872a> 2-5</color>【尤弥尔】',	'通关<color=#f1872a> 2-5</color>【尤弥尔】',	'21205',	'100125',	'[[10004,500,2],[58002,1,2]]',	''},
{'20126',	'',	'6',	'任意3件芯片强化到<color=#f1872a> 9 </color>级',	'任意3件芯片强化到<color=#f1872a> 9 </color>级',	'80002',	'100126',	'[[10004,500,2],[2000101,10,2]]',	''},
{'20127',	'',	'6',	'任意3名角色达到<color=#f1872a> 50 </color>级',	'任意3名角色达到<color=#f1872a> 50 </color>级',	'40001',	'100127',	'[[10004,500,2],[10003,20000,2]]',	''},
{'20128',	'',	'6',	'镜像竞技累计获得<color=#f1872a> 40 </color>积分',	'镜像竞技累计获得<color=#f1872a> 40 </color>积分',	'30003',	'100128',	'[[10004,500,2],[10010,1000,2]]',	''},
{'20129',	'',	'6',	'通关<color=#f1872a> 2-9</color>【对立面】',	'通关<color=#f1872a> 2-9</color>【对立面】',	'21209',	'100129',	'[[10004,500,2],[10001,20000,2]]',	''},
{'20130',	'',	'6',	'通关<color=#f1872a>碎星虚影</color>的【虚影阿瑞斯】',	'通关<color=#f1872a>碎星虚影</color>的【虚影阿瑞斯】',	'11000',	'100130',	'[[10004,500,2],[11002,1,2]]',	''},
{'20131',	'',	'7',	'任意3名角色达到<color=#f1872a> 60 </color>级',	'任意3名角色达到<color=#f1872a> 60 </color>级',	'40001',	'100131',	'[[10004,500,2],[58003,1,2]]',	''},
{'20132',	'',	'7',	'任意3件芯片强化到<color=#f1872a> 12 </color>级',	'任意3件芯片强化到<color=#f1872a> 12 </color>级',	'80002',	'100132',	'[[10004,500,2],[2000201,15,2]]',	''},
{'20133',	'',	'7',	'累计核心构建<color=#f1872a> 40 </color>次',	'累计核心构建<color=#f1872a> 40 </color>次',	'60001',	'100133',	'[[10004,500,2],[10001,25000,2]]',	''},
{'20134',	'',	'7',	'通关<color=#f1872a> 2-22 </color>【放逐者】',	'通关<color=#f1872a> 2-22 </color>【放逐者】',	'21222',	'100134',	'[[10004,500,2],[10003,25000,2]]',	''},
{'20135',	'',	'7',	'通关<color=#f1872a>碎星虚影</color>的【虚影赫拉 】',	'通关<color=#f1872a>碎星虚影</color>的【虚影赫拉 】',	'11003',	'100135',	'[[10004,500,2],[11002,1,2]]',	''},
},
}
--cfgCfgGuideTask = conf
return conf
