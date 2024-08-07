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
{'1000',	'1000',	'敬请期待',	'敬请期待',	'乞うご期待',	''},
{'1001',	'1001',	'探索等级达到%s级开启',	'探索等级达到%s级开启',	'プレイヤーレベルが%sになると開放',	''},
{'1002',	'1002',	'通关%s开启',	'通关%s开启',	'<color=#FFC142>%s</color>クリア後に開放',	''},
{'1003',	'1003',	'队员正在副本中，暂不可操作',	'队员正在副本中，暂不可操作',	'隊員がクエストで戦闘中です。操作できません',	''},
{'1004',	'1004',	'素材不足',	'素材不足',	'素材が足りません',	''},
{'1005',	'1005',	'%s个%s',	'%s个%s',	'%s%s個',	''},
{'1006',	'1006',	'通关0-10后开启',	'通关0-10后开启',	'0-10クリア後に開放',	''},
{'1007',	'1007',	'不能选择第一编队队长',	'不能选择第一编队队长',	'第一編隊のリーダーを選択できません',	''},
{'1008',	'1008',	'网络连接失败！',	'网络连接失败！',	'ネットワークに接続できません！',	''},
{'1009',	'1009',	'等级.%s',	'等级.%s',	'Lv.%s',	''},
{'1010',	'1010',	'通关<color=#FFC146>%s</color>开启',	'通关<color=#FFC146>%s</color>开启',	'<color=#FFC146>%s</color>クリア後に開放',	''},
{'1011',	'1011',	'支付异常',	'支付异常',	'決済エラー',	''},
{'1012',	'1012',	'成功替换已有对应语音的角色',	'成功替换已有对应语音的角色',	'対応言語のボイスに切り替えました',	''},
{'1013',	'1013',	'<color=#FFC146>特装构建</color>已解锁，可在构建内查看',	'<color=#FFC146>特装构建</color>已解锁，可在构建内查看',	'<color=#FFC146>スタートダッシュ構築</color>が開放されました。詳細は構築でチェックすることができます',	''},
{'1014',	'1014',	'网络连接超时，即将返回重新登录',	'网络连接超时，即将返回重新登录',	'ネットワークに接続できません。ログイン画面に戻ります',	''},
{'1015',	'1015',	'该玩家已注销账号',	'该玩家已注销账号',	'このアカウントはすでに削除されています',	''},
{'1016',	'1016',	'账号注销成功',	'账号注销成功',	'アカウント削除しました',	''},
{'1017',	'1017',	'账号功能未开启',	'账号功能未开启',	'アカウント機能が開放されていません',	''},
{'1018',	'1018',	'您已发起账号注销，登录后将取消本次注销操作\n\n注销剩余时间：%s天%s小时%s分钟',	'您已发起账号注销，登录后将取消本次注销操作\n\n注销剩余时间：%s天%s小时%s分钟',	'アカウント削除の申請を受け付けました。もう一度ログインすれば、アカウント削除の申請をキャンセルできます\n\nアカウント削除されるまで残り：%s日%s時間%s分',	''},
{'1019',	'1019',	'镜像竞技加载中，请稍后',	'镜像竞技加载中，请稍后',	'アリーナに接続中、しばらくお待ちください',	''},
{'1020',	'1020',	'当前有 %s m的数据准备下载，目前正在使用数据连接，是否继续？',	'当前有 %s m的数据准备下载，目前正在使用数据连接，是否继续？',	' %s のデータをダウンロードする必要があります。現在データ通信を使用していますが、このまま続けますか？',	''},
{'1021',	'1021',	'服务器维护中',	'服务器维护中',	'メンテナンス中',	''},
{'1022',	'1022',	'您的账号因【使用非法软件】而封禁中\n\n解封剩余时间：%s天%s小时%s分钟',	'您的账号因【使用非法软件】而封禁中\n\n解封剩余时间：%s天%s小时%s分钟',	'',	''},
{'1023',	'1023',	'您的账号因【名字涉及敏感内容】而封禁中\n\n解封剩余时间：%s天%s小时%s分钟',	'您的账号因【名字涉及敏感内容】而封禁中\n\n解封剩余时间：%s天%s小时%s分钟',	'',	''},
{'1024',	'1024',	'您的账号因【违规操作】而封禁中\n\n解封剩余时间：%s天%s小时%s分钟',	'您的账号因【违规操作】而封禁中\n\n解封剩余时间：%s天%s小时%s分钟',	'',	''},
{'1025',	'1025',	'抱歉！因账号数据异常原因暂无法登录，请联系客服QQ：3493602346',	'抱歉！因账号数据异常原因暂无法登录，请联系客服QQ：3493602346',	'',	''},
{'2000',	'2000',	'素材不足，无法进行合成',	'素材不足，无法进行合成',	'素材が足りないため、合成が行えません',	''},
{'2001',	'2001',	'是否退出基地？',	'是否退出基地？',	'基地から出ますか？',	''},
{'2002',	'2002',	'驻员已达上限',	'驻员已达上限',	'これ以上人員を配置できません',	''},
{'2003',	'2003',	'没有可进驻的驻员',	'没有可进驻的驻员',	'配置できる人員がいません',	''},
{'2004',	'2004',	'设施升级中',	'设施升级中',	'施設強化中',	''},
{'2005',	'2005',	'[挖掘矿场]还没有建造，无法收取',	'[挖掘矿场]还没有建造，无法收取',	'「採掘場」が建造されていないため、回収できません',	''},
{'2006',	'2006',	'<color=#FFC146>%s</color>开始升级',	'<color=#FFC146>%s</color>开始升级',	'<color=#FFC146>%s</color>強化開始',	''},
{'2007',	'2007',	'<color=#FFC146>%s</color>升级完成',	'<color=#FFC146>%s</color>升级完成',	'<color=#FFC146>%s</color>強化完了',	''},
{'2008',	'2008',	'选择的角色中有效果和该角色重复，无法选择当前角色',	'选择的角色中有效果和该角色重复，无法选择当前角色',	'選択したキャラの中で効果が重複したキャラがいるため、このキャラを選択できません',	''},
{'2101',	'2101',	'你正在访问该好友的订单库，请拜访其他好友',	'你正在访问该好友的订单库，请拜访其他好友',	'すでにこのフレンドの注文リストを訪問しています。ほかのフレンドを訪問しますか？',	''},
{'2102',	'2102',	'订单兑换所需素材不足,是否进行合成？',	'订单兑换所需素材不足,是否进行合成？',	'納品するには素材が足りません。合成を行いますか？',	''},
{'2103',	'2103',	'加速失败，%s当前心情不足，请前往更换其他驻员',	'加速失败，%s当前心情不足，请前往更换其他驻员',	'%sの機嫌が足りないため、加速できませんでした。ほかの人員に変更してください',	''},
{'2104',	'2104',	'拜访失败，基地未建造【原料交易中心】',	'拜访失败，基地未建造【原料交易中心】',	'「取引所」が建造されていないため、訪問できません',	''},
{'2105',	'2105',	'点赞成功！',	'点赞成功！',	'いいねしました！',	''},
{'2106',	'2106',	'是否确认返回自己的基地订单库？',	'是否确认返回自己的基地订单库？',	'自分の注文リストに戻りますか？',	''},
{'2107',	'2107',	'队员工作中，此操作将终止队员所有工作，包括清空此队员已加成的所有效果，请确认。',	'队员工作中，此操作将终止队员所有工作，包括清空此队员已加成的所有效果，请确认。',	'作業中の隊員がいます。この操作を行うと、作業が中止になり、設定中の基地スキル効果がなくなります。ご確認ください。',	''},
{'2108',	'2108',	'当前选择角色没有增加订单的技能，是否继续？',	'当前选择角色没有增加订单的技能，是否继续？',	'このキャラは注文を増やすスキルがありません。続けますか？',	''},
{'2201',	'2201',	'由于制作过程中，制作机器损耗，需要维修机器才能完成制作，是否消耗%s个“%s”快速完成维修？',	'由于制作过程中，制作机器损耗，需要维修机器才能完成制作，是否消耗%s个“%s”快速完成维修？',	'制作する途中で、設備が故障しました。制作を完了させるには設備を修理する必要があります。「%s」を%s個消費して今すぐ修理しますか？',	''},
{'2202',	'2202',	'不使用“加速装置”维修设备完成制作，则物品会进入“延迟制作”列表中',	'不使用“加速装置”维修设备完成制作，则物品会进入“延迟制作”列表中',	'「加速装置」で設備を修理せずに制作を完了させると、アイテムが「制作遅延」リストに入ります',	''},
{'2203',	'2203',	'是否消耗%s个“%s”加速维修所有的装置？',	'是否消耗%s个“%s”加速维修所有的装置？',	'「%s」を%s個消費して、今すぐすべての設備を修理しますか？',	''},
{'2204',	'2204',	'所有延迟制作的物品均已完成',	'所有延迟制作的物品均已完成',	'制作遅延のアイテムがすべて完成しました',	''},
{'2205',	'2205',	'部分延迟制作的物品已完成制作',	'部分延迟制作的物品已完成制作',	'制作遅延のアイテムが一部完成しました',	''},
{'2301',	'2301',	'暂无符合条件的角色',	'暂无符合条件的角色',	'条件に一致したキャラがいません',	''},
{'2302',	'2302',	'已达到派遣上限',	'已达到派遣上限',	'これ以上派遣できません',	''},
{'2303',	'2303',	'选中角色中包含了在其他设施和不生效能力的角色，是否继续？',	'选中角色中包含了在其他设施和不生效能力的角色，是否继续？',	'選択したキャラの中でほかの施設に配置されたキャラまたは能力が適用されていないキャラがいます。続けますか？',	''},
{'2304',	'2304',	'选中角色中包含了在其他设施中的角色，是否继续？',	'选中角色中包含了在其他设施中的角色，是否继续？',	'選択したキャラの中でほかの施設に配置されたキャラがいます。続けますか？',	''},
{'2305',	'2305',	'选中角色中包含了不生效能力的角色，是否继续？',	'选中角色中包含了不生效能力的角色，是否继续？',	'選択したキャラの中で能力が適用されていないキャラがいます。続けますか？',	''},
{'2306',	'2306',	'无法跳转，已在合成列表中',	'无法跳转，已在合成列表中',	'すでに合成リストを開いているため、移動できません',	''},
{'2307',	'2307',	'材料不足，无法合成',	'材料不足，无法合成',	'素材が足りないため、合成が行えません',	''},
{'2308',	'2308',	'已是可选择的最大数量',	'已是可选择的最大数量',	'すでに最大値です',	''},
{'2309',	'2309',	'已是可选择的最小数量',	'已是可选择的最小数量',	'すでに最小値です',	''},
{'2310',	'2310',	'通关<color=#FFC146>0-5真相</color>开启<color=#FFC142>基地</color>功能',	'通关<color=#FFC146>0-5真相</color>开启<color=#FFC142>基地</color>功能',	'<color=#FFC146>0-5真相</color>クリア後に<color=#FFC142>基地</color>機能が開放される',	''},
{'2311',	'2311',	'对应设施未解锁，请前往<color=#FFC146>基地</color>处进行建造',	'对应设施未解锁，请前往<color=#FFC146>基地</color>处进行建造',	'対象施設はまだ開放されていません。<color=#FFC146>基地</color>に移動して建造を行ってください',	''},
{'2312',	'2312',	'建筑已建造完成',	'建筑已建造完成',	'施設の建造が完了しました',	''},
{'2313',	'2313',	'建筑已完成升级',	'建筑已完成升级',	'施設の強化が完了しました',	''},
{'2314',	'2314',	'建筑已完成建造与升级',	'建筑已完成建造与升级',	'施設の建造と強化が完了しました',	''},
{'2315',	'2315',	'<color=#FFC146>%s</color>建造完成',	'<color=#FFC146>%s</color>建造完成',	'<color=#FFC146>%s</color>の建造が完了しました',	''},
{'3000',	'3000',	'已达到最大容量',	'已达到最大容量',	'容量上限に達しています',	''},
{'3001',	'3001',	'选中素材中包含了4星或以上卡牌，是否分解？',	'选中素材中包含了4星或以上卡牌，是否分解？',	'選択した素材の中で、★4以上の物が含まれています。分解しますか？',	''},
{'3002',	'3002',	'已达到选择上限',	'已达到选择上限',	'これ以上選択できません',	''},
{'3003',	'3003',	'是否花费<color=#ffae00>%s</color>%s扩充%s个格子/容量',	'是否花费<color=#ffae00>%s</color>%s扩充%s个格子/容量',	'<color=#ffae00>%s</color>%sを消費して最大容量を%s増やしますか？',	''},
{'3004',	'3004',	'没有符合要求的角色',	'没有符合要求的角色',	'条件に一致したキャラがいません',	''},
{'3005',	'3005',	'核心跃升至%s后开启',	'核心跃升至%s后开启',	'%sまで躍昇すると開放される',	''},
{'3006',	'3006',	'核心跃升至%s后解锁',	'核心跃升至%s后解锁',	'%sまで躍昇すると開放される',	''},
{'3007',	'3007',	'是否使用%s来购买%s-%s？',	'是否使用%s来购买%s-%s？',	'%sを消費して%s-%sを購入しますか？',	''},
{'3008',	'3008',	'格子',	'格子',	'枠',	''},
{'3009',	'3009',	'%s的跃变武装开启动态立绘',	'%s的跃变武装开启动态立绘',	'%sの躍昇を行うと、Live2Dが開放される',	''},
{'3010',	'3010',	'升级成功',	'升级成功',	'強化しました',	''},
{'3011',	'3011',	'此状态下无法对武装天赋进行操作，请先返回至主体',	'此状态下无法对武装天赋进行操作，请先返回至主体',	'この状態下でタレントの操作ができません。キャラ画面に戻ってください',	''},
{'3012',	'3012',	'升级成功',	'升级成功',	'強化しました',	''},
{'3013',	'3013',	'已选择当前材料可升级的最大等级',	'已选择当前材料可升级的最大等级',	'現段階強化できる最大レベルです',	''},
{'3014',	'3014',	'替换解禁角色成功',	'替换解禁角色成功',	'',	''},
{'4000',	'4000',	'未开启合成工厂功能',	'未开启合成工厂功能',	'合成工場の機能が開放されていません',	''},
{'4001',	'4001',	'是否消耗%s快速完成',	'是否消耗%s快速完成',	'%sを消費して今すぐ完了させますか？',	''},
{'4002',	'4002',	'交易所未建造',	'交易所未建造',	'取引所未建造',	''},
{'4003',	'4003',	'设施未建造',	'设施未建造',	'施設未建造',	''},
{'5000',	'5000',	'当前队伍角色正在冷却，是否进入冷却坞加速冷却？',	'当前队伍角色正在冷却，是否进入冷却坞加速冷却？',	'このチームのキャラは現在冷却中。冷却ドックに入って高速冷却を行いますか？',	''},
{'6000',	'6000',	'是否确认把对方从好友列表中删除？',	'是否确认把对方从好友列表中删除？',	'相手をフレンドリストから削除しますか？',	''},
{'6001',	'6001',	'今日删除好友次数已达上限',	'今日删除好友次数已达上限',	'本日のフレンド削除の回数が上限に達しました',	''},
{'6002',	'6002',	'加入屏蔽名单后，将解除双方好友关系，且无法接收对方消息，是否确定？',	'加入屏蔽名单后，将解除双方好友关系，且无法接收对方消息，是否确定？',	'',	''},
{'6003',	'6003',	'是否将%s从屏蔽名单中移出？',	'是否将%s从屏蔽名单中移出？',	'',	''},
{'6004',	'6004',	'您所输入的查找内容有误，请确认后再输入',	'您所输入的查找内容有误，请确认后再输入',	'該当結果が見つかりませんでした',	''},
{'6005',	'6005',	'申请已达上限',	'申请已达上限',	'申請数が上限に達しました',	''},
{'6006',	'6006',	'%s天前',	'%s天前',	'%s日前',	''},
{'6007',	'6007',	'%s小时前',	'%s小时前',	'%s時間前',	''},
{'6008',	'6008',	'%s分钟前',	'%s分钟前',	'%s分前',	''},
{'6009',	'6009',	'双方已不是好友，无法进行聊天',	'双方已不是好友，无法进行聊天',	'互いにフレンドではないため、チャットできません',	''},
{'6010',	'6010',	'搜索内容不能为空',	'搜索内容不能为空',	'内容を入力してください',	''},
{'6011',	'6011',	'复制成功',	'复制成功',	'コピーしました',	''},
{'6012',	'6012',	'已发送好友申请',	'已发送好友申请',	'フレンド申請を送りました',	''},
{'6013',	'6013',	'拜访失败，该好友未建造【原料交易中心】',	'拜访失败，该好友未建造【原料交易中心】',	'フレンドが【取引所】を建造していないため、訪問できませんでした',	''},
{'6014',	'6014',	'拜访失败，该好友未建造【宿舍】',	'拜访失败，该好友未建造【宿舍】',	'フレンドが【寮舎】を建造していないため、訪問できませんでした',	''},
{'6015',	'6015',	'好友已达到上限，无法继续添加',	'好友已达到上限，无法继续添加',	'フレンド数が上限に達しています',	''},
{'6016',	'6016',	'检查姓名超时，请稍后重试',	'检查姓名超时，请稍后重试',	'タイムアウトしました。しばらく時間をおいてからアクセスしてください',	''},
{'7000',	'7000',	'是否退出登录？',	'是否退出登录？',	'ログアウトしますか？',	''},
{'7001',	'7001',	'是否退出游戏？',	'是否退出游戏？',	'ゲームから退出しますか？',	''},
{'7002',	'7002',	'低级画质能够让游戏更加流畅，是否开启？',	'低级画质能够让游戏更加流畅，是否开启？',	'低画質にすると、フレームレートが優先され、ゲームをスムーズにプレイできます。オンにしますか？',	''},
{'7003',	'7003',	'中级画质会保留大部分美术渲染，是否开启？',	'中级画质会保留大部分美术渲染，是否开启？',	'中画質にすると、フレームレートと画質がバランスよく調整された状態でプレイできます。オンにしますか？',	''},
{'7004',	'7004',	'高级画质拥有高清画面效果，是否开启？',	'高级画质拥有高清画面效果，是否开启？',	'高画質にすると、画質が優先され、高解像度でプレイできます。オンにしますか？',	''},
{'7005',	'7005',	'输入的兑换码错误，请核对后再输入。',	'输入的兑换码错误，请核对后再输入。',	'無効なシリアルコードです。入力した内容に間違いがないか改めてご確認ください',	''},
{'7006',	'7006',	'密码重置完成',	'密码重置完成',	'パスワードを変更しました',	''},
{'8000',	'8000',	'探索等级达到<color=#FFC142>Lv.%s</color>后开启',	'探索等级达到<color=#FFC142>Lv.%s</color>后开启',	'プレイヤーレベルが<color=#FFC142>Lv.%s</color>になると開放',	''},
{'8001',	'8001',	'通过%s后开启',	'通过%s后开启',	'%sクリア後に開放',	''},
{'8002',	'8002',	'该副本今日不开放',	'该副本今日不开放',	'このクエストは本日挑戦できません',	''},
{'8003',	'8003',	'关卡达到3星后开启',	'关卡达到3星后开启',	'★3クリアで開放',	''},
{'8004',	'8004',	'当前没有可通往目标的线路，无法切换为自动寻路',	'当前没有可通往目标的线路，无法切换为自动寻路',	'目標地点に到達できるルートがありません。自動探索に変更できません',	''},
{'8005',	'8005',	'当前没有可通往目标的线路，请自行移动队伍',	'当前没有可通往目标的线路，请自行移动队伍',	'目標地点に到達できるルートがありません。手動で操作してください',	''},
{'8006',	'8006',	'道具数量不足！',	'道具数量不足！',	'アイテムが足りません！',	''},
{'8007',	'8007',	'请选择使用的道具',	'请选择使用的道具',	'使用アイテムを選んでください',	''},
{'8008',	'8008',	'自动寻路已停止',	'自动寻路已停止',	'自動探索が中止しました',	''},
{'8009',	'8009',	'本次挑战还有另一队伍生存',	'本次挑战还有另一队伍生存',	'今回の挑戦、生存チームが残り1つ',	''},
{'8010',	'8010',	'完成<color=#FFC142>%s</color>，解锁扫荡功能',	'完成<color=#FFC142>%s</color>，解锁扫荡功能',	'<color=#FFC142>%s</color>クリア後に掃討機能が開放されます',	''},
{'8011',	'8011',	'碎星虚影已每周重置',	'碎星虚影已每周重置',	'砕星虚影が更新されました',	''},
{'8012',	'8012',	'<color=#FFC142>掉落加成次数</color>已重置',	'<color=#FFC142>掉落加成次数</color>已重置',	'<color=#FFC142>ドロップボーナス回数</color>が更新されました',	''},
{'8013',	'8013',	'体力不足',	'体力不足',	'燃料が足りません',	''},
{'8014',	'8014',	'%s不足',	'%s不足',	'%sが足りません',	''},
{'8015',	'8015',	'扫荡次数不足',	'扫荡次数不足',	'掃討回数が足りません',	''},
{'8016',	'8016',	'没有掉落加成次数',	'没有掉落加成次数',	'ドロップボーナス回数がありません',	''},
{'8017',	'8017',	'<color=#FFC146>技能磨砺</color>已解锁，可每日探索内查看',	'<color=#FFC146>技能磨砺</color>已解锁，可每日探索内查看',	'<color=#FFC146>鍛冶研磨</color>が開放されました。詳細はデイリー探索でチェックすることができます',	''},
{'8018',	'8018',	'<color=#FFC146>芯片嵌合</color>已解锁，可每日探索内查看',	'<color=#FFC146>芯片嵌合</color>已解锁，可每日探索内查看',	'<color=#FFC146>チップ嵌合</color>が開放されました。詳細はデイリー探索でチェックすることができます',	''},
{'8019',	'8019',	'<color=#FFC146>荒墟拾遗与跃升行动</color>已解锁，可每日探索内查看',	'<color=#FFC146>荒墟拾遗与跃升行动</color>已解锁，可每日探索内查看',	'<color=#FFC146>遺物回収と躍昇行動</color>が開放されました。詳細はデイリー探索でチェックすることができます',	''},
{'8020',	'8020',	'是否确认播放剧情？',	'是否确认播放剧情？',	'シナリオを読みますか？',	''},
{'9000',	'9000',	'您当前使用的账号为未成年账号，游戏时间和付费会受到限制',	'您当前使用的账号为未成年账号，游戏时间和付费会受到限制',	'現在使用されているアカウントは未成年アカウントです。ゲーム時間やアプリ内の購入に制限が設けられます',	''},
{'9001',	'9001',	'您正在使用游客登录',	'您正在使用游客登录',	'現在ゲストとしてログインしています',	''},
{'9002',	'9002',	'注册成功！',	'注册成功！',	'アカウントを作成しました！',	''},
{'9003',	'9003',	'输入的文字中不得含有敏感字符',	'输入的文字中不得含有敏感字符',	'入力した内容に使用できない文字が含まれています',	''},
{'9004',	'9004',	'请先同意用户协议和用户隐私',	'请先同意用户协议和用户隐私',	'【利用規約】と【プライバシーポリシー】に同意する必要があります',	''},
{'9005',	'9005',	'注册成功！',	'注册成功！',	'アカウントを作成しました！',	''},
{'9006',	'9006',	'服务器繁忙,请稍后再试...',	'服务器繁忙,请稍后再试...',	'サーバー混雑中です。しばらく時間をおいてからもう一度試してください',	''},
{'9007',	'9007',	'验证码已发送，请注意查收',	'验证码已发送，请注意查收',	'認証コードを送信しました。ご確認ください',	''},
{'9008',	'9008',	'正在估算…',	'正在估算…',	'計算中…',	''},
{'9009',	'9009',	'未获取到服务器信息，是否重新获取？',	'未获取到服务器信息，是否重新获取？',	'サーバー情報を獲得できませんでした。もう一度試しますか？',	''},
{'9010',	'9010',	'请详细阅读并同意《账号注销协议》',	'请详细阅读并同意《账号注销协议》',	'【アカウント削除について】の全文を読んだ上で同意する必要があります',	''},
{'10000',	'10000',	'是否花费 %s 进行<color=#ffae00> %s </color>次构建？',	'是否花费 %s 进行<color=#ffae00> %s </color>次构建？',	'%sを消費して構築を<color=#ffae00> %s </color>回行いますか？',	''},
{'10001',	'10001',	'"获得新角色，是否锁定？"',	'"获得新角色，是否锁定？"',	'新しいキャラクターを獲得しました。ロックしますか？',	''},
{'10002',	'10002',	'是否使用该构建记录作为本次构建？使用后，则无法“再次构建”。',	'是否使用该构建记录作为本次构建？使用后，则无法“再次构建”。',	'この構築結果を確定しますか？確定すると、構築し直すことができなくなります',	''},
{'10003',	'10003',	'构建次数已达到上限，无法继续进行！',	'构建次数已达到上限，无法继续进行！',	'構築回数が上限に達しました。これ以上行えません！',	''},
{'10004',	'10004',	'当前的粲晶不足，无法进行兑换，是否进入商店购买？',	'当前的粲晶不足，无法进行兑换，是否进入商店购买？',	'粲晶が足りないため、交換できません。補給所で購入しますか？',	''},
{'10005',	'10005',	'今天构建次数已达到上限，无法继续构建。',	'今天构建次数已达到上限，无法继续构建。',	'本日の構築回数が上限に達しました。これ以上行えません',	''},
{'10006',	'10006',	'本次构建不需要任何费用，是否进行？',	'本次构建不需要任何费用，是否进行？',	'今回の構築は無料です。構築を行いますか？',	''},
{'10007',	'10007',	'该构建需要通关0-2后才会开启。本构建中，玩家可进行最大30次的10连构建，可从30次中选择其中一次作为最终结果；每次构建后，可暂时保留当前构建的结果，仅保留一次，若保留本次结果，则会覆盖此前的记录。',	'该构建需要通关0-2后才会开启。本构建中，玩家可进行最大30次的10连构建，可从30次中选择其中一次作为最终结果；每次构建后，可暂时保留当前构建的结果，仅保留一次，若保留本次结果，则会覆盖此前的记录。',	'0-2をクリアすると開放されます。本構築は最大30回10連構築を行うことができます。30回の10連構築の結果から1つだけ選べます。毎回の構築結果は1つだけ一時的に保存できます。新しい結果を保存する場合、現在保存されている結果が上書きされます。',	''},
{'10008',	'10008',	'是否确定以上构建作为最终结果？',	'是否确定以上构建作为最终结果？',	'この構築結果を確定しますか？',	''},
{'10009',	'10009',	'确定后将无法修改',	'确定后将无法修改',	'確定すると、変更できなくなります',	''},
{'10010',	'10010',	'当前构建暂无构建记录',	'当前构建暂无构建记录',	'構築履歴がありません',	''},
{'10011',	'10011',	'<color=#ff7781>*更换保底角色后，当前保底角色累计的次数将会重置</color>\n\n是否确定替换？',	'<color=#ff7781>*更换保底角色后，当前保底角色累计的次数将会重置</color>\n\n是否确定替换？',	'<color=#ff7781>※確定キャラを変更すると、確定までのカウントがリセットされます\n\n本当に変更しますか？',	''},
{'10012',	'10012',	'取消后，累计次数将会重置，是否取消角色保底？',	'取消后，累计次数将会重置，是否取消角色保底？',	'キャンセルすると、累計回数がリセットされます。キャラ確定をキャンセルしますか？',	''},
{'10013',	'10013',	'是否把 本次构建 替换当前的 构建记录？\n\n*<color=#ff7781>被替换掉的构建结果将会消失！</color>',	'是否把 本次构建 替换当前的 构建记录？\n\n*<color=#ff7781>被替换掉的构建结果将会消失！</color>',	'今回の構築結果に変更しますか？',	''},
{'10014',	'10014',	'通关0-2后开启',	'通关0-2后开启',	'0-2クリア後開放',	''},
{'10015',	'10015',	'当前构建卡池已关闭',	'当前构建卡池已关闭',	'この構築は終了しました',	''},
{'11000',	'11000',	'是否删除已读邮件？',	'是否删除已读邮件？',	'既読メールを削除しますか？',	''},
{'12000',	'12000',	'当前没有可以搭载的芯片',	'当前没有可以搭载的芯片',	'装着できるチップがありません',	''},
{'12001',	'12001',	'是否开启新的槽位？',	'是否开启新的槽位？',	'新しいスロットを開放しますか？',	''},
{'12002',	'12002',	'芯片被其他角色携带，是否替换到当前角色上？',	'芯片被其他角色携带，是否替换到当前角色上？',	'このチップはほかのキャラが装着しています。このキャラに装着させますか？',	''},
{'12003',	'12003',	'队员正在副本中，无法对芯片进行操作',	'队员正在副本中，无法对芯片进行操作',	'隊員がクエストで戦闘中です。チップに関する操作ができません',	''},
{'12004',	'12004',	'无可用的套装部位',	'无可用的套装部位',	'使用できるセットがありません',	''},
{'12005',	'12005',	'不存在类型为%s的芯片套装类型！',	'不存在类型为%s的芯片套装类型！',	'種類が%sのチップセットがありません！',	''},
{'12006',	'12006',	'好友角色不可更改',	'好友角色不可更改',	'フレンドキャラは変更できません',	''},
{'12007',	'12007',	'队员正在副本中，无法对芯片进行操作',	'队员正在副本中，无法对芯片进行操作',	'隊員がクエストで戦闘中です。チップに関する操作ができません',	''},
{'12008',	'12008',	'芯片已达最大强化等级',	'芯片已达最大强化等级',	'チップはすでに最大レベルです',	''},
{'12009',	'12009',	'请选择升级材料',	'请选择升级材料',	'強化素材を選んでください',	''},
{'12010',	'12010',	'强化成功！',	'强化成功！',	'強化しました！',	''},
{'12011',	'12011',	'已达到最大选择数量',	'已达到最大选择数量',	'選択可能の最大数に達しました',	''},
{'12012',	'12012',	'芯片仓库空间不足，请及时处理',	'芯片仓库空间不足，请及时处理',	'倉庫の容量が足りません。整理してください',	''},
{'12013',	'12013',	'卡牌空间不足，请清理卡牌后再次尝试',	'卡牌空间不足，请清理卡牌后再次尝试',	'容量が足りません。整理してからもう一度試してください',	''},
{'12014',	'12014',	'使用了%sx%s',	'使用了%sx%s',	'%sx%sを使用しました',	''},
{'12015',	'12015',	'自动匹配成功',	'自动匹配成功',	'自動装着しました',	''},
{'12016',	'12016',	'添加失败，强化经验已达上限',	'添加失败，强化经验已达上限',	'強化経験値が上限に達したため、選択できませんでした',	''},
{'13000',	'13000',	'存在队员技能升级完成，是否进入角色列表查看？',	'存在队员技能升级完成，是否进入角色列表查看？',	'スキル強化が完了した隊員がいます。隊員リストに移動してチェックしますか？',	''},
{'13001',	'13001',	'对话框已被<color=#ffc142>隐藏</color>',	'对话框已被<color=#ffc142>隐藏</color>',	'',	''},
{'13002',	'13002',	'对话框已<color=#ffc142>重新显示</color>',	'对话框已<color=#ffc142>重新显示</color>',	'',	''},
{'14000',	'14000',	'该队员正在战斗中...',	'该队员正在战斗中...',	'隊員がクエストで戦闘中です……',	''},
{'14001',	'14001',	'队伍正在出战中，无法执行该操作',	'队伍正在出战中，无法执行该操作',	'隊員がクエストで戦闘中です。操作できません',	''},
{'14002',	'14002',	'不能选择第一编队的队长',	'不能选择第一编队的队长',	'第一編隊のリーダーを選択できません',	''},
{'14003',	'14003',	'该角色无法下阵！',	'该角色无法下阵！',	'このキャラを外すことができません！',	''},
{'14004',	'14004',	'请选择出战队伍',	'请选择出战队伍',	'出撃するチームを選んでください',	''},
{'14005',	'14005',	'请设置出战队员',	'请设置出战队员',	'出撃する隊員を選んでください',	''},
{'14006',	'14006',	'第一小队中没有配置队员，无法出击',	'第一小队中没有配置队员，无法出击',	'第1チームに隊員が配置されていないため、出撃できません',	''},
{'14007',	'14007',	'无法放置支援队员，角色占位超过上限!',	'无法放置支援队员，角色占位超过上限!',	'キャラの配置枠に空きがないため、サポートキャラを配置できません',	''},
{'14008',	'14008',	'请选择队伍之后再变更队员',	'请选择队伍之后再变更队员',	'チームを選んでから隊員の変更を行ってください',	''},
{'14009',	'14009',	'%s中不能只上阵支援队员',	'%s中不能只上阵支援队员',	'%sの中でサポートキャラのみの出撃ができません',	''},
{'14010',	'14010',	'由于支援队员与我方队员重复，已下阵支援队员',	'由于支援队员与我方队员重复，已下阵支援队员',	'チーム内にサポートキャラと重複したキャラがいるため、サポートキャラを外しました',	''},
{'14011',	'14011',	'%s中没有配置队长，无法出击',	'%s中没有配置队长，无法出击',	'%sにリーダーが配置されていないため、出撃できません',	''},
{'14012',	'14012',	'%s缺少必要队员',	'%s缺少必要队员',	'%sに必要な隊員が足りません',	''},
{'14013',	'14013',	'未找到强制上阵的角色数据：%s',	'未找到强制上阵的角色数据：%s',	'強制参戦のキャラデータが見つかりませんでした：%s',	''},
{'14014',	'14014',	'该预设队伍没有队长，无法使用',	'该预设队伍没有队长，无法使用',	'この編成はリーダーが設定されていないため、使用できません',	''},
{'14015',	'14015',	'队伍%s中必须要有队长',	'队伍%s中必须要有队长',	'チーム%sのリーダーを設定する必要があります',	''},
{'14016',	'14016',	'当前队伍中的队员与其他队伍存在重复使用的情况，是否将该队员退出其他队伍？',	'当前队伍中的队员与其他队伍存在重复使用的情况，是否将该队员退出其他队伍？',	'チーム内にほかのチームと重複したキャラがいます。このキャラをほかのチームから抜きますか？',	''},
{'14017',	'14017',	'第%s小队',	'第%s小队',	'第%sチーム',	''},
{'14018',	'14018',	'请先解锁上一个预设队伍',	'请先解锁上一个预设队伍',	'一つ前の編成枠を開放してください',	''},
{'14019',	'14019',	'是否花费%s进行解锁？',	'是否花费%s进行解锁？',	'%sを消費して開放しますか？',	''},
{'14020',	'14020',	'预设队伍中存在正在战斗中的角色，无法使用！',	'预设队伍中存在正在战斗中的角色，无法使用！',	'編成チーム内に戦闘中のキャラがいるため、使用できません！',	''},
{'14021',	'14021',	'请配置队长',	'请配置队长',	'リーダーを配置してください',	''},
{'14022',	'14022',	'强制上阵无法使用编队预设',	'强制上阵无法使用编队预设',	'強制参戦のため、編成セットは使用できません',	''},
{'14023',	'14023',	'队长不能下阵！',	'队长不能下阵！',	'リーダーを外すことができません！',	''},
{'14024',	'14024',	'是否把角色移除出队伍？',	'是否把角色移除出队伍？',	'チームから外しますか？',	''},
{'14025',	'14025',	'无法放置，上阵人数已满!',	'无法放置，上阵人数已满!',	'参戦人数がすでに最大です。配置できません！',	''},
{'14026',	'14026',	'存在相同角色',	'存在相同角色',	'同じキャラが存在しています',	''},
{'14027',	'14027',	'队伍%s',	'队伍%s',	'チーム%s',	''},
{'14028',	'14028',	'存在其他队伍中的角色，是否确认修改？',	'存在其他队伍中的角色，是否确认修改？',	'ほかのチームと重複したキャラがいます。変更しますか？',	''},
{'14029',	'14029',	'队长',	'队长',	'リーダー',	''},
{'14030',	'14030',	'-支援角色-',	'-支援角色-',	'サポートキャラ',	''},
{'14031',	'14031',	'-强制出战-',	'-强制出战-',	'強制参戦',	''},
{'14032',	'14032',	'-非控制角色-',	'-非控制角色-',	'非操作キャラ',	''},
{'14033',	'14033',	'热值不足！',	'热值不足！',	'燃料が足りません！',	''},
{'14034',	'14034',	'是否替换到%s?',	'是否替换到%s?',	'%sに変更しますか？',	''},
{'14035',	'14035',	'每个队伍只能上阵一名支援队员',	'每个队伍只能上阵一名支援队员',	'チームごとに配置できるサポートキャラは1名のみ',	''},
{'14036',	'14036',	'当前队伍禁止上阵支援队员',	'当前队伍禁止上阵支援队员',	'このチームはサポートキャラの使用が禁止されています',	''},
{'14037',	'14037',	'第一编队队长已留下，剩余队员已迁移到第二编队',	'第一编队队长已留下，剩余队员已迁移到第二编队',	'第一編隊のリーダー以外、すべての隊員が第二編隊に移動させました',	''},
{'15000',	'15000',	'%s数量不足',	'%s数量不足',	'%sが足りません',	''},
{'15001',	'15001',	'尚未开放...',	'尚未开放...',	'まだ開放されていません…',	''},
{'15002',	'15002',	'当前还未获得该角色',	'当前还未获得该角色',	'まだこのキャラを獲得していません',	''},
{'15101',	'15101',	'暂未开放',	'暂未开放',	'未開放',	''},
{'15102',	'15102',	'星贸凭证',	'星贸凭证',	'星貿パスポート',	''},
{'15103',	'15103',	'当前测试暂不开放，敬请期待。',	'当前测试暂不开放，敬请期待。',	'現在この機能はまだ開放されていません。乞うご期待。',	''},
{'15104',	'15104',	'当前没有额外的星源可进行兑换',	'当前没有额外的星源可进行兑换',	'交換できる星源がありません',	''},
{'15105',	'15105',	'当前没有额外的碎片可以兑换',	'当前没有额外的碎片可以兑换',	'交換できる欠片がありません',	''},
{'15106',	'15106',	'是否购买%s？',	'是否购买%s？',	'%sを購入しますか？',	''},
{'15107',	'15107',	'是否花费<color=#ffc142>%s</color>%s购买%s？',	'是否花费<color=#ffc142>%s</color>%s购买%s？',	'<color=#ffc142>%s</color>%sを消費して%sを購入しますか？',	''},
{'15108',	'15108',	'购买后持续时间大于180天，暂不可再次购买',	'购买后持续时间大于180天，暂不可再次购买',	'購入後の継続日数が180日を超えるため、購入できません',	''},
{'15109',	'15109',	'限时贸易所已刷新',	'限时贸易所已刷新',	'限定ショップが更新されました',	''},
{'15110',	'15110',	'新的商品已上架',	'新的商品已上架',	'商品リストが更新されました',	''},
{'15111',	'15111',	'新的商品已上架',	'新的商品已上架',	'商品リストが更新されました',	''},
{'15112',	'15112',	'新的商品已上架',	'新的商品已上架',	'商品リストが更新されました',	''},
{'15113',	'15113',	'支付未完成，是否继续支付？',	'支付未完成，是否继续支付？',	'購入手続きはまだ完了していません。購入を続けますか？',	''},
{'15114',	'15114',	'支付失败，请稍后再尝试\n<color=#ff7781>如已充值成功，请稍后留意到账情况</color>',	'支付失败，请稍后再尝试\n<color=#ff7781>如已充值成功，请稍后留意到账情况</color>',	'購入手続きが完了できませんでした。しばらく時間をおいてから再度お試しください。\n<color=#ff7781>購入が成功した場合、アプリ内の購入状況をご確認ください</color>',	''},
{'15115',	'15115',	'支付已取消',	'支付已取消',	'購入手続きがキャンセルされました',	''},
{'15116',	'15116',	'支付成功',	'支付成功',	'決済完了',	''},
{'15117',	'15117',	'购买成功，奖励已通过邮件发送，是否前往领取？',	'购买成功，奖励已通过邮件发送，是否前往领取？',	'購入しました。報酬はメールで送りました。今すぐ受け取りに行きますか？',	''},
{'15118',	'15118',	'演习商店维护中',	'演习商店维护中',	'メンテナンス中',	''},
{'15119',	'15119',	'新的时装已上架',	'新的时装已上架',	'',	''},
{'15120',	'15120',	'商品已刷新',	'商品已刷新',	'',	''},
{'15121',	'15121',	'商店已关闭',	'商店已关闭',	'',	''},
{'15003',	'15003',	'剩余数量：%s',	'剩余数量：%s',	'残り：%s',	''},
{'15004',	'15004',	'是否花费%s%s购买%s？',	'是否花费%s%s购买%s？',	'%s%sを消費して%sを購入しますか？',	''},
{'15005',	'15005',	'是否花费 %s 进行刷新？',	'是否花费 %s 进行刷新？',	'%sを消費して更新しますか？',	''},
{'15006',	'15006',	'',	'0',	'',	''},
{'16000',	'16000',	'锁定的芯片不能出售！',	'锁定的芯片不能出售！',	'ロックされたチップは売却できません！',	''},
{'16001',	'16001',	'是否出售选择的芯片？',	'是否出售选择的芯片？',	'選択したチップを売却しますか？',	''},
{'16002',	'16002',	'没有选择需要出售的芯片',	'没有选择需要出售的芯片',	'売却するチップを選んでください',	''},
{'16003',	'16003',	'已达到选择数量上限',	'已达到选择数量上限',	'選択可能の最大数に達しました',	''},
{'16004',	'16004',	'是否花费<color=\"#ffc146\">%s</color>开启<color=\"#ffc146\">%s个背包容量</color>？',	'是否花费<color=\"#ffc146\">%s</color>开启<color=\"#ffc146\">%s个背包容量</color>？',	'<color=\"#ffc146\">%s</color>を消費して倉庫の容量を<color=\"#ffc146\">%s</color>増やしますか？',	''},
{'16005',	'16005',	'还没有解锁该跳转功能哦',	'还没有解锁该跳转功能哦',	'この機能はまだ開放されていません',	''},
{'16006',	'16006',	'暂未达到开启副本条件',	'暂未达到开启副本条件',	'クエストの開放条件はまだ満たしていません',	''},
{'16007',	'16007',	'该副本今日不开放',	'该副本今日不开放',	'このクエストは本日挑戦できません',	''},
{'16008',	'16008',	'需要到背包中使用',	'需要到背包中使用',	'倉庫の中で使用する必要があります',	''},
{'17000',	'17000',	'请输入公会名字！',	'请输入公会名字！',	'ギルドの名前を入力してください',	''},
{'17001',	'17001',	'请选择公会头像！',	'请选择公会头像！',	'ギルドのアイコンを選んでください',	''},
{'17002',	'17002',	'是否退出公会？退出后24小时内无法加入其它公会。',	'是否退出公会？退出后24小时内无法加入其它公会。',	'ギルドを脱退しますか？脱退してから24時間の間、ほかのギルドに加入できません。',	''},
{'17003',	'17003',	'是否任命%s为副会长？',	'是否任命%s为副会长？',	'%sをサブリーダーにしますか？',	''},
{'17004',	'17004',	'是否取消%s副会长权限？',	'是否取消%s副会长权限？',	'%sのサブリーダー権限を解除しますか？',	''},
{'17005',	'17005',	'是否任命%s为会长？',	'是否任命%s为会长？',	'%sをリーダーにしますか？',	''},
{'17006',	'17006',	'是否将%s请离公会？',	'是否将%s请离公会？',	'%sをギルドから追放しますか？',	''},
{'17007',	'17007',	'已经是好友了',	'已经是好友了',	'すでにフレンドになっています',	''},
{'17008',	'17008',	'你好，我是%s',	'你好，我是%s',	'こんにはち、私は%sです',	''},
{'17009',	'17009',	'20秒内无法再次刷新',	'20秒内无法再次刷新',	'20秒間更新できません',	''},
{'17010',	'17010',	'是否加入“%s”公会？',	'是否加入“%s”公会？',	'ギルド「%s」に加入しますか？',	''},
{'17011',	'17011',	'是否申请进入“%s”公会？',	'是否申请进入“%s”公会？',	'ギルド「%s」に加入申請を送りますか？',	''},
{'17012',	'17012',	'是否取消“%s”公会入会申请？',	'是否取消“%s”公会入会申请？',	'ギルド「%s」への加入申請を取り消しますか？',	''},
{'17013',	'17013',	'是否解散公会？解散后，48小时内无法创建新的公会。',	'是否解散公会？解散后，48小时内无法创建新的公会。',	'ギルドを解散しますか？解散してから48時間の間、新しいギルドを作成できません。',	''},
{'17014',	'17014',	'权限不足!',	'权限不足!',	'権限がありません',	''},
{'18000',	'18000',	'未获得',	'未获得',	'未獲得',	''},
{'19000',	'19000',	'演习无法自行退出战斗',	'演习无法自行退出战斗',	'演習中は戦闘を中止することができません',	''},
{'19001',	'19001',	'撤退后，当前队伍会撤退战斗，切换至其他队伍，是否继续？',	'撤退后，当前队伍会撤退战斗，切换至其他队伍，是否继续？',	'撤退すると、現在のチームが使用できなくなり、ほかのチームに切り替える。続けますか？',	''},
{'19002',	'19002',	'是否撤退？\n撤退后将失去该关卡的进度。',	'是否撤退？\n撤退后将失去该关卡的进度。',	'撤退しますか？\n撤退すると、現在の進行度がなくなります。',	''},
{'19003',	'19003',	'是否撤退？',	'是否撤退？',	'撤退しますか？',	''},
{'19004',	'19004',	'退出战斗无法获得任何奖励，但不扣除战斗次数，是否退出？',	'退出战斗无法获得任何奖励，但不扣除战斗次数，是否退出？',	'戦闘を中止しても戦闘回数を消費しませんが、報酬がもらえません。中止しますか？',	''},
{'19005',	'19005',	'试玩中退出战斗不会有任何的收益影响，是否退出？',	'试玩中退出战斗不会有任何的收益影响，是否退出？',	'お試し中に戦闘を中止しても影響が一切ありません。中止しますか？',	''},
{'19006',	'19006',	'%s，无法释放机神传送',	'%s，无法释放机神传送',	'%s、機神転送を発動できません',	''},
{'19007',	'19007',	'%s，无法释放',	'%s，无法释放',	'%s、発動できません',	''},
{'19008',	'19008',	'%s，无法释放核心爆发',	'%s，无法释放核心爆发',	'%s、OVERLOADを発動できません',	''},
{'19009',	'19009',	'角色同步率不足',	'角色同步率不足',	'キャラのSPが足りません',	''},
{'19010',	'19010',	'角色处于异常状态中',	'角色处于异常状态中',	'キャラが不利状態になっています',	''},
{'19011',	'19011',	'没有足够能量值',	'没有足够能量值',	'NPが足りません',	''},
{'19012',	'19012',	'角色处于同调状态',	'角色处于同调状态',	'キャラが同調状態です',	''},
{'19013',	'19013',	'该技能为被动技能',	'该技能为被动技能',	'このスキルはパッシブスキルです',	''},
{'19014',	'19014',	'场上没有对应目标',	'场上没有对应目标',	'場に対象がいません',	''},
{'19015',	'19015',	'处于冷却中',	'处于冷却中',	'冷却中です',	''},
{'19016',	'19016',	'没有足够怪物能量值',	'没有足够怪物能量值',	'エネミーのNPが足りません',	''},
{'19017',	'19017',	'不可召唤',	'不可召唤',	'召喚不可',	''},
{'19018',	'19018',	'连接服务器失败，即将返回登录界面',	'连接服务器失败，即将返回登录界面',	'サーバーに接続できませんでした。ログイン画面に戻ります',	''},
{'19019',	'19019',	'是否跳过本关卡的开场动画？',	'是否跳过本关卡的开场动画？',	'',	''},
{'19020',	'19020',	'今日跳过本关卡的所有开场动画',	'今日跳过本关卡的所有开场动画',	'',	''},
{'19021',	'19021',	'今日跳过拟真演训的所有开场动画',	'今日跳过拟真演训的所有开场动画',	'',	''},
{'20000',	'20000',	'当前方案已被修改，但没有保存，是否退出？',	'当前方案已被修改，但没有保存，是否退出？',	'設定が変更されましたが、まだ保存していません。このまま退出しますか？',	''},
{'20001',	'20001',	'当前方案已被修改，但没有保存，是否不保存切换方案？',	'当前方案已被修改，但没有保存，是否不保存切换方案？',	'設定が変更されましたが、まだ保存していません。保存せずに退出しますか？',	''},
{'21000',	'21000',	'好感度经验已达上限',	'好感度经验已达上限',	'好感度が上限に達しました',	''},
{'21001',	'21001',	'%s主题购买成功',	'%s主题购买成功',	'テーマ%sを購入しました',	''},
{'21002',	'21002',	'无法一键购买，家具币不足',	'无法一键购买，家具币不足',	'家具コインが足りないため、まとめて購入できませんでした',	''},
{'21003',	'21003',	'是否使用当前主题进行房间布置？',	'是否使用当前主题进行房间布置？',	'このテーマで部屋の配置を行いますか？',	''},
{'21004',	'21004',	'确定要撤掉所有家具？',	'确定要撤掉所有家具？',	'すべての家具を収納しますか？',	''},
{'21005',	'21005',	'是否移除该方案？',	'是否移除该方案？',	'このマイセットを削除しますか？',	''},
{'21006',	'21006',	'该主题中的部分家具正在被其他房间占用，无法进行布置',	'该主题中的部分家具正在被其他房间占用，无法进行布置',	'テーマ内の一部の家具はほかの部屋で使用されているため、配置できません',	''},
{'21007',	'21007',	'是否在当前房间进行布置',	'是否在当前房间进行布置',	'現在の部屋で配置を行いますか？',	''},
{'21008',	'21008',	'是否使用当前主题进行房间布置？',	'是否使用当前主题进行房间布置？',	'このテーマで部屋の配置を行いますか？',	''},
{'21009',	'21009',	'未拥有该主题所需的全部家具，是否前往购买？',	'未拥有该主题所需的全部家具，是否前往购买？',	'このテーマに必要なすべての家具を所持していません。購入しに行きますか？',	''},
{'21010',	'21010',	'分享数量已达到上限，需要清理分享后才能继续上传',	'分享数量已达到上限，需要清理分享后才能继续上传',	'シェア数は上限に達しました。整理してからアップロードしてください',	''},
{'21011',	'21011',	'名字不能为空',	'名字不能为空',	'名前を入力してください',	''},
{'21012',	'21012',	'名字不可用',	'名字不可用',	'この名前は使用できません',	''},
{'21013',	'21013',	'你正在访问该好友',	'你正在访问该好友',	'すでにこのフレンドを訪問しています',	''},
{'21014',	'21014',	'是否取消点赞？',	'是否取消点赞？',	'いいねを取り消しますか？',	''},
{'21015',	'21015',	'是否取消收藏？',	'是否取消收藏？',	'お気に入りを解除しますか？',	''},
{'21016',	'21016',	'是否取消分享？',	'是否取消分享？',	'シェアを解除しますか？',	''},
{'21017',	'21017',	'分享成功',	'分享成功',	'シェアしました',	''},
{'21018',	'21018',	'点赞成功',	'点赞成功',	'いいねしました',	''},
{'21019',	'21019',	'收藏成功',	'收藏成功',	'お気に入りに追加しました',	''},
{'21020',	'21020',	'无法点赞自己分享的主题',	'无法点赞自己分享的主题',	'自分がシェアしたテーマにいいねを押せません',	''},
{'21021',	'21021',	'无法收藏自己分享的主题',	'无法收藏自己分享的主题',	'自分がシェアしたテーマをお気に入りに追加できません',	''},
{'21022',	'21022',	'该物品数量不足，无法选择',	'该物品数量不足，无法选择',	'アイテムの所持数が足りないため、選択できません',	''},
{'21023',	'21023',	'家具当前摆放位置不可用,请重新调整',	'家具当前摆放位置不可用,请重新调整',	'ここに配置できません。家具の位置を調整してください',	''},
{'21024',	'21024',	'是否保存修改？',	'是否保存修改？',	'変更結果を保存しますか？',	''},
{'21025',	'21025',	'是否退出宿舍？',	'是否退出宿舍？',	'寮舎から出ますか？',	''},
{'21026',	'21026',	'已完成布置',	'已完成布置',	'配置しました',	''},
{'21027',	'21027',	'已保存成功',	'已保存成功',	'保存しました',	''},
{'21028',	'21028',	'当前房间有尚未保存的装扮更改，确定要退出？',	'当前房间有尚未保存的装扮更改，确定要退出？',	'変更されました内容はまだ保存していません。このまま退出しますか？',	''},
{'21029',	'21029',	'确定重置所有更改？',	'确定重置所有更改？',	'すべての変更をリセットしますか？',	''},
{'21030',	'21030',	'无法放置，房间可放置家具已达上限',	'无法放置，房间可放置家具已达上限',	'部屋内に配置できる家具はすでに上限に達しているため、配置できません',	''},
{'21031',	'21031',	'无法保存，存在家具位置部分重叠，请调整位置',	'无法保存，存在家具位置部分重叠，请调整位置',	'保存できません。重なっている家具があります。位置を調整してください',	''},
{'21032',	'21032',	'该家具已放置在当前房间中',	'该家具已放置在当前房间中',	'この家具はすでに部屋に配置されています',	''},
{'21033',	'21033',	'当前队员好感度已满级，无需额外赠送礼物',	'当前队员好感度已满级，无需额外赠送礼物',	'この隊員の好感度はすでに最大です',	''},
{'21034',	'21034',	'进驻队员失败，当前房间布局异常，请重新调整。',	'',	'この隊員の好感度はすでに最大です',	''},
{'22001',	'22001',	'提升至%s等级，可获得以下奖励',	'提升至%s等级，可获得以下奖励',	'',	''},
{'22002',	'22002',	'已达到最大等级',	'已达到最大等级',	'すでに最大レベルです',	''},
{'22003',	'22003',	'本期勘探指南已结束',	'本期勘探指南已结束',	'今期の探査指南が終了しました',	''},
{'23001',	'23001',	'已达到本日购买上限，无法继续购买',	'已达到本日购买上限，无法继续购买',	'本日の購入回数上限に達したため、これ以上購入できません',	''},
{'24001',	'24001',	'本次活动已关闭',	'本次活动已关闭',	'本イベントが終了しました',	''},
{'24002',	'24002',	'未通过上一难度',	'未通过上一难度',	'一つ前の難易度はまだクリアしていません',	''},
{'24003',	'24003',	'当前不在活动开放时间内',	'当前不在活动开放时间内',	'イベントの開催期間外です',	''},
{'24004',	'24004',	'未通过上一个探索关卡',	'未通过上一个探索关卡',	'一つ前の探索クエストはまだクリアしていません',	''},
{'24005',	'24005',	'本类型探索关卡2倍掉落次数已消耗完毕',	'本类型探索关卡2倍掉落次数已消耗完毕',	'ドロップボーナス回数は全部消費されました',	''},
{'24006',	'24006',	'新的阶段任务已开启',	'新的阶段任务已开启',	'新しい段階の任務が開放されました',	''},
{'24007',	'24007',	'困难模式于%s开启',	'困难模式于%s开启',	'ハードモードは%sで開放',	''},
{'24008',	'24008',	'未完成上一危险等级的挑战',	'未完成上一危险等级的挑战',	'',	''},
{'24009',	'24009',	'当天优惠购买次数已达上限，是否前往补给站购买？',	'当天优惠购买次数已达上限，是否前往补给站购买？',	'',	''},
{'24010',	'24010',	'剧情简介',	'',	'',	''},
{'24011',	'24011',	'剧情关卡',	'',	'',	''},
{'24012',	'24012',	'开始播放',	'',	'',	''},
{'25001',	'25001',	'需要通关<color=#FFC142>%s</color>后，才能解锁本板块',	'需要通关<color=#FFC142>%s</color>后，才能解锁本板块',	'このプレートは<color=#FFC142>%s</color>をクリア後に開放されます',	''},
{'25002',	'25002',	'需要通关<color=#FFC142>%s</color>后，才能解锁本战场',	'需要通关<color=#FFC142>%s</color>后，才能解锁本战场',	'この戦場は<color=#FFC142>%s</color>をクリア後に開放されます',	''},
{'25003',	'25003',	'需要通关<color=#FFC142>%s</color>后，才能解锁本区域',	'需要通关<color=#FFC142>%s</color>后，才能解锁本区域',	'この区域は<color=#FFC142>%s</color>をクリア後に開放されます',	''},
{'26001',	'26001',	'%s解锁战术',	'%s解锁战术',	'%s戦術開放',	''},
{'26002',	'26002',	'%s解锁自动战斗AI设置',	'%s解锁自动战斗AI设置',	'%sオート戦闘AI設定開放',	''},
{'26101',	'26101',	'<color=#FFC142>【战术】</color>中开启<color=#FFC142>%s</color>后解锁',	'<color=#FFC142>【战术】</color>中开启<color=#FFC142>%s</color>后解锁',	'<color=#FFC142>【戦術】</color>の中で開放<color=#FFC142>%s</color>後にアンロック',	''},
{'26102',	'26102',	'玩家升级后可获得战术点，是否前往模式选择界面？',	'玩家升级后可获得战术点，是否前往模式选择界面？',	'プレイヤーレベルが上がると、戦術ポイントがもらえます。戦術メニューに移動しますか？',	''},
{'26103',	'26103',	'<color=#FFC142>【续行战术】</color>已自动装备上当前队伍',	'<color=#FFC142>【续行战术】</color>已自动装备上当前队伍',	'自動的に<color=#FFC142>【持久戦術】</color>に設定しました',	''},
{'26104',	'26104',	'已默认装备<color=#FFC142>【续行战术】</color>技能',	'已默认装备<color=#FFC142>【续行战术】</color>技能',	'自動的に<color=#FFC142>【持久戦術】</color>に設定しました',	''},
{'27001',	'27001',	'该外观未设置为看板',	'该外观未设置为看板',	'まだロビーに設定していません',	''},
{'27002',	'27002',	'成功更换看板',	'成功更换看板',	'ロビー設定を変更しました',	''},
{'28001',	'28001',	'未解锁，到达<color=#FFC142>第%s天</color>时开启',	'未解锁，到达<color=#FFC142>第%s天</color>时开启',	'未開放です。<color=#FFC142>%s日目</color>に開放されます',	''},
{'28002',	'28002',	'完成并领取<color=#FFC142>上一阶段</color>的全部任务奖励后解锁',	'完成并领取<color=#FFC142>上一阶段</color>的全部任务奖励后解锁',	'<color=#FFC142>前の段階</color>の任務を全部達成し、報酬を受け取ると開放されます',	''},
{'29001',	'29001',	'点击<color=#FFC142>箭头</color>或<color=#FFC142>拖动图片</color>可切换教程',	'点击<color=#FFC142>箭头</color>或<color=#FFC142>拖动图片</color>可切换教程',	'<color=#FFC142>矢印</color>をタップ、または<color=#FFC142>画像</color>をスワイプすると、ページの切り替えができます',	''},
{'30001',	'30001',	'当前版本暂不支持修改名字',	'当前版本暂不支持修改名字',	'現在のバージョンでは名前変更ができません',	''},
{'33001',	'33001',	'赛季已刷新，玩家积分排名已重置',	'赛季已刷新，玩家积分排名已重置',	'シーズン更新のため、プレイヤーの順位とポイントがリセットされました',	''},
{'33002',	'33002',	'模拟次数已刷新',	'模拟次数已刷新',	'模擬回数が更新されました',	''},
{'33003',	'33003',	'演习兑换商店已刷新',	'演习兑换商店已刷新',	'アリーナショップが更新されました',	''},
{'33004',	'33004',	'当前模拟次数已满',	'当前模拟次数已满',	'模擬回数はすでに最大です',	''},
{'33005',	'33005',	'今日购买次数已消耗完毕',	'今日购买次数已消耗完毕',	'本日の購入回数上限に達しました',	''},
{'33006',	'33006',	'次数无法超过上限',	'次数无法超过上限',	'回数は上限を超えることができません',	''},
{'33007',	'33007',	'今日购买次数已消耗完毕',	'今日购买次数已消耗完毕',	'本日の購入回数上限に達しました',	''},
{'33008',	'33008',	'挑战次数购买成功',	'挑战次数购买成功',	'挑戦回数を購入しました',	''},
{'33018',	'33018',	'赛季结算中，请稍后再参加',	'赛季结算中，请稍后再参加',	'集計中です。次回の参加をお待ちしております',	''},
{'33019',	'33019',	'没有匹配到对手，请稍后再试',	'没有匹配到对手，请稍后再试',	'対戦相手が見つかりませんでした',	''},
{'34001',	'34001',	'未通过上一演训难度',	'未通过上一演训难度',	'一つ前の難易度をクリアしていません',	''},
{'34002',	'34002',	'已解锁下一演训难度',	'已解锁下一演训难度',	'次の難易度が開放されました',	''},
{'34003',	'34003',	'地狱难度会在 %s天 %s 后开启',	'地狱难度会在 %s天 %s 后开启',	'難易度「地獄」は%s日%s後に開放されます',	''},
},
}
--cfgCfgLanguageTips = conf
return conf
