
function Awake()
    --EventMgr.AddListener(EventType.Scene_Load_Complete,OnSceneLoadComplete);
    EventMgr.AddListener(EventType.Game_Log_Changed,OnGameLogChanged); 
    EventMgr.AddListener(EventType.Show_Prompt,OnShowPrompt);    
    EventMgr.AddListener(EventType.Web_Error,OnWebError);   
    --EventMgr.AddListener(EventType.Game_Quality_Changed,OnGameQualityChanged);    
    --SetGameLv(CSAPI.GetImgLv());
end

--function OnGameQualityChanged(lv)
--   SetGameLv(CSAPI.GetImgLv());
--end

function OnGameLogChanged(logState)
    _G.noLog = not logState;
end


function OnShowPrompt(content)
    CSAPI.OpenView("Prompt", 
    {
        content = content,
    });
end

function OnWebError(param)
    CSAPI.OpenView("Prompt", 
    {
        content = LanguageMgr:GetByID(38013),
    });
end