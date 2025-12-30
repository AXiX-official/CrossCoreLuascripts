--月卡说明物体
local animTotalTime=0.4;

function Refresh(data,pos,isHideMonthPay)
    if pos then --动画
        CSAPI.SetAnchor(gameObject, pos[1], pos[2], pos[3])
        -- action =ComUtil.GetOrAddCom(gameObject, "ActionUIMoveTo");
        -- if action then
        --     action.isLocal = true;
        --     action:SetStartPos(pos[1], pos[2]+200, pos[3])
        --     action:SetTargetPos(pos[1], pos[2], pos[3])
        --     action.delay=400
        --     action.time = animTotalTime * 1000
        --     action:Play()
        --     -- action:PlayByTime(pos[1], pos[2], pos[3],animTotalTime,nil,0.4);
        -- end
    end
    if data then
        local goods=data.goods.data;
        goods:GetIconLoader():Load(icon,goods:GetIcon());
        if isHideMonthPay then
            -- CSAPI.SetText(txt_name,string.format("<color=#ffc142>%s</color>",LanguageMgr:GetTips(15102)));  --测试用
            CSAPI.SetText(txt_name,LanguageMgr:GetTips(15102));
        else
            CSAPI.SetText(txt_name,string.format("%sX%s",goods:GetName(),data.goods.num)); --正式用
        end
        CSAPI.SetText(txt_desc,data.desc);
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
icon=nil;
txt_desc=nil;
txt_name=nil;
view=nil;
end
----#End#----