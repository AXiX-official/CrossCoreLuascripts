
---热更新资源版本号控制
_G.g_HotResVersion=1;
--版本检测
VerChecker = {};
local this = VerChecker;

function this:SetState(state)
    self.state = state;
end

--检测
function this:ApplyCheck()
    if(not self.state)then
        return;
    end
    local url;
    if CSAPI.IsADV() then
        ---国内不可跟随该方法，除非重新出包更新C#代码
        --url = CSAPI.HotFileUrl().."/ClientHotRes/fix.txt";
        url = CSAPI.PlatformURL().."/ClientHotRes/fix.txt";
        ---LogError("_G.g_HotResVersion:".._G.g_HotResVersion)
        CSAPI.GetServerInfo(url,function (str)
            Log(str);
            if str~=nil and str~=" " then
                local matchResult = string.match(str, "_G.g_HotResVersion")
                if matchResult then
                    local func = loadstring(str);
                    func();
                else
                  ---  LogError("HotRes获取:"..url.."异常数据内容未包含指定内容:"..tostring(str));
                end
            else
                ---LogError("HotRes获取:"..url.."异常数据内容:"..tostring(str));
            end
        end);
    else
        ---url 兼容处理
        if  CSAPI.HotFileUrl and CSAPI.HotFileUrl() and StringUtil:IsEmpty(CSAPI.HotFileUrl()) == false then
           ---新版本
           url = CSAPI.HotFileUrl().."/fix.txt";
        else
            ---旧版本兼容
            url = self.test_url or "https://cdn.megagamelog.com/cross/release/fix.txt";
        end
        CSAPI.GetServerInfo(url,function (str)
            Log(str);
            if str~=nil and str~=" " then
                local matchResult = string.match(str, "g_svnVersion")
                if matchResult then
                    local func = loadstring(str);
                    func();
                else
                   --- LogError("HotRes获取:"..url.."异常数据内容未包含指定内容:"..tostring(str));
                end
            end
        end);
    end

end

function this:ApplyUpdate()
    local dialogData = {};
    dialogData.caller = self;
    dialogData.content = LanguageMgr:GetTips(1049);
    dialogData.okCallBack =  self.UpdateVer;
    --dialogData.cancelCallBack = self.UpdateVer;
    CSAPI.OpenView("Prompt",dialogData);
    --测试时候使用
    if PlayerClient:GetUid()~=nil then
        LogError("测试使用正式关闭_触发热更新强制更新玩家:"..PlayerClient:GetUid())
    end
end

function this:UpdateVer()
    if CSAPI.IsADV() then
        CSAPI.UnityQuit();
    else
        CSAPI.Quit();
    end
end

function this:EnableTest()
    self.test_url = "http://192.168.5.53/fix.txt";--内网测试
    self:SetState(true);
end

return this;