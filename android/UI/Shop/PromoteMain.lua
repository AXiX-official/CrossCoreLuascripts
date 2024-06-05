--推荐主界面
local layout=nil;
local layout2=nil;
local layout3=nil;
local layout4=nil;
local layoutList={};
local layoutList2={};
local layoutList3={};
local layoutList4={};
function Awake()
    layout = ComUtil.GetCom(hpage, "UISlideshow")
    layout:Init("UIs/ShopPromote/PromoteImg", LayoutCallBack, true)
    layout2 = ComUtil.GetCom(mhpage, "UISlideshow")
    layout2:Init("UIs/ShopPromote/PromoteImg", LayoutCallBack2, true)
    layout3 = ComUtil.GetCom(blhpage, "UISlideshow")
    layout3:Init("UIs/ShopPromote/PromoteImg", LayoutCallBack3, true)
    layout4 = ComUtil.GetCom(brhpage, "UISlideshow")
    layout4:Init("UIs/ShopPromote/PromoteImg", LayoutCallBack4, true)
end

function Refresh()
    layoutList=ShopMgr:GetPromoteInfos(101);
    layoutList2=ShopMgr:GetPromoteInfos(201);
    layoutList3=ShopMgr:GetPromoteInfos(301);
    layoutList4=ShopMgr:GetPromoteInfos(401);
    local isMult=#layoutList>1;
    local isMult2=#layoutList2>1
    local isMult3=#layoutList3>1;
    local isMult4=#layoutList4>1
    layout.changeTimer=#layoutList>=1 and layoutList[1]:GetChangeTime() or 5
    layout2.changeTimer=#layoutList2>=1 and layoutList2[1]:GetChangeTime() or 5
    layout3.changeTimer=#layoutList3>=1 and layoutList3[1]:GetChangeTime() or 5
    layout4.changeTimer=#layoutList4>=1 and layoutList4[1]:GetChangeTime() or 5
    --生成子物体
    layout:IEShowList(#layoutList);
    layout2:IEShowList(#layoutList2);
    layout3:IEShowList(#layoutList3);
    layout4:IEShowList(#layoutList4);
    layout:SetSRActive(isMult);
    layout2:SetSRActive(isMult2);
    layout3:SetSRActive(isMult3);
    layout4:SetSRActive(isMult4);
    CSAPI.SetGOActive(hpoints,isMult);
    CSAPI.SetGOActive(mpoints,isMult2);
    CSAPI.SetGOActive(blpoints,isMult3);
    CSAPI.SetGOActive(brpoints,isMult4);
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        lua.Refresh(layoutList[index],OnClickItem);
    end
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        lua.Refresh(layoutList2[index],OnClickItem);
    end
end

function LayoutCallBack3(index)
    local lua = layout3:GetItemLua(index)
    if (lua) then
        lua.Refresh(layoutList3[index],OnClickItem);
    end
end

function LayoutCallBack4(index)
    local lua = layout4:GetItemLua(index)
    if (lua) then
        lua.Refresh(layoutList4[index],OnClickItem);
    end
end

function OnClickItem(jumpInfo)
    if jumpInfo then
        JumpMgr:Jump(jumpInfo.id);
        if jumpInfo.commId~=nil and jumpInfo.commId~="" then
            ShopCommFunc.OpenBuyConfrim(jumpInfo.shopId,jumpInfo.topId,jumpInfo.commId);
        end
    end
end
