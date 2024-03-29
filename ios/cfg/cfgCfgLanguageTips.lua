local conf = {
	["filename"] = 'd-多语言.xlsx',
	["sheetname"] = '界面提示',
	["types"] = {
'int','string','string','string','string','string'
},
	["names"] = {
'id','key','language1','language2','language3','language4'
},
	["data"] = {
{'1000',	'1000',	'敬请期待',	'',	'',	''},
{'1001',	'1001',	'探索等级达到%s级开启',	'',	'',	''},
{'1002',	'1002',	'通关%s开启',	'',	'',	''},
{'1003',	'1003',	'队员正在副本中，暂不可操作',	'',	'',	''},
{'1004',	'1004',	'素材不足',	'',	'',	''},
{'1005',	'1005',	'%s个%s',	'',	'',	''},
{'1006',	'1006',	'通关0-10后开启',	'',	'',	''},
{'1007',	'1007',	'不能选择第一编队队长',	'',	'',	''},
{'1008',	'1008',	'网络连接失败！',	'',	'',	''},
{'1009',	'1009',	'等级.%s',	'',	'',	''},
{'1010',	'1010',	'通关<color=#FFC146>%s</color>开启',	'',	'',	''},
{'1011',	'1011',	'支付异常',	'',	'',	''},
{'1012',	'1012',	'成功替换已有对应语音的角色',	'',	'',	''},
{'1013',	'1013',	'<color=#FFC146>特装构建</color>已解锁，可在构建内查看',	'',	'',	''},
{'1014',	'1014',	'网络连接超时，即将返回重新登录',	'',	'',	''},
{'1015',	'1015',	'该玩家已注销账号',	'',	'',	''},
{'1016',	'1016',	'账号注销成功',	'',	'',	''},
{'1017',	'1017',	'账号功能未开启',	'',	'',	''},
{'1018',	'1018',	'您已发起账号注销，登录后将取消本次注销操作\n\n注销剩余时间：%s天%s小时%s分钟',	'',	'',	''},
{'1019',	'1019',	'镜像竞技加载中，请稍后',	'',	'',	''},
{'1020',	'1020',	'当前有 %s m的数据准备下载，目前正在使用数据连接，是否继续？',	'',	'',	''},
{'1021',	'1021',	'服务器维护中',	'',	'',	''},
{'1022',	'1022',	'您的账号因【使用非法软件】而封禁中\n\n解封剩余时间：%s天%s小时%s分钟',	'',	'',	''},
{'1023',	'1023',	'您的账号因【名字涉及敏感内容】而封禁中\n\n解封剩余时间：%s天%s小时%s分钟',	'',	'',	''},
{'1024',	'1024',	'您的账号因【违规操作】而封禁中\n\n解封剩余时间：%s天%s小时%s分钟',	'',	'',	''},
{'1025',	'1025',	'抱歉！因账号数据异常原因暂无法登录，请联系客服QQ：3493602346',	'',	'',	''},
{'2000',	'2000',	'素材不足，无法进行合成',	'',	'',	''},
{'2001',	'2001',	'是否退出基地？',	'',	'',	''},
{'2002',	'2002',	'驻员已达上限',	'',	'',	''},
{'2003',	'2003',	'没有可进驻的驻员',	'',	'',	''},
{'2004',	'2004',	'设施升级中',	'',	'',	''},
{'2005',	'2005',	'[挖掘矿场]还没有建造，无法收取',	'',	'',	''},
{'2006',	'2006',	'<color=#FFC146>%s</color>开始升级',	'',	'',	''},
{'2007',	'2007',	'<color=#FFC146>%s</color>升级完成',	'',	'',	''},
{'2008',	'2008',	'选择的角色中有效果和该角色重复，无法选择当前角色',	'',	'',	''},
{'2101',	'2101',	'你正在访问该好友的订单库，请拜访其他好友',	'',	'',	''},
{'2102',	'2102',	'订单兑换所需素材不足,是否进行合成？',	'',	'',	''},
{'2103',	'2103',	'加速失败，%s当前心情不足，请前往更换其他驻员',	'',	'',	''},
{'2104',	'2104',	'拜访失败，基地未建造【原料交易中心】',	'',	'',	''},
{'2105',	'2105',	'点赞成功！',	'',	'',	''},
{'2106',	'2106',	'是否确认返回自己的基地订单库？',	'',	'',	''},
{'2107',	'2107',	'队员工作中，此操作将终止队员所有工作，包括清空此队员已加成的所有效果，请确认。',	'',	'',	''},
{'2108',	'2108',	'当前选择角色没有增加订单的技能，是否继续？',	'',	'',	''},
{'2201',	'2201',	'由于制作过程中，制作机器损耗，需要维修机器才能完成制作，是否消耗%s个“%s”快速完成维修？',	'',	'',	''},
{'2202',	'2202',	'不使用“加速装置”维修设备完成制作，则物品会进入“延迟制作”列表中',	'',	'',	''},
{'2203',	'2203',	'是否消耗%s个“%s”加速维修所有的装置？',	'',	'',	''},
{'2204',	'2204',	'所有延迟制作的物品均已完成',	'',	'',	''},
{'2205',	'2205',	'部分延迟制作的物品已完成制作',	'',	'',	''},
{'2301',	'2301',	'暂无符合条件的角色',	'',	'',	''},
{'2302',	'2302',	'已达到派遣上限',	'',	'',	''},
{'2303',	'2303',	'选中角色中包含了在其他设施和不生效能力的角色，是否继续？',	'',	'',	''},
{'2304',	'2304',	'选中角色中包含了在其他设施中的角色，是否继续？',	'',	'',	''},
{'2305',	'2305',	'选中角色中包含了不生效能力的角色，是否继续？',	'',	'',	''},
{'2306',	'2306',	'无法跳转，已在合成列表中',	'',	'',	''},
{'2307',	'2307',	'材料不足，无法合成',	'',	'',	''},
{'2308',	'2308',	'已是可选择的最大数量',	'',	'',	''},
{'2309',	'2309',	'已是可选择的最小数量',	'',	'',	''},
{'2310',	'2310',	'通关<color=#FFC146>0-5真相</color>开启<color=#FFC142>基地</color>功能',	'',	'',	''},
{'2311',	'2311',	'对应设施未解锁，请前往<color=#FFC146>基地</color>处进行建造',	'',	'',	''},
{'2312',	'2312',	'建筑已建造完成',	'',	'',	''},
{'2313',	'2313',	'建筑已完成升级',	'',	'',	''},
{'2314',	'2314',	'建筑已完成建造与升级',	'',	'',	''},
{'2315',	'2315',	'<color=#FFC146>%s</color>建造完成',	'',	'',	''},
{'3000',	'3000',	'已达到最大容量',	'',	'',	''},
{'3001',	'3001',	'选中素材中包含了4星或以上卡牌，是否分解？',	'选中素材中包含了4星或以上角色，是否分解？',	'',	''},
{'3002',	'3002',	'已达到选择上限',	'',	'',	''},
{'3003',	'3003',	'是否花费<color=#ffae00>%s</color>%s扩充%s个格子/容量',	'',	'',	''},
{'3004',	'3004',	'没有符合要求的角色',	'',	'',	''},
{'3005',	'3005',	'核心跃升至%s后开启',	'',	'',	''},
{'3006',	'3006',	'核心跃升至%s后解锁',	'',	'',	''},
{'3007',	'3007',	'是否使用%s来购买%s-%s？',	'',	'',	''},
{'3008',	'3008',	'格子',	'',	'',	''},
{'3009',	'3009',	'%s的跃变武装开启动态立绘',	'',	'',	''},
{'3010',	'3010',	'升级成功',	'',	'',	''},
{'3011',	'3011',	'此状态下无法对武装天赋进行操作，请先返回至主体',	'',	'',	''},
{'3012',	'3012',	'升级成功',	'',	'',	''},
{'3013',	'3013',	'已选择当前材料可升级的最大等级',	'',	'',	''},
{'4000',	'4000',	'未开启合成工厂功能',	'',	'',	''},
{'4001',	'4001',	'是否消耗%s快速完成',	'',	'',	''},
{'4002',	'4002',	'交易所未建造',	'',	'',	''},
{'4003',	'4003',	'设施未建造',	'',	'',	''},
{'5000',	'5000',	'当前队伍角色正在冷却，是否进入冷却坞加速冷却？',	'',	'',	''},
{'6000',	'6000',	'是否确认把对方从好友列表中删除？',	'',	'',	''},
{'6001',	'6001',	'今日删除好友次数已达上限',	'',	'',	''},
{'6002',	'6002',	'加入屏蔽名单后，将解除双方好友关系，且无法接收对方消息，是否确定？',	'',	'',	''},
{'6003',	'6003',	'是否将%s从屏蔽名单中移出？',	'',	'',	''},
{'6004',	'6004',	'您所输入的查找内容有误，请确认后再输入',	'',	'',	''},
{'6005',	'6005',	'申请已达上限',	'',	'',	''},
{'6006',	'6006',	'%s天前',	'',	'',	''},
{'6007',	'6007',	'%s小时前',	'',	'',	''},
{'6008',	'6008',	'%s分钟前',	'',	'',	''},
{'6009',	'6009',	'双方已不是好友，无法进行聊天',	'',	'',	''},
{'6010',	'6010',	'搜索内容不能为空',	'',	'',	''},
{'6011',	'6011',	'复制成功',	'',	'',	''},
{'6012',	'6012',	'已发送好友申请',	'',	'',	''},
{'6013',	'6013',	'拜访失败，该好友未建造【原料交易中心】',	'',	'',	''},
{'6014',	'6014',	'拜访失败，该好友未建造【宿舍】',	'',	'',	''},
{'6015',	'6015',	'好友已达到上限，无法继续添加',	'',	'',	''},
{'6016',	'6016',	'检查姓名超时，请稍后重试',	'',	'',	''},
{'7000',	'7000',	'是否退出登录？',	'',	'',	''},
{'7001',	'7001',	'是否退出游戏？',	'',	'',	''},
{'7002',	'7002',	'低级画质能够让游戏更加流畅，是否开启？',	'',	'',	''},
{'7003',	'7003',	'中级画质会保留大部分美术渲染，是否开启？',	'',	'',	''},
{'7004',	'7004',	'高级画质拥有高清画面效果，是否开启？',	'',	'',	''},
{'7005',	'7005',	'输入的兑换码错误，请核对后再输入。',	'',	'',	''},
{'7006',	'7006',	'密码重置完成',	'',	'',	''},
{'8000',	'8000',	'探索等级达到<color=#FFC142>Lv.%s</color>后开启',	'',	'',	''},
{'8001',	'8001',	'通过%s后开启',	'',	'',	''},
{'8002',	'8002',	'该副本今日不开放',	'',	'',	''},
{'8003',	'8003',	'关卡达到3星后开启',	'',	'',	''},
{'8004',	'8004',	'当前没有可通往目标的线路，无法切换为自动寻路',	'',	'',	''},
{'8005',	'8005',	'当前没有可通往目标的线路，请自行移动队伍',	'',	'',	''},
{'8006',	'8006',	'道具数量不足！',	'',	'',	''},
{'8007',	'8007',	'请选择使用的道具',	'',	'',	''},
{'8008',	'8008',	'自动寻路已停止',	'',	'',	''},
{'8009',	'8009',	'本次挑战还有另一队伍生存',	'',	'',	''},
{'8010',	'8010',	'完成<color=#FFC142>%s</color>，解锁扫荡功能',	'',	'',	''},
{'8011',	'8011',	'碎星虚影已每周重置',	'',	'',	''},
{'8012',	'8012',	'<color=#FFC142>掉落加成次数</color>已重置',	'',	'',	''},
{'8013',	'8013',	'体力不足',	'',	'',	''},
{'8014',	'8014',	'%s不足',	'',	'',	''},
{'8015',	'8015',	'扫荡次数不足',	'',	'',	''},
{'8016',	'8016',	'没有掉落加成次数',	'',	'',	''},
{'8017',	'8017',	'<color=#FFC146>技能磨砺</color>已解锁，可每日探索内查看',	'',	'',	''},
{'8018',	'8018',	'<color=#FFC146>芯片嵌合</color>已解锁，可每日探索内查看',	'',	'',	''},
{'8019',	'8019',	'<color=#FFC146>荒墟拾遗与跃升行动</color>已解锁，可每日探索内查看',	'',	'',	''},
{'8020',	'8020',	'是否确认播放剧情？',	'',	'',	''},
{'9000',	'9000',	'您当前使用的账号为未成年账号，游戏时间和付费会受到限制',	'',	'',	''},
{'9001',	'9001',	'您正在使用游客登录',	'',	'',	''},
{'9002',	'9002',	'注册成功！',	'',	'',	''},
{'9003',	'9003',	'输入的文字中不得含有敏感字符',	'',	'',	''},
{'9004',	'9004',	'请先同意用户协议和用户隐私',	'',	'',	''},
{'9005',	'9005',	'注册成功！',	'',	'',	''},
{'9006',	'9006',	'服务器繁忙,请稍后再试...',	'',	'',	''},
{'9007',	'9007',	'验证码已发送，请注意查收',	'',	'',	''},
{'9008',	'9008',	'正在估算…',	'',	'',	''},
{'9009',	'9009',	'未获取到服务器信息，是否重新获取？',	'',	'',	''},
{'9010',	'9010',	'请详细阅读并同意《账号注销协议》',	'',	'',	''},
{'10000',	'10000',	'是否花费 %s 进行<color=#ffae00> %s </color>次构建？',	'',	'',	''},
{'10001',	'10001',	'"获得新角色，是否锁定？"',	'',	'',	''},
{'10002',	'10002',	'是否使用该构建记录作为本次构建？使用后，则无法“再次构建”。',	'',	'',	''},
{'10003',	'10003',	'构建次数已达到上限，无法继续进行！',	'',	'',	''},
{'10004',	'10004',	'当前的粲晶不足，无法进行兑换，是否进入商店购买？',	'',	'',	''},
{'10005',	'10005',	'今天构建次数已达到上限，无法继续构建。',	'',	'',	''},
{'10006',	'10006',	'本次构建不需要任何费用，是否进行？',	'',	'',	''},
{'10007',	'10007',	'该构建需要通关0-2后才会开启。本构建中，玩家可进行最大30次的10连构建，可从30次中选择其中一次作为最终结果；每次构建后，可暂时保留当前构建的结果，仅保留一次，若保留本次结果，则会覆盖此前的记录。',	'',	'',	''},
{'10008',	'10008',	'是否确定以上构建作为最终结果？',	'',	'',	''},
{'10009',	'10009',	'确定后将无法修改',	'',	'',	''},
{'10010',	'10010',	'当前构建暂无构建记录',	'',	'',	''},
{'10011',	'10011',	'<color=#ff7781>*更换保底角色后，当前保底角色累计的次数将会重置</color>\n\n是否确定替换？',	'',	'',	''},
{'10012',	'10012',	'取消后，累计次数将会重置，是否取消角色保底？',	'',	'',	''},
{'10013',	'10013',	'是否把 本次构建 替换当前的 构建记录？\n\n*<color=#ff7781>被替换掉的构建结果将会消失！</color>',	'',	'',	''},
{'10014',	'10014',	'通关0-2后开启',	'',	'',	''},
{'10015',	'10015',	'当前构建卡池已关闭',	'',	'',	''},
{'11000',	'11000',	'是否删除已读邮件？',	'',	'',	''},
{'12000',	'12000',	'当前没有可以搭载的芯片',	'',	'',	''},
{'12001',	'12001',	'是否开启新的槽位？',	'',	'',	''},
{'12002',	'12002',	'芯片被其他角色携带，是否替换到当前角色上？',	'',	'',	''},
{'12003',	'12003',	'队员正在副本中，无法对芯片进行操作',	'',	'',	''},
{'12004',	'12004',	'无可用的套装部位',	'',	'',	''},
{'12005',	'12005',	'不存在类型为%s的芯片套装类型！',	'',	'',	''},
{'12006',	'12006',	'好友角色不可更改',	'',	'',	''},
{'12007',	'12007',	'队员正在副本中，无法对芯片进行操作',	'',	'',	''},
{'12008',	'12008',	'芯片已达最大强化等级',	'',	'',	''},
{'12009',	'12009',	'请选择升级材料',	'',	'',	''},
{'12010',	'12010',	'强化成功！',	'',	'',	''},
{'12011',	'12011',	'已达到最大选择数量',	'',	'',	''},
{'12012',	'12012',	'芯片仓库空间不足，请及时处理',	'',	'',	''},
{'12013',	'12013',	'卡牌空间不足，请清理卡牌后再次尝试',	'',	'',	''},
{'12014',	'12014',	'使用了%sx%s',	'',	'',	''},
{'12015',	'12015',	'自动匹配成功',	'',	'',	''},
{'12016',	'12016',	'添加失败，强化经验已达上限',	'',	'',	''},
{'13000',	'13000',	'存在队员技能升级完成，是否进入角色列表查看？',	'',	'',	''},
{'14000',	'14000',	'该队员正在战斗中...',	'',	'',	''},
{'14001',	'14001',	'队伍正在出战中，无法执行该操作',	'',	'',	''},
{'14002',	'14002',	'不能选择第一编队的队长',	'',	'',	''},
{'14003',	'14003',	'该角色无法下阵！',	'',	'',	''},
{'14004',	'14004',	'请选择出战队伍',	'',	'',	''},
{'14005',	'14005',	'请设置出战队员',	'',	'',	''},
{'14006',	'14006',	'第一小队中没有配置队员，无法出击',	'',	'',	''},
{'14007',	'14007',	'无法放置支援队员，角色占位超过上限!',	'',	'',	''},
{'14008',	'14008',	'请选择队伍之后再变更队员',	'',	'',	''},
{'14009',	'14009',	'%s中不能只上阵支援队员',	'',	'',	''},
{'14010',	'14010',	'由于支援队员与我方队员重复，已下阵支援队员',	'',	'',	''},
{'14011',	'14011',	'%s中没有配置队长，无法出击',	'',	'',	''},
{'14012',	'14012',	'%s缺少必要队员',	'',	'',	''},
{'14013',	'14013',	'未找到强制上阵的角色数据：%s',	'',	'',	''},
{'14014',	'14014',	'该预设队伍没有队长，无法使用',	'',	'',	''},
{'14015',	'14015',	'队伍%s中必须要有队长',	'',	'',	''},
{'14016',	'14016',	'当前队伍中的队员与其他队伍存在重复使用的情况，是否将该队员退出其他队伍？',	'',	'',	''},
{'14017',	'14017',	'第%s小队',	'',	'',	''},
{'14018',	'14018',	'请先解锁上一个预设队伍',	'',	'',	''},
{'14019',	'14019',	'是否花费%s进行解锁？',	'',	'',	''},
{'14020',	'14020',	'预设队伍中存在正在战斗中的角色，无法使用！',	'',	'',	''},
{'14021',	'14021',	'请配置队长',	'',	'',	''},
{'14022',	'14022',	'强制上阵无法使用编队预设',	'',	'',	''},
{'14023',	'14023',	'队长不能下阵！',	'',	'',	''},
{'14024',	'14024',	'是否把角色移除出队伍？',	'',	'',	''},
{'14025',	'14025',	'无法放置，上阵人数已满!',	'',	'',	''},
{'14026',	'14026',	'存在相同角色',	'',	'',	''},
{'14027',	'14027',	'队伍%s',	'',	'',	''},
{'14028',	'14028',	'存在其他队伍中的角色，是否确认修改？',	'',	'',	''},
{'14029',	'14029',	'队长',	'',	'',	''},
{'14030',	'14030',	'-支援角色-',	'',	'',	''},
{'14031',	'14031',	'-强制出战-',	'',	'',	''},
{'14032',	'14032',	'-非控制角色-',	'',	'',	''},
{'14033',	'14033',	'热值不足！',	'',	'',	''},
{'14034',	'14034',	'是否替换到%s?',	'',	'',	''},
{'14035',	'14035',	'每个队伍只能上阵一名支援队员',	'',	'',	''},
{'14036',	'14036',	'当前队伍禁止上阵支援队员',	'',	'',	''},
{'14037',	'14037',	'第一编队队长已留下，剩余队员已迁移到第二编队',	'',	'',	''},
{'15000',	'15000',	'%s数量不足',	'',	'',	''},
{'15001',	'15001',	'尚未开放...',	'',	'',	''},
{'15002',	'15002',	'当前还未获得该角色',	'',	'',	''},
{'15101',	'15101',	'暂未开放',	'',	'',	''},
{'15102',	'15102',	'星贸凭证',	'',	'',	''},
{'15103',	'15103',	'当前测试暂不开放，敬请期待。',	'',	'',	''},
{'15104',	'15104',	'当前没有额外的星源可进行兑换',	'',	'',	''},
{'15105',	'15105',	'当前没有额外的碎片可以兑换',	'',	'',	''},
{'15106',	'15106',	'是否购买%s？',	'',	'',	''},
{'15107',	'15107',	'是否花费<color=#ffc142>%s</color>%s购买%s？',	'',	'',	''},
{'15108',	'15108',	'购买后持续时间大于180天，暂不可再次购买',	'',	'',	''},
{'15109',	'15109',	'限时贸易所已刷新',	'',	'',	''},
{'15110',	'15110',	'新的商品已上架',	'',	'',	''},
{'15111',	'15111',	'新的商品已上架',	'',	'',	''},
{'15112',	'15112',	'新的商品已上架',	'',	'',	''},
{'15113',	'15113',	'支付未完成，是否继续支付？',	'',	'',	''},
{'15114',	'15114',	'支付失败，请稍后再尝试\n<color=#ff7781>如已充值成功，请稍后留意到账情况</color>',	'',	'',	''},
{'15115',	'15115',	'支付已取消',	'',	'',	''},
{'15116',	'15116',	'支付成功',	'',	'',	''},
{'15117',	'15117',	'购买成功，奖励已通过邮件发送，是否前往领取？',	'',	'',	''},
{'15118',	'15118',	'演习商店维护中',	'',	'',	''},
{'15119',	'15119',	'新的时装已上架',	'',	'',	''},
{'15003',	'15003',	'剩余数量：%s',	'',	'',	''},
{'15004',	'15004',	'是否花费%s%s购买%s？',	'',	'',	''},
{'15005',	'15005',	'是否花费 %s 进行刷新？',	'',	'',	''},
{'15006',	'15006',	'',	'',	'',	''},
{'16000',	'16000',	'锁定的芯片不能出售！',	'',	'',	''},
{'16001',	'16001',	'是否出售选择的芯片？',	'',	'',	''},
{'16002',	'16002',	'没有选择需要出售的芯片',	'',	'',	''},
{'16003',	'16003',	'已达到选择数量上限',	'',	'',	''},
{'16004',	'16004',	'是否花费<color=\"#ffc146\">%s</color>开启<color=\"#ffc146\">%s个背包容量</color>？',	'',	'',	''},
{'16005',	'16005',	'还没有解锁该跳转功能哦',	'',	'',	''},
{'16006',	'16006',	'暂未达到开启副本条件',	'',	'',	''},
{'16007',	'16007',	'该副本今日不开放',	'',	'',	''},
{'16008',	'16008',	'需要到背包中使用',	'',	'',	''},
{'17000',	'17000',	'请输入公会名字！',	'',	'',	''},
{'17001',	'17001',	'请选择公会头像！',	'',	'',	''},
{'17002',	'17002',	'是否退出公会？退出后24小时内无法加入其它公会。',	'',	'',	''},
{'17003',	'17003',	'是否任命%s为副会长？',	'',	'',	''},
{'17004',	'17004',	'是否取消%s副会长权限？',	'',	'',	''},
{'17005',	'17005',	'是否任命%s为会长？',	'',	'',	''},
{'17006',	'17006',	'是否将%s请离公会？',	'',	'',	''},
{'17007',	'17007',	'已经是好友了',	'',	'',	''},
{'17008',	'17008',	'你好，我是%s',	'',	'',	''},
{'17009',	'17009',	'20秒内无法再次刷新',	'',	'',	''},
{'17010',	'17010',	'是否加入“%s”公会？',	'',	'',	''},
{'17011',	'17011',	'是否申请进入“%s”公会？',	'',	'',	''},
{'17012',	'17012',	'是否取消“%s”公会入会申请？',	'',	'',	''},
{'17013',	'17013',	'是否解散公会？解散后，48小时内无法创建新的公会。',	'',	'',	''},
{'17014',	'17014',	'权限不足!',	'',	'',	''},
{'18000',	'18000',	'未获得',	'',	'',	''},
{'19000',	'19000',	'演习无法自行退出战斗',	'',	'',	''},
{'19001',	'19001',	'撤退后，当前队伍会撤退战斗，切换至其他队伍，是否继续？',	'',	'',	''},
{'19002',	'19002',	'是否撤退？\n撤退后将失去该关卡的进度。',	'',	'',	''},
{'19003',	'19003',	'是否撤退？',	'',	'',	''},
{'19004',	'19004',	'退出战斗无法获得任何奖励，但不扣除战斗次数，是否退出？',	'',	'',	''},
{'19005',	'19005',	'试玩中退出战斗不会有任何的收益影响，是否退出？',	'',	'',	''},
{'19006',	'19006',	'%s，无法释放机神传送',	'',	'',	''},
{'19007',	'19007',	'%s，无法释放',	'',	'',	''},
{'19008',	'19008',	'%s，无法释放核心爆发',	'',	'',	''},
{'19009',	'19009',	'角色同步率不足',	'',	'',	''},
{'19010',	'19010',	'角色处于异常状态中',	'',	'',	''},
{'19011',	'19011',	'没有足够能量值',	'',	'',	''},
{'19012',	'19012',	'角色处于同调状态',	'',	'',	''},
{'19013',	'19013',	'该技能为被动技能',	'',	'',	''},
{'19014',	'19014',	'场上没有对应目标',	'',	'',	''},
{'19015',	'19015',	'处于冷却中',	'',	'',	''},
{'19016',	'19016',	'没有足够怪物能量值',	'',	'',	''},
{'19017',	'19017',	'不可召唤',	'',	'',	''},
{'19018',	'19018',	'连接服务器失败，即将返回登录界面',	'',	'',	''},
{'20000',	'20000',	'当前方案已被修改，但没有保存，是否退出？',	'',	'',	''},
{'20001',	'20001',	'当前方案已被修改，但没有保存，是否不保存切换方案？',	'',	'',	''},
{'21000',	'21000',	'好感度经验已达上限',	'',	'',	''},
{'21001',	'21001',	'%s主题购买成功',	'',	'',	''},
{'21002',	'21002',	'无法一键购买，家具币不足',	'',	'',	''},
{'21003',	'21003',	'是否使用当前主题进行房间布置？',	'',	'',	''},
{'21004',	'21004',	'确定要撤掉所有家具？',	'',	'',	''},
{'21005',	'21005',	'是否移除该方案？',	'',	'',	''},
{'21006',	'21006',	'该主题中的部分家具正在被其他房间占用，无法进行布置',	'',	'',	''},
{'21007',	'21007',	'是否在当前房间进行布置',	'',	'',	''},
{'21008',	'21008',	'是否使用当前主题进行房间布置？',	'',	'',	''},
{'21009',	'21009',	'未拥有该主题所需的全部家具，是否前往购买？',	'',	'',	''},
{'21010',	'21010',	'分享数量已达到上限，需要清理分享后才能继续上传',	'',	'',	''},
{'21011',	'21011',	'名字不能为空',	'',	'',	''},
{'21012',	'21012',	'名字不可用',	'',	'',	''},
{'21013',	'21013',	'你正在访问该好友',	'',	'',	''},
{'21014',	'21014',	'是否取消点赞？',	'',	'',	''},
{'21015',	'21015',	'是否取消收藏？',	'',	'',	''},
{'21016',	'21016',	'是否取消分享？',	'',	'',	''},
{'21017',	'21017',	'分享成功',	'',	'',	''},
{'21018',	'21018',	'点赞成功',	'',	'',	''},
{'21019',	'21019',	'收藏成功',	'',	'',	''},
{'21020',	'21020',	'无法点赞自己分享的主题',	'',	'',	''},
{'21021',	'21021',	'无法收藏自己分享的主题',	'',	'',	''},
{'21022',	'21022',	'该物品数量不足，无法选择',	'',	'',	''},
{'21023',	'21023',	'家具当前摆放位置不可用,请重新调整',	'',	'',	''},
{'21024',	'21024',	'是否保存修改？',	'',	'',	''},
{'21025',	'21025',	'是否退出宿舍？',	'',	'',	''},
{'21026',	'21026',	'已完成布置',	'',	'',	''},
{'21027',	'21027',	'已保存成功',	'',	'',	''},
{'21028',	'21028',	'当前房间有尚未保存的装扮更改，确定要退出？',	'',	'',	''},
{'21029',	'21029',	'确定重置所有更改？',	'',	'',	''},
{'21030',	'21030',	'无法放置，房间可放置家具已达上限',	'',	'',	''},
{'21031',	'21031',	'无法保存，存在家具位置部分重叠，请调整位置',	'',	'',	''},
{'21032',	'21032',	'该家具已放置在当前房间中',	'',	'',	''},
{'21033',	'21033',	'当前队员好感度已满级，无需额外赠送礼物',	'',	'',	''},
{'22001',	'22001',	'提升至%s等级，可获得以下奖励',	'',	'',	''},
{'22002',	'22002',	'已达到最大等级',	'',	'',	''},
{'22003',	'22003',	'本期勘探指南已结束',	'',	'',	''},
{'23001',	'23001',	'已达到本日购买上限，无法继续购买',	'',	'',	''},
{'24001',	'24001',	'本次活动已关闭',	'',	'',	''},
{'24002',	'24002',	'未通过上一难度',	'',	'',	''},
{'24003',	'24003',	'当前不在活动开放时间内',	'',	'',	''},
{'24004',	'24004',	'未通过上一个探索关卡',	'',	'',	''},
{'24005',	'24005',	'本类型探索关卡2倍掉落次数已消耗完毕',	'',	'',	''},
{'24006',	'24006',	'新的阶段任务已开启',	'',	'',	''},
{'24007',	'24007',	'困难模式于%s开启',	'',	'',	''},
{'24008',	'24008',	'未完成上一危险等级的挑战',	'',	'',	''},
{'25001',	'25001',	'需要通关<color=#FFC142>%s</color>后，才能解锁本板块',	'',	'',	''},
{'25002',	'25002',	'需要通关<color=#FFC142>%s</color>后，才能解锁本战场',	'',	'',	''},
{'25003',	'25003',	'需要通关<color=#FFC142>%s</color>后，才能解锁本区域',	'',	'',	''},
{'26001',	'26001',	'%s解锁战术',	'',	'',	''},
{'26002',	'26002',	'%s解锁自动战斗AI设置',	'',	'',	''},
{'26101',	'26101',	'<color=#FFC142>【战术】</color>中开启<color=#FFC142>%s</color>后解锁',	'',	'',	''},
{'26102',	'26102',	'玩家升级后可获得战术点，是否前往模式选择界面？',	'',	'',	''},
{'26103',	'26103',	'<color=#FFC142>【续行战术】</color>已自动装备上当前队伍',	'',	'',	''},
{'26104',	'26104',	'已默认装备<color=#FFC142>【续行战术】</color>技能',	'',	'',	''},
{'27001',	'27001',	'该外观未设置为看板',	'',	'',	''},
{'27002',	'27002',	'成功更换看板',	'',	'',	''},
{'28001',	'28001',	'未解锁，到达<color=#FFC142>第%s天</color>时开启',	'',	'',	''},
{'28002',	'28002',	'完成并领取<color=#FFC142>上一阶段</color>的全部任务奖励后解锁',	'',	'',	''},
{'29001',	'29001',	'点击<color=#FFC142>箭头</color>或<color=#FFC142>拖动图片</color>可切换教程',	'',	'',	''},
{'30001',	'30001',	'当前版本暂不支持修改名字',	'',	'',	''},
{'33001',	'33001',	'赛季已刷新，玩家积分排名已重置',	'',	'',	''},
{'33002',	'33002',	'模拟次数已刷新',	'',	'',	''},
{'33003',	'33003',	'演习兑换商店已刷新',	'',	'',	''},
{'33004',	'33004',	'当前模拟次数已满',	'',	'',	''},
{'33005',	'33005',	'今日购买次数已消耗完毕',	'',	'',	''},
{'33006',	'33006',	'次数无法超过上限',	'',	'',	''},
{'33007',	'33007',	'今日购买次数已消耗完毕',	'',	'',	''},
{'33008',	'33008',	'挑战次数购买成功',	'',	'',	''},
{'33018',	'33018',	'赛季结算中，请稍后再参加',	'',	'',	''},
{'33019',	'33019',	'没有匹配到对手，请稍后再试',	'',	'',	''},
{'34001',	'34001',	'未通过上一演训难度',	'',	'',	''},
{'34002',	'34002',	'已解锁下一演训难度',	'',	'',	''},
{'34003',	'34003',	'地狱难度会在 %s天 %s 后开启',	'',	'',	''},
},
}
--cfgCfgLanguageTips = conf
return conf
