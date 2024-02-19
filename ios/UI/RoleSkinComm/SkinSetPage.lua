--皮肤合集子物体
local list=nil;
local elseData=nil;
local items={}; --子物体
local delay=0;
local tweens=nil;
local index=0;
function Awake()
    tweens=ComUtil.GetComsInChildren(tweenObj,"ActionBase");
end

function Refresh(_d,_elseData)
    list=_d or {};
    elseData=_elseData;
    ItemUtil.AddItems("RoleSkinComm/SkinInfoItem", items, list, layout,OnClickItem,1,{flag=elseData.flag},function()
        SetDelay(index);
    end)
    if #list>=1 then
        if not _elseData.isAll then--否则显示该系列所有皮肤
            local cfg=list[1]:GetSetCfg();
            CSAPI.SetText(txt_title,cfg.name);
            CSAPI.SetText(txt_desc,cfg.story);
            CSAPI.SetGOActive(txt_tips,false);
            CSAPI.SetGOActive(txt_sort,false);
            CSAPI.SetGOActive(txt_desc,true)
        else--合集分期数
            local cfg=list[1]:GetSeasonCfg();
            CSAPI.SetGOActive(txt_tips,true);
            CSAPI.SetGOActive(txt_sort,true);
            CSAPI.SetGOActive(txt_desc,false)
            --设置标题
            CSAPI.SetText(txt_title,LanguageMgr:GetByID(cfg.LanguageID));
            CSAPI.SetText(txt_tips,LanguageMgr:GetByType(cfg.LanguageID,4));
            CSAPI.SetText(txt_sort,LanguageMgr:GetByID(cfg.LanguageID2));
        end
    end
end

function OnClickItem(tab)
    --打开详情界面
    CSAPI.OpenView("SkinFullInfo",{list=list,idx=tab.GetIndex()});
end

function SetDelay(idx)
    if tweens then
        for i=0,tweens.Length-1 do 
            local v=tweens[i]
            v.delay=(idx-1)*100;
            v:Play();
        end
    end
end

function SetIndex(idx)
    index=idx;
end