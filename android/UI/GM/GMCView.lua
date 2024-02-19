-- local GMCInfos = {
--         --玩家
--         {content = "设置玩家等级", formatStr = "plrlvl %s", tips = "参数格式：等级"},
--         {content = "添加玩家经验", formatStr = "plrexp %s", tips = "参数格式：经验值"},
--         {content = "设置金钱", formatStr = "money %s", tips = "参数格式：钻石数量 金币数量"},
--         {content = "设置金钱Max", formatStr = "money 1000000 1000000", tips = "参数格式：无"},
--         {content = "开启所有能力", formatStr = "ablilitys %s", tips = "参数格式：无"},
--         {content = "开启所有技能组", formatStr = "skillGroup %s", tips = "参数格式：无"},
--         {content = "设定服务器时间", formatStr = "time %s", tips = "参数格式：2019-10-13-11:40:30"},
--         --关卡
--         {content = "开启所有关卡", formatStr = "passAll %s", tips = "参数格式：无"},
--         {content = "一键结束战斗", formatStr = "overFight %s", tips = "参数格式：为1 时胜利，为2时失败"},
--         {content = "通过某一关卡", formatStr = "passgate %s", tips = "参数格式：关卡id"},
--         --背包/道具
--         {content = "清空背包", formatStr = "cleanItemBag %s", tips = "参数格式：无"},
--         {content = "添加物品", formatStr = "additem %s", tips = "参数格式：物品id 数量"},
--         {content = "掉落道具", formatStr = "reward %s", tips = "参数格式：掉落表id"},
--         {content = "满背包", formatStr = "fullItemBag %s", tips = "参数格式：物品类型，不指定类型就添加全部类型"},
--         --卡牌
--         {content = "全卡牌满级", formatStr = "superCard %s", tips = "参数格式：无"},
--         {content = "添加所有卡牌", formatStr = "addAllCard %s", tips = "参数格式：无"},
--         {content = "添加卡牌", formatStr = "addcard %s", tips = "参数格式：卡牌id"},
--         {content = "设置所有卡牌热值", formatStr = "cardHot %s", tips = "参数格式：热值"},
--         {content = "清空未使用的卡牌", formatStr = "cleanCard %s", tips = "参数格式：无"},
--         --装备
--         {content = "全装备满级", formatStr = "superEquip %s", tips = "参数格式：无"},
--         {content = "添加装备", formatStr = "addEquip %s", tips = "参数格式：装备id 数量"},
--         {content = "按数量添加装备", formatStr = "addAllEquip %s", tips = "参数格式：数量，数量不填直接按配置表数量读取"},
--         --邮件
--         {content = "向玩家发送邮件", formatStr = "mail %s", tips = "参数格式：邮件配置ID"},
--         {content = "掉落邮件", formatStr = "rmail %s", tips = "参数格式：掉落id 掉落次数"},
--         {content = "发送全局邮件", formatStr = "gmail %s", tips = "参数格式：邮件配置ID"},
--         {content = "发送gm邮件", formatStr = "gmMail %s", tips = "参数格式：邮件标题 发件人 发送时间(单位:秒) 正文 道具奖励(掉落id)"},
--         --活动
--         {content = "开启活动", formatStr = "openactive %s", tips = "参数格式：活动配置ID，不填时全部开启"},
--         --其他
--         {content = "兑换码兑换", formatStr = "exchangeCode %s", tips = "参数格式：兑换码"},
--         {content = "重置军演信息", formatStr = "armyReset %s", tips = "参数格式：增减的分数"},
--         {content = "商店折扣开启/关闭", formatStr = "shop %s", tips = "参数格式：商品id 操作类型:1为折扣设置2为购买记录设置 操作值：当操作类型为1时为0或1，0为取消折扣，1为开启折扣"},
--         --关卡步数
--         {content = "设置行动次数", formatStr = "SetDuplicateStep %s", tips = "参数格式：行动次数"}
-- }
local options = nil;
local isTemp = false;
function Awake()
    inputField = ComUtil.GetCom(input, "InputField");
    txtPlot = ComUtil.GetCom(TxtPlot, "InputField");
    txt_vibrate = ComUtil.GetCom(TxtVibrate, "InputField");
    txt_jump = ComUtil.GetCom(TxtJump, "InputField");
    -- 初始化下拉列表
    txtParams = ComUtil.GetCom(TxtParams, "InputField");
    txt_paramTips = ComUtil.GetCom(paramTips, "Text");
    GMDropList = ComUtil.GetCom(GMList, "Dropdown");
    options = GmCmdList;
    GMDropList:ClearOptions()
    CSAPI.AddDropdownOptions(GMList, GetOptions())
    CSAPI.AddDropdownCallBack(GMList, OnDropValChange);
    selectIndex = 1;
    local ex = options[selectIndex].exapmle and options[selectIndex].exapmle or "";
    txt_paramTips.text = options[selectIndex].use .. " 示例：" .. ex;
    inputSearch = ComUtil.GetCom(search, "InputField");
    inputVideoField = ComUtil.GetCom(inputVideo, "InputField");
    inputGuideField = ComUtil.GetCom(inputGuide, "InputField");
    inputSceneField = ComUtil.GetCom(inputScene, "InputField");
    CSAPI.SetText(txt_fightRoleInfo, _G.showPvpRoleInfo and "关闭PVP卡牌信息" or "开启PVP卡牌信息");
    SetSearchText(options[selectIndex].desc);
    CSAPI.AddInputFieldChange(search, OnSearch);
end

function OnEnable()
    CSAPI.AddSliderCallBack(slider_Light, OnLightChange);
end

function OnDisable()
    CSAPI.RemoveSliderCallBack(slider_Light, OnLightChange);
    CSAPI.RemoveInputFieldChange(search, OnSearch);
end

-- 点击按钮
function OnClick()
    local str = inputField.text;
    local proto = {"ClientProto:GmCmd", {
        cmd = str
    }};
    if GMCmd(str) then
        return
    end
    NetMgr.net:Send(proto);
end

-- 点击进入副本按钮
function OnClickEnterDungeon()
    local str = inputField.text;

    DungeonMgr:ApplyEnterByDefault(tonumber(str));
end

function btnAddJQ()
    local str = txtPlot.text == "" and nil or txtPlot.text;
    if str ~= nil then
        local strs = StringUtil:split(str, " ");
        local pID = strs[1] == nil and nil or tonumber(strs[1]);
        local tID = strs[2] == nil and nil or tonumber(strs[2]);
        local story = StoryData.New();
        story:InitCfg(pID);
        if story ~= nil then
            if story:GetType() == PlotType.Normal then
                CSAPI.OpenView("Plot", {
                    storyID = pID,
                    talkID = tID
                });
            else
                CSAPI.OpenView("PlotSimple", {
                    storyID = pID
                });
            end
        end
    end
    view:Close();
end

function btnAddPVE()
    local proto = {
        nDuplicateID = 1001,
        groupID = 101011
    };
    FightProto:StartMainLineFight(proto);
end

function OnBtnDisconnect()
    NetMgr.net:Disconnect();
end

function OnBtnNewPlayerFight()
    -- GuideMgr:SkipTo(3010);
    PlayerPrefs.SetInt(PlayerClient:GetNewPlayerFightStateKey() .. "_" .. PlayerClient:GetID(), 0);
    PlayerClient:NewPlayerFight(3);
end

function OnBtnNewPlayerFight0()
    -- GuideMgr:SkipTo(3010);
    PlayerPrefs.SetInt(PlayerClient:GetNewPlayerFightStateKey() .. "_" .. PlayerClient:GetID(), 0);
    PlayerClient:NewPlayerFight(1);
end

function btnJump()
    local str = txt_jump.text
    str = str == "" and 0 or tonumber(str)
    JumpMgr:Jump(str)
end

function btnAddJD()
    EventMgr.Dispatch(EventType.Scene_Load, "Matrix")
end

----------在客户端处理的GM----------------------------------------------
function GetCmdID(str)
    local r = SplitString(str, " ")
    return r[1], r[2], r[3], r[4], r[5], r[6]
end

function GMCmd(str)
    LogDebugEx("GMCmd", str)

    -- if not DEBUG and player:GetUserID() ~= GM_USER_ID then return end
    local id, p1, p2, p3, p4, p5 = GetCmdID(str)

    if id == nil then
        return
    end

    if id == "overFight" then
        if not g_FightMgrServer then
            return
        end
        if p1 == "2" then
            g_FightMgrServer:Over(1, 2)
        else
            g_FightMgrServer:Over(1, 1)
        end
    elseif id == "EnterDuplicate" then
        -- 例子 EnterDuplicate 2010 {1,2}
        local data = {
            index = 1, -- 副本类型
            nDuplicateID = p1, -- 副本id 
            data = p2, -- 队伍id {1,2}
            list = {} -- 编队信息(前端补充)
        }

        FightProto:EnterDuplicate(data)
    elseif id == "showRewardCfg" then
        ShowRewardCfgInfo(p1)
    else
        return
    end

    return true
end

function ShowRewardCfgInfo(id, showInfo)

    LogDebug("ShowRewardCfgInfo id: " .. id)
    if type(id) ~= "number" then
        id = tonumber(id)
    end

    local isShow = true
    if showInfo then
        isShow = false
    end

    showInfo = showInfo or {}
    local useCfg = RewardInfo[id]

    local randType = {
        [1] = "全部",
        [2] = "随机",
        [3] = "加权",
        [4] = "选择, 只能支持, 第一层",
        [5] = ":随机多个， 根据数量字段决定掉几个"
    }

    local ruleType = {
        [1] = "嵌套模板",
        [2] = "物品",
        [3] = "卡牌",
        [4] = "装备"
    }

    local ruleTypeFun = {
        [1] = function(iCfg, info)
            ShowRewardCfgInfo(iCfg.id, info)
        end,
        [2] = function(iCfg, info)
            local cfg = ItemInfo[iCfg.id]
            info.name = cfg.name
        end,
        [3] = function(iCfg, info)
            local cfg = CardData[iCfg.id]
            info.name = cfg.name
        end,
        [4] = function(iCfg, info)
            local cfg = CfgEquip[iCfg.id]
            info.sName = cfg.sName
            info.nStart = cfg.nStart
        end
    }

    showInfo.id = useCfg.id
    showInfo['随机类型'] = randType[useCfg.type]

    showInfo['item'] = {}
    for _, iCfg in ipairs(useCfg.item) do
        if not iCfg.probability or (iCfg.probability and iCfg.probability > 0) then
            local info = {
                id = iCfg.id,
                ["规则类型"] = ruleType[iCfg.type],
                probability = iCfg.probability
            }

            local fun = ruleTypeFun[iCfg.type]
            if fun then

                fun(iCfg, info)

                local notFing = true
                for _, item in ipairs(showInfo.item) do
                    if item.id == info.id then
                        notFing = false
                        break
                    end

                    if item.nStart then
                        if item.nStart == info.nStart then
                            notFing = false
                            break
                        end
                    end
                end

                if notFing then
                    table.insert(showInfo.item, info)
                end
            else
                LogError("物品规类型：" .. iCfg.type .. "暂未支持！")
            end
        end
    end

    if isShow then
        LogTable(showInfo, "showInfo:")
    end
end

---------------------------------------震动测试方法-----------------
function OnLightChange(val)
    CSAPI.SetScreenLight(val);
end

function OnClickDoVibrate()
    local time = txt_vibrate.text == nil and 1 or tonumber(txt_vibrate.text);
    CSAPI.Vibrate2(time);
end

function OnClickStartVibrate()
    -- body
    CSAPI.StartVibrate();
end

function OnClickStopVibrate()
    -- body
    CSAPI.StopVibrate();
end

function OnClickStartVibrate1()
    CSAPI.Vibrate();
end

-- 测试开关Bloom
function OnClickBloom()
    if (CameraMgr.isBloom == nil) then
        CameraMgr.isBloom = true;
    end
    CameraMgr.isBloom = not CameraMgr.isBloom;
    CameraMgr:SwitchBloom(CameraMgr.isBloom);
end
---------------------------------------震动测试方法-----------------
---------------------------------------下拉列表操作-----------------
function GetOptions()
    local ops = {};
    for k, v in ipairs(options) do
        table.insert(ops, v.desc);
    end
    return ops;
end

function OnDropValChange(index)
    selectIndex = index + 1;
    if isTemp then
        local cfg = options[selectIndex]
        SetGMDropOptions(GmCmdList); -- 重置下拉选项
        -- 设置真实下标
        for k, v in ipairs(options) do
            if v.id == cfg.id then
                selectIndex = k;
                SetGMDropIndex(k);
                SetFormatTxt(k);
                break
            end
        end
    else
        SetFormatTxt(selectIndex)
    end
    isTemp = false;
end

function SetFormatTxt(index)
    local ex = options[index].exapmle and options[index].exapmle or "";
    CSAPI.SetText(txtSearch, options[index].desc);
    txt_paramTips.text = options[index].use .. " 示例：" .. ex;
    txtParams.text = "";
    SetSearchText(options[index].desc);
end

function btnSend()
    local cmd = options[selectIndex].cmd;
    if cmd then
        local params = txtParams.text;
        if params == nil or params == "" then
            params = "";
        end
        local cmdStr = Trim(string.format(cmd .. " %s", params));
        Log("发送命令：" .. tostring(cmdStr));

        if GMCmd(cmdStr) then
            return
        end

        local proto = {"ClientProto:GmCmd", {
            cmd = cmdStr
        }};

        NetMgr.net:Send(proto);
    end
end

function OnClickVideo()
    if (not IsNil(video)) then
        CSAPI.RemoveGO(video.gameObject);
        video = nil;
    end
    local str = inputVideoField.text;
    video = ResUtil:PlayVideo(str);

    --    video:AddCompleteEvent(function()           
    --        LogError("播放完成");
    --    end); 

end

function OnClickGuideSet()
    local str = inputGuideField.text;

    local id = tonumber(str);
    --    GuideMgr:SkipTo(id);
    local cfgs = Cfgs.Guide:GetAll();

    local guideData = {};
    for _, cfg in pairs(cfgs) do
        if (id > cfg.id) then
            if (cfg.group) then
                guideData[GuideMgr:GetKey(cfg.group)] = 1;
            end
        end
    end

    PlayerProto:SetClientData(GuideMgr:GetGuideKey(), guideData);
    GuideMgr:SetData(guideData);
end

function OnClickGuiding()
    local data = GuideMgr:IsGuiding();
    LogError(data and data.cfg);
    inputGuideField.text = data and tostring(data.cfg.id) or "无";
end

function OnClickScene()
    if (StringUtil:IsEmpty(inputSceneField.text)) then
        _G.g_fight_scene_id = nil;
    else
        local id = tonumber(inputSceneField.text);
        local cfgScene = Cfgs.scene:GetByID(id);
        if (cfgScene) then
            _G.g_fight_scene_id = id;
        end
    end

end

function OnClickCharacterPreview()
    EventMgr.Dispatch(EventType.Scene_Load, 301001004);
end

-- 调用1
function OnFunc1()
    -- Log(1);
    -- 进入等待战斗
    -- local proto = {"FightProtocol:EnterBoss", {nConfigID = 1001}};
    -- NetMgr.net:Send(proto);
    -- FightClient:Clean()
    -- PlayerClient:NewPlayerFight(1)
    -- 设置自动战斗数据
    tStrategyData = {
        {1, 2, 3},
        {2, 2, 3},
        {3, 3, 3},
        bOverLoad = true
    }
    PlayerProto:SetAIStrategy(1, 1, 3, tStrategyData)

end
-- 调用2
function OnFunc2()
    -- Log(2);
    -- -- 进入boss战斗
    local proto = {"FightProtocol:EnterBossFight", {
        bossUUID = g_bossUUID,
        nTeamIndex = 1,
        nCastTP = 2
    }};
    NetMgr.net:Send(proto);
    -- -- 获取自动战斗数据
    -- PlayerProto:GetAIStrategy({33})
end
-- 调用3
function OnFunc3()
    -- 获得当前开启的boss活动
    -- local proto = {"FightProtocol:GetBossActivityInfo", {}};
    -- NetMgr.net:Send(proto);
    -- local proto = {"FightProtocol:GetBossDamage", {nConfigID = 1001}};
    -- NetMgr.net:Send(proto);
    -- local proto = {"FightProtocol:GetBossRank", {nConfigID = 1001}};
    -- NetMgr.net:Send(proto);
    -- local proto = {"ClientProto:ExeCode", {cmd = "LogTable(GameApp._timeouts_)"}};
    -- NetMgr.net:Send(proto);
    local proto = {"ClientProto:GmCmd", {
        cmd = "test"
    }};
    -- if GMCmd(cmdStr) then return end
    NetMgr.net:Send(proto);
end

function OnFloatFontSwitch()
    _G.no_float_font = not _G.no_float_font;

    Log("切换飘字状态：" .. tostring(not _G.no_float_font));
end

function OnFireBallSwitch()
    _G.no_fb_eff = not _G.no_fb_eff;
end

-- lua日志控制
function OnLogOpen()
    _G.noLog = nil;
    _G.debug_model = 1;
    PlayerPrefs.SetInt("key_log_state", 1)
end
function OnLogClose()
    _G.noLog = 1;
    _G.debug_model = nil;
    PlayerPrefs.SetInt("key_log_state", 0);
end

function OnFightRoleInfo()
    _G.showPvpRoleInfo = not _G.showPvpRoleInfo;
    Log(_G.showPvpRoleInfo);
    CSAPI.SetText(txt_fightRoleInfo, _G.showPvpRoleInfo and "关闭PVP卡牌信息" or "开启PVP卡牌信息");
end

function OnClickProto()
    OnClickClose();
    CSAPI.OpenView("ProtoRecord");
end

function OnClickNetwork()
    local ip = inputSceneField.text;
    CSAPI.ConnectToNetworkServer(ip);
    -- FuncUtil:Call(CSAPI.SendToNetworkServer, nil, 500, "测试发送信息");
end

function OnClickURL()
    local url = "https://itunes.apple.com/in/app/id6443983362";
    LogError("打开URL" .. url);
    CSAPI.OpenWebBrowser(url);
end

function OnClickURL1()
    local url = "hhttps://itunes.apple.com/in/app/id6443983362";
    LogError("Application.OpenURL：" .. url);
    UnityEngine.Application.OpenURL(url);
end

function OnClickUI()
    if (_G.fightViewState == nil) then
        _G.fightViewState = true;
    end
    _G.fightViewState = not _G.fightViewState;
    CSAPI.SetGOActive(CSAPI.GetView("CharacterInfo"), _G.fightViewState);
    CSAPI.SetGOActive(CSAPI.GetView("FightBoss"), _G.fightViewState);
    CSAPI.SetGOActive(CSAPI.GetView("FightTimeLine"), _G.fightViewState);
    CSAPI.SetGOActive(CSAPI.GetView("Fight"), _G.fightViewState);
    CSAPI.SetGOActive(CSAPI.GetView("Skill"), _G.fightViewState);
end

function OnClickSTips()
    view:Close();
    if TipsMgr then
        TipsMgr:HandleMsg({
            strId = "serverMaintain"
        })
    end
end

function OnClickAutoBattle()
    BattleMgr:SetAIMoveState(not BattleMgr:GetAIMoveState());
end

function OnClickAutoFight()
    if (_G.Fight_Auto) then
        _G.Fight_Auto = false;
        return;
    end

    if (SceneMgr and SceneMgr:IsMajorCity()) then
        BattleMgr:SetFightAuto(not _G.Fight_Auto, DungeonMgr:GetCurrId());
    end
end

function OnClickMovieLv()
    local devieName = UnityEngine.SystemInfo.deviceModel
    local graphicsDeviceName = UnityEngine.SystemInfo.graphicsDeviceName
    devieName = devieName .. " 图像设备名：" .. graphicsDeviceName;
    local deviceType = CSAPI.GetDeviceType()

    local strs1 = {"未知", "手机", "掌机", "台式机"}

    local lv, score = SettingMgr:GetMobieLv()
    local strs2 = {"低端", "中端", "高端"}

    local isEmulator = CSAPI.CheckEmulator()
    local strs0 = isEmulator and "是模拟器" or "不是模拟器"
    local str = string.format("%s  设备类型：%s  设备名称：%s  分数：%s(%s)", strs0, strs1[deviceType + 1],
        devieName, score, strs2[lv])
    LogError(str)
end

-- function OnClickBorm()
-- 	CSAPI.OpenView("DormRoom")
-- 	view:Close()
-- 	--LogError("开发中")
-- end

function OnClickMatrix()
    -- CSAPI.OpenView("DormBuilding")
    -- UIUtil:ToMatrix()
    -- view:Close()
    --
    -- ResUtil:CreateUIGOAsync("Test/TestUISV2", gameObject)
    PlayerPrefs.SetInt(s_mobie_lv_key, 0)
	LogError("已重置，请重新登录游戏")
end

-- 测试内置网页
function OnClickWeb()
    CSAPI.OpenWebBrowser("https://www.wjx.cn/vm/es164o3.aspx")
end

-- function OnClickTestSkillItem()
--    for i = 1,200 do
--        local goSkillItem = ResUtil:CreateSkillItem(transform);        
--    end
--    view:Close();
-- end
-- 剧情全开
function OnClickPlot()
    local cfgPlots = Cfgs.StoryInfo:GetAll()
    local cfgID = 0
    for k, v in pairs(cfgPlots) do
        if v.id > cfgID then
            cfgID = v.id
        end
    end
    if cfgID > 0 then
        PlotMgr:UpdateStoryData(cfgID)
        PlotMgr:Save()
    end
end

function OnClickFlipFight()
    _G.testFlip = not _G.testFlip;
    Log(_G.testFlip and "启动镜像翻转战斗" or "取消镜像翻转战斗", "eeee55");
end

function SetSearchText(str)
    CSAPI.RemoveInputFieldChange(search, OnSearch)
    inputSearch.text = tostring(str);
    CSAPI.AddInputFieldChange(search, OnSearch)
end

function SetGMDropIndex(index)
    CSAPI.RemoveDropdownCallBack(GMList, OnDropValChange);
    GMDropList.value = selectIndex;
    CSAPI.AddDropdownCallBack(GMList, OnDropValChange);
end

function SetGMDropOptions(temp)
    CSAPI.RemoveDropdownCallBack(GMList, OnDropValChange);
    options = temp;
    GMDropList:ClearOptions()
    CSAPI.AddDropdownOptions(GMList, GetOptions())
    CSAPI.AddDropdownCallBack(GMList, OnDropValChange);
end

-- 搜索
function OnSearch(str)
    if str ~= nil and str ~= "" then
        local temp = {};
        for k, v in ipairs(GmCmdList) do
            if string.match(v.desc, str) then
                table.insert(temp, v);
            end
        end
        if temp and #temp > 0 then
            isTemp = true;
            selectIndex = 1;
            -- SetSearchText(temp[1].desc);
            SetGMDropOptions(temp);
            SetFormatTxt(selectIndex);
            GMDropList:Show();
        end
    end
end

function OnClickFightRecord()
    FightRecordMgr:Save();

    CS.CSAPI.ShowPersistentPath();
end

function OnClickServerList()
    _G.server_list_enc_close = 1;
    -- InitServerInfo(nil, "219.135.170.30/php/serverlist.php?cmd=get&zone=1");
    InitServerInfo(nil, "http://219.135.170.30/php/res/serverList/serverlist_nw1.json");
    OnClickClose();
     
    FuncUtil:Call(function() EventMgr.Dispatch(EventType.Login_Switch_Server) end,nil,500);   
end

function OnClickLoadingList()
    local go = CSAPI.GetView("Loading");
    local lua = ComUtil.GetLuaTable(go);
    lua.RefreshLoadContent();
end

--------------------------------------下拉列表逻辑处理完毕------------
-- 关闭
function OnClickClose()
    view:Close();
end

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    input = nil;
    TxtPlot = nil;
    slider_Light = nil;
    TxtVibrate = nil;
    TxtJump = nil;
    inputVideo = nil;
    GMList = nil;
    TxtParams = nil;
    paramTips = nil;
    inputGuide = nil;
    inputScene = nil;
    txt_fightRoleInfo = nil;
    view = nil;
end
----#End#----
