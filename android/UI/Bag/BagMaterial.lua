--素材背包
local this={};
local root=nil;
local data=nil;
function this.SetData(_root,_data)
    root=_root;
    data=_data;
end

function this.Refresh()
    local list = this.GetShowGoods();  
    root.Refresh(list);
end

-- function this.GetScreenDataType()
--     return EquipViewKey.Bag;
-- end

--返回显示的素材信息
function this.GetShowGoods()
	local bagDatas = BagMgr:GetDatas();
	local arr = {};
	if(bagDatas) then
		for _, data in pairs(bagDatas) do
			if(data) then
				local cfgGoods = data:GetCfg();
				if cfgGoods and cfgGoods.hide == nil then
					table.insert(arr, data);
				end
			end
		end
		--根据品质和id进行排序
		table.sort(arr, function(a, b)
			if a:GetQuality() == b:GetQuality() then
				return a:GetID() < b:GetID();
			else
				return a:GetQuality() > b:GetQuality()
			end
		end);
	end
	return arr;
end

function this.GetElseData(element)
    return {isClick = true, isSelect = false,selectType=1,showNew=true,checkRed=true,removeFunc = nil};
end

function this.OnClickGrid(tab)
	UIUtil:OpenGoodsInfo( tab.data);
	BagMgr:SetNewState(tab.data:GetID(),false);
	tab.SetNewState(BagMgr:IsNew(tab.data:GetID()));
end

function this.OnClickReturn()
    root.Close();
end

return this;