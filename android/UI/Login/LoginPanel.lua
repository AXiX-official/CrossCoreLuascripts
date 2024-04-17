-- 登录面板
require "LoginCommFuns"
local userLogin = nil; -- 登录框
local userRegister = nil; -- 用户注册框
local serverList = nil; -- 服务器列表框

-- 控件
local serverName = nil;
-- 更新进度文本
local updateProgress = nil;
-- 更新进度条
local updateSilder = nil;

local serverID = nil; -- 服务器ID
local serverIP = nil; -- 服务器IP
local port = 0; -- 端口号

-- local iconContent=nil;
local isOpenJuLiang = false --开启巨量sdk初始化

local netDelayTime = 20; -- 网络连接延迟时间
local currTime = 0;
local isLink = false;

local isChannel = false;
local isOnline = true; -- 服务器是否在线
local isFirst = true;
local uiState = {};
uiState.Start = 0; -- 快速登录
uiState.ChangeUser = 1; -- 切换账号
uiState.Reg = 2; -- 注册
uiState.Login = 3; -- 登录
uiState.ServerList = 4; -- 服务器列表
local childPanelName = {}; -- 创建的子模块名
childPanelName.Login = "Login/UserLogin";
childPanelName.Reg = "Login/Register";
childPanelName.Server = "Login/ServerList";
local reLoginSDK = true;

local loginCallBack = nil --缓存回调

local currState = uiState.Start
local isAgree=false
-- 测试用正式服删除
local inp_account;
function Awake()
    CheckUpdate();--ios旧包强更包体

    UIUtil:AddLoginMovie(movieObj);
    serverName = ComUtil.GetCom(txt_ServerName, "Text");
    -- iconContent= ComUtil.GetCom(icon, "CanvasGroup");
    -- ResUtil:CreateUIGO("Logo/Logo",icon.transform);
    -- ResUtil:CreateUIGO("Logo/LineView",lineObj.transform);

    -- local goRT = CSAPI.GetGlobalGO("CommonRT")
    -- CSAPI.SetRenderTexture(rt,goRT);
    -- CSAPI.SetCameraRenderTarget(CameraMgr:GetCameraGO(),goRT);
    --CSAPI.SetText(txtVer, "Ver:1.0.0" .. tostring(UnityEngine.Application.version));
    CSAPI.SetText(txtVer, "Ver:1.5");
    -- 开启战斗场景镜头
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if (xluaCamera) then
        xluaCamera.SetEnable(true);
    end

    -- CameraMgr:ApplyCommonAction(nil,"login");
    CSAPI.SetText(loading, LanguageMgr:GetByID(1024));
    isChannel = false;
    local type = GetChannelType();
    if CSAPI.IsChannel() and type ~= ChannelType.TapTap and type ~= ChannelType.Normal then -- Taptap包即是官网包
        isChannel = true;
    end
    CSAPI.SetGOActive(btn_Account, not isChannel);
    --CSAPI.SetGOActive(btnAge, isChannel)
    CSAPI.SetGOActive(btnUserAgree, isChannel)
    isAgree=GetAgree();
	CSAPI.SetGOActive(tick,isAgree);
    -- CSAPI.SetGOActive(btn_Start1,false)
    SetOpenCount();
end

function OnInit()
    InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
    -- eventMgr:AddListener(EventType.Login_Server_Success, OnLoginSuccess);
    eventMgr:AddListener(EventType.Login_Click_RegisterBtn, OnClickRegister);
    eventMgr:AddListener(EventType.Login_Click_HasUserBtn, ShowLoginView);
    eventMgr:AddListener(EventType.Login_Select_Server, OnSelectServer);
    eventMgr:AddListener(EventType.Login_Click_Return, ShowContent);
    eventMgr:AddListener(EventType.Login_Click_In, OnClickLoginIn);
    eventMgr:AddListener(EventType.Login_Phone_Auth_Code, OnLoginPhoneAuthCode);
    eventMgr:AddListener(EventType.Net_Connect_Fail, OnLoginFail);
    eventMgr:AddListener(EventType.Login_Fial, OnLoginFail);
    eventMgr:AddListener(EventType.Login_Show_Mask, ShowMask);
    eventMgr:AddListener(EventType.Login_Hide_Mask, HideMask);
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadingOver);
    eventMgr:AddListener(EventType.Net_Connect_Fail, OnNetConnectFail);
    eventMgr:AddListener(EventType.Login_SDK_Result, OnLoginSDKResult)
    eventMgr:AddListener(EventType.Login_Wait_Begin, OnLoginWait)
    eventMgr:AddListener(EventType.Login_Wait_Over, OnLoginWaitOver)
    eventMgr:AddListener(EventType.Login_Switch_LoginView, OnSwitchLoginView)
    eventMgr:AddListener(EventType.Login_State_Agree, OnAgreeState)

    eventMgr:AddListener(EventType.Login_White_Mask_FadeOut, ApplyFadeOut)

 eventMgr:AddListener(EventType.Login_Switch_Server, OnClickSwitch)
    -- eventMgr:AddListener(EventType.Main_Activity,function(key)
    -- 	Log(key)
    -- 	if key==BackstageFlushType.Board then
    -- 		Log(ActivityMgr:GetDatasByType(BackstageFlushType.Board))
    -- 		CSAPI.OpenView("ActivityView",1);
    -- 	end
    -- end)
end

-- 白色遮罩淡出
function ApplyFadeOut()
    if (isApplyFadeOut) then
        return;
    end
    isApplyFadeOut = 1;
    CSAPI.SetGOActive(whiteMask, true);
    FuncUtil:Call(CSAPI.SetGOActive, nil, 500, whiteMask, false);
    -- 播放动画
    FuncUtil:Call(PlayEnter, nil, 150, nil, false);
end

-- 登录排队
function OnLoginWait(proto)
    if proto then
        if proto.isWaiting then
            CSAPI.OpenView("LoginWait", proto);
        else
            -- 提示服务器繁忙
            NetMgr.net:Disconnect();
            HideMask();
            CSAPI.OpenView("Prompt", {
                content = LanguageMgr:GetTips(9006)
            })
        end
    end
end

-- 排队结束，开始登陆
function OnLoginWaitOver()
    local account, pwd = GetLastAccount();
    LoginAccount(account, pwd)
end

function OnClickLoginIn(data)
    if IsAccount() then
        Login(data);
    else -- 手机登陆SDK
        local currServer = GetCurrentServer();
        if currServer and currServer.is_open_white == 1 then
            SignWhite(data.account, function(proto)
                LoginSDK(data.account, data.pwd, function(result)
                    -- 登陆SDK成功，登陆游戏服
                    Login(result);
                end);
            end)
        else
            LoginSDK(data.account, data.pwd, function(result)
                SetPhoneLoginKey();--清除验证码快捷登录
                -- 登陆SDK成功，登陆游戏服
                Login(result);
            end);
        end
    end
end

--登陆官方SDK
function LoginSDK(account, pwd, func)
    if account and pwd then
        loginCallBack = function()
            ShowMask();
            local currServer = GetCurrentServer();
            SignSDK(account, pwd,currServer.id, function(result)
                -- 登陆SDK成功，登陆游戏服
                local d = result.data;
                SaveLastSDKAccount(d.phone, pwd, d.open_id);
                SignAccount(d.phone, d.open_id, currServer.id, function(result2)
                    -- Log(result2)                
                    SaveLastAccount(result2.data.open_id, result2.data.opwd);
                    func({
                        account = result2.data.open_id,
                        pwd = result2.data.opwd
                    });
                end);
            end);
        end        
        
        ChannelWebUtil.SendToServer2({phone = account,game_id = "1"},ChannelWebUtil.Extends.DelAccountInfo,OnAccountInfo)
    end
end

--手机验证码登录
function OnLoginPhoneAuthCode(data)
    loginCallBack = function()
        ChannelWebUtil.SendToServer2(data,nil,
        function(json)	
            --LogError(json);
            EventMgr.Dispatch(EventType.Login_Hide_Mask);
            if json~=nil and type(json)=="table" then
                if(json.code == 0)then
                    Log("验证码登录成功！");
                    local jsonData = json.data;
                    if(not jsonData)then
                        LogError("验证码登录返回结果出错%s",table.tostring(json,true));
                    end

                    local loginKey = jsonData.login_key;                
                    SetPhoneLoginKey(loginKey);
                    local currServer = GetCurrentServer();
                    SignAccount(jsonData.phone, jsonData.open_id, currServer.id, function(result2)
                        SaveLastSDKAccount(result2.data.oacc_name,  "", result2.data.open_id);
                        -- SaveLastAccount(result2.data.open_id, result2.data.opwd);
                        Login({
                            account = result2.data.open_id,
                            pwd = result2.data.opwd
                        });
                    end);

                else
                    Tips.ShowTips(json.msg);
                end
            end
        end);
    end

    ChannelWebUtil.SendToServer2({phone = data.phone,game_id = "1"},ChannelWebUtil.Extends.DelAccountInfo,OnAccountInfo)
end

--检测账号删除情况
function OnAccountInfo(json)
    if json.code==ResultCode.Normal then
        if loginCallBack then
            loginCallBack()
            loginCallBack = nil
        end
    elseif json.left_time then
        local tab = TimeUtil:GetTimeTab(json.left_time)
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(json.language,tab[1],tab[2] % 24,tab[3])
        dialogData.okCallBack = loginCallBack
        loginCallBack = nil
        CSAPI.OpenView("Dialog", dialogData)
    else
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(json.language)
        CSAPI.OpenView("Prompt", dialogData)
    end
end

function OnNetConnectFail()
    CSAPI.OpenView("Dialog", {
        content = LanguageMgr:GetTips(1008)
    });
    
    local account, pwd = GetLastAccount();
    LogError(string.format("connect fail。%s",tostring(account)));
end

function OnLoadingOver()
    if isFirst then
        InitServerInfo(function()
            local lastServerInfo = GetLastServerInfo();
            if lastServerInfo == nil then
                lastServerInfo = GetServerInfoFirst();
            end
            ShowServerInfo(lastServerInfo);
            local token, pwd, sid = GetLastSDKInfo();
            -- Log(tostring(token).."\t"..tostring(pwd).."\t"..tostring(sid));
            if token and token ~= "" and pwd and pwd ~= "" and IsAccount() ~= true and not CSAPI.IsPhoneLogin() then
                LoginSDK(token, pwd, function()
                    -- LogError("----------LoginSDK Success-------");
                    HideMask();
                    reLoginSDK = false;
                end);
            end
        end);
        --初始化热云和bugly、巨量
        EventMgr.Dispatch(EventType.SDK_ReYun_Init,nil,true);
        EventMgr.Dispatch(EventType.SDK_Bugly_Init,nil,true);
        if isOpenJuLiang then
            EventMgr.Dispatch(EventType.SDK_JuLiang_Init,nil,true);
        end
        CSAPI.SetGOActive(tween1, true);
        isFirst = false;
        BuryingPointMgr:BuryingPoint("before_login", "10017");
    end
    if GetOpenCount() > 1 then
        PlayEnter();
    end
end

function PlayEnter()
    CSAPI.SetGOActive(iconObj, true);
    CSAPI.SetGOActive(iconTweenObj, true);
    CSAPI.SetGOActive(lineTweenObj, true);
    CSAPI.SetGOActive(childTweenObj, true);
end

function OnDisable()
    userLogin = nil;
    userRegister = nil;
    serverList = nil;
    -- SetAgree(isAgree);
end

function OnDestroy()
    eventMgr:ClearListener();
    
    --更新帧率
    --SettingMgr:UpdateTargetFPS(); 
end

-- 点击换区
function OnClickSwitch()
    -- 加载一个换区面板
    if userLogin ~= nil then
        CSAPI.SetGOActive(userLogin, false);
    end
    if userRegister ~= nil then
        CSAPI.SetGOActive(userRegister, false);
    end
    CSAPI.SetGOActive(childNode, false);
    if serverList == nil then
        serverList = ResUtil:CreateUIGO("Login/ServerList", childRoot.transform);
    else
        CSAPI.SetGOActive(serverList, true);
    end
end

-- 点击注册按钮
function OnClickRegister()
    if not isChannel then
        SetLayout(uiState.Reg);
    end
end

-- 显示注册面板
-- function ShowRegisterView()
-- 	if not isChannel then
-- 		if userRegister == nil then
-- 			userRegister = ResUtil:CreateUIGO("Login/Register", childRoot.transform);
-- 		else
-- 			CSAPI.SetGOActive(userRegister, true);
-- 		end
-- 	end
-- end

-- 显示登录面板
function ShowLoginView()
    SetLayout(uiState.Login);
end

-- 选择服务器
function OnSelectServer(serverInfo)
    if serverInfo == nil then
        SetLayout(uiState.Start);
        return;
    end
    serverID = serverInfo.id;
    local currServerInfo = GetCurrentServer();
    if IsAccount() ~= true then -- 重新查询账号
        reLoginSDK = currServerInfo.id == serverID;
    end
    ShowServerInfo(serverInfo);
    SetLayout(uiState.Start);
end

-- 显示服务器信息
function ShowServerInfo(serverInfo)
    isOnline = serverInfo.state ~= ServerListState.Maintentance;
    serverName.text = serverInfo.serverName;
    -- CSAPI.SetText(txt_state,StringConstant["loginStateTips"..tostring(serverInfo.state)]);
    SetCurrentServer(serverInfo);
    ChannelWebUtil.SetServerInfo(serverInfo); -- 设置当前显示的serverInfo
    local color = GetStateImgColor(serverInfo.state);
    CSAPI.SetImgColor(stateImg, color[1], color[2], color[3], color[4]);
    if not isOnline then
        ShowCurrServerNotice(); -- 弹出提示
    end
end

-- 点击开始按钮
function OnClickStartBtn()
    -- CSAPI.WebPostRequest("http://sdk.megagamelog.com/php/sdk/mega/",{cmd="register",subcmd="code",phone="15814231992"},function(text)
    -- 	LogError(text);
    -- end);
    if isChannel then -- 其他渠道调用SDK登陆接口
        EventMgr.Dispatch(EventType.Login_SDK_Command, nil, true);
    else
        -- 检测是否登陆过账号，未登录时显示登陆窗口，否则进入游戏
        local account, pwd = GetLastAccount();
        local serverInfo = GetCurrentServer();
        if IsAccount() then
            if account ~= "" and account ~= nil and pwd ~= "" and pwd ~= nil and serverInfo then
                -- 显示登陆
                Login({
                    account = account,
                    pwd = pwd
                })
            else
                -- 显示登陆窗口
                SetLayout(uiState.ChangeUser);
            end
        else            
            if(TryPhoneLogin())then
                --手机验证码快捷登录模式               
                return;
            end
            local token, pwd2, sid = GetLastSDKInfo();       
            if token ~= "" and token ~= nil and pwd2 ~= "" and pwd2 ~= nil and serverInfo then
                if serverInfo.is_open_white == 1 then -- 开启了白名单
                    SignWhite(token, function()
                        QuerryLastSDK(token, pwd2, sid, serverInfo);
                    end);
                else
                    QuerryLastSDK(token, pwd2, sid, serverInfo);
                end
            else
                SetLayout(uiState.ChangeUser);
            end
        end
    end
end


--尝试手机快捷登录
function TryPhoneLogin()
    local accountName = GetLastSDKInfo();
    local loginKey = GetPhoneLoginKey();
    if StringUtil:IsEmpty(loginKey) or not accountName then
        return;
    end
    local data = 
    {
	    cmd = "login2",
	    subcmd = "fast_login",
        phone = accountName,
        login_key=loginKey,
        game_id = gameId
    };
    OnLoginPhoneAuthCode(data);
    return true;
end


-- 快速登录最后一次登录的SDK
function QuerryLastSDK(token, pwd2, sid, serverInfo)
    if token ~= "" and token ~= nil and pwd2 ~= "" and pwd2 ~= nil and serverInfo then
        if reLoginSDK then -- 需要重新验证
            LoginSDK(token, pwd2, function(result)
                Login(result);
            end);
        else -- 直接登录
            ShowMask();            
            SignAccount(token, sid, serverInfo.id, function(result2)
                if result2==nil or result2.data==nil then
                    HideMask();
                    LogError("登录失败，返回的数据有误！result:");
                    LogError(result2);
                    do return end
                end
                SaveLastAccount(result2.data.open_id, result2.data.opwd);
                Login({
                    account = result2.data.open_id,
                    pwd = result2.data.opwd
                });
            end);
        end
    else
        SetLayout(uiState.ChangeUser);
    end
end

function OnClickSetting()
    CSAPI.OpenView("SettingView", SettingEnterType.Login)
end

-- 快捷进入上次测试训练
function OnClickStartBtn1()
    if not isChannel then
        _G.enter_last_dirll_fight = 1;
        OnClickStartBtn();
    end
end

-- 渠道SDK登陆成功 有数据即登陆成功,数据格式为json类型，否则登陆失败
function OnLoginSDKResult(jStr)
    ShowMask();
    if jStr then
        local jData = Json.decode(jStr);
        local currServer = GetCurrentServer();
        local channelType = GetChannelType();
        if jData ~= nil and currServer then
            local signParams = nil;
            if channelType == ChannelType.BliBli then -- B站登录
                signParams = {
                    uid=jData["uid"],
                    access_token = jData["access_token"],
                    server_id = tostring(currServer.id),
                    channelType = tostring(channelType)
                };
				PlayerClient:SetSDKUserInfo(jData["uid"],jData["username"]);
                GetServeSign(signParams, currServer, OnChannelSignResult);
            elseif channelType == ChannelType.QOO then
                -- LogError("签名数据：");
                local phone = tostring(jData["data"]["name"]); -- phone字段必须有，后端用来做唯一判定，如果返回值为空，则使用open_id
                local open_id = tostring(jData["data"]["user_id"])
                local isFind = string.find(phone, "function:"); -- name为null时会返回function:的错误字符串...这里做个判断
                if phone == nil or phone == "" or isFind ~= nil then
                    phone = open_id;
                end
                signParams = {
                    cmd = SendCMD.Sign,
                    server_id = tostring(currServer.id),
                    open_id = open_id,
                    phone = phone,
                    is_anonymous = tostring(jData["data"]["is_anonymous"]),
                    channelType = tostring(channelType)
                };
                -- LogError(signParams)
                SignChannelAccount(signParams, OnChannelSignResult);
            end
        else
            HideMask();
            LogError("登录渠道ID为：" .. tostring(channelType) .. "时出错！")
            LogError(jData);
        end
    else
        HideMask();
    end
end

-- 渠道验证通过回调，开始登录
function OnChannelSignResult(json)
    if json ~= nil and json ~= "" and type(json) == "table" then
        if json.code==ResultCode.Normal then --验证通过
            local open_id = json["open_id"];
            local pwd = json["opwd"];
            local uid=json["uid"];
            Login({
                account = open_id,
                pwd = pwd
            });
        elseif json.left_time then
            local tab = TimeUtil:GetTimeTab(json.left_time)
            local dialogData = {}
            dialogData.content = LanguageMgr:GetTips(json.language,tab[1],tab[2] % 24,tab[3])
            if json.forbit and json.forbit == 1 then
                CSAPI.OpenView("Prompt", dialogData)
            else
                dialogData.okCallBack = loginCallBack
                loginCallBack = nil    
                CSAPI.OpenView("Dialog", dialogData)
            end
            EventMgr.Dispatch(EventType.Login_Hide_Mask, nil)
        else
            local dialogdata = {
                content = LanguageMgr:GetTips(json.language)
            }
            CSAPI.OpenView("Prompt", dialogdata)
            LogError("登陆SDK返回的json数据不正确:" .. tostring(json))
            EventMgr.Dispatch(EventType.Login_Hide_Mask, nil)
        end
    else
        local dialogdata = {
            content = LanguageMgr:GetTips(9006)
        }
        CSAPI.OpenView("Prompt", dialogdata)
        LogError("登陆SDK返回的json数据不正确:" .. tostring(json))
        EventMgr.Dispatch(EventType.Login_Hide_Mask, nil)
    end
end

function Login(_data)
    -- if isAgree then
    if isAgree~=true then
        Tips.ShowTips(LanguageMgr:GetTips(9004));
        HideMask();
        return;
    end
    local serverInfo = GetCurrentServer();
    local ipAndPort=GetLoginIpInfo(serverInfo,_data.account);
    local serverIp,serverPort = GetIpAndPort(ipAndPort)
    serverPort = serverPort or serverInfo.port;
    if isOnline then
        ShowMask();
        --LogError(serverIp);
        --LogError(serverPort);
        NetMgr.net:Connect(serverIp,serverPort, function()
            LoginAccount(_data.account, _data.pwd)
            SaveLastServerInfo(serverInfo.id);
        end);
    else
        InitServerInfo(function()
            serverInfo = GetCurrentServer();
            ShowServerInfo(serverInfo);
            isOnline = serverInfo.state ~= ServerListState.Maintentance;
            if isOnline then
                ShowMask();
                NetMgr.net:Connect(serverIp, serverPort, function()
                    LoginAccount(_data.account, _data.pwd)
                    SaveLastServerInfo(serverInfo.id);
                end);
            end
        end); -- 刷新服务器状态
    end
    -- else
    -- 	Tips.ShowTips(LanguageMgr:GetTips(9004));
    -- end
end

function OnValid()
    CSAPI.OpenView("Authentication");
end

function OnClickBack()
    if currState == uiState.Login or currState == uiState.Reg then
        SetLayout(uiState.ChangeUser);
    else
        SetLayout(uiState.Start);
    end
end

-- 点击切换账号按钮
function OnClickAccount()
    -- CSAPI.OpenView("Authentication");
    if not isChannel then
        SetLayout(uiState.ChangeUser);
    end
end

function ShowSwitchObj()
    CSAPI.SetGOActive(switchObj, true);
    CSAPI.SetGOActive(starObj, false);
end

function OnClickLoginBtn()
    SetLayout(uiState.Login);
end

function OnClickRegBtn()
    SetLayout(uiState.Reg);
end

function ShowContent()
    SetLayout(uiState.Start);
end

function SetLayout(state)
    currState = state == nil and uiState.Start or state;
    if currState == uiState.Start then
        SetChildPanel();
        CSAPI.SetGOActive(childNode, true);
        CSAPI.SetGOActive(switchObj, false);
        CSAPI.SetGOActive(btn_Back, false);
        CSAPI.SetGOActive(iconObj, true);
    elseif currState == uiState.ChangeUser then
        SetChildPanel();
        CSAPI.SetGOActive(childNode, false);
        CSAPI.SetGOActive(switchObj, true);
        CSAPI.SetGOActive(btn_Back, true);
        CSAPI.SetGOActive(iconObj, false);
    elseif currState == uiState.Reg then
        SetChildPanel(childPanelName.Reg);
        CSAPI.SetGOActive(childNode, false);
        CSAPI.SetGOActive(switchObj, false);
        CSAPI.SetGOActive(btn_Back, true);
        CSAPI.SetGOActive(iconObj, false);
    elseif currState == uiState.Login then
        SetChildPanel(childPanelName.Login);
        CSAPI.SetGOActive(childNode, false);
        CSAPI.SetGOActive(switchObj, false);
        CSAPI.SetGOActive(btn_Back, true);
        CSAPI.SetGOActive(iconObj, false);
    elseif currState == uiState.ServerList then
        SetChildPanel(childPanelName.Server);
    end
end

function OnClickAgree(go)
	isAgree=not isAgree;
	CSAPI.SetGOActive(tick,isAgree);
    SetAgree(isAgree);
    
	-- SendToClean();
end

-- targetName:子物体的gameObject名称
function SetChildPanel(targetName)
    local isShow1 = false;
    local isShow2 = false;
    local isShow3 = false;
    if targetName then
        isShow1 = targetName == childPanelName.Login and true or false;
        isShow2 = targetName == childPanelName.Reg and true or false;
        isShow3 = targetName == childPanelName.Server and true or false;
    end
    if serverList ~= nil then
        CSAPI.SetGOActive(serverList, isShow3);
    elseif isShow3 and serverList == nil then
        serverList = ResUtil:CreateUIGO(childPanelName.Server, childRoot.transform);
    end
    if isChannel then -- 渠道包不需要显示官方登录UI
        return;
    end
    if userLogin ~= nil then
        CSAPI.SetGOActive(userLogin, isShow1);
    elseif isShow1 and userLogin == nil then
        userLogin = ResUtil:CreateUIGO(childPanelName.Login, childRoot.transform);
    end
    if userRegister ~= nil then
        CSAPI.SetGOActive(userRegister, isShow2);
    elseif isShow2 and userRegister == nil then
        userRegister = ResUtil:CreateUIGO(childPanelName.Reg, childRoot.transform);
    end
end

function OnClickNotice()
    local serverInfo = GetCurrentServer();
    if serverInfo ~= nil then
        -- 获取当前服务器的公告信息
        -- Tips.ShowTips("功能开发中");
        local _data = {}
        _data.id = serverInfo.id
        local s = Json.Encode(_data)
        CSAPI.PostUpload(serverInfo.sdkUrl .. "/SvrInfo.php", s, function(str)
            if (str) then
                local json = Json.decode(str)
                if (json and json["time"]) then
                    --ActivityMgr:Init1(serverInfo.webIp, serverInfo.webPort, tonumber(json["time"]))
                    --CSAPI.OpenView("ActivityView", tonumber(json["time"]))
                    local _data = {webIp =serverInfo.webIp,webPort =serverInfo.webPort,time = tonumber(json["time"])}
                    CSAPI.OpenView("ActivityView", _data)
                end
            end
        end)
    end
end

function OnSwitchLoginView()
    OnClickLoginBtn();
end

function OnLoginFail()
    NetMgr.net:Disconnect();
    HideMask();
end

function ShowMask(isNative)
    --LogError(tostring(isNative));
    currTime = 0;
    if isNative then
        netDelayTime = 9999
    else
        netDelayTime = 20
    end
    CSAPI.SetGOActive(clickMask, true);
    isLink = true;
end

function HideMask()
    isLink = false;
    CSAPI.SetGOActive(clickMask, false);
end

function OnClickAge()
    CSAPI.OpenView("AgeTipsView");
end

function OnClickUserAgree()
    CSAPI.OpenView("LoginAgreement", nil, 3);
end

function OnAgreeState(_isAgree)
    isAgree=_isAgree;
    SetAgree(isAgree);
    CSAPI.SetGOActive(tick,isAgree);
end

function OnClickUserTips(go)
	local type=1;
	if go.name=="txt_userTips" then
		type=1; --注册协议下标
    elseif go.name=="txt_userTips2" then
        type=3; --个人隐私下标
	else
		type=2; --儿童隐私下标
	end
	CSAPI.OpenView("LoginAgreement",nil,type);
end


function Update()
    if isLink then -- 连接网络即开始计时
        if currTime >= netDelayTime then
            -- 断开网络
            currTime = 0;
            HideMask();
        else
            currTime = currTime + Time.deltaTime;
        end
    end
end


--检查更新安装包（IOS）
function CheckUpdate()
    if(not CSAPI.IsIOS())then--非ios包
        return;
    end
    if(CS.CSAPI.GetReservedStr)then--是新包
       return; 
    end

    local dialogdata = 
    {
		content = "检测到有新版本，请总队长前往升级",
        okCallBack = GoToUpdateIOS, 
	}
	CSAPI.OpenView("Prompt", dialogdata)
end
function GoToUpdateIOS()
    local url = "https://itunes.apple.com/in/app/id6443983362";
    Log("打开URL" .. url);
    CSAPI.OpenWebBrowser(url);
end