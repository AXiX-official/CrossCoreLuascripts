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
    local url = "https://cdn.megagamelog.com/cross/release/fix.txt";
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
return this;