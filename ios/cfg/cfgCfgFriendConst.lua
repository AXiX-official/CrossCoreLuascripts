local conf = {
	["filename"] = 'h-好友.xlsx',
	["sheetname"] = '好友常量',
	["types"] = {
'int','string','string','int','string'
},
	["names"] = {
'id','key','sEnum','nVal','sDesc'
},
	["data"] = {
{'1',	'1',	'InviteLimit',	'999',	'好友发送申请上限'},
{'2',	'2',	'InviteSignLimit',	'20',	'申请备注文字上限'},
{'3',	'3',	'DeleteCoolTime',	'24',	'删除的好友在XX小时内不能再添加'},
{'4',	'4',	'RecommendLimit',	'10',	'系统推荐好友的数量'},
{'5',	'5',	'RecommendFlushDiff',	'2',	'推荐好友的刷新时间（小时）'},
{'6',	'6',	'DailyDelLimit',	'15',	'每天删除好友上限'},
{'7',	'7',	'RecomendMaxLvlDiff',	'10',	'推荐等级最大差距'},
{'8',	'8',	'SendMsgLenLimit',	'60',	'聊天信息文字上限'},
{'9',	'9',	'AliasLenLimit',	'20',	'别名长度限制'},
{'10',	'10',	'RecomendFlushCnt',	'5',	'好友推荐少于多少时刷新'},
{'11',	'11',	'FriendStateUpdate',	'30',	'好友状态刷新时间(前端使用，开着界面的时候多久申请一次)'},
{'12',	'12',	'FluhDiff',	'5',	'好友刷新间隔，包含助战队列刷新间隔（秒）(后端使用)'},
{'13',	'13',	'AssitCntLimit',	'50',	'每个好友，可助战次数'},
{'14',	'14',	'AssitCardMaxLevelLimit',	'20',	'助战卡牌和玩家最高等级差'},
{'15',	'15',	'DenyCoolTime',	'1',	'拒绝后多久不能重复申请(小时)'},
{'16',	'16',	'RecommendManualFlushDiff',	'10',	'好友推荐手动刷新间隔'},
{'17',	'17',	'AssitPlrCnt',	'36',	'好友助战人数发送上限（包括非好友）'},
{'18',	'18',	'NotFriendAssitCntLimit',	'5',	'非好友，可助战次数'},
},
}
--cfgCfgFriendConst = conf
return conf
