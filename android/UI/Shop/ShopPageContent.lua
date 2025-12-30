--商店中的商品页
local grids={};
function Refresh(_data,_elseData)
    if _data then
        ItemUtil.AddItems("Shop/CommodityItem", grids, _data, gameObject, nil, 1, _elseData,function()
            if this.cb then
                for k,v in ipairs(grids) do
                    v.SetClickCB(this.cb);
                end
            end
        end);
    end
end

function CheckDiscountRefresh(nowTime);
    if grids then
        for k,v in ipairs(grids) do
            v.CheckDiscountRefresh(nowTime);
        end
    end
end

function SetClickCB(cb)
    this.cb=cb;
end
