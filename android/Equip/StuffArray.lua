--素材列表工具类
local this={
    stuffList=nil,
    stuffTotalExp=0,
    stuffTotalPrice=0,
    stuffCount=0,
}

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins, this);		
	return ins;
end

--添加选择的素材信息
function this:AddStuffItem(data,type,count)
    if data==nil or type==nil then
        return;
    end
    count=count or 1;
    self.stuffList=self.stuffList or {};
    if self:GetStuffIsMax()==false then
        -- if type==0 then --装备
        --     if self.stuffList[data:GetID()]~=nil then
        --         return
        --     end
        --     self.stuffList[data:GetID()]={type=type,data=data,num=1};
        --     local info = data:GetMaterialInfo();
        --     self.stuffTotalExp=self.stuffTotalExp+info.exp;
        --     self.stuffTotalPrice=self.stuffTotalPrice+info.gold;
        --     self.stuffCount=self.stuffCount+1;
        -- elseif type==1 then--素材(由于素材可以叠加，所以这里使用配置表ID)
        --     local item=self.stuffList[data:GetID()];
        --     if item then
        --         item.num=item.num+1;
        --     else
        --         self.stuffList[data:GetID()]={type=type,data=data,num=1};
        --     end
        --     self.stuffCount=self.stuffCount+1;
        --     local info = data:GetMaterialInfo();
        --     self.stuffTotalExp=self.stuffTotalExp+info.exp;
        --     self.stuffTotalPrice=self.stuffTotalPrice+info.gold;
        -- end
        for i=1,count do 
            table.insert(self.stuffList,{type=type,data=data,num=1});
            local info = data:GetMaterialInfo();
            self.stuffTotalExp=self.stuffTotalExp+info.exp;
            self.stuffTotalPrice=self.stuffTotalPrice+info.gold;
            self.stuffCount=self.stuffCount+1;
        end
    end
end

--返回同一id的素材数量
function this:GetStuffNumByID(id)
    local num=0;
    if self.stuffList then
        for k,v in ipairs(self.stuffList) do
            if v.data:GetID()==id then
                num=num+1;
            end
        end
    end
    return num;
end
--移除素材信息
function this:RemoveStuffItem(id,num)
    if self.stuffList then
        local indexList={};
        for k,v in ipairs(self.stuffList) do
            if v.data:GetID()==id then
                table.insert(indexList,k);
                if #indexList==num then
                    break;
                end
            end
        end
        for i=#indexList,1,-1 do
            self:RemoveStuffItemByIndex(indexList[i])
        end
    end
    -- if self.stuffList and self.stuffList[id] then
        -- local item=self.stuffList[id];
        -- if item.type==0 then
        --     local info = item.data:GetMaterialInfo();
        --     self.stuffTotalExp=self.stuffTotalExp-info.exp;
        --     self.stuffTotalPrice=self.stuffTotalPrice-info.gold;
        --     self.stuffList[id]=nil;
        --     self.stuffCount=self.stuffCount-1;
        -- elseif item.type==1 then
        --     local info = item.data:GetMaterialInfo();
        --     self.stuffTotalExp=self.stuffTotalExp-info.exp;
        --     self.stuffTotalPrice=self.stuffTotalPrice-info.gold;
        --     item.num=item.num-num<=0 and 0 or item.num-num;
        --     self.stuffCount=self.stuffCount-1;
        --     if item.num<=0 then
        --         self.stuffList[id]=nil;
        --     end
        -- end
    -- end
end

function this:RemoveStuffItemByIndex(index)
    if self.stuffList and self.stuffList[index] then
        local info = self.stuffList[index].data:GetMaterialInfo();
        self.stuffTotalExp=self.stuffTotalExp-info.exp;
        self.stuffTotalPrice=self.stuffTotalPrice-info.gold;
        self.stuffCount=self.stuffCount-1;
        table.remove(self.stuffList,index);
    end
end

--根据ID返回素材信息
function this:GetStuffByID(id)
    if self.stuffList then
        for k,v in ipairs(self.stuffList) do
            if v.data:GetID()==id then
                return v;
            end
        end
    end
    return nil;
end

--根据Index返回素材信息
function this:GetStuffByIndex(index)
    if self.stuffList and self.stuffList[index] then
        return self.stuffList[index];
    end
    return nil;
end

--返回选择的升级素材列表
function this:GetStuffArr()
    -- local arr={};
    -- if self.stuffList then
    --     for k,v in pairs(self.stuffList) do
    --         if v.type==0 then
    --             table.insert(arr,v);
    --         elseif v.type==1 then
    --             table.insert(arr,v);
    --         end
    --     end
    -- end
    return self.stuffList or {};
end

--是否到达最大选择数量
function this:GetStuffIsMax()
    return self.stuffCount>=EquipMgr.maxStuffNum;
end

--返回还能放置的数量
function this:GetEmptyNum()
    return EquipMgr.maxStuffNum-self.stuffCount;
end

--清空选择的素材信息
function this:CleanStuffInfo()
    self.stuffCount=0;
    self.stuffTotalExp=0;
    self.stuffTotalPrice=0;
    self.stuffList=nil;
end

return this;