--版本设置
local this = {};
function this:Init()
    --语言设置
    ---1:中国内陆
    ---2：港澳台
    ---3：日语
    ---4：英文
    ---5：韩国
    LanguageMgr:ChangeLanguage(RegionalSet.CurrentRegion)
end


return this;