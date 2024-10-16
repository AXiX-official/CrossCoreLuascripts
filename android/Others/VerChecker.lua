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
    local url = self.test_url or "https://cdn.megagamelog.com/cross/release/fix.txt";
    CSAPI.WebPostRequest(url,nil,function (str)
        Log(str);
        local func = loadstring(str);
        func(); 
    end);
end

function this:ApplyUpdate()
    local dialogData = {};    
    dialogData.caller = self;
    dialogData.content = LanguageMgr:GetTips(1049);
    dialogData.okCallBack =  self.UpdateVer;
    --dialogData.cancelCallBack = self.UpdateVer;
    CSAPI.OpenView("Prompt",dialogData);
end

function this:UpdateVer()
    CSAPI.Quit();
end

function this:EnableTest()
    self.test_url = "http://192.168.5.53/fix.txt";--内网测试
    self:SetState(true);
end

return this;