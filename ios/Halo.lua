-- OPENDEBUG(true)

-- 获取卡牌的站格
function GetCardGrids(cid, row, col)
	local config = CardData[cid] or MonsterData[cid]
	ASSERT(config)
	if config.grids then
		local grids = {}
		
		-- 占多个格子
		local formation = MonsterFormation[config.grids]
		ASSERT(formation)
		-- LogTable(formation, "config"..config.grids)

		-- relative 相对坐标
		for i, pos in ipairs(formation.coordinate) do
			local r = row + pos[1]
			local c = col + pos[2]
			table.insert(grids, {r, c})
		end
		return grids
	end
	-- LogTable(config, "config"..cid)
	-- if cid == 30120 then ASSERT() end
end


----------------------------------------------
-- 光环计算器 
Halo = {}

function Halo:InitMap(map, row, col)
	for i=1,row do
		map[i] = {}
		for j=1,col do
			map[i][j] = {}
		end
	end
end

-- 内部函数, 给某个格子加buff
function Halo:AddBuff(id, map, row, col, buff)
	-- if row < 1 or row > 3 or col < 1 or col > 3 then return end
	if not map[row] or not map[row][col]  then return end -- 越界

	-- LogTable(buff.percents)
	local data = map[row][col]
	buff.nClass = buff.nClass or {0}
	buff.id = id -- 标记这是谁加的光环
	table.insert(data, buff)
end

-- function Halo:GetBuff(mapItem, nClass)
-- 	local data = {}
-- 	for i,buff in ipairs(mapItem) do
-- 		for i,v in ipairs(buff.nClass) do
-- 			if v == 0 or v == nClass then
-- 				for k,v in pairs(buff.percents) do
-- 					data[k] = data[k] or 0
-- 					data[k] = data[k] + v
-- 				end
-- 				break
-- 			end
-- 		end
-- 	end

-- 	-- LogTable(data, "Halo:GetBuff")
-- 	return data
-- end

-- 考虑多格站位
function Halo:GetBuffEx(cid, map, row, col, nClass)

	-- LogDebugEx("Halo:GetBuffEx",cid, row, col, nClass)
	local data = {}
	local mapItem = map[row][col]
	local grids = GetCardGrids(cid, row, col)

	if grids then
		-- LogTable(grids, "grids =")
		local item = {}
		-- 合并&过滤重复buff
		for i,pos in ipairs(grids) do
			local m = map[pos[1]][pos[2]]
			for i,v in ipairs(m) do
				item[v] = v
			end
		end

		mapItem = {}
		local its = {}
		for k,v in pairs(item) do
			table.insert(mapItem, v)
		end
		-- return data
		-- LogTable(mapItem, "mapItem_"..row.."_"..col)
	end

	for i,buff in ipairs(mapItem) do
		if buff.id == cid then
			-- 自己的buff不用加
		else
			for i,v in ipairs(buff.nClass) do
				if v == 0 or v == nClass then
					for k,v in pairs(buff.percents) do
						data[k] = data[k] or 0
						data[k] = data[k] + v
					end
					break
				end
			end
		end
	end

	-- LogTable(data, "Halo:GetBuff")
	return data
end
---------------------------------------------------------------------------
-- data格式
-- {
--     [ 1 ]n = 
--     {
--         [ "data" ]s = 
--         {
--             [ "id" ]s = [ 60010 ]f
--             [ "name" ]s = [ "格拉姆" ]s
--             [ "attack" ]s = [ 201 ]f
--             [ "maxhp" ]s = [ 1273 ]f
--             [ "defense" ]s = [ 97 ]f
--             [ "speed" ]s = [ 110 ]f
--             [ "crit_rate" ]s = [ 0.1 ]f
--             [ "crit" ]s = [ 1.5 ]f
--             [ "hit" ]s = [ 0 ]f
--             [ "damage" ]s = [ 1.1 ]f
--             [ "resist" ]s = [ 0 ]f
--         }
--         [ "col" ]s = [ 1 ]f
--         [ "row" ]s = [ 1 ]f
--     }
--     [ 2 ]n = 
--     {
--         [ "data" ]s = 
--         {
--             [ "id" ]s = [ 40010 ]f
--             [ "name" ]s = [ "飓风" ]s
--             [ "attack" ]s = [ 201 ]f
--             [ "maxhp" ]s = [ 1273 ]f
--             [ "defense" ]s = [ 97 ]f
--             [ "speed" ]s = [ 110 ]f
--             [ "crit_rate" ]s = [ 0.1 ]f
--             [ "crit" ]s = [ 1.5 ]f
--             [ "hit" ]s = [ 0 ]f
--             [ "damage" ]s = [ 1.1 ]f
--             [ "resist" ]s = [ 0 ]f
--         }
--         [ "col" ]s = [ 2 ]f
--         [ "row" ]s = [ 1 ]f
--     }
-- }
local needFloor = {attack = true, maxhp = true, defense = true}
function Halo:CalcAttr(data, key, add)
	-- LogTable(data)

	-- attack	maxhp	defense	speed
	-- 整数取整, 浮点保留, 比率改为相加(0-1)
	if needFloor[key] then
		local calRet = GCardCalculator:CalLvlPropertys(data.id, data.level, data.intensify_level, data.break_level)
		if calRet and calRet[key] then
			LogDebug("CalcAttr name[%s] key[%s] val[%s] cfg[%s] src[%s] des[%s]", data.name, key, add, calRet[key], data[key], data[key] + math.floor(calRet[key]*add))
			data[key] = data[key] + math.floor(calRet[key]*add)
		else
			data[key] = math.floor(data[key]*(1 + add))
		end
	else
		data[key] = data[key] + add
	end
end

-- 计算光环后属性值
function Halo:Calc(data)

	--LogTable(data)
	local ret = table.copy(data)
	local map = {}
	Halo:InitMap(map, ret.row or 3, ret.col or 3)

	-- local row = ret.row or 3
	-- local col = ret.col or 3

	for i,carddata in ipairs(ret) do
		-- LogTable(carddata)
		-- LogDebug("--------"..i)
		local row, col = carddata.row, carddata.col
		local id = carddata.data.id
		local config = CardData[id] or MonsterData[id]
		ASSERT(config, "没有找到配置"..id)
		carddata.data.nClass = config.nClass or 0
		if config.halo then
			-- 遍历加buff的格子 并记录buff
			for i,haloid in ipairs(config.halo) do
				local cfgH = cfgHalo[haloid]
				ASSERT(cfgH, "没有找到光环配置"..haloid)
				cfgH = table.copy(cfgHalo[haloid])
				for index=1,#cfgH.coorHalo do -- 相对坐标
					Halo:AddBuff(id, map, row+cfgH.coorHalo[index][1], col+cfgH.coorHalo[index][2], cfgH)
				end
			end
		end
	end

	-- LogTable(map, "Halo:Calc map = ")

	for i,carddata in ipairs(ret) do
		local row, col = carddata.row, carddata.col  -- 需要处理多格站位的角色
		-- local buffs = Halo:GetBuff(map[row][col], carddata.data.nClass) 

		local buffs = Halo:GetBuffEx(carddata.data.id, map, row, col, carddata.data.nClass)
		if not table.empty(buffs) then
			carddata.bInHalo = true -- 是否受到光环
			for key,val in pairs(buffs) do
				LogDebugEx("光环加成",carddata.data.name, key, val, carddata.data[key], carddata.data[key] *(1 + val))
				self:CalcAttr(carddata.data, key, val)
			end
		end
	end

	-- LogTable(ret, "Halo:Calc ret = ")
	return ret
end

-- function Halo:CalcDuplicate(data)
-- 	LogTable(data, "Halo:CalcDuplicate = ")

-- 	local ret = table.copy(data)
-- 	local newdata = {}
-- 	for i,carddata in ipairs(ret) do
-- 		table.insert(newdata, {data = carddata.carddata.data, row = carddata.row, col = carddata.col})
-- 	end 

-- 	newdata = Halo:Calc(newdata)

-- 	for i,v in ipairs(newdata) do
-- 		ret[i].carddata.data = v.data
-- 		ret[i].maxhp = v.data.maxhp
-- 	end

-- 	-- LogTable(ret, "Halo:Calc ret = ")
-- 	return ret
-- end