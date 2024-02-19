--装备信息物体
local baseItems={};
local skillItems={};
local grid=nil;
function Refresh(_data)
    data=_data;
    if data and data:GetClassType()=="EquipData" then
        CSAPI.SetGOActive(gridNode,true);
        CSAPI.SetGOActive(lockBtn,true);
        CSAPI.SetText(txt_name,data:GetName());
        if grid==nil then
            ResUtil:CreateUIGOAsync("Grid/EquipItem",gridNode,function(go)
                grid=ComUtil.GetLuaTable(go);
                grid.Refresh(data);
            end)
        else
            grid.Refresh(data);
        end
        ShowBase();
        ShowSkill();
    else
        CSAPI.SetText(txt_name,"");
        CSAPI.SetGOActive(gridNode,false);
        CSAPI.SetGOActive(lockBtn,false);
        ItemUtil.AddItems("AttributeNew2/AttributeItemLittle",baseItems,{},attrNode,nil,1);
        ItemUtil.AddItems("AttributeNew2/AttributeItemLittle",skillItems,{},skillNode,nil,1);
    end
end

function ShowBase()
    local list={};
    for i=1,g_EquipMaxAttrNum do
        local id,add,upAdd=data:GetBaseAddInfo(i);
        if id and add and upAdd then
            local addition=add+upAdd*data:GetLv();
            local text="+"..EquipCommon.FormatAddtion(id,addition);
            table.insert(list,{id=id,val1=text});
        end
    end
    ItemUtil.AddItems("AttributeNew2/AttributeItemLittle",baseItems,list,attrNode,nil,1);
end

function ShowSkill()
    local list={};
    if data then
        local index=0;
        for i=1,g_EquipMaxSkillNum do
            local cfg=data:GetSkillInfo(i);
            if cfg then
                if index<=g_EquipMaxSkillNum then
                    local lvStr = LanguageMgr:GetByID(1033) or "LV."
                    table.insert(list,{id=cfg.group,val1=lvStr..cfg.nLv,type=2,alpha=204,val1Color="FFC146"});
                    index=index+1;
                else
                    LogError("技能数量超过上限！！");
                end
            end       
        end
    end
    ItemUtil.AddItems("AttributeNew2/AttributeItemLittle",skillItems,list,skillNode,nil,1);
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
gridNode=nil;
lockBtn=nil;
lockIcon=nil;
lockIcon2=nil;
txt_lock=nil;
txt_name=nil;
attrNode=nil;
skillNode=nil;
view=nil;
end
----#End#----