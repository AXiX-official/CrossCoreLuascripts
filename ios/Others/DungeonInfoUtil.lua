local this = {};

this.ShowType = {
    Title = "Title",
    Target = "Target",
    Prograss = "Prograss",
    Output = "Output",
    Level = "Level",
    Double = "Double",
    Details ="Details",
    Danger = "Danger",
    Course = "Course",
    Button = "Button",
    Badge = "Badge",
    Plot = "Plot",
    PlotButton = "PlotButton",
}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:Set(cfg)
    self.cfg = cfg
    if cfg then
        self.data = DungeonMgr:GetDungeonData(cfg.id)
        self.sectionData = DungeonMgr:GetSectionData(cfg.group)
        self.panel = self.panel or {}
        self.create = self.create or {}
    end
    self.datas = {cfg =self.cfg,data =self.data,sectionData =self.sectionData}
end

function this:Show(typeName,parent,callback)
    if not parent then
        LogError("未传入父物体！！！")
        return
    end
    local isCanShow = false
    for _type, name in pairs(this.ShowType) do
        if name == typeName then
            isCanShow = true
            break
        end
    end
    if not isCanShow then
        LogError("没有指定类型的模块！！！" .. typeName)
        return
    end

    if self.panel[typeName] then
        CSAPI.SetGOActive(self.panel[typeName].gameObject, true)
        self.panel[typeName].Refresh(self.datas)
        if callback then
            callback(self.panel[typeName])
        end
        self.panel[typeName].transform:SetSiblingIndex(parent.transform.childCount - 1)
    else
        if self.create[typeName] then
            return
        end
        self.create[typeName] = true
        ResUtil:CreateUIGOAsync("DungeonItemInfo/DungeonInfo" .. typeName,parent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(self.datas)
            self.panel[typeName] = lua
            if callback then
                callback(self.panel[typeName])
            end
        end)
    end
end

function this:Hidden(typeName)
    if typeName ~= nil and typeName ~= "" and self.panel[typeName] then
        CSAPI.SetGOActive(self.panel[typeName], false)
    else
        for _, lua in pairs(self.panel) do
            CSAPI.SetGOActive(lua.gameObject, false)
        end
    end
end

function this:ShowPanels(typeNames)
    self:Hidden()
    if typeNames and #typeNames > 0 then
        for _, typeName in ipairs(typeNames) do
            if self.panel[typeName] then
                CSAPI.SetGOActive(self.panel[typeName], true)
            end
        end
    end
end

function this:GetPanel(typeName)
    return self.panel and self.panel[typeName]
end

function this:RefreshPanel()
    if this.panel then
        for _, lua in pairs(self.panel) do
            if lua.gameObject.activeSelf then
                lua.Refresh(self.datas)
            end
        end
    end
end

return this