--时装图册界面
local layout=nil;
local layout2=nil;
local isGroup=false;--是否分组视图
local flag=false;--是否显示未持有
-- local commList={};--商品列表
local skinList={};--皮肤列表
local setList={}--合集列表
local allID=201;--时装合集ID
local curSetID=nil;--当前选择的时装ID
local groupItems={};--分组子物体
local layoutTween=nil;
function Awake()
    layout = ComUtil.GetCom(vsv, "UISV")
    layout:Init("UIs/RoleSkinComm/SkinSetItem",LayoutCallBack,true)
    layoutTween=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.MoveByType2,{"DTU"});
    -- layout2 = ComUtil.GetCom(vsv2, "UISV")
    -- layout2:Init("UIs/RoleSkinComm/SkinSetPage",LayoutCallBack2,true)
    UIUtil:AddTop2("ShopView", gameObject, Close,nil,{});
end

function OnOpen()
    InitData();
    Refresh();
end

function InitData()
    -- commList={};
    -- for k, v in pairs(Cfgs.CfgCommodity:GetAll()) do
    --     if v.nType==CommodityItemType.Skin then
    --         local comm=CommodityData.New();
    --         comm:SetCfg(v.id);
    --         local gets=comm:GetCommodityList();
    --         if gets then
    --             for _,item in ipairs(gets) do
    --                 if item.type==RandRewardType.ITEM and item.data:GetType()==ITEM_TYPE.SKIN then
    --                     local record=ShopMgr:GetRecordInfos(v.id);
    --                     comm:SetData(record);
    --                     commList[item.data:GetDyVal2()]=comm;
    --                     break;
    --                 end
    --             end
    --         end
    --     end
    -- end
    skinList={} --setID:List<ShopSkinInfo> 根据系列划分数组
    for k,v in pairs(Cfgs.CfgSkinInfo:GetAll()) do
        local skin=ShopSkinInfo.New();
        skin:InitCfg(v.id);
        skinList[v.setID]=skinList[v.setID] or {};
        local isShow=IsSkinCommShow(skin);
        if isShow then --满足条件才显示
            table.insert(skinList[v.setID],skin);
        end
    end
    setList={};
    for k,v in pairs(Cfgs.CfgSkinSetInfo:GetAll()) do
        if (skinList and skinList[v.id] and #skinList[v.id]>0) or v.id==201 then
            table.insert(setList,v);
        end
    end
    table.sort(setList,function(a,b)
        return a.sort<b.sort;
    end)
end

--未获得是否隐藏（读角色模型表的show字段）
function IsSkinCommShow(shopSkinInfo)
    local isShow=false;
    if shopSkinInfo==nil then
        return isShow
    end
    local hideType=shopSkinInfo:GetHideType();
    if hideType==nil or hideType==3 then --type==3表示一定隐藏
        isShow=false;
    elseif hideType==1 then--原始图
        local modelCfg=shopSkinInfo:GetModelCfg();
        --判断是否在商品上架期限
        local commodity=ShopMgr:GetFixedCommodity(modelCfg.shopId);
        if commodity==nil then
            return isShow;
        end
        local rSkinInfo=RoleSkinMgr:GetRoleSkinInfo(shopSkinInfo:GetModelCfg().role_id, shopSkinInfo:GetModelCfg().id)
        if commodity:GetNowTimeCanBuy() then --是否可以购买
            isShow=true;
        elseif rSkinInfo~=nil and rSkinInfo:CheckCanUse() then
            isShow=true
        end
    elseif hideType==2 then--和谐图
        local modelCfg=shopSkinInfo:GetModelCfg();
        --判断是否在商品上架期限
        local commodity=ShopMgr:GetFixedCommodity(modelCfg.shopId);
        if commodity==nil then
            return isShow;
        end
        local buyStartTime=commodity:GetBuyStartTime();
        if (buyStartTime>0 and buyStartTime<=TimeUtil:GetTime()) or (buyStartTime==0) then
            isShow=true;
        end
    end
    return isShow;
end

function Refresh()
    CSAPI.SetGOActive(vsv,not isGroup);
    CSAPI.SetGOActive(vsv2,isGroup);
    CSAPI.SetGOActive(toggleObj,flag);
    if not isGroup then
        if layoutTween~=nil then
            layoutTween:AnimAgain();
        end
        layout:IEShowList(#setList);
    else
        local list={};
        local isAll=curSetID==allID;
        if isAll then
            local groupList={};
            for k, v in pairs(skinList) do
                for _, val in pairs(v) do
                    local season=val:GetSeasonID();
                    list[season]=list[season] or {}
                    table.insert(list[season],val);
                end
            end
            for k, v in pairs(list) do --合集只分期数
                table.insert(groupList,v);
            end
            ItemUtil.AddItems("RoleSkinComm/SkinSetPage", groupItems, groupList, Content,nil,1,{isAll=isAll,flag=flag})
        else
            list=skinList[curSetID] or {};
            if #list>0 then
                --根据时装季度和序列进行分组排序
                table.sort(list,function(a,b)
                    if a:GetSetID()==b:GetSetID() then
                        if a:GetSeasonID()==b:GetSeasonID()then
                            return a:GetSort() <b:GetSort()
                        else
                            return a:GetSeasonID()<b:GetSeasonID()
                        end
                    else
                        return a:GetSetID()<b:GetSetID()
                    end
                end);
                --创建子物体
                local groupList={list};
                --创建子物体并初始化
                ItemUtil.AddItems("RoleSkinComm/SkinSetPage", groupItems, groupList, Content,nil,1,{isAll=isAll,flag=flag})
            else
                LogError("没有找到对应的时装信息")
            end
        end
    end
end

function LayoutCallBack(index)
    local _d=setList[index];
    local item=layout:GetItemLua(index);
    item.Refresh(_d)
    item.SetClickCB(OnClickSet);
end

function OnClickToggle()
    flag=not flag;
    Refresh();
end

function OnClickSet(tab)
    curSetID=tab.data.id;
    isGroup=true;
    Refresh();
end

function Close()
    if isGroup then
        isGroup=false;
        Refresh();
    else
        view:Close();
    end
end