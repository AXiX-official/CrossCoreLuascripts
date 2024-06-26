PlayerMgr = MgrRegister("PlayerMgr")
local this = PlayerMgr

function this:Init()
	--self:PlrPaneInfo()
	self:Clear()
	PlayerProto:GetSpecialDropsInfo()
end

function this:Clear()
	self.dropInfos = {}
end


-----------------------------------------------协议发------------------------
--获取玩家信息
function this:PlrPaneInfo()
	local proto = {"PlayerProto:PlrPaneInfo"}
	NetMgr.net:Send(proto)
end

--获取头像框列表
function this:PlrIconGrid()
	local proto = {"PlayerProto:PlrIconGrid"}
	NetMgr.net:Send(proto)
end

--获取背景列表
function this:PlrPaneBg()
	local proto = {"PlayerProto:PlrPaneBg"}
	NetMgr.net:Send(proto)
end

--修改签名
function this:Sign(_sign)
	local proto = {"PlayerProto:Sign", {sign = _sign}}
	NetMgr.net:Send(proto)
end

--修改模型
function this:ChangeIcon(_panel_id, _icon_id,_cb)
	self.ChangeIconCB = _cb 
	local proto = {"PlayerProto:ChangeIcon", {panel_id = _panel_id or _icon_id}}
	NetMgr.net:Send(proto)
end
--修改模型
function this:ChangeIconRet(proto)
	PlayerClient:SetPanelId(proto.panel_id)
	PlayerClient:SetLastRoleID(proto.role_panel_id)
	--PlayerClient:SetIconId(proto.icon_id)
	EventMgr.Dispatch(EventType.Player_Select_Card)
	if(self.ChangeIconCB) then 
		self.ChangeIconCB()
	end 
	self.ChangeIconCB = nil 

	LanguageMgr:ShowTips(27002)
end


function this:PlrPaneInfoRet(proto)
	--self.data = proto.info
	EventMgr.Dispatch(EventType.Player_Info,proto)
end

--获取头像框列表
function this:PlrIconGridRet(proto)
	print("获取头像框返回")
end

--获取背景列表
function this:PlrPaneBgRet(proto)
	print("获取背景返回")
end

--修改签名
function this:SignRet(proto)
	PlayerClient:SetSign(proto.sign)
	EventMgr.Dispatch(EventType.Player_Change_Sign)
end

---------------------------------------------特殊掉落---------------------------------------------
function this:UpdateSpecialDrops(proto)
    self.dropInfos = {}
    if proto and proto.dropInfos and #proto.dropInfos > 0 then
        for i, v in ipairs(proto.dropInfos) do
            self.dropInfos[v.sid] = v.num
        end
    end
    EventMgr.Dispatch(EventType.SpecialDrops_Info_Update)
end

function this:GetSpecialDrops()
    return self.dropInfos
end

function this:GetSpecialDrop(goodId)
	return self.dropInfos[goodId] or 0
end


return this

