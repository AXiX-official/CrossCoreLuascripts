--战前编队格子
local clicker=nil
local isDisable=false;
local data=nil;
local cb=nil;
function Awake()
    clicker=ComUtil.GetCom(clickImg,"Image");
end

--data: teamItemData:上阵的队员信息
function Refresh(d,index)
    InitNull();
    data=d;
    if data then
        CSAPI.SetGOActive(gridNode,true);
        CSAPI.SetGOActive(nilObj,false);
        CSAPI.SetGOActive(disObj,false);
        CSAPI.SetGOActive(node,true);
        SetTagObj();
        SetName(data:GetName());
        SetLv(data:GetLv());
        SetIcon(data:GetSmallImg());
        SetQuality(data:GetQuality());
        -- SetAssist(data:IsAssist())
    -- elseif index==6 then
    --     SetAssist(true)
    end
    if index==6 then
        SetAssist(not isDisable)
    end
end

function SetName(name)
    CSAPI.SetText(txt_name,name or "");
end

-- function SetIndex(index)
--     CSAPI.LoadImg(indexImg,"UIs/TeamConfirm/img_9_0"..tostring(index)..".png",true,nil,true);
-- end

function SetLv(lv)
    CSAPI.SetText(txt_lv,tostring(lv) or "")
end

function SetIcon(iconName)
    if iconName then
        CSAPI.SetGOActive(icon,true);
        ResUtil.Card:Load(icon,iconName);
    else
        CSAPI.SetGOActive(icon,false);
    end
end

function SetQuality(_quality)
    local q1=_quality or 3
    local q2=_quality or 1;
    local name= "btn_1_0"..tostring(q1);
    local bName="btn_b_1_0"..tostring(q2)
    ResUtil.CardBorder:Load(tagObj,name);
    ResUtil.CardBorder:Load(border,bName);
end

function SetAssist(isShow)
    CSAPI.SetGOActive(txt_assist,isShow)
    CSAPI.SetGOActive(assistObj,isShow);
end

function SetTagObj()
    if data then     
		CSAPI.SetGOActive(tagObj,true);
		if data:IsNPC() then
			CSAPI.SetText(txt_tag,LanguageMgr:GetByID(26005));
            CSAPI.SetGOActive(txt_tag,true)
		elseif data:IsLeader() then
			CSAPI.SetText(txt_tag,LanguageMgr:GetByID(26007));
            CSAPI.SetGOActive(txt_tag,true)
		else
			CSAPI.SetGOActive(txt_tag,false)
		end
	else
		CSAPI.SetGOActive(tagObj,false);
	end
end

function SetPos(pos)
    CSAPI.SetAnchor(gameObject,pos[1],pos[2]);
end

function OnClickSelf()
    if cb then
        cb(this);
    end
end

function SetClick(canClick)
    clicker.raycastTarget=canClick;
    local imgName=canClick==true and "btn_3_04" or "btn_1_061"
    ResUtil.CardBorder:Load(nilObj,imgName);
end

--设置禁用
function SetDisable(_isDisable)
    isDisable=_isDisable;
    InitNull();
end

function InitNull()
    data=nil;
    SetQuality();
    CSAPI.SetGOActive(nilObj,not isDisable);
    CSAPI.SetGOActive(disObj,isDisable);
    CSAPI.SetGOActive(node,false);
    CSAPI.SetGOActive(disObj,isDisable);
    CSAPI.SetGOActive(tipsObj,false);
    SetClick(not isDisable);
end

function SetCB(_cb)
    cb=_cb
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
border=nil;
nilObj=nil;
disObj=nil;
node=nil;
icon=nil;
txt_lvTips=nil;
txt_lv=nil;
txt_name=nil;
tagObj=nil;
txt_tag=nil;
txt_hot=nil;
tipsObj=nil;
txt_tips=nil;
tipsIcon=nil;
clickImg=nil;
view=nil;
end
----#End#----