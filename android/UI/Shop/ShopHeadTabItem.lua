--商店头部页签
local isNowOn=false;
local data=nil;
local eventMgr=nil;
local isNew=false;
local setNew=false;
--超过五个需要滑动，低于五个自适应长度，总长度1498


function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
    -- eventMgr:AddListener(EventType.Shop_NewInfo_Refresh,SetNewInfo)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function Refresh(_data,_elseData)
    if _data==nil then
        return
    end
    data=_data;
    SetIcon(_data:GetIcon());
    SetTitle(_data:GetNameID())
    -- Log(_data.cfg)
    SetHotObj(_data:GetIsHot());
    local isRed=false;
    -- if _data:GetCommodityType()==CommodityType.Promote then 暂时隐藏推荐栏的红点
    --     local tabs=_data:GetTopTabs(true);
    --     for _,val in ipairs(tabs) do
    --         local info=ShopMgr:GetPromoteInfo(val.id)
    --         if info and info:HasRed() then
    --             isRed=true;
    --             break;
    --         end
    --     end
    -- end
    SetRedPoint(isRed);
    if _elseData then
        if _elseData.newInfos then
            SetNewInfo(_elseData.newInfos);
        end
        if this.index==_elseData.sIndex or (this.index~=_elseData.sIndex and isNowOn) then
            PlayTween(this.index==_elseData.sIndex);
        end
    end
end

function SetHotObj(isShow)
    CSAPI.SetGOActive(hotObj,isShow==true);
end

--检测红点数据
function SetRedInfo()
    local rd=RedPointMgr:GetData(RedPointType.Shop);
    local rd2=RedPointMgr:GetData(RedPointType.RegressionShop);
    local isShowRed=false;
    if rd and data and rd[data:GetID()] then
        isShowRed=true;
    end
    if isShowRed~=true and rd2 and data and rd2[data:GetID()] then
        isShowRed=true;
    end
    SetRedPoint(isShowRed)
end

function SetNewInfo(infos)
    if infos and infos[data:GetID()] then
        CSAPI.SetGOActive(newObj,true);
        isNew=true;
    else
        CSAPI.SetGOActive(newObj,false);
        isNew=false;
    end 
end


function SetIndex(i)
    this.index=i;
end

function SetIcon(iconName)
    if iconName~="" and iconName~=nil then
        CSAPI.LoadImg(icon,string.format("UIs/Shop/%s.png",iconName),true,nil,true)
        CSAPI.SetGOActive(icon,true)
    else
        CSAPI.SetGOActive(icon,false)
    end
end

function SetTitle(id)
    local str="";
    local str2=""
    if id then
        str=LanguageMgr:GetByID(id)
    end
    CSAPI.SetText(txt_title,str);
end

function SetRedPoint(isShow)
    CSAPI.SetGOActive(redPoint,isShow);
end

function PlayTween(isOn)
    CSAPI.SetGOActive(tweenObj,isOn);
    if isNowOn==true and isOn~=true then
        CSAPI.SetGOActive(tweenObj2,true);
    else
        CSAPI.SetGOActive(tweenObj2,false);
    end
    isNowOn=isOn;
end

function OnClickSelf()
    -- if data:GetTips() and isNew then
    --     Tips.ShowTips(LanguageMgr:GetTips(data:GetTips()));
    -- end
    EventMgr.Dispatch(EventType.Shop_Tab_Change,this.index)
end
