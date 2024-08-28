Loader:Require('SvnVersion')
Loader:AddReplaceFile('SvnVersion')

Loader:Require('GEnum')
Loader:Require('GComLogicCheck')

local CfgBase = Loader:Require('CfgBase')

-------------------------------------------------
-- 配置表处理
local os = require('os')

Cfgs = {}
ConfigParser = {
    m_mapConfigList = {},
    m_mapTableInfo = {}
    -- 配置表对应的文件名信息
}

function ConfigParser:SplipLine(str, p1)
    local r = {}

    if str == nil then
        return r
    end

    if p1 == nil then
        p1 = '\t'
    end
    local index = 1

    local str1 = str
    while str1 do
        local str2 = str1

        local n = string.find(str2, p1)
        if n == nil then
            r[index] = str2
            return r
        end

        r[index] = string.sub(str2, 1, n - 1)
        str1 = string.sub(str2, n + 1, #str2)

        index = index + 1
    end

    return r
end

function ConfigParser:LineParser(line)
    if not line then
        return
    end

    -- linux 不用\r结尾
    line = string.gsub(line, '\r', '')
    return self:SplipLine(line)
end

-- 格式化数值
function ConfigParser:FormatValue(val, typ)
    -- print("FormatValue", val, typ)
    -- LogDebug("##%s##", val)
    if typ == 'int' then
        if not val or val == '' then
            return
        end
        if not tonumber(val) then
            print('int val is illegality :' .. val)
            assert()
            return
        end
        return math.floor(tonumber(val))
    elseif typ == 'float' then
        return tonumber(val)
    elseif typ == 'string' then
        if val == '' then
            return nil
        end
        return val
    elseif typ == 'text' then
        if val == '' then
            return nil
        end
        return val
    elseif typ == 'bool' then
        if not val or val == '0' or val == 0 or val == '' then
            return false
        else
            return true
        end
    elseif typ == 'json' then
        -- val = "{"..val.."}"
        -- print(val)
        if val == '' then
            return nil
        end
        return Json.Decode(val)
    else
        -- 处理数组
        local n = string.find(typ, '[]', 1, true)
        if n ~= nil then
            if val == '' then
                return nil
            end
            local arrtyp = string.sub(typ, 1, n - 1)
            local arr = self:SplipLine(val, ',')

            for i, v in ipairs(arr) do
                arr[i] = self:FormatValue(v, arrtyp)
            end

            return arr
        else
            print('FormatValue', val, typ)
            LogDebug('unkown type of ' .. typ .. ', val = ' .. val)
            LogTrace()
            assert()
        end
    end
end

function ConfigParser:FormatTable(config, row, col, colnum)
    -- LogDebugEx("FormatTable", row, col, colnum)
    ASSERT(config.types[col + colnum], '二维数组表格列数大于实际列数')
    local tablelen = #config.data
    local ret = {}
    local rownum = 0

    for i = row + 1, tablelen do
        local val = config.data[i][col + 1]
        if not val or val == '' then
            break
        end
        rownum = rownum + 1
    end

    -- if config.sheetname == "礼物" then
    --     LogTable(config, "CfgGifts: colnum:" .. colnum .. " rownum:" .. rownum)
    -- end

    for i = row + 1, row + rownum do
        local data = config.data[i]
        local key = self:FormatValue(data[col + 1], config.types[col + 1])
        ret[key] = {}
        for j = col + 1, col + colnum do
            local name = config.names[j]
            local typ = config.types[j]

            -- if config.sheetname == "礼物" then
            --     print("key:", key, "j:", j, "name:", name, "typ:", typ)
            -- end

            ret[key][name] = self:FormatValue(data[j], typ)

            -- if config.sheetname == "礼物" then
            --     LogTable(ret, "Ret:")
            -- end
        end
    end
    -- DT(ret, "FormatTable "..rownum)
    return rownum, ret
end

function ConfigParser:GetTableSize(typ)
    local n = string.find(typ, 'table', 1, true)
    if n ~= nil then
        -- 读取子表
        local t = self:SplipLine(typ, '#')
        return tonumber(t[2])
    end
end

-- 合成表
function ConfigParser:Union()
    -- _G[filename]
    -- 表联合配置
    for k, v in pairs(ConfigUnion) do
        LogDebugEx('合成 ' .. v.name .. '=>' .. v.sUnionName)

        local unionTb = {}

        local mapTb = {arrUnion = {}, sheetname = v.sUnionName}
        self.m_mapTableInfo[v.sUnionName] = mapTb

        for _, item in ipairs(v.item) do
            -- LogDebugEx("--"..item.sCfgName..":"..item.sCfgKey)
            local cfgName = item.sCfgKey
            local cfgs = _G[cfgName]
            if cfgs then
                for _, cfg in pairs(cfgs) do
                    -- ASSERT(not _unionTb[key], "重复的id"..key)
                    if unionTb[cfg.id] then
                        ASSERT(false, string.format('配置表:%s, 的id:%s, 重复', cfgName, cfg.id))
                    end
                    unionTb[cfg.id] = cfg
                end

                _G[cfgName] = nil

                self.m_mapConfigList[cfgName] = nil
                table.insert(mapTb.arrUnion, self.m_mapTableInfo[cfgName])
                self.m_mapTableInfo[v.sUnionName].filename = self.m_mapTableInfo[cfgName].filename
                mapTb.filename = self.m_mapTableInfo[cfgName].filename
            end
        end

        _G[v.sUnionName] = unionTb
        self.m_mapConfigList[v.sUnionName] = v.sUnionName
    end
end

function ConfigParser:PrintByCar(char, charCnt, val)
    LogInfo(string.rep(char, charCnt) .. val)
end

function ConfigParser:SimpleShowTable(tb, title, deep)
    deep = deep or 1
    local charLen = deep * 4
    self:PrintByCar(' ', charLen, title)
    self:PrintByCar(' ', charLen, '{')
    for k, v in pairs(tb) do
        local vType = type(v)
        if vType == 'table' then
            self:SimpleShowTable(v, k, deep + 1)
        else
            self:PrintByCar(' ', charLen + 4, k .. ':' .. v .. '[' .. vType .. ']')
        end
    end
    self:PrintByCar(' ', charLen, '}')
end

-- 读取配置表到内存
function ConfigParser:ReadOneConfig(filename)
    local fullfileName = 'cfg' .. filename
    local config = require(fullfileName)

    -- Loader:AddReplaceFile(filename)
    -- LogInfo("Read[ " .. fullfileName .. " ]from[ " .. config.filename .. " ]->[ " .. config.sheetname .. "]")
    local takeColInfo = {}
    if config then
        self.m_mapTableInfo[filename] = {
            filename = config.filename,
            sheetname = config.sheetname,
            names = config.names,
            types = config.types
        }

        local newCfgs = {}

        local currrow = 0
        for k, data in ipairs(config.data) do
            local function TmpXpcallCB(msg, ...)
                LogInfo('-------------------配置表出错---------------------')
                LogInfo(config.filename .. '的 ' .. config.sheetname .. ' 第' .. (k + 5) .. '行')
                self:SimpleShowTable(takeColInfo, '报错的列信息:')
                LogInfo('LUA ERROR: ' .. tostring(msg) .. '\n')
                LogInfo(debug.traceback())
                self:SimpleShowTable({...}, 'TmpXpcallCB:')
                LogInfo('----------------------------------------')
            end

            local tmpRetOnLineFun = function()
                -- 导表工具，xpcall 只接受一个回调函数
                currrow = self:ReadOneLineLuaConfig(filename, newCfgs, config, currrow, k, data, takeColInfo)
            end

            local isCallOk = xpcall(tmpRetOnLineFun, TmpXpcallCB)
            if not isCallOk then
                ASSERT(false)
            end
        end

        _G[filename] = newCfgs
        _G[fullfileName] = nil
    end

    package.loaded[fullfileName] = nil
    -- LogInfo("loaded %s", fullfileName)
    -- table.print(_G[filename])
    ASSERT(_G[filename])
end

-- 读取配置表到内存
function ConfigParser:ReadLuaConfig()
    for k, filename in pairs(self.m_mapConfigList) do
        ConfigParser:ReadOneConfig(filename)
    end
end

function ConfigParser:ReadOneLineLuaConfig(filename, newCfgs, config, currrow, k, data, takeColInfo)
    if currrow >= k then
        -- 跳过二级table表结构的行
        -- print("ignore sub item ", k)
        return currrow
    end

    local tableRowNum = 0
    local t = {}
    local currcol = 0
    for i, name in ipairs(config.names) do
        if currcol >= i then
        else
            currcol = i
            local typ = config.types[i]

            takeColInfo['列名: '] = name
            takeColInfo['列类型: '] = typ

            if typ ~= '' then
                local num = self:GetTableSize(typ)
                if num and num > 0 then
                    local rownum, ret = self:FormatTable(config, k, i, num)
                    if rownum > 0 then
                        t[name] = ret
                        currcol = i + num
                        tableRowNum = tableRowNum < rownum and rownum or tableRowNum
                    else
                        t[name] = {}
                    end
                else
                    t[name] = self:FormatValue(data[i], config.types[i])
                end
            end
        end
    end

    currrow = k + tableRowNum

    if not t.key then
        t.key = t.id
    end

    if newCfgs[t.id] then
        LogTable(t, 't:')
        LogTable(newCfgs, 'newCfgs:')

        local info = self.m_mapTableInfo[filename]
        ASSERT(false, info.filename .. '-[' .. info.sheetname .. ']表中存在重复的id:' .. t.id)
    else
        newCfgs[t.id] = t
    end

    return currrow
end

function ConfigParser:SetGolble()
    -- 代码移动到，ConfigChecker:global_setting(cfgs)
    -- IS_CLIENT
end

function ConfigParser:GenCfgList(ConfigList)
    -- 真正有效的配置表
    self.m_mapConfigList = {}
    for k, v in pairs(ConfigList) do
        self.m_mapConfigList[v] = v
    end
end

function ConfigParser:GetCfgSheetName(cfgName)
    -- LogTable(self.m_mapTableInfo[cfgName], 'm_mapTableInfo')
    -- LogTable(self.m_mapConfigList[cfgName], 'm_mapConfigList')
    local cfgStructInfo = self.m_mapTableInfo[cfgName]
    return cfgStructInfo.sheetname
end

function ConfigParser:ClientConfig()
    -- local this = {};
    -- _G.CfgBase = Loader:Require('CfgBase');
    for k, v in pairs(self.m_mapConfigList) do
        LogDebugEx('load config:' .. k)
        local initData = _G[k]
        if initData then
            Cfgs[k] = CfgBase:New()
            Cfgs[k]:Init(_G[k])
        else
            if LogError then
                LogError('ConfigParser:ClientConfig()' .. k .. 'get nil')
            else
                print('ConfigParser:ClientConfig() ', k, 'get nil')
            end
        end
    end

    -- 需要全部配置检查完才检查的配置，key为表名，value随便配的
    local FinallyCheckConfig = {
        AvatarFrame = 1,
        CfgAvatar = 1,
        CfgShopPage = 1,
        CfgReturningActivity = 1,
        MainLine = 1,
        CfgMenuBg = 1
    }

    -- 检查/特殊处理以及设为只读
    for cfgName, _ in pairs(self.m_mapConfigList) do
        if ConfigChecker[cfgName] and not FinallyCheckConfig[cfgName] then
            local result, errmsg = pcall(ConfigChecker[cfgName], ConfigChecker, _G[cfgName])
            if errmsg then
                print(result, errmsg)
                ASSERT(false, '配置表出错' .. cfgName)
            end
        end
    end

    -- 检查/特殊处理以及设为只读(再检查一遍配置)
    for cfgName, _ in pairs(FinallyCheckConfig) do
        if self.m_mapConfigList[cfgName] then
            if ConfigChecker[cfgName] then
                local result, errmsg = pcall(ConfigChecker[cfgName], ConfigChecker, _G[cfgName])
                if errmsg then
                    print(result, errmsg)
                    ASSERT(false, '配置表出错' .. cfgName)
                end
            end
        end
    end

    -- 主键关联检查
    ConfigChecker:CheckPrimaryKey()
    ConfigChecker:CheckDungeon()

    -- 设置为只读
    -- for cfgName, _ in pairs(self.m_mapConfigList) do
    --     local cfgs = _G[cfgName]
    --     for k, cfg in pairs(cfgs) do
    --         cfgs[k] = table.ReadOnly(cfg)
    --     end

    --     _G[cfgName] = table.ReadOnly(cfgs)
    -- end

    return Cfgs
end

function ConfigParser:LoadConfig(filename)
    -- print("--------LoadConfig------------", filename)
    ConfigParser:ReadOneConfig(filename)
    Cfgs[filename] = CfgBase:New()
    Cfgs[filename]:Init(_G[filename])
    -- LogError(Cfgs[filename])
end
