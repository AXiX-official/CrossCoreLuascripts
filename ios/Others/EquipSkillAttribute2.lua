--装备技能
local cfg=nil;
local pList={};

function Awake()
    if points then
        pList=ComUtil.GetComsInChildren(points,"Image");
    end
end

--isUp:1：绿色,2:红色，nil不显示
function Refresh(skillCfg,isUp)
    cfg=skillCfg;
    --设置技能框颜色
    if skillCfg then
        CSAPI.SetGOActive(root,true);
        CSAPI.SetGOActive(nullObj,false);
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
    else
        InitNull();
    end
    if isUp==1 then
        CSAPI.LoadImg(arrow,"UIs/EquipInfo/img_30_01.png",true,nil,true);
    else
        CSAPI.LoadImg(arrow,"UIs/EquipInfo/img_30_02.png",true,nil,true);
    end
    CSAPI.SetGOActive(arrow,isUp~=nil);
end

function InitNull()
    CSAPI.SetGOActive(root,false);
    CSAPI.SetGOActive(nullObj,true);
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