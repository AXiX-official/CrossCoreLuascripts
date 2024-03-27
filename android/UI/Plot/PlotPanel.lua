--剧情面板
local storyData = nil;
local currentPlotData = nil;--当前输出的对话信息
local isPlotEnd = false; --剧情播放结束

local playPower = {1, g_PLotForwardSpeed};--播放倍率
local powerIndex = 1;--当前倍率档位

local anyWayObj; --任意处点击按钮
local plotBox; --对话框
local roleList = {};--立绘信息队列
local text_desc;--剧情简介

local cgList;--cg队列
local cgIndex = - 1;--cg播放下标,为-1时表示没有播放
local cgTimer = 0;--cg计时器
local cgCall = nil;--cg播放完的回调
local isCGPlay = false --用于背景动画执行时禁止点击部分按钮

local shakeObjs = nil;--震动脚本对象

local lastFrameInfo = nil;--最后一帧的信息

local eventMgr;

local isJump = false

local sceneInfo = nil;--背景图片切换信息

local effectTimer = 0;--特效计时器
local lineEffect = nil;--百叶穿效果脚本
local lineTween = nil;--百叶窗动画脚本

local lastShakeInfo = nil --上一个震动信息

local jumpRecord = nil;--跳过的数据缓存
local effectLayer = nil;--特效层级父物体
local bgImg = nil;--背景图片

local timers = {};--用来统计各部分的播放时长的
local delayTimer = 0; --当前信息的播放时长，不包括对话信息
local recordBeginTime = 0;
local hideMode = false;
local optionDic = {};--用来记录玩家当前选择的选项信息，用于显示回放记录
local isOptions = false;--开启选项
local autoDelay = 0;
local forceAutoTime = nil --强制自动播放
local isTimeStop = false

local roleCount = 0 --用于存储当前场上立绘数量

local bgActionTime = 1300 --场景切换时间

local plotSound = nil --音效

local plotVideo = nil

local effectInfos = {} --用于记录已播放的特效

--动画脚本
local bgFade
local lineFade
local imgFade
local nodeFade
local boxFade

--模糊
local blur = nil
local blurTimer = 0
local blurSpeed = 0

local currBgName = nil
local isOpenTween = true
local isCanPlay = true --剧情文字播放状态

--眨眼
local isBlink = false
local blinkNum = 0

--背景切换
local isChangeBg = false
local isFirstChange = true


local myBGMLockKey = "plot_bgm";

function Awake()
	recordBeginTime = CSAPI.GetRealTime();
	anyWayObj = ComUtil.GetCom(gameObject, "Button");
	text_desc = ComUtil.GetCom(DescText, "Text");
	lineEffect = ComUtil.GetCom(effCamera, "ScreenTransitionSimpleSoft");
	lineTween = ComUtil.GetCom(effCamera, "ActionBlindEffect");
	bgImg = ComUtil.GetCom(bg, "Image");
	effectLayer = {
		bottomParent,
		topParent,
	}
	CSAPI.SetGOActive(DescContent, false);
	InitShakeObjs();
	CSAPI.SetText(txt_forwardVal, "×" .. playPower[powerIndex]);
	
	bgFade = ComUtil.GetCom(bg_fade, "ActionFade")
	lineFade = ComUtil.GetCom(line_fade, "ActionFade")
	imgFade = ComUtil.GetCom(img_fade, "ActionFade")
	nodeFade = ComUtil.GetCom(node_fade, "ActionFade")
	boxFade = ComUtil.GetCom(box_fade, "ActionFade")
	
	--底图
	local goRT = CSAPI.GetGlobalGO("CommonRT")
	CSAPI.SetRenderTexture(bg, goRT);
	CSAPI.SetCameraRenderTarget(bgCamera, goRT);
	
	blur = ComUtil.GetCom(bgCamera, "SuperBlur")
end

--添加震动动画预制物
function InitShakeObjs()
	shakeObjs = {};
	for i = 0, shakes.transform.childCount - 1 do
		local go = shakes.transform:GetChild(i).gameObject;
		local shakeObj = ComUtil.GetCom(go, "ActionShake");
		table.insert(shakeObjs, shakeObj);
	end
end

function OnInit()
	InitListener();
end

function InitListener()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Select_Plot_Option, OnSelectPlotOption);
	eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed);
	eventMgr:AddListener(EventType.Plot_Close_Delay, OnCloseDelay);
end

function OnDisable()
	--重置timeScale
	CSAPI.SetTimeScale(1);
	--LogError("播放结束");	
	TryCallBack();
	--CSAPI.StopBGM();
    EventMgr.Dispatch(EventType.Replay_BGM, 50);
	data = nil;
end

--完成回调
function TryCallBack()
	local callBack = data and data.playCallBack;
	if(callBack) then
		local caller = data.caller;
		
		data.playCallBack = nil;
		data.caller = nil;
		
		callBack(caller);
	end
end

function OnDestroy()   
    local key = CSAPI.GetBGMLock();
--    LogError(key); 
--    LogError(myBGMLockKey); 
    if(CSAPI.GetBGMLock() == myBGMLockKey)then
	    CSAPI.SetBGMLock();
        EventMgr.Dispatch(EventType.Replay_BGM, 50);
    end
	
	eventMgr:ClearListener();
	eventMgr = nil;
	storyData = nil;
	currentPlotData = nil;
	anyWayObj = nil;
	plotBox = nil;
	jumpRecord = nil;
	timers = {};
	blurTimer = 0
	blurSpeed = 0
	effectInfos = {}
	PlayerPrefs.SetInt(GetSpeedKey(), powerIndex);
	RecordMgr:Save(RecordMode.View, recordBeginTime, "ui_id=" .. RecordViews.Plot);	
	ReleaseCSComRefs()
end

--数据
function InitData(storyID)
	--初始化数据
	storyData = StoryData.New();
	storyData:InitCfg(storyID);
	currentPlotData = storyData:GetBeginPlotData();
end

function OnOpen()
	-- ResUtil:PlayVideo("plot_burn1", gameObject)
	CSAPI.StopBGM(1)
	if data == nil then
		LogError("章节ID不能为空！");
		return;
	end
	--自适应背景
	SetSelfAdaptionBG()
	InitData(data.storyID);
	
	--速度
	powerIndex = PlayerPrefs.GetInt(GetSpeedKey()) or 1;
	powerIndex = powerIndex == 0 and 1 or powerIndex;
	SetPowerText();
	
	--自动
	isAuto = PlayerPrefs.GetInt(GetAutoKey()) == 1;
	SetAutoLayout(isAuto);
	
	--初始化
	if plotBox == nil then
		local go = ResUtil:CreateUIGO("Plot/PlotBox", boxParent.transform);
		plotBox = ComUtil.GetLuaTable(go);
		CSAPI.SetAnchor(go, 0, 0, 0);
		plotBox.SetOnPlotOver(OnPlayOver);
		plotBox.HideBox(false);
	end
	if(plotSound == nil) then
		local go = ResUtil:CreateUIGO("Plot/PlotSound", soundParent.transform);
		plotSound = ComUtil.GetLuaTable(go);
		CSAPI.SetAnchor(go, 0, 0, 0);
	end

	PlotTween.Init()
	
	--开头动效
	SetTween(true)
end

function GetSpeedKey()
	return PlayerClient and "Plot_Speed_" .. tostring(PlayerClient:GetUid()) or "Plot_Speed_Default";
end

function GetAutoKey()
	return PlayerClient and "Plot_Auto_" .. tostring(PlayerClient:GetUid()) or "Plot_Auto_Default";
end

function Update()
	if(isTimeStop) then
		do return end
	end
	--播放连续cg内容处理
	if cgList and cgIndex > 0 then	
		local isFull = cgTimer >= currentPlotData:GetImgDelay();
		if cgIndex <= #cgList and isFull then
			cgTimer = 0;
			if cgIndex == #cgList then				
				CSAPI.SetGOActive(boxParent, false)
				ShowImgContent(cgList[cgIndex], currentPlotData:GetImgChangeType(), cgCall, function()
					CSAPI.SetGOActive(boxParent, true)					
					-- if not isOpenTween then
					PlayContent();
					-- end			
					isCGPlay = false
				end);
				-- if cgCall then
				-- 	cgCall();
				-- end
				anyWayObj.enabled = true;
				-- CSAPI.SetGOActive(buttonChild, true);
				CSAPI.SetTimeScale(playPower[powerIndex]);--还原快进速度							
			else
				ShowImgContent(cgList[cgIndex], currentPlotData:GetImgChangeType());
			end
		else--计时
			cgTimer = cgTimer + Time.deltaTime;
		end
	end
	if delayTimer > 0 then
		delayTimer = delayTimer - Time.deltaTime;
	end
	PlotTween.Update();
	if IsPlayOver() then
		local options = currentPlotData and currentPlotData:GetOptions() or nil
		if (isAuto and options == nil) or forceAutoTime then
			if autoDelay > 0 then --自动播放间隔
				autoDelay = autoDelay - Time.deltaTime;
			else
				PlayNext();
				autoDelay = g_PlotPlayInterval;
			end
		elseif isAuto and not isOptions and options ~= nil then
			isOptions = true
			plotBox.InitSelectObj(options)
		end	
	end
	--模糊动画
	if blurTimer > 0 then
		blurTimer = blurTimer - Time.deltaTime
	end
	if blurTimer > 0 then
		blur.Progress = blur.Progress + blurSpeed
		if blur.Progress > 1 then
			blur.Progress = 1
		elseif blur.Progress < 0 then
			blur.Progress = 0
		end
	end
	
	--眨眼动画
	if isBlink and blinkNum > 0 then --从闭眼开始到睁眼结束
		isBlink = false
		local plotID = currentPlotData:GetID()
		PlotTween.Twinkle(effectEye, 0.5, function()
			FuncUtil:Call(function()
				if(gameObject and not effectInfos[plotID].isJumpBlink and currentPlotData) then
					if blinkNum == 1 then
						PlayContent()
						blinkNum = 0
						CSAPI.SetGOActive(effectEye, false)
					else
						blinkNum = blinkNum - 1
						isBlink = true
					end
				end								
			end, nil, 500)
		end)
	end
end

function SetBlink(num)
	isBlink = num > 0
	blinkNum = num
end


--进入和退出的动画 
--进入：背景->立绘和边框->按钮和文本框->文字播放 
--退出：按钮和文本框->立绘和场景、边框
function SetTween(isOpen)
	if isOpen then
		AnimStart()
		bgFade:Play(0, 1, 250, 0)
		lineFade:Play(0, 1, 250, 250)
		imgFade:Play(0, 1, 250, 250)
		nodeFade:Play(0, 1, 250, 500)
		boxFade:Play(0, 1, 250, 500, function()	
			CSAPI.SetGOActive(leftButton, true)
			-- PlayContent()
			if data.talkID then
				JumpToPlot(data.talkID);
			else
				PlayPlot()
			end
			
			isOpenTween = false
			AnimEnd()
		end)
	else
		AnimStart()
		nodeFade:Play(1, 0, 250, 0)
		boxFade:Play(1, 0, 250, 0)
		lineFade:Play(1, 0, 250, 250)
		imgFade:Play(1, 0, 250, 250)
		bgFade:Play(1, 0, 250, 250, function()
			CSAPI.SetGOActive(bgCamera, false)
			AnimEnd()
			CloseView();
		end)
	end
end

--整段剧情播放完毕
function PlotPlayOver()
	if isAuto then
		isAuto = false;
	end	
	BuryingPointMgr:TrackEvents("plot_dialogue", {reason = "完成对话", plot_id = storyData:GetID()})
	isPlotEnd = true
	SetTween(false)
end

--显示对话框
function ShowContent()
	plotBox.ShowBox(currentPlotData, isAuto);
	plotSound.PlaySound(currentPlotData)
end

--隐藏对话框
function HideDialogBox(isTween)
	if plotBox ~= nil then
		plotBox.HideBox(isTween);
	end
end

--显示剧情简介
function ShowDescContent(isShow)
	CSAPI.SetGOActive(DescContent, isShow);
	text_desc.text = storyData:GetDesc();
	local length, chars = GLogicCheck:GetStringLen(storyData:GetDesc())
	if(length > 28) then
		text_desc.alignment = UnityEngine.TextAnchor.MiddleLeft
	else
		text_desc.alignment = UnityEngine.TextAnchor.MiddleCenter
	end
	local func = isShow and PlotTween.FadeIn or PlotTween.FadeOut
	--播放动画
	if func then
		func(DescContent)
	end
end

--播放剧情
function PlayPlot()
	effectInfos[currentPlotData:GetID()] = {}
	
	local pInfos = currentPlotData:GetAllRoleInfos();
	local clearRoles = currentPlotData:GetClearRoles() --全立绘退场
	if roleList == nil then
		roleList = {};
	end
	delayTimer = 0;--播放时间，不计算文字内容的播放
	timers = {};
	PlayBGM();
	cgList = currentPlotData:GetImgContents();
	
	--强制自动
	forceAutoTime = currentPlotData:GetForceAutoTime()
	if forceAutoTime then
		autoDelay = 0.001
	end
	
	PlayShake()
	PlayVideo()
	
	--判断是否存在图片内容
	if cgList ~= nil then--播放图片内容
		--播放图片内容时将所有立绘退场
		-- ClearImg();
		--开始播放cg
		anyWayObj.enabled = false;
		-- CSAPI.SetGOActive(buttonChild, false);
		isCGPlay = true
		CSAPI.SetTimeScale(1);--设置速度
		-- isAuto=false;
		cgIndex = 1;
		local cgTimer2 = currentPlotData:GetImgDelay();
		table.insert(timers, #cgList * cgTimer2);
		cgCall = function()			
			if clearRoles then
				ClearImg(clearRoles)
			else
				UpdateRoleImg(pInfos)
			end
		end		
	else
		--播放文字和立绘
		local delayCount = 0.5; --动画播放时间
		if pInfos then
			for k, v in ipairs(pInfos) do
				local delay = v.delay and v.delay + 1 or 1; --1是默认的播放动画时长
				delayCount = delayCount > delay and delayCount or delay;
			end
		end
		if clearRoles then
			ClearImg(clearRoles)
		else
			UpdateRoleImg(pInfos)
		end
		--SetTween(true)
		PlayContent();
		table.insert(timers, delayCount);
	end
	
	if(currentPlotData:GetEffSoundInfos() and currentPlotData:GetSoundKey()) then --音效时长
		local soundTime = plotSound.GetSoundTime() or 0
		if(soundTime > 0) then
			table.insert(timers, soundTime);
		end
	end	
	
	if(currentPlotData:GetBlinkTime() > 0) then --眨眼时长
		table.insert(timers, currentPlotData:GetBlinkTime());
	end
	
	PlayEffect();--播放特效
	PlayBlur()
	PlayCameraTween();
	
	if timers then
		delayTimer = timers[1];
		for k, v in ipairs(timers) do
			if delayTimer < v then
				delayTimer = v;
			end
		end
	end
	
	if currentPlotData:GetContent() == nil or currentPlotData:GetContent() == "" then --无对话框的时候播放完毕
		FuncUtil:Call(OnPlayOver, nil, delayTimer * 1000);
	end

	--打点
	local recordId = currentPlotData.cfg.record_id
	if recordId then
		BuryingPointMgr:BuryingPoint("after_login",recordId)
end
end

--播放震动
function PlayShake()	
	if lastShakeInfo and #lastShakeInfo > 0 then --停止持续震动
		for k, v in ipairs(lastShakeInfo) do
			if v.time == - 1 then
				PlotTween.StopTweenShake()
				lastShakeInfo = nil
				break
			end
		end
	end
	
	local shakeDelay = cgList ~= nil and bgActionTime or 0.1
	local shakeInfo = GetShakeInfo(currentPlotData.cfg.shakeInfos);
	if shakeInfo then --震动
		local plotID = currentPlotData:GetID()
		FuncUtil:Call(function()			
			if( gameObject and not effectInfos[plotID].isJumpShake and currentPlotData) then
				lastShakeInfo = shakeInfo
				PlotTween.TweenShake(shakeInfo);
				table.insert(timers, shakeInfo.time);		
			end
		end, nil, shakeDelay)
	end	
end

function PlayVideo()
	if plotVideo == nil then
		ResUtil:CreateUIGOAsync("Plot/PlotEffect", videoParent, function (go)
			local lua = ComUtil.GetLuaTable(go)
			lua.Refresh(currentPlotData,effectInfos)
			plotVideo = lua

			local videoTime = lua.GetCurrTime()
			if videoTime then
				table.insert(timers, videoTime);
			end
		end)
	else
		plotVideo.Refresh(currentPlotData,effectInfos)
		local videoTime = plotVideo.GetCurrTime()
		if videoTime then
			table.insert(timers, videoTime);
		end
	end
end

--播放bgm
function PlayBGM()
	local bgmName = currentPlotData:GetBGM();
	if bgmName == "none" then
		CSAPI.StopBGM();
	elseif bgmName ~= nil and bgmName ~= "none" and currBgName ~= bgmName then
		--切换BGM		
		CSAPI.SetBGMLock(myBGMLockKey);
		CSAPI.PlayBGM(bgmName, nil, nil, myBGMLockKey);
		currBgName = bgmName
	end
end

--播放特效
function PlayEffect()
	local effectCfg = currentPlotData:GetEffectCfg();
	if effectCfg then
		local parent = effectLayer[effectCfg.layer];
		--加载特效
		ResUtil:CreateEffect(effectCfg.path, 0, 0, 0, parent);
		-- ResUtil:CreateEffect(effectCfg.path,0,0,0,parent,function(go)
		--设置粒子层级
		-- effectTimer=effectCfg.time or 3;
		-- end);
		table.insert(timers, effectCfg.time or 3);
	end
end

--播放模糊效果
function PlayBlur()
	local sBlur, eBlur, blurTime = currentPlotData:GetBlur()
	if blurTime > 0 then
		blur.Progress = sBlur / 100
		blurTimer = blurTime / 1000
		blurSpeed =((eBlur - sBlur) / blurTime) / 10 * 2
		table.insert(timers, blurTimer);
	end
end

--播放镜头动画
function PlayCameraTween(func)
	local cameraInfo = currentPlotData:GetCameraInfo();
	if cameraInfo then
		PlotTween.PlayCameraTween(childs, cameraInfo, func);
		local timer1 = cameraInfo.time1 or 0;
		local timer2 = cameraInfo.time2 or 0;
		local timer3 = cameraInfo.time3 or 0;
		table.insert(timers,(timer1 + timer2 + timer3));
	end
end

--显示图片内容
function ShowImgContent(imgPath, changeType, roleCB, boxCB)
	if changeType and changeType ~= ImgChangeType.None then
		isChangeBg = true
		if changeType == ImgChangeType.Fade then
			local plotID = currentPlotData:GetID()
			-- AnimStart()
			if isFirstChange then --首次切换
				PlotTween.FadeIn(bg, 0.25, nil, 0.25)
				PlotTween.FadeIn(ImgParent, 0.25, nil, 0.25)
				isFirstChange = false
			else
				PlotTween.Twinkle(ImgParent, 0.5)
				PlotTween.Twinkle(bg, 0.5)	
			end
			FuncUtil:Call(function()
				if(gameObject and not effectInfos[plotID].isJumpCG and currentPlotData) then
					CSAPI.SetGOActive(grayEffect, currentPlotData ~= nil and currentPlotData:IsGray() or false);
					SetBackGround(imgPath);
					if roleCB then
						roleCB()
					end
					if cgIndex + 1 > #cgList then
						cgIndex = - 1;
						cgList = nil;
						cgTimer = 0;
					else
						cgIndex = cgIndex + 1
					end
					effectInfos[plotID].isJumpCG = true
				end
			end, nil, 250)
			FuncUtil:Call(function()
				if(gameObject and (not effectInfos[plotID].isPlayBox) and currentPlotData) then
					isChangeBg = false
					if boxCB then
						boxCB()
					end
					effectInfos[plotID].isPlayBox = true
				end
			end, nil, 500)
		elseif changeType == ImgChangeType.Line then
			PlayLineTween(- 1, 1, 500, function()
				CSAPI.SetGOActive(grayEffect, currentPlotData:IsGray());
				SetBackGround(imgPath);
				if roleCB then
					roleCB()
				end
				PlayLineTween(1, - 1, 500, function()
					isChangeBg = false
					if boxCB then
						boxCB()
					end
				end);
				if cgIndex + 1 > #cgList then
					cgIndex = - 1;
					cgList = nil;
					cgTimer = 0;
				else
					cgIndex = cgIndex + 1
				end
			end);
		end
	else
		CSAPI.SetGOActive(grayEffect, currentPlotData:IsGray());
		SetBackGround(imgPath);
		if roleCB then
			roleCB()
		end
		if boxCB then
			boxCB()
		end
		if cgIndex + 1 > #cgList then
			cgIndex = - 1;
			cgList = nil;
			cgTimer = 0;
		else
			cgIndex = cgIndex + 1
		end
	end
end

--设置背景图
function SetBackGround(path)
	for _, val in pairs(PlotColorImg) do
		if val.type == path then
			isFind = true;
			bgImg.sprite = nil;
			CSAPI.SetImgColor(bg, val.color[1], val.color[2], val.color[3], val.color[4]);
			do return end
		end
	end
	ResUtil:LoadBigSR2ByExtend(bgModel, path, true, function()
		CSAPI.SetImgColor(bg, 255, 255, 255, 255);
	end);
end

--自适应背景 --以1920为标准进行等比缩放
function SetSelfAdaptionBG()
	local arr = CS.UIUtil.mainCanvasRectTransform.sizeDelta
	local offset = arr[0] / 1920
	CSAPI.SetScale(bgModel, offset, offset, offset)	
end

--播放文字内容
function PlayContent()	
	if(not currentPlotData) then
		return
	end
	--眨眼动画
	if currentPlotData:GetBlinkNum() ~= nil and currentPlotData:GetBlinkNum() > 0 and blinkNum == 0 then
		HideDialogBox()
		CSAPI.SetGOActive(effectEye, true)
		-- ComUtil.GetCom(effectEye, "CanvasGroup").alpha = 1
		SetBlink(currentPlotData:GetBlinkNum())
		return
	end
	
	local isHide = currentPlotData:IsHideBox();
	if(currentPlotData:GetContent() ~= nil or currentPlotData:IsLastContent() == true) and(isHide ~= true) then
		--播放对话框
		ShowContent();
	else
		HideDialogBox(isHide);
	end
end

--清理所有的立绘
function ClearImg(tween)
	for k, v in pairs(roleList) do
		if tween then
			v.SetOut(tween)
		end
		--播放退场动画
		v.PlayImgLeave();
		roleList[k] = nil;
	end
end

--更新立绘信息
function UpdateRoleImg(pInfos)	
	if(not currentPlotData) then
		return
	end
	--更新立绘视图数组数据
	-- Log( "PlotID:"..tostring(currentPlotData.cfg.id))
	-- Log( "立绘信息：");
	-- Log(pInfos)
	if pInfos ~= nil then
		--处理入场、移动、退场
		for k, v in ipairs(pInfos) do	
			local roleView = roleList[v.id];	
			if v.out and roleView then--退场
				roleView.SetImg(v);
				roleView.PlayImgLeave(v.time, nil, v.delay, isChangeBg); --当进行背景切换时出现退场直接退场
				-- roleView.PlayImgLeave(nil, v.delay)
				roleList[v.id] = nil;
				roleCount = roleCount - 1
			elseif v.move then--移动
				roleView.PlayImgMove(v.move, v.time);
			elseif v.pingPong then
				roleView.PlayImgMoveByPingPong(v.pingPong, v.time)
			elseif v.enter then--入场
				local isTalk = currentPlotData:IsTalkID(v.id);
				local posRoleView = GetRoleViewByPos(v.pos); --获取当前位置上的其他立绘
				local leaveFunc = nil;
				if roleView ~= nil and posRoleView ~= nil then--执行操作
					leaveFunc = function()
						roleView.SetImg(v);
						roleView.PlayImgMove(roleView.GetTargetPos(), v.time)
					end
				elseif roleView == nil and posRoleView ~= nil then
					roleView = CreateRoleImg(v);
					roleView.SetImg(v);
					roleView.SetImgState(isTalk);
					CSAPI.SetGOActive(roleView.gameObject, false);
					leaveFunc = function()
						--同一个位置上替换新的人物立绘
						CSAPI.SetGOActive(roleView.gameObject, true);
						roleView.PlayImgEntrance(v.time);
					end
					roleList[v.id] = roleView;
				elseif roleView ~= nil then
					roleView.SetImg(v);
					roleView.PlayImgMove(roleView.GetTargetPos(), v.time, nil, v.delay)
				else
					roleView = CreateRoleImg(v);
					roleView.SetImg(v);
					roleView.PlayImgEntrance(v.time, nil, v.delay);
					roleView.SetImgState(isTalk);
					roleList[v.id] = roleView;
					roleCount = roleCount + 1
				end
				if posRoleView then  --播放旧立绘退场之后再播放新立绘入场
					local oldId = posRoleView.data.id;
					roleList[oldId] = nil;
					posRoleView.PlayImgLeave(v.time, leaveFunc, v.delay);
				end				
			elseif v.black then --变色
				v.SetBlack(v.black, false);
			end
		end
	end
	--更新立绘队列表情
	if roleList then
		local hasMasks = currentPlotData:HasMask()
		for k, v in pairs(roleList) do
			local currFaceIDs = currentPlotData:GetFaceIDs()
			local currEmojis = currentPlotData:GetEmojiIDs()
			local currPos = v.GetPos()
			local index = - 1;
			-- local isTalk=currentPlotData:IsTalkID(v.data.id);
			local talkIds = currentPlotData:GetTalkID();
			if talkIds then
				for ix, id in ipairs(talkIds) do
					if v.data.id == id then
						index = ix;
						break;
					end
				end
			end
			v.SetImgState(index > 0);
			v.SetMask(hasMasks[currPos]>0); --设置遮罩
			v.SetFace(currFaceIDs[currPos])
			v.SetEmoji(currEmojis[currPos])
			-- if index > 0 then
			-- 	v.SetFace(currFaceIDs[index]);
			-- 	local emojiInfo = currEmojis[index];
			-- 	if emojiInfo then
			-- 		v.SetEmoji(emojiInfo[1], emojiInfo[2]);
			-- 	else
			-- 		v.SetEmoji();
			-- 	end
			-- else
			-- 	v.SetFace();
			-- 	v.SetEmoji();
			-- end
		end
	end
	--当前背景是否变暗
	-- if roleCount > 0 then
	-- 	CSAPI.csSetUIColorByTime(bgMask.gameObject, "action_UIColor_to_front", 0, 0, 0, 70, nil, 0.15, 0)
	-- else
	if(bgMask) then
		CSAPI.csSetUIColorByTime(bgMask.gameObject, "action_UIColor_to_front", 0, 0, 0, 0, nil, 0.15, 0)
	end
	-- end
end

--根据位置返回立绘面板对象
function GetRoleViewByPos(pos)
	if roleList then
		for k, v in pairs(roleList) do
			if v.data.pos == pos then
				return v;
			end
		end
	end
	return nil;
end

--新增人物立绘
function CreateRoleImg(roleImgInfo)
	local roleInfoView = nil;
	local go = ResUtil:CreateUIGO("Plot/PlotRole", ImgParent.transform);
	roleInfoView = ComUtil.GetLuaTable(go);
	return roleInfoView;
end

--对话显示完成时
function OnPlayOver()
	--更新表情
	-- if isAuto then
	-- boxPlayOver=true;
	-- FuncUtil:Call(function()
	-- 	if isJump~=true then
	-- 		PlayNext();
	-- 	end
	-- 	end,nil,300);
	-- PlayNext();
	-- end
end

--点击任意地方
function OnClickAnyway()		
	if isOpenTween then
		do return end
	end

	if isJump then
		do return end
	end

	if isPlotEnd then
		return 
	end
	
	if hideMode then--隐藏UI的情况下,退出隐藏模式
		SetHideMode(false);
		ContiuePlay();
		do return end
	end
	
	if(isAuto) then --退出自动播放
		OnClickAuto()		
		do return end
	end
	
	if(forceAutoTime) then --强制自动下无法操作特效和文字
		do return end
	end	
	
	if(FinshEffect()) then --跳过特效
		do return end
	end
	
	if not isAuto and not plotBox.IsTween() then		
		delayTimer = 0
		if IsPlayOver() then		
			local options = currentPlotData:GetOptions();
			if options ~= nil then
				plotBox.InitSelectObj(options)
			else
				-- 播放下一条对话
				PlayNext();		
			end				
		else
			--显示当前对话显示动画
			plotBox.JumpPlot();
		end
	end
end

--提前终止所有效果
function FinshEffect()	
	if(IsPlayOver()) then --已经播放完就不需要跳过特效
		return false
	end
	
	local isEffect = false
	local plotID = currentPlotData:GetID()
	
	if(PlotTween.IsTween()) then --动效		
		PlotTween.StopAllAction()
		isEffect = true
	end
	
	if(cgList) then --背景
		if(not effectInfos[plotID].isJumpCG) then			
			CSAPI.SetGOActive(grayEffect, currentPlotData:IsGray());
			SetBackGround(cgList[#cgList]);
			if cgCall then
				cgCall()
			end			
			cgIndex = - 1;
			cgList = nil;
			cgTimer = 0;
			anyWayObj.enabled = true;
			CSAPI.SetTimeScale(playPower[powerIndex])
			effectInfos[plotID].isJumpCG = true
			isEffect = true
		end
		if(not effectInfos[plotID].isPlayBox) then
			isCGPlay = false
			isChangeBg = false
			CSAPI.SetGOActive(boxParent, true)
			PlayContent();
			effectInfos[plotID].isPlayBox = true
			isEffect = true
		end
	end
	
	if(blurTimer > 0) then --模糊
		blur.Progress = blur.Progress + blurTimer * blurSpeed
		blurTimer = 0
		isEffect = true
	end	
	
	if(blinkNum > 0) then --眨眼
		PlayContent()
		blinkNum = 0
		CSAPI.SetGOActive(effectEye, false)
		effectInfos[plotID].isJumpBlink = true
		isEffect = true
	end	
	
	local shakeInfo = GetShakeInfo(currentPlotData.cfg.shakeInfos);
	if(shakeInfo) then --震动
		if(not effectInfos[plotID].isJumpShake) then
			lastShakeInfo = shakeInfo
			for i, v in ipairs(shakeInfo) do
				if v.time and v.time == - 1 then
					v.shakeObj.enabled = true;
					v.shakeObj.time = 9999000;
					if v.force then
						v.shakeObj.range = UnityEngine.Vector3(v.force[1], v.force[2], 0);
					end
					if v.interval then
						v.shakeObj.intervalTime = v.interval;
					end
					v.shakeObj:Play()
				end
			end
			effectInfos[plotID].isJumpShake = true
			isEffect = true
		end
	end
	
	if(currentPlotData:GetVideoInfo()) then --视频
		if(not effectInfos[plotID].isJumpVideo) then
			if plotVideo then
				plotVideo.SkipVideo()
			end
			effectInfos[plotID].isJumpVideo = true
			isEffect = true
		end
	end
	
	return isEffect
end

--播放下一条
function PlayNext()
	if(not isAuto) then
		plotBox.SetNextTween(false, true)
	end
	local tempData = currentPlotData:GetNextPlotInfo();
	if tempData ~= nil then
		currentPlotData = tempData;	
		PlayPlot();
	else
		PlotPlayOver();
	end	
end

--当选择剧情选项后
function OnSelectPlotOption(plot)
	isOptions = false
	if plot ~= nil then
		if(not isAuto) then
			plotBox.SetNextTween(false, true)
		end
		optionDic[currentPlotData:GetID()] = plot:GetID();
		currentPlotData = plot:GetNextPlotInfo();
		PlayPlot();
	else
		PlotPlayOver();
	end
end

--当前对话是否播放完毕
function IsPlayOver()
	local playOver = false;
	-- Log( "对话:"..tostring(plotBox.IsPlaying()).."\tEffect:"..effectTimer.."\tCg:"..cgIndex);
	if plotBox.IsPlaying() == false and delayTimer <= 0 and cgIndex == - 1 and isChangeBg == false then
		playOver = true;
	end
	return playOver;
end

function SetAutoLayout(isOn, isTween)
	autoDelay = g_PlotPlayInterval;
	if isTween then
		PlotTween.Twinkle(btn_auto, 0.05, function()
			CSAPI.SetText(txt_auto, isOn == true and LanguageMgr:GetByID(19003) or LanguageMgr:GetByID(19000));
		end)
	else
		CSAPI.SetText(txt_auto, isOn == true and LanguageMgr:GetByID(19003) or LanguageMgr:GetByID(19000));
	end	
end

--点击自动播放
function OnClickAuto()
	isAuto = not isAuto;
	SetAutoLayout(isAuto, true)
	-- CSAPI.LoadImg(autoIcon,isAuto==true and "UIs/Plot/stop.png" or "UIs/Plot/mobile.png",true,nil,true);
	-- CSAPI.SetGOActive(autoIcon,not isAuto)
	plotBox.SetNextTween(isAuto)
	PlayerPrefs.SetInt(GetAutoKey(), isAuto == true and 1 or 0);
	if IsPlayOver() and currentPlotData:CanJump() then
		-- FuncUtil:Call(PlayNext,nil,100);
		PlayNext();
	end
end

function SetPowerText(hasTween)
	CSAPI.SetTimeScale(playPower[powerIndex]);
	local powerStr = playPower[powerIndex] == 1 and 1 or 2
	if hasTween then
		PlotTween.Twinkle(btn_forward, 0.05, function()
			CSAPI.SetText(txt_forwardVal, "×" .. powerStr);
		end)		
	else
		CSAPI.SetText(txt_forwardVal, "×" .. powerStr);
	end
end

--点击加速
function OnClickForward()
	powerIndex = powerIndex >= #playPower and 1 or powerIndex + 1;
	SetPowerText(true);
	-- CSAPI.SetText(txt_forward,StringConstant.plot_forward..playPower[powerIndex]);
end

--点击跳过
function OnClickJump()
	if isJump or isOpenTween or isPlotEnd then
		return
	end
	isJump = true;
	isAuto = false
	SetAutoLayout(false)
	
	--隐藏按钮和对话框
	PlotTween.FadeOut(buttonChild)
	PlotTween.FadeOut(leftButton)
	PlotTween.FadeOut(boxParent)
	
	if storyData:GetDesc() ~= nil and storyData:GetDesc() ~= "" then
		ShowDescContent(true);
		-- CSAPI.ApplyAction(DescContent, "View_Open_Fade", nil);
	else
		CloseView();
	end
end

function PlayJumpBlur()
	blur.Progress = 0
	blurTimer = 0.25
	blurSpeed =(50 / 250) / 10 * 2
end

function OnClickSure()	
	-- 停止背景音效
	plotSound.StopAllSound();
	
	-- isJump = false
	lastFrameInfo = {};--清空记录
	RecordMgr:SaveCount(RecordMode.Count, RecordViews.PlotJump, storyData:GetID());	
	CSAPI.SetGOActive(blackMask, true)
	PlotTween.FadeIn(blackMask, nil, function()
		CloseView()
	end)
	BuryingPointMgr:TrackEvents("plot_dialogue", {reason = "跳过对话", plot_id = storyData:GetID()})
end

function OnClickCancel()
	isJump = false
	PlotTween.FadeIn(buttonChild)
	PlotTween.FadeIn(leftButton)
	PlotTween.FadeIn(boxParent)
	ShowDescContent(false)
end

--跳过剧情判定	------------------旧代码，对话、特效无法跳过-----------
-- function JumpPlot()
-- 	if currentPlotData:CanJump()==false then
-- 		return
-- 	end
-- 	local plotInfo = currentPlotData:GetNextPlotInfo();
-- 	if plotInfo == nil then --播放中断
-- 		PlotPlayOver();
-- 		return
-- 	end
-- 	local canJump = plotInfo:CanJump();
-- 	currentPlotData = plotInfo;
-- 	if canJump and plotInfo:GetNextPlotInfo() == nil then --跳跃完整段剧情
-- 		--显示剧情最后一帧的登场人物立绘、背景图片
-- 		-- ShowLastFrame();
-- 		if jumpRecord and jumpRecord.lastCGPath then
-- 			SetBackGround(jumpRecord.lastCGPath);
-- 		end
-- 		--显示剧情简介
-- 		ShowDescContent();
-- 	elseif canJump and plotInfo:GetNextPlotInfo() ~= nil then --还能跳
-- 		--继续跳     
-- 		RecordFrameInfo(plotInfo);
-- 		JumpPlot();
-- 	elseif canJump==false then --无法继续跳跃
-- 		--跳到不能调的剧情
-- 		ShowLastFrame();
-- 		PlayPlot();
-- 	end
-- end
--用于测试 跳到指定对话ID
function JumpToPlot(plotID)
	while(true) do
		local plotInfo = nil;
		if currentPlotData:GetNextPlotInfo() ~= nil then
			plotInfo = currentPlotData:GetNextPlotInfo();
		elseif currentPlotData:GetOptions() ~= nil then
			plotInfo = currentPlotData:GetOptions() [1]:GetNextPlotInfo();
		else
			LogError("播放完毕，没有找到指定对话ID");
			PlotPlayOver();
			return
		end
		if plotInfo:GetID() == plotID then
			currentPlotData = plotInfo;
			break
		else
			RecordFrameInfo(plotInfo);
			currentPlotData = plotInfo;
		end
	end
	ShowLastFrame();
	PlayPlot();
end

--记录帧信息
function RecordFrameInfo(plotInfo)
	jumpRecord = jumpRecord or {};
	--是否是灰色
	-- jumpRecord.isGray=currentPlotData:IsGray();
	--记录图片内容
	local cgList = currentPlotData:GetImgContents();
	if cgList ~= nil then--播放图片内容
		jumpRecord.lastCGPath = cgList[#cgList];
	end
	--记录对话内容
	jumpRecord.isLastContent = currentPlotData:IsLastContent();
	if jumpRecord.isLastContent ~= true then
		jumpRecord.content = currentPlotData:GetContent();
		jumpRecord.talkID = currentPlotData:GetTalkID();
	end
	--记录立绘信息
	local pInfos = currentPlotData:GetAllRoleInfos();
	if pInfos then
		jumpRecord.roles = jumpRecord.roles == nil and {} or jumpRecord.roles;
		jumpRecord.hasMask = currentPlotData:HasMask();
		--更新重新入场图片的位置
		for k, v in ipairs(pInfos) do
			if v.enter and jumpRecord.roles[v.id] then
				local roleImgInfo = RoleImgInfo.New();
				roleImgInfo:InitCfg(v.id);
				local posList = roleImgInfo:GetRoleImgPos();
				local pos = {0, 0};
				if posList and posList[v.pos] then
					pos = {posList[v.pos] [1], posList[v.pos] [2]};
				end
				jumpRecord.roles[v.id] = {
					id = v.id,
					pos = v.pos,
					realPos = pos,
					black = v.black;
				}
			end
		end
		--更新要显示的图片缓存
		for k, v in ipairs(pInfos) do
			if v.out then
				jumpRecord.roles[v.id] = nil;
			elseif v.enter then
				local roleImgInfo = RoleImgInfo.New();
				roleImgInfo:InitCfg(v.id);
				local posList = roleImgInfo:GetRoleImgPos();
				local pos = {0, 0};
				if posList and posList[v.pos] then
					pos = {posList[v.pos] [1], posList[v.pos] [2]};
				end
				if jumpRecord and jumpRecord.roles then --剔除相同位置上的立绘
					local removeId = nil;
					for _, imgInfo in pairs(jumpRecord.roles) do
						if imgInfo.pos == v.pos then
							removeId = imgInfo.id;
							break;
						end
					end
					if removeId then
						jumpRecord.roles[removeId] = nil;
					end
				end
				jumpRecord.roles[v.id] = {
					id = v.id,
					pos = v.pos,
					realPos = pos,
					black = v.black;
				};
			elseif v.move then
				jumpRecord.roles[v.id].pos = v.move;
			elseif v.black then
				jumpRecord.roles[v.id].black = v.black;
			end
			-- if v.header then --表情
			-- 	jumpRecord.roles[v.id].header = v.header
			-- end
			-- if v.emoji then --气泡
			-- 	jumpRecord.roles[v.id].emoji = v.emoji
			-- 	jumpRecord.roles[v.id].emojiPos = v.emojiPos or 1
			-- end
		end
	end
end

--显示最后一帧的信息
function ShowLastFrame()
	if jumpRecord then
		--显示背景图
		if jumpRecord.lastCGPath then
			SetBackGround(jumpRecord.lastCGPath);
		end
		if jumpRecord.roles then
			--显示立绘
			for k, v in pairs(jumpRecord.roles) do
				local roleImg = roleList[v.id];
				local isTalk = false;
				if jumpRecord.talkID then
					for _, tID in ipairs(jumpRecord.talkID) do
						if v.id == tID then
							isTalk = true;
							break;
						end
					end
				end
				local posRoleView = GetRoleViewByPos(v.pos); --获取当前位置上的其他立绘
				if posRoleView then  --播放旧立绘退场
					local oldId = posRoleView.data.id;
					roleList[oldId] = nil;
					posRoleView.PlayImgLeave();
				end
				if roleImg == nil then--新立绘入场
					roleImg = CreateRoleImg(v);
					roleImg.SetImg(v);
					roleList[v.id] = roleImg;
					CSAPI.SetLocalPos(roleImg.gameObject, v.realPos[1], v.realPos[2], 0);
					
				end
				roleImg.SetImgState(isTalk);
				local currPos = roleImg:GetPos()
				roleImg.SetMask(jumpRecord.hasMask[currPos]>0);
			end
		end
	end
	jumpRecord = nil;
end

--返回震动信息
function GetShakeInfo(shakeInfo)
	local tab = nil;
	if shakeInfo then
		tab = {};
		for k, v in ipairs(shakeInfo) do
			local info = {};
			info.type = v.type;
			info.shakeObj = shakeObjs[v.type];
			info.time = v.time;
			info.force = v.force;
			info.interval = v.interval;
			table.insert(tab, info);
		end
	end
	return tab;
end

--播放百叶窗动画
function PlayLineTween(starVal, endVal, time, callBack)
	if lineTween then
		isLine = true;
		lineTween:Play(starVal, endVal, time, callBack);
	end
end

function PausePlay()
	isTimeStop = true
	CSAPI.SetTimeScale(0);
end

function ContiuePlay()
	isTimeStop = false
	CSAPI.SetTimeScale(playPower[powerIndex]);
end

function OnCloseDelay(delay)
	closeDelayTime = delay;
	--LogError(delay);
end
function CloseView()
	if not gameObject then
		return
	end

	TryCallBack();
	
	if(closeDelayTime) then
		local delay = closeDelayTime;
		closeDelayTime = nil;
		FuncUtil:Call(CloseView, nil, delay);
		return;
	end
		
	--停止音效
	plotSound.StopAllSound();
	--CSAPI.StopBGM()
    EventMgr.Dispatch(EventType.Replay_BGM, 50);
	PlotTween.StopAllAction()
	
	CSAPI.SetGOActive(bgModel, false)
	CSAPI.SetGOActive(blackMask, false);
	if(not IsNil(view)) then
		view:Close();
	end
end

function OnViewClosed(viewKey)
	if viewKey == "PlotStory" then
		ContiuePlay();
	end
end

function OnClickStory()
	if(isCGPlay) then return end
	--暂停播放
	PausePlay();
	--显示已完的对话
	CSAPI.OpenView("PlotStory", {story = storyData, currPlot = currentPlotData, options = optionDic})
end

function OnClickHide()
	if(isCGPlay) then return end
	--暂停播放
	PausePlay();
	--隐藏按钮和对话框
	SetHideMode(true);
end

--隐藏UI
function SetHideMode(isHide)
	if hideMode then--隐藏UI的情况下,退出隐藏模式
		hideMode = false
		ContiuePlay();
	else
		hideMode = isHide;
	end
	local time = 0.1
	CSAPI.SetGOActive(hideMask, hideMode)
	if hideMode then
		PlotTween.FadeIn(leftButton, time)
		PlotTween.FadeIn(boxParent, time)
		PlotTween.FadeIn(hideImg, time)
		PlotTween.FadeIn(buttonChild, time)
		PlotTween.FadeIn(shakes, time)
		PlotTween.FadeIn(lineObj, time)
	end
end

-----------------------------------动画-------------------------
function AnimStart()
	if not UIMask then
		UIMask = CSAPI.GetGlobalGO("UIClickMask")
	end
	CSAPI.SetGOActive(UIMask, true)
end

function AnimEnd()
	CSAPI.SetGOActive(UIMask, false)
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	effCamera = nil;
	bgCamera = nil;
	bgModel = nil;
	bgBlackModel = nil;
	childs = nil;
	bg = nil;
	bgMask = nil;
	bottomParent = nil;
	ImgParent = nil;
	lineObj = nil;
	boxParent = nil;
	topParent = nil;
	grayEffect = nil;
	effectEye = nil;
	blinkFadeIn = nil;
	blinkFadeOut = nil;
	buttonChild = nil;
	btn_auto = nil;
	txt_auto = nil;
	autoIcon = nil;
	btn_forward = nil;
	txt_forward = nil;
	txt_forwardVal = nil;
	btn_jump = nil;
	txt_jump = nil;
	img = nil;
	hideMask = nil;
	leftButton = nil;
	hideImg = nil;
	DescContent = nil;
	DescText = nil;
	txt_confirm = nil;
	shakes = nil;
	effectParent = nil;
	bg_fade = nil;
	line_fade = nil;
	img_fade = nil;
	node_fade = nil;
	box_fade = nil;
	view = nil;
end
----#End#----
