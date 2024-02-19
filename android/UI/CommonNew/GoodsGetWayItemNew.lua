
local state=JumpModuleState.Normal;
local data=nil;
local isDisable=false;
function Refresh(_data,_isDisable)
    data=_data;
    isDisable=_isDisable
    if data then
        state=data.state;
        if state==JumpModuleState.Lock then
            CSAPI.SetGOActive(lockImg,true);
            CSAPI.SetGOActive(jumpImg,false);
            CSAPI.SetGOActive(txt_state,false)
            -- CSAPI.SetGOActive(jumpImg2,false);
            CSAPI.SetGOActive(btn_jump,true);
        elseif state==JumpModuleState.Close or isDisable then
            -- CSAPI.SetGOActive(lockImg,false);
            -- CSAPI.SetGOActive(jumpImg,true);
            -- CSAPI.SetGOActive(jumpImg2,true);
            CSAPI.SetGOActive(btn_jump,false);
        else
            CSAPI.SetGOActive(lockImg,false);
            CSAPI.SetGOActive(jumpImg,true);
            CSAPI.SetGOActive(txt_state,true)
            CSAPI.SetGOActive(btn_jump,true);
        end
        local jumpCfg=Cfgs.CfgJump:GetByID(data.jumpId)
        local txt="";
        if jumpCfg then
            txt=txt..jumpCfg.desc;
            -- CSAPI.SetText(name,jumpCfg.desc);
        end
        if data.outTips then
            txt=txt.."    "..data.outTips;
        end
        CSAPI.SetText(tipsContent,txt);
    end
end

function SetJumpCall(call)
    this.jumpCall=call;
end

function OnClickJump()
    if isDisable then
        return
    end
    if state==JumpModuleState.Normal then
        if this.jumpCall then
            this.jumpCall(data);
        end
        FuncUtil:Call(function()
            JumpMgr:Jump(data.jumpId);
        end,nil,100)    
    else
        Tips.ShowTips(data.lockStr);
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
layout=nil;
tipsContent=nil;
btn_jump=nil;
jumpImg=nil;
jumpImg2=nil;
lockImg=nil;
view=nil;
end
----#End#----