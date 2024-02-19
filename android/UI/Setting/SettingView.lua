local childPanels = {"SettingFpsPanel", "SettingMusicPanel", "SettingFightPanel", "SettingCDKPanel"}
local panels = {}
local curPanel = nil
local curIndex = 1
local itemsRT = {}
local eventMgr = nil;
local leftDatas = {}
local top = nil
curIndex1, curIndex2 = 1,1
function Awake()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Login_SDK_Logout, OnLogoutResult);
	
	for i = 1, 5 do
		local itemRT = ComUtil.GetCom(this["itemRT" .. i], "ActionWH")
		table.insert(itemsRT, itemRT)
	end
end

function OnDestroy()
	eventMgr:ClearListener();
	ReleaseCSComRefs()
	if top then
		CSAPI.SetGOActive(top.btn_home, true)
	end
	if data == SettingEnterType.FightMenu then
		-- FightClient:SetPauseState(true);
	end
end


function OnOpen()
	if openSetting and openSetting > 0  then
		curIndex1 = openSetting
	end
	CSAPI.SetLocalPos(imgObj,0,0)
	if data == SettingEnterType.Login then
		leftDatas = {{14000, "Setting/icon1"}, {14001, "Setting/icon2"}}
		CSAPI.SetGOActive(btnSign, false)
		CSAPI.SetGOActive(btnExit, true)	
	elseif data == SettingEnterType.FightMenu then
		top= UIUtil:AddTop2("SettingView", backNode, function()
			view:Close()
		end,nil,{})
		CSAPI.SetGOActive(top.btn_home, false)
		leftDatas = {{14000, "Setting/icon1"}, {14001, "Setting/icon2"}, {14003,"Setting/icon3"}}
		CSAPI.SetGOActive(btnSign, false)
		CSAPI.SetGOActive(btnExit, false)
	else
		UIUtil:AddTop2("SettingView", backNode, function()
			view:Close()
		end)
		leftDatas = {{14000, "Setting/icon1"}, {14001, "Setting/icon2"}, {14003,"Setting/icon3"},{14002,"Setting/icon4"}}
		CSAPI.SetGOActive(btnSign, true)
		CSAPI.SetGOActive(btnExit, false)		
	end
	InitLeftPanel()
	RefreshPanel()
end

function InitLeftPanel()
	if(not leftPanel) then
		local go = ResUtil:CreateUIGO("Common/LeftPanel", leftParent.transform)
		leftPanel = ComUtil.GetLuaTable(go)
	end
	-- local leftDatas = {{14000, "Setting/icon1"}, {14001, "Friend/icon2"}, {14002, "Friend/icon3"}, {14003, "Friend/icon4"}, {}, {14004, "Friend/icon4"}} --多语言id，需要配置英文
	leftPanel.Init(this, leftDatas)
end

function RefreshPanel()
	if isFirst then --打开界面时
		CSAPI.PlayUISound("ui_popup_open")
	else
		isFirst = true
	end
	
	leftPanel.Anim()
	
	local index = curIndex1
	if(curPanel) then
		CSAPI.SetGOActive(clickMask, true)
		curPanel.SetFade(false, SetMask)		
	end
	if(panels[index]) then
		panels[index].SetFade(true)		
	else
		local itemName = childPanels[index]
		local go = ResUtil:CreateUIGO("Setting/" .. itemName, node.transform)
		local panel = ComUtil.GetLuaTable(go)
		if index ~= 4 then
			local screenCount= SettingMgr:GetScreenCount()
			CSAPI.SetLocalPos(go,-screenCount,0)			
		end
		
		panels[index] = panel
	end
	curPanel = panels[index]
	
	curIndex = index	

	if curIndex == 2 and data == SettingEnterType.Login then
		curPanel.CloseSelectLanguage()
	end
end

--重登
function OnClickSign()
	-- local tips = {}
	-- tips.content = LanguageMgr:GetTips(7000)
	-- tips.okCallBack = function()
	-- 	if CSAPI.IsChannel() then
	-- 		EventMgr.Dispatch(EventType.Login_SDK_LogoutCommand, nil, true);
	-- 	else
	-- 		Logout();
	-- 	end
	-- end
	-- CSAPI.OpenView("Dialog", tips)	

	CSAPI.OpenView("SettingWindow")
end

function OnLogoutResult(isSuccess)
	if isSuccess then
		Logout();	
	end
end

function Logout()
	Tips.ClearMisionTips() --清除任务tips		
	PlayerClient:Exit();
	FightClient:Reset();
end

--退出游戏
function OnClickQuit()
	local tips = {}
	tips.content = LanguageMgr:GetTips(7001)
	tips.okCallBack = function()
		Tips.ClearMisionTips() --清除任务tips
		CSAPI.Quit()
	end
	CSAPI.OpenView("Dialog", tips)	
end

--隐藏在右下角的GM开关按钮
function OnGMStateChanged()
	EventMgr.Dispatch(EventType.GM_State_Changed, nil, true);	
end

function SetMask()
	CSAPI.SetGOActive(clickMask, false)
end

function OnClickBack()
	view:Close()
end 
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
leftParent=nil;
btnSign=nil;
txtSign=nil;
txtSign2=nil;
node=nil;
backNode=nil;
btnExit=nil;
clickMask=nil;
itemRT1=nil;
itemRT2=nil;
itemRT4=nil;
itemRT5=nil;
itemRT3=nil;
view=nil;
end
----#End#----