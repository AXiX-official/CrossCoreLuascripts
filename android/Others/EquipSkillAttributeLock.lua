--装备技能
local cfg=nil;
local pList={};
local isLock=false;
local clicker=nil;
local exColor=nil;
function Awake()
    if points then
        pList=ComUtil.GetComsInChildren(points,"Image");
    end
    clicker=ComUtil.GetCom(btnLock,"Image");
end

--isLock
function Refresh(skillCfg,elseData)
    cfg=skillCfg;
    isLock=false
    if elseData and elseData.lockSkills and cfg then
        for k,v in ipairs(elseData.lockSkills) do
            if cfg.id==v then
                isLock=true;
                break;
            end
        end
    end
    exColor=nil;
    if elseData and elseData.changeIDs and cfg then
        for k,v in ipairs(elseData.changeIDs) do
            if cfg.id==v then
                exColor="00ffbf"
                break;
            end
        end
    end
    if elseData and elseData.disClicker==true then
        clicker.raycastTarget=false
    else
        clicker.raycastTarget=true
    end
    --设置技能框颜色
    if skillCfg then
        CSAPI.SetGOActive(root,true);
        CSAPI.SetGOActive(nullObj,false);
        CSAPI.SetGOActive(btnLock,skillCfg.id<20000)
        SetBorderColor(skillCfg.nQuality);
        --设置图标
        -- CSAPI.SetGOActive(icon,true);
        ResUtil.EquipSkillIcon:Load(icon,skillCfg.group,false);
        CSAPI.SetScale(icon,1,1,1);
        CSAPI.SetRTSize(icon,44,44);
        --设置名称描述
        CSAPI.SetText(txt_Name,skillCfg.sName);
        CSAPI.SetText(txt_lvVal,tostring(skillCfg.nLv));
        if points then
            local cfgs=Cfgs.CfgEquipSkill:GetGroup(skillCfg.group);
            for i=0,pList.Length-1 do
                local go=pList[i].gameObject;
                CSAPI.SetGOActive(go,i+1<=#cfgs);
                if i<=skillCfg.nLv-1 then
                    CSAPI.SetImgColor(go,255,193,70,255);
                else
                    CSAPI.SetImgColor(go,255,255,255,76);
                end
            end
        end
        SetLockIcon()
    else
        InitNull();
    end
    CSAPI.SetGOActive(arrow,isUp~=nil);
end

function InitNull()
    SetBorderColor();
    CSAPI.SetGOActive(root,false);
    CSAPI.SetGOActive(nullObj,true);
    CSAPI.SetGOActive(btnLock,false)
end

function SetBorderColor(colorID)
    -- local color=Cfgs.CfgUIColorEnum:GetByID(colorID or 1);
    colorID=colorID or 1;
    local color=colorID==1 and {r=255,g=255,b=255,a=255} or {r=255,g=193,b=70,a=255}
    CSAPI.SetImgColor(border,color.r,color.g,color.b,color.a,false);
    if colorID==1 then
        CSAPI.SetTextColorByCode(txt_Name,exColor and exColor or "c3c3c8");
        CSAPI.SetTextColorByCode(txt_Lv,"c3c3c8",false);
        CSAPI.SetImgColor(line,15,15,25,255);
    else
        CSAPI.SetTextColorByCode(txt_Name,exColor and exColor or "0f0f19");
        CSAPI.SetTextColorByCode(txt_Lv,"0f0f19",false);
        CSAPI.SetImgColor(line,color.r,color.g,color.b,color.a,false);
    end
end

function SetClickCB(call)
    this.call=call;
end

function OnClickDetails()
    if this.call then
        this.call(cfg);
    end
end

function OnClickSelf()
    if this.call then
        this.call(cfg);
    end
end

function OnClickLock()
    if cfg then
        isLock=not isLock
        EventMgr.Dispatch(EventType.Equip_Lock_Attribute,{id=cfg.id,isLock=isLock});
        SetLockIcon()
    end
end

function SetLockIcon()
    CSAPI.LoadImg(lockImg,string.format("UIs/EquipInfo/%s.png",isLock and "img_07_02" or "img_07_03"),true,nil,true);
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
root=nil;
icon=nil;
txt_Name=nil;
txt_Lv=nil;
txt_lvVal=nil;
border=nil;
pList=nil;
points=nil;
line=nil;
view=nil;
end
----#End#----