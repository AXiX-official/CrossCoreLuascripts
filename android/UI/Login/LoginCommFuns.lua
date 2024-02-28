local crossSign="/cross/";
local qoo="/qoo/";

local lastServerPath = "last_login_server";
local login_account = "last_login_account";
local login_pwd = "last_login_pwd";
local sdk_phone="last_sdk_phone";
local sdk_pwd="last_sdk_pwd";
local sdk_id="last_sdk_sid"
agreenLoken="user_login_agreeLoken";
local login_agree="user_login_agree"
local permission_agree="user_permission_agree"
local currServerInfo=nil;
local agreeNum=-1;
local permissionNum=-1;
gameId="1";
local codeCDTime=0;
local codeCDTime2=0;
local openCount=0;--登录界面打开次数
--返回图片路径
function GetImgPath(spriteName)
	return "UIs/Login/" .. spriteName .. ".png";
end

function GetChannelType()
	return CSAPI.GetChannelType();
end

--返回签名验证url
function GetSignUrl(serverInfo)
	local type=GetChannelType();
	local str="";
	if type==ChannelType.BliBli then
		str=serverInfo.sdkUrl.."/bilibili/sessionVerify.php";--服务器登录验证路径 /bilibili/是渠道名
	end
	return str;
end

--SDK登录找服务器验证(需要服务器通过token去自己获取uid) token params:参数列表 
function GetServeSign(params,serverInfo,callBack)
	if	params and serverInfo then
		local link=GetSignUrl(serverInfo);
		if link==nil or link=="" then
			LogError("获取服务器验证路径为空！"..serverInfo.id)
			return
		end
		--LogError(string.format("b站登录请求%s",tostring(link)));
		--LogError(string.format("参数%s",table.tostring(params,true)));
		
		CSAPI.WebPostRequest(link,params,function(str)
			if str then
				local json = Json.decode(str);
				if callBack then
					callBack(json);
				end
			end
		end,true);
	end
end

--不需要服务器通过token获取uid的渠道登录方式
function SignChannelAccount(data,func)
	ChannelWebUtil.SendToServer2(data,ChannelWebUtil.Extends.GetAccount,function(json)
		if json.code==ResultCode.Normal then
			local bnew=json.data["bnew"];
			local open_id=json.data["open_id"];
			if bnew=="1" then --新注册账号
				local account=string.format("%s_%s",CSAPI.GetChannelStr(),open_id);
				--LogError("ReYunSDK:RegSDK------------------->"..tostring(account));
				--上传热云注册事件
				ReYunSDK:SetRegisterEvent(account,{channelType=CSAPI.GetChannelName()});
				--上传数数
				ThinkingAnalyticsMgr:TrackEvents("openid_register", {phone=open_id}, TAType.First);
			end
			if func then
				func(json.data);
			end
		else
			Tips.ShowTips(json.msg);
			EventMgr.Dispatch(EventType.Login_Hide_Mask);
		end
	end);
end

function GetServerPath()
	local useJsonFile;
    local isRelease = true;
    if(isRelease)then
		--正式
		useJsonFile = "https://cdn.megagamelog.com/cross/release/sl.json";--正式
		--if(CSAPI.GetPlatform() ==-1)then--审核用
		--	useJsonFile = "https://cdn.megagamelog.com/cross/release/sl_1.json";
		--end
    else
		--主干
        _G.server_list_enc_close = 1;
        useJsonFile = "http://219.135.170.30/php/res/serverList/serverlist_nw1.json";--测试	        
    end  
		
	Log("GetServerPath() useJsonFile is:" .. useJsonFile);
	return useJsonFile;
end

--返回服务器状态对于的颜色
function GetStateImgColor(state)
	if state == ServerListState.Normal then --良好
		return {139,225,56,255};
	elseif state == ServerListState.Busy then --繁忙
		return {244,164,18,255};
	elseif state == ServerListState.HotFull then --爆满
		return {253,20,18,255};
	elseif state == ServerListState.Maintentance then--维护
		return {116,116,116,255};
	else
		return {139,225,56,255};
	end
end

--账号验证方法
function ValidateAccount(str)
	local len = string.len(str);
	if str == nil or len == 0 then
		return false, 16045;
	end
	if IsAccount() then
		if len < eRegisterLen.AccMin then
			return false, 16010;
		end
		local singlechar;
		for i = 1, #str do
			singlechar = string.sub(str, i, i);
			if nil == string.find(singlechar, "[0-9A-Za-z]") then
				return false, 16011;
			end
		end
		return true;
	else
		if len < 11 then
			return false, 16073;
		end
		local singlechar;
		for i = 1, #str do
			singlechar = string.sub(str, i, i);
			if nil == string.find(singlechar, "[0-9]") then
				return false, 16011;
			end
		end
		return true;
	end
end

--密码验证方法
function ValidatePwd(str)
	local len = string.len(str);
	if str == nil or len == 0 then
		return false, 16012;
	end
	if len < eRegisterLen.PwdMin then
		return false, 16013;
	end
	local singlechar;
	for i = 1, #str do
		singlechar = string.sub(str, i, i);
		if nil == string.find(singlechar, "[0-9A-Za-z]") then
			return false, 16014;
		end
	end
	return true;
end

function ValidateCode(str)
	local len = string.len(str);
	if str == nil or len == 0 then
		return false, 16069;
	end
	if len ~=6 then
		return false, 16069;
	end
	local singlechar;
	for i = 1, #str do
		singlechar = string.sub(str, i, i);
		if nil == string.find(singlechar, "[0-9A-Za-z]") then
			return false, 16069;
		end
	end
	return true;
end

--显示服务器维护公告信息
function ShowCurrServerNotice()
	local info=GetCurrentServer();
	local path=string.format("https://%s:%s/php/res/%s/maintentance/%s",info.webIp,info.webPort,info.resDir,info.mainntentFile);
	CSAPI.GetServerInfo(path, function(str)
		if str then
			local json = Json.decode(str);
			local dialogdata = {
				content = json.content,
			}
			CSAPI.OpenView("Prompt", dialogdata)
		end
	end);
end

--通过http获取服务器列表
function InitServerInfo(callBack,serverListUrl)
	local path= serverListUrl or GetServerPath();
	-- Log(path)
	CSAPI.GetServerInfo(path, function(str)
		--	LogError(str);
		if str then
			
			local dStr=CSAPI.EncyptStr(str);
			local decodeStr=Base64.dec(dStr);

			if(_G.server_list_enc_close)then
				decodeStr = str;
			end			

			-- local decodeStr=Base64.dec(str)
			if decodeStr==nil or decodeStr=="" then
				LogError("获取服务器信息出错！"..tostring(decodeStr));
				do return end;
			end
			--LogError(decodeStr);
			local json = Json.decode(decodeStr);
			--LogError(json)
			-- local json = Json.decode(str);
            if(not json)then
                local dialogData =
	            {
		            content = LanguageMgr:GetByID(38011)
	            };
	            CSAPI.OpenView("Dialog", dialogData);
                return;
            end
			serverInfo = {};
			if json.code==0 then
				local list=json.data
				--LogError(list);
				for i = 1, #list do
					local item = {};
					item.id = tonumber(list[i] ["id"]);
					item.state = tonumber(list[i] ["state"]);
					item.serverName = list[i] ["serverName"];
					item.isNew = list[i] ["isNew"];
					item.hasRole = list[i] ["hasRole"];
					item.serverIp = list[i] ["serverIp"];
					item.port = tonumber(list[i] ["port"]);
					item.recommend = list[i] ["recommend"];
					item.resDir = list[i] ["resDir"];
					item.gmSvrIp=list[i]["gmSvrIp"];
					item.gmSvrPort=list[i]["gmSvrPort"];
					item.index=tonumber(list[i]["index"]);
					item.sdkUrl=list[i]["SDK_URL"];
					item.webIp=list[i]["webIp"];
					item.webPort=tonumber(list[i]["webPort"]);
					item.mainntentFile=list[i]["mainntentFile"];
					item.is_open_white=tonumber(list[i]["is_open_white"])
					table.insert(serverInfo, item);
				end
			end
			if callBack then
				callBack();
			end
		end
	end);
end


--获取IP和端口
function GetIpAndPort(str)
    local strs = StringUtil:split(str,":");
    if(strs == nil)then
        LogError(string.format("get ip and por fail from %s",str));
        return;
    end
    local ip,port = strs[1],strs[2];
    if(port)then
        port = tonumber(port);
    end
    return ip,port;
end

function GetServerInfoByID(id)
	if serverInfo then
		for i, v in ipairs(serverInfo) do			
			if v.id == id then
				return v;
			end
		end
	end
	return nil;
end

--返回第一个服务器信息
function GetServerInfoFirst()
	if serverInfo then
		return serverInfo[1];
	end
	return nil;
end

--返回推荐服数据，没有的时候默认读取最后一个服务器
function GetCommendServerInfo()
	local commendServer = nil;
	if serverInfo==nil then
		return commendServer;
	end
	for i, v in ipairs(serverInfo) do
		if v.recommend then
			commendServer = v;
		end
	end
	if commendServer == nil then
		commendServer = serverInfo[#serverInfo];
	end
	return commendServer;
end

function GetAgree()
	if agreeNum==-1 then
		agreeNum=PlayerPrefs.GetInt(login_agree);
	end	
	if agreeNum and agreeNum==1 then
		return true;
	else
		return false
	end
end

function SetAgree(isAgree)
	agreeNum=isAgree==true and 1 or 0;
	PlayerPrefs.SetInt(login_agree,agreeNum);
end

function GetPermission()
	if permissionNum==-1 then
		permissionNum=PlayerPrefs.GetInt(permission_agree);
	end	
	if permissionNum and permissionNum==1 then
		return true;
	else
		return false
	end
end

function SetPermission(isPermission)
	permissionNum=isPermission==true and 1 or 0;
	PlayerPrefs.SetInt(permission_agree,permissionNum);
end

function GetLastServerInfo()
	--local serverID = 3;--默认打包服
    --local serverID = 5;--默认内部稳定测试服
	--local serverID = 22;--默认打包测试服
    --local serverID = 11;--默认主干外服  	
	--local serverID = 16;--默认审核服
	--local serverID = 19;--内部稳定服
	--local serverID = 23;--默认ios提审服
	local serverID = PlayerPrefs.GetInt(lastServerPath);--正式服
	--LogError(serverID);
	local lastServerInfo = nil;
	if serverID and type(serverID) == "number" and serverID ~= 0 then
		lastServerInfo = GetServerInfoByID(serverID);
		--LogError(lastServerInfo);
	else
		if serverInfo then
			for i, v in ipairs(serverInfo) do
				if v.isNew then
					lastServerInfo = v;
					break;
				end
			end
		end
	end
	return lastServerInfo;
end

function SetCurrentServer(_serverInfo)
	currServerInfo=_serverInfo;
end

function GetCurrentServer()
	local info=nil;
	if currServerInfo then
		info=currServerInfo;
	else
		info=GetLastServerInfo();
		if info==nil then
			info=GetServerInfoFirst();
		end
	end
	return info;
end

--获取当前登录的IP信息 服务器信息,open_id
function GetLoginIpInfo(serverInfo,open_id)
	local num=tonumber(open_id);
	if num==nil and type(open_id)=="string" then
		num=StringUtil:GetUnicodeNum(open_id);
	end
	if serverInfo and serverInfo.serverIp and type(serverInfo.serverIp)=="table" and open_id and num then
		local len=#serverInfo.serverIp;
		local idx=num%len+1;
		return serverInfo.serverIp[idx];
	else
		--LogError("获取ip信息时错误！"..tostring(open_id));
		--LogError(serverInfo);
		if serverInfo and serverInfo.serverIp then
			if type(serverInfo.serverIp)=="table" then
				return serverInfo.serverIp[1];
			else
				return serverInfo.serverIp;
			end
		end
	end
end

function SaveLastServerInfo(serverId)
	if serverId and type(serverId) == "number" then
		PlayerPrefs.SetInt(lastServerPath, serverId);
	end
end

function SaveLastAccount(accountName, pwd)
	PlayerPrefs.SetString(login_account, accountName);
	PlayerPrefs.SetString(login_pwd, pwd);
end

function SaveLastSDKAccount(sdkName,pwd,sid)
	PlayerPrefs.SetString(sdk_phone, sdkName);
	PlayerPrefs.SetString(sdk_pwd, pwd);
	PlayerPrefs.SetString(sdk_id,sid)
end

function GetLastSDKInfo()
	local token = PlayerPrefs.GetString(sdk_phone);
    local pwd = PlayerPrefs.GetString(sdk_pwd);
	local sid=PlayerPrefs.GetString(sdk_id)
	return token,pwd,sid;
end

function GetLastAccount()
	local accountName = PlayerPrefs.GetString(login_account);
	local pwd = PlayerPrefs.GetString(login_pwd);
    -- local pwd1 = PlayerPrefs.GetString(login_pwd);
	-- local pwd="mega"..Base64.enc(pwd1);
	-- local startIdx,endIdx=string.find(pwd,"mega");
	-- LogError(startIdx)
	-- LogError(endIdx)
	-- if startIdx~=nil and startIdx==1 and endIdx~=nil then
	-- 	LogError(pwd)
	-- 	local enCode=string.sub(pwd,endIdx+1);
	-- 	LogError(enCode)
	-- 	-- pwd=Base64.dec(pwd);
	-- 	LogError("dec:"..tostring(Base64.dec(pwd)))
	-- 	return accountName,Base64.dec(pwd);
	-- else
	-- 	return accountName,pwd;
	-- end
	return accountName,pwd;
end

function GetReloginTime()
    return reloginTime;
end

--登录账户
function LoginAccount(accountName, pwd,relogin)

    if(relogin)then
        reloginTime = CSAPI.GetTime();
    else
        reloginTime = nil;
    end
	--清理登录缓存
	LoginProto:Clear();
	local msg = {account = accountName, pwd = pwd};	
	--连接内网
	LoginProto:SendQueryAccount(msg,relogin,function()
		-- if not CSAPI.IsChannel() then
				--缓存最后一次登录的账户
				SaveLastAccount(accountName, pwd);
			-- end
	end, function()
        if(relogin)then
			--重登时，刷新商店物品
			ShopProto:GetShopInfos();
            return;
        end
		SceneMgr:SetLoginLoaded(true);
		if CSAPI.IsChannel() then
			ThinkingAnalyticsMgr:TrackStateEvent("open_id",accountName)
			ThinkingAnalyticsMgr:TrackEvents("openid_login", {open_id=accountName});
		end
		ThinkingAnalyticsMgr:Login(accountName);
        --登录服务器地址
        local currServer = GetCurrentServer();
        --LogWarning(serverInfo);
        local address = currServer.gmSvrIp .. ":" .. currServer.gmSvrPort;        
        EventMgr.Dispatch(EventType.Login_Server_Address,address,true);		

        CSAPI.LoadABsByOrder({"prefabs_uis_plot"});--进入新手战斗，预加载出剧情资源包

        GuideMgr:RequestData();
        --RedPointMgr:Clean();
        SoundMgr:InitLanguageCV();
		
        local playerLv = PlayerClient:GetLv(); 

		--缓存公告地址
		ActivityMgr:Init1(currServer.webIp,currServer.webPort)

        if(playerLv and playerLv > 1)then
        --if(false)then  
			--2级以上，进入主城            
			EventMgr.Dispatch(EventType.Scene_Load, "MajorCity");
        else
            if(not relogin)then
				if PlayerClient:GetModifyName() == 2  then --显示性别设置和名称设置
					PlayPV();
					-- CSAPI.OpenView("UserName",{closeFunc=function()
					-- 	--进入主城
					-- 	PlayerClient:EnterGame();
					-- end});
				else
					--进入主城
					PlayerClient:EnterGame();
				end
            end            
        end
	end);	
end 

function BackToLogin()
    GuideMgr:Clear();
    GuideMgr:CloseGuideView();

    CSAPI.OpenView("Prompt", 
    {
        content = LanguageMgr:GetByID(38010),
        okCallBack = ToLogin, 
    });
end
function ToLogin()
    CSAPI.CloseAllOpenned();
	PlayerClient:Exit();
end

--重新登录
function ReloginAccount()    
	PlayerClient:SetChangeLine(false);--重新登录了，取消切线
    NetMgr.net:Disconnect();

    local lastServer = GetLastServerInfo();  
	if lastServer==nil then
		InitServerInfo(function()
			lastServer = GetLastServerInfo();  
			if lastServer==nil then
				LogError("获取服务器信息失败...终止重连")
				return;
			end
			local accountName,pwd = GetLastAccount();

            local ipAndPort=GetLoginIpInfo(lastServer,accountName);
            local serverIp,serverPort = GetIpAndPort(ipAndPort)
            serverPort = serverPort or lastServer.port;
			NetMgr.net:Connect(serverIp, serverPort, function()
				-- local accountName,pwd = GetLastAccount();
				-- Log( "重新登录，账号：" .. tostring(accountName) .. "，密码：" .. tostring(pwd)); 
				LoginAccount(accountName,pwd,true);
				--LoginAccount(accountName,pwd);
			end);
		end)
	else
		Log( "重新连接服务器========================="); 
		Log( lastServer);
		local accountName,pwd = GetLastAccount();
		local ipAndPort=GetLoginIpInfo(lastServer,accountName);
		local serverIp,serverPort = GetIpAndPort(ipAndPort)
		serverPort = serverPort or lastServer.port;

		NetMgr.net:Connect(serverIp, serverPort, function()
			-- local accountName,pwd = GetLastA ccount();
			-- Log( "重新登录，账号：" .. tostring(accountName) .. "，密码：" .. tostring(pwd)); 
			LoginAccount(accountName,pwd,true);
			--LoginAccount(accountName,pwd);
		end);
	end
end

--播放PV
function PlayPV()
	if(PlayerClient:PlayOP(PlayPVOver)==false)then
		PlayPVOver();
	end
end

function PlayPVOver()
	--播放第一段剧情
	local isPlayed=PlotMgr:IsPlayed(10000);
	if isPlayed then
		CSAPI.OpenView("UserName",{closeFunc=function()
			--进入主城
			PlayerClient:EnterGame();
		end});
	else
		CSAPI.OpenView("UserName",{closeFunc=function()
			--进入主城
			PlayerClient:EnterGame();
		end});
		PlotMgr:TryPlay(10000);
	end
end

function StartCodeCD(time)
	codeCDTime=time;
	local func=function()
		EventMgr.Dispatch(EventType.Login_CD_Down,codeCDTime);
		codeCDTime=codeCDTime-1;
	end
	FuncUtil:Timer(func,nil,0,1000,time+1);
end

function StartCodeCD2(time)
	codeCDTime2 = time;
	local func=function()
		EventMgr.Dispatch(EventType.Login_CD_Down2,codeCDTime2);
		codeCDTime2=codeCDTime2-1;
	end
	FuncUtil:Timer(func,nil,0,1000,time+1);
end

function GetCodeCD()
	return codeCDTime or 0;
end

function GetCodeCD2()
	return codeCDTime2 or 0;
end

--登陆米茄官方SDK
function SignSDK(token,pwd,server_id,func)
	ChannelWebUtil.SendToServer2({cmd=SendCMD.Login,phone=token,password=pwd,game_id=gameId,server_id=server_id},nil,function(json)
		if json.code==ResultCode.Normal then
			if func then
				func(json);
			end
			ThinkingAnalyticsMgr:TrackStateEvent("open_id", json.open_id)
			ThinkingAnalyticsMgr:TrackEvents("openid_login", {open_id=json.open_id,phone=token});
		else
			-- ThinkingAnalyticsMgr:TrackEvents("openid_login", {code=json.code});
			Tips.ShowTips(json.msg);
			EventMgr.Dispatch(EventType.Login_Hide_Mask);
		end
	end);
end

--米茄官方SDK验证账号
function SignAccount(phone,oid,server_id,func)
	ChannelWebUtil.SendToServer2({cmd=SendCMD.Sign,phone=phone,game_id=gameId,server_id=tostring(server_id),open_id=tostring(oid),channelType=tostring(GetChannelType())},ChannelWebUtil.Extends.GetAccount,function(json)
		if json.code==ResultCode.Normal then
			--新号则上传注册事件
			local bnew=json.data["bnew"];
			local accountName=json.data["oacc_name"];
			if bnew=="1" then
				--上传热云注册事件
				local account=string.format("%s_%s",CSAPI.GetChannelStr(),accountName);
				--LogError("ReYunSDK:Reg------------------->"..tostring(account));
				ReYunSDK:SetRegisterEvent(account,{channelType=CSAPI.GetChannelName()});
				JuLiangSDK:Register("官网", true)
				ThinkingAnalyticsMgr:TrackEvents("openid_register", {phone=accountName}, TAType.First);
			end
			if func then
				func(json);
			end
		else
			Tips.ShowTips(json.msg);
			EventMgr.Dispatch(EventType.Login_Hide_Mask);
		end
	end);
end

function SignWhite(phone,func)
	if GetChannelType()==ChannelType.BliBli or GetChannelType()==ChannelType.QOO then --B站/QOO不验证官网白名单
		if func then
			func();
		end
		EventMgr.Dispatch(EventType.Login_Hide_Mask);
		return;
	end
	-- ChannelWebUtil.SendToServer2({cmd=SendCMD.White,subcmd=SendSubCMD.query,phone=phone,game_id=gameId},"",function(json)
	-- 	if json.code==ResultCode.Normal then
			if func then
				func(json);
			end
	-- 	else
	-- 		local dialogdata = {
	-- 			content = json.msg,
	-- 		}
	-- 		CSAPI.OpenView("Prompt", dialogdata)
	-- 		EventMgr.Dispatch(EventType.Login_Hide_Mask);
	-- 	end
	-- end);
end

function IsAccount()
	if isAccount==nil then
		isAccount=not CSAPI.IsPhoneLogin();
	end
	return isAccount;
end

function SetOpenCount()
	openCount=openCount+1;
end

function GetOpenCount()
	return openCount;
end


--手机验证码登录相关--------------------------------------------------------------------
--验证码登录
local keyPhoneAuthCodeLogin = "phone_auth_code_login";
function GetPhoneLoginKey()
    local key = PlayerPrefs.GetString(keyPhoneAuthCodeLogin);
    if(not StringUtil:IsEmpty(key))then
        return key;
    end
end
function SetPhoneLoginKey(key)
    --LogError(key);
    PlayerPrefs.SetString(keyPhoneAuthCodeLogin,key);
end