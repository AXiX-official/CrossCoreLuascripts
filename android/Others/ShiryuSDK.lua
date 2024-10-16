--local this=MgrRegister("ShiryuSDK")
require "AdvGoogleGit";
require "AdvGuiDeScore"
require "AdvBindingRewards"
require "AdvDeductionvoucher"
require "AdaptiveConfiguration"
require "RegionalSet"
ShiryuSDK={}
local  this=ShiryuSDK;

if CSAPI.IsADV() or CSAPI.IsDomestic() then
MJSdkManagerImpl=CS.MJSdkBridge.MJSdkManagerImpl:GetInstance();
CShiryuSDK=CS.ShiryuSDK.Instance;
end
---2.SDK获取数据
this.SdkProperties={}
this.SdkProperties.gid=0;
this.SdkProperties.cid=0;
this.SdkProperties.cid2=0;
this.SdkProperties.channelProperties={}  --词典--Item ：1.appKey 2.channelId 3.ecid 4.deviceId
---3.登录获取数据返回（数据需要上传到游戏服务器）
this.ShiryuLogin={}
this.ShiryuLogin.success=false;
this.ShiryuLogin.uid="";
this.ShiryuLogin.token="";
this.ShiryuLogin.channelExts={} ---opcode、operators、appKey、channelId、ecid、deviceId，did（打点参数）


this.ShiryuGoodsList={}
this.ShiryuGoodsList.success=false;
this.ShiryuGoodsList.goodsList= { };

this.GetSdkProperties={};
--Item:
---skuCode string      充值id
---productName string  商品名称
---amount  int  定价商品价格（单位分）
---currency  string  定价币种
---productDesc  string  充值商品描述。
---goodsId  string  应用商店的商品id
---voucherId  string  这个商品对应使用的抵扣劵ID
---type int  1应用内商品，2预注册，3礼品码，4订阅型商品, 5应用外商品, 6抵扣券
--- displayCurrency  string  显示币种的标准货币代码（例如：USD，CNY）
--- displayPrice   string  显示价格
---服务端返回登录数据
this.Serverlogin={}

---脚本是否重复初始化
this.IsInit=false;
---SDK初始化 是否成功
this.SDKinit=false;
---登录页面  切换账号
this.LoginViewSwitchAccounts=false;
---是否已经进入大厅
this.IsEnterhall=false;
function this.Init()
    if this.IsInit then return; end
    this.IsInit=true
    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        Log("zilong SDK Init  ----start")
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_Init_complete,this.SDKShiryuSDKInitcomplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_GetSdkProperties_complete,this.SDKShiryuSDKGetSdkPropertiescomplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_Login_complete,this.SDKShiryuSDKLogincomplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_SetLogoutCallback_complete,this.SDKShiryuSDKSetLogoutCallbackcomplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_GetGoodsList_complete,this.SDKShiryuSDKGetGoodsListcomplete)
        CSAPI.AddEventListener(EventType.SDK_ShiryuSDK_Pay_complete,this.SDKShiryuSDKPaycomplete)
    end
end
---1.SDK初始化完成返回
function this.SDKShiryuSDKInitcomplete(datapacket)
    Log("-zilong--SDK init Success--------end---------------")
    this.LoginSDK();
end

function this.LoginSDK()
    if this.SDKinit then
        if this.ShiryuLogin.success==false then
            Log("----------GetCommonData--------Rest----------------")
            CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_GetSdkProperties)
            CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_Login)
            this.GetCommonData();
        end
        return;
    end
    this.SDKinit=true
    this.SDKinterfacelisten();


    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_GetSdkProperties)
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_Login)
    this.GetCommonData();
end

---获取通用常规数据
function this.GetCommonData()
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_GetGoodsList)
end
---2.获取SDK数据
function this.SDKShiryuSDKGetSdkPropertiescomplete(datapacket)
    --print("--------Lua 输出数据"..table.tostring(datapacket))
    this.GetSdkProperties={};
    local isAdv = CSAPI.IsADV()
    if datapacket then
        for i, v in pairs(datapacket) do
            -- print("--------Lua--------key:"..i.." value:"..v);
            this.GetSdkProperties[i]=v;
            if isAdv and tostring(i)=="ecid" then
                AdvGoogleGit.ecid=v;
                AdvGuiDeScore.Setecid(v)
            end
        end
    end
end

---4.登录数据返回
function this.SDKShiryuSDKLogincomplete(datapacket)
    this.ShiryuLogin={}
    this.ShiryuLogin.success=datapacket.success;
    this.ShiryuLogin.uid=datapacket.uid;
    this.ShiryuLogin.token=datapacket.token;
    this.ShiryuLogin.channelExts={}
    local isAdv = CSAPI.IsADV()
    if datapacket.channelExts then
        for i, v in pairs(datapacket.channelExts) do
            --print("key:"..i.." value:"..v);
            this.ShiryuLogin.channelExts[i]=v;
            if isAdv and tostring(i)=="ecid" then
                AdvGoogleGit.ecid=v;
                AdvGuiDeScore.Setecid(v)
            end
        end

    end
    if this.ShiryuLogin.success then
        this.GetCommonData();
        Log("-------------Login -success---------------------")
    else
        Log("-------------Login -fail-----------------------")
    end
end

---5.退出登录成功返回
function this.SDKShiryuSDKSetLogoutCallbackcomplete(datapacket)
    ---LogError("SDKShiryuSDKSetLogoutCallbackcomplete")
    ---LogError(datapacket)
end
---8.获取商品列表返回
function this.SDKShiryuSDKGetGoodsListcomplete(datapacket)

    if CSAPI.IsADV() or CSAPI.IsDomestic() then        
        this.ShiryuGoodsList={}
        this.ShiryuGoodsList.success=datapacket.success;
        this.ShiryuGoodsList.goodsList= { };
        if datapacket.goodsList  then
            local index=0;
            for i, v in pairs(datapacket.goodsList) do
                index=index+1
                local Item={}
                Item.skuCode=datapacket.goodsList[i].skuCode;
                Item.productName=datapacket.goodsList[i].productName;
                Item.amount=datapacket.goodsList[i].amount;
                Item.currency=datapacket.goodsList[i].currency;
                Item.productDesc=datapacket.goodsList[i].productDesc;
                Item.goodsId=datapacket.goodsList[i].goodsId;
                Item.voucherId=datapacket.goodsList[i].voucherId;
                Item.type=datapacket.goodsList[i].type;
                Item.displayCurrency=datapacket.goodsList[i].displayCurrency;
                Item.displayPrice=datapacket.goodsList[i].displayPrice;
                table.insert(this.ShiryuGoodsList.goodsList,index,Item)
            end
        end
        this.InitShopData()
    end
    --Item:
    ---skuCode string      充值id
    ---productName string  商品名称
    ---amount  int  定价商品价格（单位分）
    ---currency  string  定价币种
    ---productDesc  string  充值商品描述。
    ---goodsId  string  应用商店的商品id
    ---voucherId  string  这个商品对应使用的抵扣劵ID
    ---type int  1应用内商品，2预注册，3礼品码，4订阅型商品, 5应用外商品, 6抵扣券
    --- displayCurrency  string  显示币种的标准货币代码（例如：USD，CNY）
    --- displayPrice   string  显示价格
end

---首次 初始化表后，进行对基础表增加或者修改内容，根据SDK返回
function this.InitShopData()

    for i, v in pairs(this.ShiryuGoodsList.goodsList) do
        local id=0;
        id=tonumber(this.ShiryuGoodsList.goodsList[i].skuCode);
        local TableShop=Cfgs.CfgCommodity:GetByID(id)
        if TableShop then
            --Cfgs.CfgCommodity:GetByID(id).sName=this.ShiryuGoodsList.goodsList[i].productName      ---string  商品名称
            --Cfgs.CfgCommodity:GetByID(id).sDesc=this.ShiryuGoodsList.goodsList[i].productDesc      --- string  充值商品描述。
            --Cfgs.CfgCommodity:GetByID(id).jCosts[1][2]=tonumber(this.ShiryuGoodsList.goodsList[i].displayPrice)   ---string  显示价格
            Cfgs.CfgCommodity:GetByID(id).currency=this.ShiryuGoodsList.goodsList[i].currency         ---string  定价币种
            Cfgs.CfgCommodity:GetByID(id).amount=this.ShiryuGoodsList.goodsList[i].amount           ---int  定价商品价格（单位分）
            Cfgs.CfgCommodity:GetByID(id).goodsId=this.ShiryuGoodsList.goodsList[i].goodsId          ---string  应用商店的商品id
            Cfgs.CfgCommodity:GetByID(id).voucherId=this.ShiryuGoodsList.goodsList[i].voucherId        ---string  这个商品对应使用的抵扣劵ID
            Cfgs.CfgCommodity:GetByID(id).type=this.ShiryuGoodsList.goodsList[i].type             ---int  1应用内商品，2预注册，3礼品码，4订阅型商品, 5应用外商品, 6抵扣券
            Cfgs.CfgCommodity:GetByID(id).displayCurrency=this.ShiryuGoodsList.goodsList[i].displayCurrency  ---string  显示币种的标准货币代码（例如：USD，CNY）
            Cfgs.CfgCommodity:GetByID(id).displayPrice=this.ShiryuGoodsList.goodsList[i].displayPrice  ---string  显示价格
            --Cfgs.CfgCommodity:GetByID(id).displayPrice=tonumber(999)   ---string  显示价格
            --Cfgs.CfgCommodity:GetByID(id).displayCurrency="jyp"  ---string  显示币种的标准货币代码（例如：USD，CNY）
        end
    end
end

---节点数据修改
function this.ShopDataEdit(data)
    if this.IsShopExist(data["id"]) then
        --LogError("----------------满足条件的ID-----------"..data["id"])
        --LogError(data)
        for i, v in pairs(this.ShiryuGoodsList.goodsList) do
            local id=tonumber(data["id"]);
            if tostring(this.ShiryuGoodsList.goodsList[i].skuCode)==tostring(id)  then
                --                 data["sName"]=this.ShiryuGoodsList.goodsList[i].sName  ---string  商品名称
                --                 data["sDesc"]=this.ShiryuGoodsList.goodsList[i].sDesc  --- string  充值商品描述。
                --data["shop_config"]["jCosts"][1][2]=tonumber(this.ShiryuGoodsList.goodsList[i].displayPrice) ---string  显示价格
                data["currency"]=this.ShiryuGoodsList.goodsList[i].currency ---string  定价币种
                data["amount"]=this.ShiryuGoodsList.goodsList[i].amount ---int  定价商品价格（单位分）
                data["goodsId"]=this.ShiryuGoodsList.goodsList[i].goodsId  ---string  应用商店的商品id
                data["voucherId"]=this.ShiryuGoodsList.goodsList[i].voucherId  ---string  这个商品对应使用的抵扣劵ID
                data["type"]=this.ShiryuGoodsList.goodsList[i].type ---int  1应用内商品，2预注册，3礼品码，4订阅型商品, 5应用外商品, 6抵扣券
                data["displayCurrency"]=this.ShiryuGoodsList.goodsList[i].displayCurrency ---string  显示币种的标准货币代码（例如：USD，CNY）
                data["displayPrice"]=this.ShiryuGoodsList.goodsList[i].displayPrice  ---string  显示价格
                --data["displayPrice"]=tonumber(999) ---string  显示价格
                --data["displayCurrency"]="jyp"  ---string  显示价格
                return data;
            end
        end
    end
    return data;
end
---判断是否存在
function this.IsShopExist(id)
    if this.ShiryuGoodsList.goodsList then
        for i, v in pairs(this.ShiryuGoodsList.goodsList) do
            if tostring(this.ShiryuGoodsList.goodsList[i].skuCode)==tostring(id) then
                return true;
            end
        end
    end
    return false;
end


---9. 支付返回
function this.SDKShiryuSDKPaycomplete(datapacket)
    EventMgr.Dispatch(EventType.Shop_Buy_Mask,false);
    --  Log("SDKShiryuSDKGetGoodsListcomplete")
    Log("---------------Payment successful---------------")
    if datapacket.success then
        CSAPI.DispatchEvent(EventType.SDK_Deduction_voucher_paymentcompleted)
        SDKPayMgr:SearchPayReward(true);
    else
        if CSAPI.IsDomestic and  CSAPI.IsDomestic() then

        else
            Tips.ShowTips(LanguageMgr:GetTips(1011));
        end
    end
end

---SDK 初始化成功，接口监听集合
function this.SDKinterfacelisten()
    ShiryuSDK.SetLogoutCallback(ShiryuSDK.LogoutCallback)
    if CSAPI.IsADV() then
        ShiryuSDK.SetCheckGiftCallback(ShiryuSDK.CheckGiftCallback)
    end

end
----------------------------------------------SDK监听回调区域下---------------------------------------------------------------------------------------
function this.LogoutCallback(Success)
    if Success then
        Log("-------------SDK logout-----------------------")
        this.IsEnterhall=false;
        this.ShiryuLogin={}
        this.ShiryuLogin.success=false;
        this.ShiryuLogin.uid="";
        this.ShiryuLogin.token="";
        this.ShiryuLogin.channelExts={} ---opcode、operators、appKey、channelId、ecid、deviceId
        this.IsEnterhall=false;
        if this.LoginViewSwitchAccounts then
            this.LoginViewSwitchAccounts=false;
            CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_Login)
        else
            if CSAPI.IsChannel() then
                EventMgr.Dispatch(EventType.Login_SDK_LogoutCommand,nil,true)
            end
            PlayerClient:SDKExit();
            PlayerClient:Clearuid();

            --ClientProto:Offline()
            --MgrCenter:Clear();
            --EventMgr.Dispatch(EventType.Login_Quit,nil,true);
            --if CSAPI.IsChannel() then
            --    EventMgr.Dispatch(EventType.Login_SDK_LogoutCommand,nil,true)
            --end
            --LoginProto:Logout();
            --PlayerClient:Clearuid()
        end

    else
        Log("接收到异常退出 失败")
    end
end


function this.CheckGiftCallback(MJGoodsLit)
    print("接收到消息返回：")
    print("接收到消息返回MJGoodsLit："..table.tostring(MJGoodsLit))
    AdvGoogleGit.SDKBackAdvGoogleGitTrue=true;
    if this.IsEnterhall then

        AdvGoogleGit.GoogleReservationRewards();

    else
        print("有奖励，但是处于数据准备阶段")
    end


end


----------------------------------------------SDK监听回调区域上---------------------------------------------------------------------------------------


---1：初始化SDK
function this.InitSdk(MJSdkEnv,SDKInitCallback)
    MJSdkManagerImpl:InitSdk(MJSdkEnv,SDKInitCallback);
end
---2:获取数据
if CSAPI.IsADV() or CSAPI.IsDomestic() then
this.GetSdkProperties=MJSdkManagerImpl.GetSdkProperties;
end

---3.是否是审核状态接口
function this.IsReview()
    return CShiryuSDK:IsReview();
end
---4:登录
function this.Login(SDKLoginCallback)
    MJSdkManagerImpl:Login(SDKLoginCallback);
end
---5：登出---退出账号/切换账号时候
function this.Logout()
    print("====================================unity Logout")
    MJSdkManagerImpl:Logout();
end
---6：SDK登出账号成功，游戏需在此做游戏切换账号操作
function this.SetLogoutCallback(SDKLogoutCallback)
    MJSdkManagerImpl:SetLogoutCallback(SDKLogoutCallback);
end
---7_1：角色上报_创建角色
function this.CreateRole()
    ---发送结构参考
    local roleInfoTable={}
    local serverInfo = GetCurrentServer();
    roleInfoTable.uid=PlayerClient:GetUid();
    roleInfoTable.serverId=serverInfo.id;
    roleInfoTable.serverName=serverInfo.serverName;
    roleInfoTable.roleId=PlayerClient:GetUid();
    roleInfoTable.roleLevel=PlayerClient:GetLv();
    roleInfoTable.roleName=PlayerClient:GetName();
    roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
    roleInfoTable.createSecs=PlayerClient:GetCreateTime();
    roleInfoTable.battleStrength=0;
    roleInfoTable.vipLevel=0;
    roleInfoTable.guildId="";
    roleInfoTable.guildLeaderName="";
    roleInfoTable.guildLeaderUid="";
    roleInfoTable.guildName="";
    roleInfoTable.guildLeaderRoleId="";
    roleInfoTable.guildLevel="";
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_OnCreateRole,roleInfoTable)
end

---7_2：角色登录进入服务器
function this.OnLoginServer()
    Log("----------------------角色登录进入服务器-------------------------------")
    local roleInfoTable={}
    local serverInfo = GetCurrentServer();
    roleInfoTable.uid=PlayerClient:GetUid();
    roleInfoTable.serverId=serverInfo.id;
    roleInfoTable.serverName=serverInfo.serverName;
    roleInfoTable.roleId=PlayerClient:GetUid();
    roleInfoTable.roleLevel=PlayerClient:GetLv();
    roleInfoTable.roleName=PlayerClient:GetName();
    roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
    roleInfoTable.createSecs=PlayerClient:GetCreateTime();
    roleInfoTable.battleStrength=this.GetbattleStrength();
    roleInfoTable.vipLevel=0;
    roleInfoTable.guildId="";
    roleInfoTable.guildLeaderName="";
    roleInfoTable.guildLeaderUid="";
    roleInfoTable.guildName="";
    roleInfoTable.guildLeaderRoleId="";
    roleInfoTable.guildLevel="";
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_OnLoginServe,roleInfoTable)


end
---7_3：角色数据更新
function this.OnRoleInfoUpdate()
    Log("----------------------角色数据更新-------------------------------")
    local roleInfoTable={}
    local serverInfo = GetCurrentServer();
    roleInfoTable.uid=PlayerClient:GetUid();
    roleInfoTable.serverId=serverInfo.id;
    roleInfoTable.serverName=serverInfo.serverName;
    roleInfoTable.roleId=PlayerClient:GetUid();
    roleInfoTable.roleLevel=PlayerClient:GetLv();
    roleInfoTable.roleName=PlayerClient:GetName();
    roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
    roleInfoTable.createSecs=PlayerClient:GetCreateTime();
    roleInfoTable.battleStrength=this.GetbattleStrength();
    roleInfoTable.vipLevel=0;
    roleInfoTable.guildId="";
    roleInfoTable.guildLeaderName="";
    roleInfoTable.guildLeaderUid="";
    roleInfoTable.guildName="";
    roleInfoTable.guildLeaderRoleId="";
    roleInfoTable.guildLevel="";
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_OnRoleInfoUpdate,roleInfoTable)
end


function this.GetbattleStrength()
    local   teamData=TeamMgr:GetTeamData(1,true)
    local haloStrength=teamData:GetHaloStrength();
    local battleStrength= teamData:GetTeamStrength()+haloStrength
    Log("-------------------------battleStrength------------"..tostring(battleStrength))
    return  battleStrength;
end
---7_4：设置角色名称
function this.OnSetRoleName(roleInfo)
    local roleInfoTable={}
    local serverInfo = GetCurrentServer();
    roleInfoTable.uid=PlayerClient:GetUid();
    roleInfoTable.serverId=serverInfo.id;
    roleInfoTable.serverName=serverInfo.serverName;
    roleInfoTable.roleId=PlayerClient:GetUid();
    roleInfoTable.roleLevel=PlayerClient:GetLv();
    roleInfoTable.roleName=PlayerClient:GetName();
    roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
    roleInfoTable.createSecs=PlayerClient:GetCreateTime();
    roleInfoTable.battleStrength=this.GetbattleStrength();
    roleInfoTable.vipLevel=0;
    roleInfoTable.guildId="";
    roleInfoTable.guildLeaderName="";
    roleInfoTable.guildLeaderUid="";
    roleInfoTable.guildName="";
    roleInfoTable.guildLeaderRoleId="";
    roleInfoTable.guildLevel="";
    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_OnSetRoleName,roleInfoTable)
end

---10：游戏退出杀死进程
function this.ExitGame()
    MJSdkManagerImpl:ExitGame();
end

---11.游戏事件上报接口   （调试异常）
function this.TrackEvent(eventName,eventToken,data)
    if eventToken==nil then eventToken="" end
    if data==nil then data= { } end
    CShiryuSDK:TrackEvent(eventName,eventToken,data);
end
---12.此接口获取当前登录的账号是否已绑定
---如果返回False，需要提供一个按钮让用户去绑定页面
---如果是True并且游戏后台记录用户还没领取过奖励，则显示“领取”按钮
function this.IsNeedBinding()
    return CShiryuSDK:IsNeedBinding();
end
-----13.打开绑定账号页面  (存在不回调，Bug未解决)
-----调用此接口打开SDK绑定页面 请在回调里面更新“绑定/领取”按钮的状态
function this.ToBindingPage(action)
    return CShiryuSDK:ToBindingPage(action);
end
-----14.用户中心接口 此接口用于打开用户用心此接口不需要参数和回调
function this.ShowUserCenter()
    return CShiryuSDK:ShowUserCenter();
end
-----15.此接口打开一个页面，如公告，隐私协议，用户协议等
--- 输入值1-20  具体查看C# 枚举类型
function this.ShowSdkCommonUI(type)
    return CShiryuSDK:ShowSdkCommonUI(type);
end
---16.判断显示评价的条件
---只有这个方法返回值等于true，并且满足紫龙要求的显示评价的条件才能弹窗要求用户去评价。
function this.CanShowRateUs()
    return CShiryuSDK:CanShowRateUs();
end
-----17.游戏内评分接口 游戏在指定的时机调用游戏内评分功能，引导玩家在appstore或者google play store为游戏进行评分
function this.RateUs()
    CShiryuSDK:RateUs();
end
-----18.游戏权限检查接口
function this.CheckPermission(mjSdkPermissionType,action)
    CShiryuSDK:CheckPermission(mjSdkPermissionType,action);
end
-----19.游戏动态授权接口 游戏在使用权限功能时，如果没有权限，需要先调用sdk接口获取相关权限。
function this.RequestPermission(mjSdkPermissionType,action)
    CShiryuSDK:RequestPermission(mjSdkPermissionType,action);
end
-----20.扫描PC二维码登录接口
---Unity编辑器 无法调试
function this.DoStartQRLogin(action)
    CShiryuSDK:DoStartQRLogin(action);
end
-----21.监听待领取的奖励
-----此接口在每次进入区服后都要调用
---此接口在有待领取的奖励时才会回调
-----收到回调后请在合适的时机弹窗询问用户是否将该奖励领取到当前角色
---弹窗条件：
---1、解锁邮件系统已经解锁。
---2、不在强制引导/战斗状态。
---3、如果收到回调时不满足上面两条件，则在满足上面两条件后马上弹出领取提示窗
function this.SetCheckGiftCallback(checkGiftCallback)
    CShiryuSDK:SetCheckGiftCallback(checkGiftCallback);
end
-----22.玩家进到游戏后，判断是否有奖励，如果有奖励，在领取奖励页面点击领取调用此接口  需要第21条返回为true 调用
function this.ClaimGift(paymentInfo,action)
    return CShiryuSDK:ClaimGift(paymentInfo,action);
end


----- 23.打开活动接口 游戏首页“活动”按钮调用此接口
function this.ShowActivityUI(action)
    CShiryuSDK:ShowActivityUI(action);
end
-----  24.信息通知显示红点接口
-----游戏中的UI上有一些和平台SDK功能相关的按钮，这些按钮有些需要在某些通知事件发生时显示红点以提醒玩家。
-----游戏在适当的时机调用此接口检查信息的状态，并根据查询结果在对应的地方显示红点通知。
-----例如玩家在客服中心提的客服问题，如果客服有答复了，会在“问题解答”按钮上提示红点
---参数1，2,3
function this.QueryRedDotState(mjSdkNoticeType,action)
    CShiryuSDK:QueryRedDotState(mjSdkNoticeType,action);
end
----- 25.设置语言接口
-----游戏在每次设置游戏语言的时候，需要调用此接口来设置sdk的语言，使sdk的相关界面或者提示中的语言保持和游戏语言一致。
---EN = "en";//英文
---TW = "zh";//繁体
---KR = "ko";//韩语
---JP = "ja";//日语
---CN = "zh_TW";//简体
function this.SetLanguage(language)
    CShiryuSDK:SetLanguage(language);
end
----- 26.抵扣券点数查询接口  （需要进入服务器后才能调）
----- 此接口用于查询用户的抵扣券点数信息
function this.QueryPoints(action)
    CShiryuSDK:QueryPoints(action);
end
-----27.抵扣点数支付接口
-----游戏需要在玩家点击一个抵扣点数，尝试进行一次充值时调用该方法。
-----支付结果请以服务端通知为准
function this.PayPoints(paymentInfo,action)
    CShiryuSDK:PayPoints(paymentInfo,action);
end
---28.分享
function this.Share(Jsonstr,action)
    ---参考发送结构 最后转成Json
    --local ShareTable=
    --{
    --    ["Text"]="分享测试内容，分享测试内容",---分享的内容。
    --    ["Title"]="分享测试标题",---分享的标题。
    --    ["ImagePath"]="Application.persistentDataPath".."/Share.jpg",---分享的链接。
    --    ["thumbImagePath"]="Application.persistentDataPath".."thumbShare.jpg",---分享缩略图图片的本地存储地址。要求缩略图为PNG格式大小不超过32k。
    --    ["Url"]="",---分享的链接。
    --    ["shareType"]=tonumber(2),---分享类型，具体的值见下面表格。
    --    ["sharePlatform"]=tonumber(8),---分享平台，具体的值说明见下面表格。
    --    ["para"]="",---分享参数，个别特殊分享使用。例如社区分享的GaragePainting，GaragePaintingCode
    --}
    -- local Jsonstr = Json.Encode(ShareTable)
    CShiryuSDK:Share(Jsonstr,action);
end

---在线
function this.OnRoleOnline()
    if  this.ShiryuLogin.success then

        local roleInfoTable={}
        local serverInfo = GetCurrentServer();
        roleInfoTable.uid=PlayerClient:GetUid();
        roleInfoTable.serverId=serverInfo.id;
        roleInfoTable.serverName=serverInfo.serverName;
        roleInfoTable.roleId=PlayerClient:GetUid();
        roleInfoTable.roleLevel=PlayerClient:GetLv();
        roleInfoTable.roleName=PlayerClient:GetName();
        roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
        roleInfoTable.createSecs=PlayerClient:GetCreateTime();
        roleInfoTable.battleStrength=this.GetbattleStrength();
        roleInfoTable.vipLevel=0;
        roleInfoTable.guildId="";
        roleInfoTable.guildLeaderName="";
        roleInfoTable.guildLeaderUid="";
        roleInfoTable.guildName="";
        roleInfoTable.guildLeaderRoleId="";
        roleInfoTable.guildLevel="";
        CShiryuSDK:OnRoleOnline(roleInfoTable);
    end

end
---离线
function this.OnRoleOffline()
    if  this.ShiryuLogin.success then
        local roleInfoTable={}
        local serverInfo = GetCurrentServer();
        roleInfoTable.uid=PlayerClient:GetUid();
        roleInfoTable.serverId=serverInfo.id;
        roleInfoTable.serverName=serverInfo.serverName;
        roleInfoTable.roleId=PlayerClient:GetUid();
        roleInfoTable.roleLevel=PlayerClient:GetLv();
        roleInfoTable.roleName=PlayerClient:GetName();
        roleInfoTable.gameCoins=PlayerClient:GetCoin(10002);
        roleInfoTable.createSecs=PlayerClient:GetCreateTime();
        roleInfoTable.battleStrength=this.GetbattleStrength();
        roleInfoTable.vipLevel=0;
        roleInfoTable.guildId="";
        roleInfoTable.guildLeaderName="";
        roleInfoTable.guildLeaderUid="";
        roleInfoTable.guildName="";
        roleInfoTable.guildLeaderRoleId="";
        roleInfoTable.guildLevel="";
        CShiryuSDK:OnRoleOffline(roleInfoTable);
    end

end

---关闭支付页面
function this.ClosePurchasePage(gameOrderId)
    if CSAPI.IsDomestic() then
        CShiryuSDK:ClosePurchasePage(gameOrderId);
    end
end

function this.GetDeviceID()
    local deviceId=this.ShiryuLogin.channelExts["deviceId"];
    --print("设备 ID："..deviceId)
    return deviceId;
end
this.Init();