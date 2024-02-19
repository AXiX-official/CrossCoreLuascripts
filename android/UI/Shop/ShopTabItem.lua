--二级分页子物体
local eventMgr=nil;
local pageID=nil;--一级页面ID
local isNew=false;
local setNew=false;
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function Refresh(cfg,elseData)
    local isRed=false;
    if cfg then
        this.cfg=cfg;
        CSAPI.SetText(txt_name,cfg.name);
        SetIcon(cfg.icon);
    else
        this.cfg=nil;
    end
    if elseData then
        this.isOn=elseData.sID==this.cfg.id;
        isRed=elseData.isRed==true;
        pageID=elseData.pageID;
        if elseData.newInfos then
            SetNewInfo(elseData.newInfos);
        end
    else
        this.isOn=false;
    end
    SetRed(isRed);
    SetState(this.isOn)
end

function SetState(_isOn)
    this.isOn=_isOn;
    CSAPI.SetGOActive(onObj,_isOn);
end

function SetIcon(_iconName)
    if (_iconName) then
        CSAPI.SetGOActive(icon1,true);
        CSAPI.SetGOActive(icon2,true);
        ResUtil.IconGoods:Load(icon1, _iconName.."_1")
        ResUtil.IconGoods:Load(icon2, _iconName.."_1")
    else
        CSAPI.SetGOActive(icon1,false);
        CSAPI.SetGOActive(icon2,false);
    end
end

function RefreshRecord()
    if isNew and this.cfg and pageID then
        setNew=true;
        ShopMgr:SetCommResetInfo(pageID,this.cfg.id);
    end
end

function OnClickItem()
    EventMgr.Dispatch(EventType.Shop_TopTab_Change,this);
end

function SetRed(isShow)
    CSAPI.SetGOActive(red,isShow==true);
end

--检测红点数据
function SetRedInfo()
    local rd=RedPointMgr:GetData(RedPointType.Shop);
    if rd and this.cfg and rd[this.cfg.id] then
        SetRed(true);
    else
        SetRed(false);
    end
end

function SetNewInfo(infos)
    if infos and this.cfg and pageID and infos[pageID] and infos[pageID][this.cfg.id] then
        CSAPI.SetGOActive(newObj,true);
        isNew=true;
    else
        CSAPI.SetGOActive(newObj,false);
        isNew=false
    end 
end
