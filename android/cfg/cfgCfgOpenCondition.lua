local conf = {
	["filename"] = 'x-新手教程.xlsx',
	["sheetname"] = '模块开启',
	["types"] = {
'string','string','string','int','string','int[]','int','string'
},
	["names"] = {
'id','key','sName','open_tips','icon','conditions','jump','sSceneName'
},
	["data"] = {
{'TeamView',	'TeamView',	'编队',	'',	'',	'',	'',	''},
{'Section',	'Section',	'出击',	'',	'',	'',	'',	''},
{'CreateView',	'CreateView',	'抽卡',	'',	'',	'',	'',	''},
{'RoleListNormal',	'RoleListNormal',	'角色',	'',	'',	'',	'',	''},
{'CoolView',	'CoolView',	'冷却',	'',	'',	'',	'',	''},
{'SettingView',	'SettingView',	'设置',	'',	'',	'',	'',	''},
{'SignInView',	'SignInView',	'签到',	'',	'',	'',	'',	''},
{'FriendView',	'FriendView',	'好友',	'1',	'FriendView',	'2001',	'',	''},
{'PlayerView',	'PlayerView',	'玩家',	'',	'',	'2001',	'',	''},
{'CourseView',	'CourseView',	'教程',	'1',	'CourseView',	'2001',	'',	''},
{'MissionView',	'MissionView',	'任务',	'1',	'MissionView',	'2002',	'',	''},
{'Bag',	'Bag',	'仓库',	'',	'',	'2002',	'',	''},
{'MailView',	'MailView',	'邮件',	'1',	'MailView',	'2003',	'90001',	''},
{'ShopView',	'ShopView',	'商店',	'1',	'ShopView',	'2002',	'',	''},
{'Matrix',	'Matrix',	'基地',	'1',	'Matrix',	'2005',	'',	'Matrix'},
{'Dorm',	'Dorm',	'宿舍',	'1',	'Dorm',	'2005',	'',	''},
{'ActivityListView',	'ActivityListView',	'活动界面',	'1',	'ActivityListView',	'2007',	'',	''},
{'ExplorationMain',	'ExplorationMain',	'勘探指南',	'1',	'ExplorationMain',	'2007',	'',	''},
{'PlayerAbility',	'PlayerAbility',	'战术',	'1',	'PlayerAbility',	'2007',	'',	''},
{'ArchiveView',	'ArchiveView',	'档案',	'1',	'ArchiveView',	'2103',	'',	''},
{'GuildMenu',	'GuildMenu',	'公会',	'',	'',	'2110',	'',	''},
{'ExerciseLView',	'ExerciseLView',	'镜像竞技',	'1',	'Arena',	'2114',	'',	''},
{'ExtraActivityView',	'ExtraActivityView',	'付费活动',	'',	'',	'2002',	'',	''},
{'TowerListView',	'TowerListView',	'异构空间',	'',	'',	'2120',	'',	''},
{'BadgeView',	'BadgeView',	'徽章',	'1',	'Badge',	'2001',	'',	''},
{'Achievement',	'Achievement',	'成就',	'1',	'Achievement',	'2105',	'',	''},
{'TowerView',	'TowerView',	'异构空间',	'',	'',	'2120',	'',	''},
},
}
--cfgCfgOpenCondition = conf
return conf
