//
//  HeaderFile.h
//  MemoryWebApp
//
//  Created by 怀恩03 on 15/6/15.
//  Copyright (c) 2015年 怀恩03. All rights reserved.
//
//#import "AFNetworking.h"
#import "MyLayout.h"
#import "UIImage(Extension).h"
#import "NSString (Extension).h"
#import "HeaderFile.h"
//#import "CheckNetworkManager.h"
//#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "ProgressHUD.h"
#import "MJRefresh.h"
#import "BDKNotifyHUD.h"
//#import "EGOViewCommon.h"
#ifndef MemoryWebApp_HeaderFile_h
#define MemoryWebApp_HeaderFile_h
#import "AppDelegate.h"
#import "NetWorking.h"
#define  SCREEN_WIDTH   [UIScreen  mainScreen].bounds.size.width
#define  SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
//弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
//请佛的按钮字体颜色
#define  Typeface   [[UIColor alloc]initWithRed:51.0f/255.0f green:19.0f/255.0f blue:0.0f alpha:0.9f]
//佛像和寓意的名称字体颜色
#define  TypefaceName   [[UIColor alloc]initWithRed:255.0f/255.0f green:221.0f/255.0f blue:0.0f alpha:1.0f]
#define  YuYiName   [[UIColor alloc]initWithRed:255.0f/255.0f green:204.0f/255.0f blue:0.0f alpha:1.0f]
#define TempleNameLa   [[UIColor alloc]initWithRed:51.0f/255.0f green:19.0f/255.0f blue:0.0f alpha:1.0f]
//佛像界面中弹窗的取消按钮的字体颜色
#define cancelColor     [[UIColor alloc]initWithRed:188.0f/255.0f green:95.0f/255.0f blue:20.0f/255.0f alpha:1.0f]
//大多数文字或按钮的颜色
#define majorityColor    [[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f]
//排行榜上说明类型的字体颜色
#define  RankingListColor   [[UIColor alloc]initWithRed:255.0f/255.0f green:246.0f/255.0f blue:218.0f/255.0f  alpha:1.0f]
//每日功课中文字颜色155,93,6
#define  WorkDayColor  [[UIColor alloc]initWithRed:155.0f/255.0f green:93.0f/255.0f blue:6.0f/255.0f  alpha:1.0f]

#define  darkYellow  [UIColor colorWithRed:239 / 255.0 green:208 / 255.0 blue:162 / 255.0 alpha:1]
#define  titleYellow  [UIColor colorWithRed:148 / 255.0 green:87 / 255.0 blue:0 / 255.0 alpha:1]
#define  systemOrange  [UIColor colorWithRed:221 / 255.0 green:157 / 255.0 blue: 82/ 255.0 alpha:1]
#define  DarkOrange  [UIColor colorWithRed:217 / 255.0 green:146 / 255.0 blue: 73/ 255.0 alpha:1]
#define  DDarkOrange  [UIColor colorWithRed:207 / 255.0 green:126 / 255.0 blue: 58/ 255.0 alpha:1]
#define  DarkRed  [UIColor colorWithRed:147 / 255.0 green:0 / 255.0 blue: 0/ 255.0 alpha:1]
#define  LIGHTGREEN [UIColor colorWithRed:243 / 255.0 green:255 / 255.0 blue:219 / 255.0 alpha:1]
#define  PINK      [UIColor colorWithRed: 255 / 255.0 green:205 / 255.0 blue:160 / 255.0 alpha:1]
#define  NAVTITLECOLOE  [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:165 / 255.0 alpha:1]
#define  SelectBtnBGColor [UIColor colorWithRed:227 / 255.0 green:180 / 255.0 blue:115 / 255.0 alpha:1]
#define  UnSelectBtnBGColor [UIColor colorWithRed:236 / 255.0 green:205 / 255.0 blue:153 / 255.0 alpha:1]
#define  BtnBGColor [UIColor colorWithRed:128 / 255.0 green:80 / 255.0 blue:35 / 255.0 alpha:1]
#define  OrangeColor [UIColor colorWithRed:230 / 255.0 green:157 / 255.0 blue:79 / 255.0 alpha:1]
#define  DarkGrayOrange [UIColor colorWithRed:180 / 255.0 green:159 / 255.0 blue:128 / 255.0 alpha:1]
#define tintColor1 [UIColor colorWithRed: 255 / 255.0 green:245 / 255.0 blue:185 / 255.0 alpha:1]
#define  SelectTitleColor  [UIColor colorWithRed:208 / 255.0 green: 148 / 255.0 blue:0 / 255.0 alpha:1]
//佛像排行字体颜色
#define BuddhaddTitleColor [UIColor colorWithRed:91.0f/255.0f green:25.0f/255.0f blue:1.0f/255.0f alpha:1]
#define buddhaddBottomColor [UIColor colorWithRed:254.0f/255.0f green:241.0f/255.0f blue:139.0f/255.0f alpha:1]
#define  NAVBARHEIGHT     64.0
/************************接口**************************/
//菩提心接口域名
#define mainDainName @ "http://a.ptx.huaien.com:9001";
//会员系统接口域名 http://a.ptx.huaien.com:9001/ptxGetTempleOrder.do
#define member @ "http://a.usr.huaien.com:9001/";
//账务系统接口域名
#define financeSystem @"http://a.bll.huaien.com:9001/";
//消息通知接口域名
#define newNotice @"http://a.msg.huaien.com:9001/";
//日志信息接口域名
#define logInformation @"http://a.log.huaien.com:9001/";
//公共基础信息接口域名
#define publicBasicInformation @ "http://a.pub.huaien.com:9001/";
//下载升级接口域名
#define downloadUpgrade @ "http://a.app.huaien.com:9001/";

//#define __kBaseURLString  @"http://192.168.1.16:8080" //主接口
#define __kBaseURLString  @"http://139.196.28.29:8080/" //主接口
//#define __kBaseURLString  @"http://a.ptx.huaien.com:9001/"
//登陆会员和普通接口
#define memberloginURL   @"/members/usrAddLogin.do?"
#define putixinloginURL  @"/putixin/ptxUserLogin.do?"

//#define memberloginURL   @"http://a.usr.huaien.com:9001/usrAddLogin.do"
//#define putixinloginURL  @"http://a.ptx.huaien.com:9001/ptxUserLogin.do"
//个人资料会员和普通接口
#define memberVipURL    @"/members/usrGetUserCoreInfo.do?"
#define putixinzhanghuURL @"/putixin/ptxGetUserInfo.do?"
//（修改菩提心用户信息及会员系统中的用户真实姓名接口
#define UserInfoAndRealName @"/putixin/ptxUptUserInfoAndRealName.do?"

//获取积分、等级、称号对照表信息
#define GetIntegralLevel @"/putixin/ptxGetIntegralLevel.do?"

//APP用户获取系统提供的消息
#define MessgeByUserID @"/msgs/msgGetSystemMessgeByUserID.do?"
//APP用户设置消息状态
#define SetMessgeStatus @"/msgs/msgSetMessgeStatus.do?"

//实验手机号是否被注册过
#define registeredTelePhoneURL @"/members/usrJudgeMobileIfExists.do?"
//发送手机短信验证码接口
#define usrSendMobileVerCodeURL @"/members/usrSendMobileVerCode.do?"
//修改并绑定用户手机接口
#define usrUptUserMobile  @"/members/usrUptUserMobile.do?"
//修改并绑定用户Email接口
#define usrUptUserEmail   @"/members/usrUptUserEmail.do?"
//会员系统新用户注册
#define usrAddUserURL    @"/members/usrAddUser.do?"
//（会员系统） 怀恩用户修改自己密码
#define usrUptUserPwd   @"/members/usrUptUserPwd.do?"

//恭敬礼佛中佛堂的接口//佛像列表的接口（私人）
#define TempleURL  @"/putixin/ptxGetPrivateTempleList.do?"
//神佛阁
#define TempleList @"/putixin/ptxGetTempleList.do?"
//佛堂佛像的名称含义
#define TempleMeaning  @"/putixin/ptxGetMaterailByID.do?"
//佛堂许愿的接口
#define WishURL     @"/putixin/ptxAddUserMakeWishDivine.do?"
//佛堂许愿的次数接口
#define WishNumURL  @"/putixin/ptxGetUserMakeWishQty.do?"
//用户获取自己的许愿信息列表
#define TempleVowURL  @"/putixin/ptxGetUserWishListByTemple.do?"
//还愿的接口
#define VowURL        @"/putixin/ptxFulfilWish.do?"
//佛堂贡品接口
#define TributeURL    @"/putixin/ptxGetMaterailList.do?"
//依据ID获取素材（如佛像）的明细数据
#define GetMaterailByIDURL @"/putixin/ptxGetMaterailByID.do?"
//恭请佛像
#define ptxAddTemple  @"/putixin/ptxAddTemple.do?"
//提交用户各种修行行为记录
#define ptxAddUserTaskRecord @"/putixin/ptxAddUserTaskRecord.do?"
//依据类别获取经书/梵音列表
#define ClassicURL @"/putixin/ptxGetBookListByCategory.do?"
//智慧文库中我的书架
#define BookShelfURL @"/putixin/ptxGetMyCollectList.do?"
//智慧文库中读/抄经总排行接口
#define RankingURL @"/putixin/ptxGetUserTaskOrderBy.do?"
//智慧文库中读经／抄经排行
#define ReadingURL @"/putixin/ptxGetBookOrderByBookID.do?"
//智慧文库中搜索接口
#define SearchWordsURL @"/putixin/ptxGetBookListByKeywords.do?"
//下载经书/梵音记录表
#define   ptxDowloadRecordURL @"/putixin/ptxDowloadRecord.do?"
//智慧文库中收藏经书的接口
#define CollectionInfoURL @"/putixin/ptxAddCollect.do?"
//智慧文库中收藏经书的删除接口
#define DeleteURL @"/putixin/ptxDelCollect.do?"
//用户各种修行行为提交
#define SubmitSitMeditationURL @"/putixin/ptxAddUserTaskRecord.do?"
//静心修禅，念佛珠中总排行接口
#define MeditationRankURL @"/putixin/ptxGetUserTaskOrderBy.do?"
//功课中获取功课列表的
#define HomeWorkListURL @"/putixin/ptxGetEveryDayTaskList.do?"
//功课中完成情况
#define CompletionURL @"/putixin/ptxGetUserEveryDayTaskAchieve.do?"
//佛珠中排行接口
#define BeadsRankURL @"/putixin/ptxGetUserTaskOrderByUserID.do"
//修行用户总积分排行列表接口
#define GetIntegralOrder @"/putixin/ptxGetIntegralOrder.do?"
//依据怀恩ID获取该用户的总积分排行
#define GetIntegralOrderByID @"/putixin/ptxGetIntegralOrderByID.do?"
//持久化
#define StoreMusic   @"StoreMusic4"
#define MusicType     @"MusicType"
#define MusicName     @"MusicName"
#define MusicWordTotal  @"MusicWordTotal"
#define MusicWordClicks  @"MusicWordClicks"
#define MusicCollectedId  @"collectID"
#define MusicIsDownLoad  @"isDownLoad"
#define Group   @"group.ptx"
#define fileStoreURL   @"Library/Caches/file"

//用于归档解档
#define WisdomModelArchiver  @"WisdomModel1.archiver"
//获取系统提供的候选背景List
#define ptxGetUserBackGroundImgListURL @"/putixin/ptxGetUserBackGroundImgList.do?"
//修改菩提心用户的背景图接口
#define UptUserURL @"/putixin/ptxUptUser.do?"
//用户是否完成每日签到
#define ptxJudgeGetLoginRewardByID @"/putixin/ptxJudgeGetLoginRewardByID.do?"
//用户领取每日签到奖励
#define ptxGetLoginRewardByID @"/putixin/ptxGetLoginRewardByID.do?"

// 获取用户积分、等级、称号信息
#define ptxGetUserLevel @"/putixin/ptxGetUserLevel.do?"
//获取用户当前读/抄/听经/坐禅/念珠统计数据
#define ptxGetUserTaskCurrentStatInfo  @"/putixin/ptxGetUserTaskCurrentStatInfo.do?"
//依据套餐类型获取套餐中的怀恩点、祈福币信息
#define bllUserGetPackageInfo @"/billing/bllUserGetPackageInfo.do?"
//在线购买怀恩点前置接口
#define blBuyHuaienPointPrior @"/billing/blBuyHuaienPointPrior.do?"
//添加APP用户的建议或意见
#define msgAddSuggestion @"/msgs/msgAddSuggestion.do?"
//获取读/抄/听经书总排行
#define ptxGetUserTaskOrderByUserID @"/putixin/ptxGetUserTaskOrderByUserID.do?"
//获取用户在某本经书的读/抄/听经书的排名1137
#define ptxGetBookOrderByUserID  @"/putixin/ptxGetBookOrderByUserID.do?"
// 修改菩提心用户信息接口
#define ptxUptUserInfo  @"/putixin/ptxUptUserInfo.do?"

//关于每日功课
#define earlyHomeWorkHint  @"earlyHomeWorkHint"
#define lateHomeWorkHint   @"lateHomeWorkHint"
#define everyDayHomeWorkHint  @"everyDayHomeWorkHintNotification"
#define earlyHomeWorkTime  @"earlyHomeWorkTime"
#define lateHomeWorkTime   @"lateHomeWorkTime"


//获取佛堂排名
#define ptxGetTempleOrder @"/putixin/ptxGetTempleOrder.do?"
//#define ptxGetTempleOrder @"/ptxGetTempleOrder.do?"
//依据怀恩ID获取该用户的某佛堂的积分排行位置
#define ptxGetTempleIntegralOrderByID @"/putixin/ptxGetTempleIntegralOrderByID.do?"
//获取图形验证码
#define usrGetPicVerificationCode @"/members/usrGetPicVerificationCode.do?"
//判断图形验证码是否正确
#define usrPicVerificationCode @"/members/usrPicVerificationCode.do?"
//依据怀恩ID、手机号码或email获取用户手机号码
#define usrGetMobileByCondition @"/members/usrGetMobileByCondition.do?"
//判断短信验证码是否正确
#define usrJudgeVerificationCode @"/members/usrJudgeVerificationCode.do?"
//修改密码（通过密码找回方式）
#define uptUserPwdByOtherWay @"/members/uptUserPwdByOtherWay.do?"
#endif


#define  resURL @"http://res1.huaien.com/flashrs/assets2/content/"
