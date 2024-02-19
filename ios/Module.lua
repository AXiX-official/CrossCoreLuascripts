--��������Ϣ
_G.PlayerClient = require "PlayerClient";

_G.ChannelWebUtil=require "ChannelWebUtil";

_G.GridDataBase = require "GridDataBase";
_G.GridObjectData = require "GridObjectData";
_G.CharacterCardsData = require "CharacterCardsData"
_G.MonsterCardsData = require "MonsterCardsData"

--提示
_G.GShowTipor = require "GShowTipor";
_G.TipsData = require "TipsData";
_G.TipsMgr = require "TipsMgr";

--关卡数据
_G.SectionData = require "SectionData";--章节
_G.DungeonData = require "DungeonData";--副本
_G.DungeonGroupData = require "DungeonGroupData"; --副本
_G.DungeonBoxData = require "DungeonBoxData"; --副本星级
_G.DungeonOpenInfo = require "DungeonOpenInfo";--活动副本开启信息

--base64
_G.Base64=require "Base64"
--文件工具类
_G.FileUtil = require "FileUtil";

--Exp工具类
_G.ExpBar = require "ExpBar";
_G.SVCenterDrag=require "SVCenterDrag"

_G.FriendInfo = require "FriendInfo"

--排序类
_G.EquipSortUtil = require "EquipSortUtil";
_G.AssistSortUtil = require "AssistSortUtil";

--掉落物品
_G.RewardUtil = require "RewardUtil";

--����
-- _G.BagMgr = require "BagMgr";
--��Ʒ����
_G.GoodsData = require "GoodsData";
--��ɫ��Ʒ����
_G.CharacterGoodsData = require "CharacterGoodsData";

--关卡信息工具类
_G.DungeonUtil = require "DungeonUtil"
--战场信息工具类
_G.BattleFieldUtil = require "BattleFieldUtil"
--释放管理
require "ReleaseMgr"
--战棋
require "MapTranslatorClient"
require "BattleMgr"

--require("GCalculatorHelp")
require("GComLogicCheck");

_G.TeamItemData = require "TeamItemData"
_G.TeamData = require "TeamData"
_G.FormationTable = require "FormationTable"
--��ɹ�����
_G.FormationUtil = require "FormationUtil";
--������ݹ�����
-- _G.TeamMgr = require "TeamMgr";
-- _G.AIStrategyMgr=require "AIStrategyMgr"
_G.CardAIPreset=require "CardAIPreset"
_G.CardSkillPreset=require "CardSkillPreset"
_G.TeamConfirmUtil = require "TeamConfirmUtil"
_G.GridUtil = require "GridUtil"
require "EquipCalculator"
--装备
_G.StuffArray = require "StuffArray";
_G.EquipCommon = require "EquipCommon";
-- _G.EquipInfoItem=require "EquipInfoItem";
_G.EquipData = require "EquipData";
-- _G.EquipMgr = require "EquipMgr";
--商城
_G.ShopPageData = require "ShopPageData"
_G.ShopCommFunc = require "ShopCommFunc"
_G.CommodityData = require "CommodityData"
_G.ShopSkinInfo=require "ShopSkinInfo"
_G.RandCommodityData = require "RandCommodityData"
_G.ShopPromote=require "ShopPromote"
-- _G.ShopMgr = require "ShopMgr"
--剧情
require "PlotMgr"

--公会战
_G.GuildFightData = require "GuildFightData"
_G.GuildRoomData = require "GuildRoomData"
--指挥官战术
_G.TacticsMgr = require "TacticsMgr"
_G.TacticsData = require "TacticsData"

--勘探
_G.ExplorationData=require "ExplorationData"
_G.ExplorationRewardInfo=require "ExplorationRewardInfo"

--通用属性计算
_G.CardCalculator = require "CardCalculator"	

--场景管理
_G.SceneMgr = require "SceneMgr";

----------------------------------------------------------------------
--管理器中心
_G.MgrCenter = require "MgrCenter"


--设置
_G.SettingMgr = require "SettingMgr"

--结算封装工具
_G.FightOverTool = require "FightOverTool"

--简易进度条工具
require "Bar"

--简易时间计算工具
require "TimeBase"

require "GuideMgr"
--require "RedPointMgr"

require "RecordMgr"

--剧情
_G.PlotData = require("PlotData")
_G.PlotOption = require("PlotOption");
_G.RoleImgInfo = require("RoleImgInfo");
_G.StoryData = require("StoryData");
_G.PlotTween = require("PlotTween")


--左侧栏动画工具
require "LItemAnimTools" 

--动画曲线枚举
_G.AnimaCurveEnum=CS.AnimCurveEnum;

--基地角色管理工具
require "MatrixRoleTool"

