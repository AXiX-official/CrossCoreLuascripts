--渠道工具类,用于发送各种SDK相关的HTTP post请求 
local this={};
local gameId="1";
local signType={ --SDK访问的渠道对应关键字
     Mega="/mega/",
     Cross="/cross/",
     Qoo="/qoo/",
	 BiliBili="/bilibili/",
}
local serverInfo=nil;
this.Extends={--url额外拼接关键字
	GetAccount="/getAccount.php",
    CheckOrder="/payNoticeFromClient.php",--检测未完成订单（目前只有QOO使用）
    GetOrderID="/payClientGetOrderId.php",--从服务器获取订单ID（附带给SDK的参数）
	Authen="/realName/authen.php",--实名验证
	AuthenLogin="/realName/login_out.php",--上传玩家游戏时长接口
	DelAccountMsg = "/delAccountMsg.php",
	DelAccount = "/delAccount.php",
	DelAccountInfo = "/delAccountInfo.php"
};
--- func 设置服务器信息
---@param _serverInfo 登录的服务器信息
function this.SetServerInfo(_serverInfo) 
    serverInfo=_serverInfo
    -- LogError(serverInfo)
end

--- func 返回SDK访问路径
---@param cmd string SDK操作类型
---@param extend string 额外拼接路径
---@param data table 附帶參數
function this.GetRealUrl(cmd,extend,data)
    -- local url=signType.Mega;
	-- if CSAPI.GetChannelType()==ChannelType.QOO then
	-- 	url=signType.Qoo;
	-- elseif CSAPI.GetChannelType()==ChannelType.BiliBili then
	-- 	url=signType.BiliBili;
	-- elseif cmd==SendCMD.Sign then
	-- 	url=signType.Cross;
	-- end
	local url="";
	if serverInfo then
		local targetUrl=serverInfo.sdkUrl;
		--if	data and data.pay_type==tostring(PayType.WeChat) then
		--	targetUrl="https://mycdn.megagamelog.com/php/sdk/";
		--end
		if extend then
			url=string.format("%s%s%s",targetUrl,url,extend);
		else
			url=string.format("%s%s",targetUrl,url);
		end
	end
	-- LogError(url)
    return url;
end

--- func 根据data的cmd获取url并发送POST请求
---@param data table 
---@param extend string
---@param func any
function this.SendToServer2(data,extend,func)
    local url=this.GetRealUrl(data.cmd or nil,extend,data);
	-- LogError("SendToServer2:");
	-- LogError(url)
	-- LogError(data)
    this.SendToServer(url,data,func);
end

--- func 发送POST请求给指定的URL
---@param url string
---@param data table 
---@param func function
function this.SendToServer(url,data,func)
    -- Log("SendToServer:"..tostring(url))
	-- Log(data);
	EventMgr.Dispatch(EventType.Login_Show_Mask)
	CSAPI.WebPostRequest(url,data,function(result)
		if result then
			local json = Json.decode(result);
			if json~=nil and type(json)=="table" and func~=nil then
				func(json);
			else
				LogError("http返回结果有误：" ..tostring(result) .. tostring(url) .. table.tostring(data,true));
				-- LogError("访问"..tostring(url).."时出错！返回结果："..tostring(result));
			end
		end
	end,true,100,0);
end

function this.GetServerID()
    if serverInfo then
        return serverInfo.id;
    end
    return nil;
end

function this.GetServerInfo()
	return serverInfo;
end

return this;