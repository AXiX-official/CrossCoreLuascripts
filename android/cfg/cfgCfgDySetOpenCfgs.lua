local conf = {
	["filename"] = 'd-动态配置开启表.xlsx',
	["sheetname"] = '动态设置开启的配置',
	["types"] = {
'string','string','table#7','int','string','string','string','string','string','string[]'
},
	["names"] = {
'id','name','fields','index','field','sub_tb','sub_index_type','field_type','desc','show_ids'
},
	["data"] = {
{'AvatarFrame',	'avatarname',	'',	'',	'',	'',	'',	'',	'',	''},
{'AvatarFrame',	'',	'',	'1',	'isShow',	'',	'',	'bool',	'是否显示',	''},
{'AvatarFrame',	'',	'',	'2',	'type',	'',	'',	'number',	'类型',	''},
{'CfgAccTypeLimit',	'name',	'',	'',	'',	'',	'',	'',	'',	''},
{'CfgAccTypeLimit',	'',	'',	'1',	'sumTime',	'infos',	'number',	'number',	'在线总时长',	''},
{'CfgCardPool',	'CardPool',	'',	'',	'',	'',	'',	'',	'',	''},
{'CfgCardPool',	'',	'',	'1',	'sStart',	'',	'',	'date',	'开始时间',	''},
{'CfgCardPool',	'',	'',	'2',	'sEnd',	'',	'',	'date',	'结束时间',	''},
{'CfgCardPool',	'',	'',	'3',	'jCost',	'',	'',	'json',	'抽卡花费',	''},
{'CfgAvatar',	'avatarname',	'',	'',	'',	'',	'',	'',	'',	''},
{'CfgAvatar',	'',	'',	'1',	'isShow',	'',	'',	'bool',	'是否显示在列表中',	''},
{'global_setting',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'global_setting',	'',	'',	'1',	'value',	'',	'',	'string',	'活动按钮开启',	'g_ZilongWebBtnOpen,g_ZilongWebBtnClose,g_ZilongWebBtnLv'},
{'CfgActiveEntry',	'Active',	'',	'',	'',	'',	'',	'',	'',	''},
{'CfgActiveEntry',	'',	'',	'1',	'mainShow',	'',	'',	'number',	'是否在主界面显示',	''},
{'CfgActiveEntry',	'',	'',	'2',	'begTime',	'',	'',	'string',	'开始时间',	''},
{'CfgActiveEntry',	'',	'',	'3',	'hardBegTime',	'',	'',	'string',	'困难本开启时间',	''},
{'CfgActiveEntry',	'',	'',	'4',	'battleendTime',	'',	'',	'string',	'副本关闭时间',	''},
{'CfgActiveEntry',	'',	'',	'5',	'endTime',	'',	'',	'string',	'结束时间',	''},
{'CfgCommodity',	'CfgCommodity',	'',	'',	'',	'',	'',	'',	'',	''},
{'CfgCommodity',	'',	'',	'1',	'sBuyStart',	'',	'',	'string',	'购买开始时间',	''},
{'CfgCommodity',	'',	'',	'2',	'sBuyEnd',	'',	'',	'string',	'购买结束时间',	''},
},
}
--cfgCfgDySetOpenCfgs = conf
return conf
