
-- data={
--     id,  --属性的id，对应CfgCardPropertyEnum表中的id
--     val1, --显示的第一个数字
--     val2, --显示的第二个数字
--     val3，--显示的第二个中文 （val2 数字，val3 中文）
--     val1Color, --不设置默认为FFFFFF
--     val2Color, --不设置默认为1CFF7C
--     nobg,      --默认为false 
--	   nobg2,--默认为false，当存在背景图时，设置背景图是否显示
-- } 
local isLock=false;
local cfg=nil;
local clicker=nil;

function Awake()
    clicker=ComUtil.GetCom(btnLock,"Image");
end

function Refresh(_data,_elseData)
	data = _data
	elseData=_elseData
	if elseData and elseData.isLockBase then
		isLock=elseData.isLockBase;
	else
		isLock=false;
    end
    if elseData and elseData.disClicker==true then
        clicker.raycastTarget=false
    else
        clicker.raycastTarget=true
    end
	if elseData and elseData.isChangeSlot==true then
		CSAPI.SetTextColorByCode(txtName,"00ffbf");
    else
		CSAPI.SetTextColorByCode(txtName,"ffffff");
    end
	val1Color = data.val1Color and data.val1Color or "929296"
	val2Color = data.val2Color and data.val2Color or "00ffbf"
	val3Color = data.val3Color and data.val3Color or "00ffbf"
	CSAPI.SetGOActive(val1, data.val1 ~= nil)
	CSAPI.SetGOActive(val2, data.val2 ~= nil)
	CSAPI.SetGOActive(val3, data.val3 ~= nil)
	
	cfg = Cfgs.CfgCardPropertyEnum:GetByID(data.id)
	
	--icon
	local iconName = data.nobg and string.format("UIs/AttributeNew2/%s_1.png", data.id) or string.format("UIs/AttributeNew2/%s.png", data.id)
	if bg then--存在背景图片时
		CSAPI.SetGOActive(bg,not data.nobg2);
	end
	CSAPI.LoadImg(icon, iconName, true, nil, true)
	
	--name
	SetName(cfg.sName);
	
	local str1 = ""
	local str2 = ""
	local str3 = ""
	--val1
	if(cfg.sFieldName == "career") then
		if(data.val1) then
			str3 = StringUtil:SetByColor(data.val1, val1Color)
		end
	else
		if(data.val1) then
			str1 = StringUtil:SetByColor(data.val1, val1Color)
		end
	end
	--val2
	if(data.val2) then
		str2 = StringUtil:SetByColor(data.val2, val2Color)
	end
	--val3
	-- if(data.val3) then
	-- 	str2_2 = StringUtil:SetByColor(data.val3, val3Color)
	-- end
	SetVal1(str1);
	SetVal2(str2);
	SetVal2_2(data.val3);
	SetValStr(str3);
	
	--arrow
	if(arrow) then
		CSAPI.SetGOActive(arrow, str3 == "" and str2 ~= "")
	end
    SetLockIcon();
end

function SetName(str)
	CSAPI.SetText(txtName, str == nil and "" or str)
end

function SetVal1(str)
	CSAPI.SetText(val1, str == nil and "" or str)
end

function SetVal2(str)
	CSAPI.SetText(val2, str == nil and "" or str)
end
function SetVal2_2(str)
	local b = StringUtil:IsEmpty(str)
	CSAPI.SetGOActive(val3, not b)
	if(not b) then
		local s = StringUtil:SetByColor(str, val3Color)
		CSAPI.SetText(val3, s)
	end
end

function SetValStr(str)
	CSAPI.SetText(valStr, str == nil and "" or str)
end
function OnDestroy()	
	ReleaseCSComRefs();
end

function OnClickLock()
    if cfg then
        isLock=not isLock
        EventMgr.Dispatch(EventType.Equip_Lock_Attribute,{id=cfg.id,isLock=isLock,isBase=true});
        SetLockIcon();
    end
end

function SetLockIcon()
    CSAPI.LoadImg(lockImg,string.format("UIs/AttributeNew2/%s.png",isLock and "img_07_02" or "img_07_03"),true,nil,true);
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	icon = nil;
	txtName = nil;
	val1 = nil;
	val2 = nil;
	val3 = nil;
	valStr = nil;
	view = nil;
end
----#End#----
