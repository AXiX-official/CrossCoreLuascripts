--剧情对话框
--播放文字效果参数
local isPlaying = false; --文字是否播放完
local isTween = false;--是否正在播放窗口动画
-- local playSpeed = 3;--文字播放速度
local playSpeed = 0.02;--文字播放速度，值越小越快
-- local lastIndex = 1;--计时器
local plotOptionObj;--对话选项
local plotContent = nil
local isLastCenter = false
local currentPlotData;
local text_roleName1;  --角色名称控件
local text_roleName2;  --角色名称控件

local onPlotOver;--当字幕播放完成时

local isFirst = true;
local roleInfos = nil

local fade1 = nil --标题动画控件
local fade2 = nil --标题动画控件
local isMove = false --标题是否移动

function Awake()
	plotContent = PlotContent1
	text_roleName1 = ComUtil.GetCom(PlotTitle1, "Text");
	text_roleName2 = ComUtil.GetCom(PlotTitle2, "Text");
	fade1 = ComUtil.GetCom(titleFade1, "ActionFade");
	fade2 = ComUtil.GetCom(titleFade2, "ActionFade");
end

function OnEnable()
	isTween = true;
	isFirst = true;
end

function OnDisable()
	CSAPI.SetText(plotContent, "")
	text_roleName1.text = ""
	text_roleName2.text = ""	
	isPlaying = false;
	isTween = false;
end

function OnDestroy()
	currentPlotData = nil;
	plotOptionObj = nil;
	onPlotOver = nil;
	ReleaseCSComRefs()
end

function IsPlaying()
	return isPlaying;
end

function IsTween()
	return isTween;
end

function ShowBox(data, isAuto)	
	if data:IsLastContent() == false then
		currentPlotData = data;
		CSAPI.SetGOActive(gameObject, true);
		-- CSAPI.SetGOActive(moveObj, false)
		CSAPI.SetGOActive(centerObj, currentPlotData:IsCenter())
		CSAPI.SetGOActive(bottomObj, not currentPlotData:IsCenter())		
		-- CSAPI.SetGOActive(childNode, not currentPlotData:IsCenter())
		if currentPlotData:IsCenter() then
			PlotTween.FadeIn(centerObj)
		end
		plotContent = currentPlotData:IsCenter() and PlotContent2 or PlotContent1
		local talkName = currentPlotData:GetTalkName();		
		if talkName == nil or talkName == "" then
			CSAPI.SetGOActive(titleObj, false);
		else
			SetTitlePos(currentPlotData)
			CSAPI.SetGOActive(titleObj, true);
		end
		-- CSAPI.SetGOActive(iconObj, false)
		CSAPI.SetGOActive(iconObj, currentPlotData:GetShowIcon());
		if currentPlotData:GetShowIcon() then
			--获取配置表头像
			if currentPlotData:IsLeader() then
				ResUtil.RoleCard:Load(icon, PlayerClient:GetIconName(), true);
			else
				local talkInfo = currentPlotData:GetTalkInfo();
				ResUtil.RoleCard:Load(icon, talkInfo:GetIcon(), true);
			end
		end
		-- lastIndex=1;
		-- fIndex=1;
		tagInfo = {};--记录当前字符串的标签信息
		for s in string.gmatch(data:GetContent(), "<[%p%w]->") do
			table.insert(tagInfo, s);
		end
		if isTween then
			PlotTween.FadeIn(childNode, nil, function()
				isPlaying = true;
				isTween = false;
				PlayPlot()
				isLastCenter = currentPlotData:IsCenter()
			end);
		else
			isPlaying = true;
			PlayPlot()
			isLastCenter = currentPlotData:IsCenter()
		end

		SetNextTween(isAuto)
	end
end

function HideBox(isTween)
	if isTween and gameObject.activeSelf == true then
		PlotTween.FadeOut(childNode, nil, function()
			isTween = false;
			CSAPI.SetGOActive(gameObject, false);
		end);
	else
		-- CSAPI.SetScale(gameObject,0,0,0);
		CSAPI.SetGOActive(gameObject, false);
	end
end

--初始化选项
function InitSelectObj(info)
	if plotOptionObj == nil then
		local go = ResUtil:CreateUIGO("Plot/PlotOption", view.myParent);
		plotOptionObj = ComUtil.GetLuaTable(go);
	else
		CSAPI.SetGOActive(plotOptionObj.gameObject, true);
	end
	CSAPI.SetGOActive(gameObject,false)
	plotOptionObj.InitView(info);
end

--跳过对话输出
function JumpPlot()
	CSAPI.ApplyTextTweenFull(plotContent);
end

function PlayPlot()
	-- if isLastCenter and currentPlotData:IsCenter() then
	-- 	MoveUpAndFadeOut(plotContent.gameObject, 0.5, function()
	-- 		PlayPlotContent()
	-- 	end, 0, 95, 20)
	-- else
	-- 	PlayPlotContent()
	-- end
	PlayPlotContent()
end

function PlayPlotContent()
	if currentPlotData:IsLastContent() == false then
		local textContent = currentPlotData:GetContent();
		CSAPI.ApplyTextTween(plotContent, textContent, playSpeed, PlayFullPolt);
	else
		isPlaying = false;
		OnPlotOver();
	end
end

--播放完的回调
function PlayFullPolt()
	-- text_content.text=currentPlotData:GetContent().." ";
	if isPlaying then
		isPlaying = false;
		-- lastIndex=1;
		-- local options = currentPlotData:GetOptions();
		-- if options ~= nil then
		-- 	InitSelectObj(options);--初始化选项
		-- else
			OnPlotOver();
		-- end
	end
end

function PlayOut()
	CSAPI.ApplyAction(plotContent, "action_text_exit");
end

function SetOnPlotOver(func)
	if func ~= nil then
		onPlotOver = func;
	end
end

--剧情播放完成时
function OnPlotOver()
	if onPlotOver ~= nil then
		onPlotOver();
	end
end

--标题左右
function SetTitlePos(data)
	local isRight = false
	roleInfos = roleInfos or {}
	
	local dataInfos = data:GetRoleInfos()
	if dataInfos ~= nil and #dataInfos > 0 then
		for _, v in ipairs(dataInfos) do
			roleInfos[v.id] = v.pos
		end
	end
	
	local id = data:GetTalkID()
	if roleInfos and id then
		if roleInfos[id[1]] and roleInfos[id[1]] == 3 then
			isRight = true
		end								
	end
	
	-- local title = isRight and imgTitle2 or imgTitle1
	-- local txtRole = isRight and text_roleName2 or text_roleName1
	-- local fade = isRight and fade1 or fade2
	-- local otherFade = not isRight and fade1 or fade2
	local title = imgTitle1
	local txtRole = text_roleName1
	local fade = fade1
	local otherFade = fade2
	
	
	-- if(isMove ~= isRight) then
	-- 	fade:Play(1, 0, 333, 0, function()
	-- 		txtRole.text = currentPlotData:GetTalkName();
	-- 		CSAPI.SetText(text_title2,currentPlotData:GetTalkEnName())
	-- 		otherFade:Play(0, 1, 333)
	-- 	end)	
	-- 	isMove = isRight
	-- else
	txtRole.text = currentPlotData:GetTalkName();	
	CSAPI.SetText(text_title2, currentPlotData:GetTalkEnName())		
	-- end
end

--移动渐出
function MoveUpAndFadeOut(go, _time, callBack, _delay, startY, offsetY)
	CSAPI.MoveTo(go, "UI_Local_Move", 0, startY + offsetY, 0, function()
		CSAPI.SetAnchor(go, 0, startY)
	end, _time, _delay)
	PlotTween.FadeOut(go, _time, function()
		PlotTween.FadeIn(go)
		if callBack then
			callBack()
		end
	end, _delay)
end

--设置NEXT动画
function SetNextTween(isAuto, isClick)
	CSAPI.SetGOActive(nextTween, isAuto)	
	if(not isAuto) then
		CSAPI.SetLocalPos(moveObj, 0, 0)		
		if(isClick) then
			PlotTween.TweenMoveByPingPong2(moveObj, {0, 13}, 0.1)
		end
	end	
	-- if not nextFade then
	-- 	nextFade = ComUtil.GetCom(nextTween, "ActionFade")
	-- end
	-- if not nextMove then
	-- 	nextMove = ComUtil.GetCom(nextTween, "ActionMoveByCurve")
	-- end
	-- if state then		
	-- 	CSAPI.SetGOActive(moveObj, true)
	-- 	nextFade.delayValue = 0
	-- 	nextFade:Play(0, 1, 400, 0)
	-- else
	-- 	--CSAPI.SetGOActive(nextTween, true)
	-- 	nextFade.delayValue = 1
	-- 	nextFade:Play(1, 0, 400, 0)
	-- end
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	childNode = nil;
	bottomObj = nil;
	PlotContent1 = nil;
	moveObj = nil;
	nextObj1 = nil;
	titleObj = nil;
	imgTitle1 = nil;
	PlotTitle1 = nil;
	text_title2 = nil;
	imgTitle2 = nil;
	PlotTitle2 = nil;
	centerObj = nil;
	PlotContent2 = nil;
	iconObj = nil;
	icon = nil;
	titleFade1 = nil;
	titleFade2 = nil;
	nextTween = nil;
	view = nil;
end
----#End#----
