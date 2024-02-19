--角色碎片兑换UI
local layout=nil;
local stuff1=nil;
local stuff2=nil;
local stuffID1=10033
local stuffID2=10034
local exChangeList={};
function Awake()
    layout = ComUtil.GetCom(vsv, "UISV")
	layout:Init("UIs/Grid/GridItem",LayoutCallBack,true,0.85)
end

function OnOpen()
    Refresh();
end

function Refresh()
    local preNum1=0;
    local preNum2=0
    exChangeList={};
    curDatas=data or {};
    for k,v in ipairs(curDatas) do
        local c=v:GetCfg();
        if c and c.dy_value2 then --通过动态值2获取兑换表数据
            local cfg=Cfgs.CfgItemExchange:GetByID(c.dy_value2);
            if cfg and cfg.type==ExchangeItemType.CardCoreItem and cfg.gets and cfg.costs then
                --统计能兑换的次数
                local num=0;
                if cfg.costs[1] then
                    local val=cfg.costs[1][1];
                    local cost=cfg.costs[1][2]==nil and 0 or cfg.costs[1][2]
                    local goods=BagMgr:GetCardCore(val,true); --获取消耗的素材
                    if goods and goods:GetType()==ITEM_TYPE.CARD_CORE_ELEM then
                        num=math.floor(goods:GetCount()/cost);
                    elseif goods and good:GetType()~=ITEM_TYPE.CARD_CORE_ELEM then
                        LogError("兑换消耗的素材不是角色碎片类型！");
                    end
                end
                for _,val in ipairs(cfg.gets) do
                    if val[1]==stuffID1 then
                        preNum1=preNum1+val[2]*num
                    else
                        preNum2=preNum2+val[2]*num
                    end
                end
                
                if num>0 then
                    table.insert(exChangeList,{id=c.dy_value2,num=num});
                end
            end
        end
    end
    local goods=BagMgr:GetDataByCfgID(stuffID1);
    if goods==nil then
        goods = GoodsData({id = stuffID1, num = 0});
    end
    local goods2=BagMgr:GetDataByCfgID(stuffID2);
    if goods2==nil then
        goods2 = GoodsData({id = stuffID2, num = 0});
    end
    CreateStuffGrid(stuff1,stuffGrid1,goods)
    CreateStuffGrid(stuff2,stuffGrid2,goods2)
    RefrehStuffInfo(goods,preNum1,txt_stuff1,txt_curr1,txt_pre1)
    RefrehStuffInfo(goods2,preNum2,txt_stuff2,txt_curr2,txt_pre2)
    layout:IEShowList(#curDatas);
end

function CreateStuffGrid(grid,gridParent,goods)
    if grid==nil and gridParent then
        ResUtil:CreateUIGOAsync("Grid/GridItem",gridParent,function(go)
            local lua=ComUtil.GetLuaTable(go);
            lua.Refresh(goods);
            lua.SetClickCB(GridClickFunc.OpenInfo);
        end)
    end
end

function RefrehStuffInfo(goods,preNum,nameObj,currObj,preObj)
    if goods and preNum and nameObj and currObj and preObj then
        CSAPI.SetText(nameObj,goods:GetName());
        CSAPI.SetText(currObj,tostring(goods:GetCount()));
        CSAPI.SetText(preObj,tostring(goods:GetCount()+preNum));
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
	local grid=layout:GetItemLua(index);
	grid.SetIndex(index);
	grid.Refresh(_data);
	grid.SetClickCB(GridClickFunc.OpenInfo);
end

--兑换
function OnClickPay()
    if #exChangeList>0 then
        ClientProto:ExchangeItem(exChangeList, function(proto)
            UIUtil:OpenReward({proto.rewards})
            view:Close();
        end);
    else
        LanguageMgr:ShowTips(15104);
    end
end

function OnClickAnyWay()
    view:Close();
end