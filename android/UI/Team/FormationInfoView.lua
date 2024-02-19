--编队详情UI
local leaderClick=nil;
local descTxts={}
local data=nil;
function Awake()
    leaderClick=ComUtil.GetCom(btnLeader,"Image");
    if topRoot~=nil then
        upTween = ComUtil.GetCom(txt_topAddVal, "ActionNumberRunner");
        downTween = ComUtil.GetCom(txt_downAddVal, "ActionNumberRunner");
        descTxts={{txt_topAdd,txt_topAddVal,upTween},{txt_downAdd,txt_downAddVal,downTween}};
    end
end

--- func 刷新界面
---@param _data teamItemData
---@param isTop 是否只显示上方UI
function Refresh(_data,isTop)
    --读取光环信息
    data=_data
    if data and topRoot~=nil then
        local cfg=data:GetCfg();
        if(cfg.gridsIcon) then --光环范围
            ResUtil.RoleSkillGrid:Load(icon, cfg.gridsIcon)
            CSAPI.SetRTSize(icon,60,60);
        end
        --读取光环加成
        local desc="";
        local index=1;
        if cfg.halo then
            local haloCfg=Cfgs.cfgHalo:GetByID(cfg.halo[1]);
            for k,v in ipairs(haloCfg.use_types) do
                local attrCfg=Cfgs.CfgCardPropertyEnum:GetByID(v);
                if attrCfg then
                    local num =haloCfg[attrCfg.sFieldName] or 0;
                    local addtive=0;
                    local endStr="";
                    if v~=4 then --除速度外所有加成以百分比显示
                        addtive = tonumber(string.match(num * 100, "%d+"));
                        endStr="%"
                    else
                        addtive=num;
                    end
                    CSAPI.SetText(descTxts[index][1],attrCfg.sName2);
                    -- CSAPI.SetText(descTxts[index][2],addtive);
                    descTxts[index][3].currentNum = 0;
                    descTxts[index][3].fixedBStr=endStr;
                    descTxts[index][3].targetNum = addtive;
                    descTxts[index][3]:Play();
                    index=index+1;
                end
            end
        end
        CSAPI.SetGOActive(topLine,index>1);
    end
    if isTop then
        CSAPI.SetGOActive(leftRoot,false);
    else
        CSAPI.SetGOActive(leftRoot,true);
    end
end

function SetLeaderEnable(enable)
    -- local color=enable and {255,255,255,255} or {122,122,122,255}
    -- CSAPI.SetImgColor(btnLeader,color[1],color[2],color[3],color[4]);
    -- CSAPI.SetTextColor(btnLeader,color[1],color[2],color[3],color[4]);
    leaderClick.raycastTarget=enable==true;
    CSAPI.SetGOActive(btnLeader,enable==true);
end

--设为队长
function OnClickLeader()
    local cid=nil;
    if data then
        cid=data.cid;
    end
    EventMgr.Dispatch(EventType.Team_FormationInfo_Click,{type=1,cid=cid});
end

--角色详情
function OnClickDetails()
    local cid=nil;
    if data then
        cid=data.cid;
    end
    EventMgr.Dispatch(EventType.Team_FormationInfo_Click,{type=2,cid=cid});
end

--移出队伍
function OnClickLeave()
    local cid=nil;
    if data then
        cid=data.cid;
    end
    EventMgr.Dispatch(EventType.Team_FormationInfo_Click,{type=3,cid=cid});
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
data=nil;
gameObject=nil;
transform=nil;
this=nil;  
leftRoot=nil;
btnLeader=nil;
btnDetails=nil;
btnLeave=nil;
topRoot=nil;
icon=nil;
txt_topAdd=nil;
txt_topAddVal=nil;
txt_downAdd=nil;
txt_downAddVal=nil;
topLine=nil;
view=nil;
end
----#End#----