//
//  UmShareHelper.m
//  RFProjectDemo
//
//  Created by 任 on 2019/8/2.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "UmShareHelper.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>     // 友盟分享
#import <UShareUI/UShareUI.h>


@implementation UmShareHelper

/** 添加友盟 */
+ (void)addUmsocialManager {
    [UMConfigure initWithAppkey:kUmengKey channel:kUMengChannelId];
}


/* 友盟分享 平台设置 */
+ (void)configUSharePlatforms {
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeChat_AppKey appSecret:WeChat_AppSecret redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_AppKey/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
//    /* 设置新浪的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
//    
//    /* 钉钉的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];
//    /* 支付宝的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//    /* 设置易信的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_YixinSession appKey:@"yx35664bdff4db42c2b7be1e29390c1a06" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//    /* 设置点点虫（原来往）的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_LaiWangSession appKey:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" redirectURL:@"http://mobile.umeng.com/social"];
//    /* 设置领英的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81t5eiem37d2sc"  appSecret:@"7dgUXPLH8kA8WHMV" redirectURL:@"https://api.linkedin.com/v1/people"];
//    /* 设置Twitter的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
//    /* 设置Facebook的appKey和UrlString */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"506027402887373"  appSecret:nil redirectURL:@"http://www.umeng.com/social"];
//    /* 设置Pinterest的appKey */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Pinterest appKey:@"4864546872699668063"  appSecret:nil redirectURL:nil];
//    /* dropbox的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DropBox appKey:@"k4pn9gdwygpy4av" appSecret:@"td28zkbyb9p49xu" redirectURL:@"https://mobile.umeng.com/social"];
//    /* vk的appkey */
//    [[UMSocialManager defaultManager]  setPlaform:UMSocialPlatformType_VKontakte appKey:@"5786123" appSecret:nil redirectURL:nil];
    
    
    [UmShareHelper confitUShareSettings];
}

+ (void)confitUShareSettings {
    /** 打开图片水印 */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}


/** 创建分享内容 */
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType parameters:(NSDictionary *)parameters {
    //lis分享
    NSString * urlShare = [parameters[@"shareAppUrl"] description];
    NSString * shareAppImage = [parameters[@"shareAppImage"] description];
    NSString * shareAppTitle = [parameters[@"shareAppTitle"] description];
    NSString * shareAppContent = [parameters[@"shareAppContent"] description];
    
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建分享内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareAppTitle descr:shareAppContent thumImage:shareAppImage];
    shareObject.webpageUrl = urlShare;
    
    if (platformType == UMSocialPlatformType_Sms) {
        //如果是短信的话
        shareObject.webpageUrl = [NSString stringWithFormat:@"%@%@", shareAppContent, urlShare];
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[UIViewController currentViewController] completion:^(id data, NSError *error) {
        if (error) {
            [kKeyWindow makeCenterToast:@"分享失败"];
            NSLog(@"分享失败Error: %@",error);
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        } else {
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                UMSocialLogInfo(@"分享结果消息 - %@",resp.message);
                UMSocialLogInfo(@"第三方原始返回的数据 - %@",resp.originalResponse);
            } else {
                UMSocialLogInfo(@"response data is %@",data);
            }
            [kKeyWindow makeCenterToast:@"分享成功"];
        }
    }];
}


/* 调起分享页面 */
+ (void)shareWithInfo:(NSDictionary *)dict {
    // 定制分享面板显示的分享平台
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ), @(UMSocialPlatformType_WechatSession), @(UMSocialPlatformType_WechatTimeLine), @(UMSocialPlatformType_Sms)]];
    
    [self configShareViewUI];
    
    // 显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [UmShareHelper shareWebPageToPlatformType:platformType parameters:dict];
    }];
}


/** 自定义分享界面样式 */
+ (void)configShareViewUI {
//    UMSocialShareTitleView  --> UMSocialShareTitleViewConfig
//    UMSocialSharePageScrollView --> UMSocialSharePageScrollViewConfig
//    UMSocialSharePageControl --> UMSocialSharePageControlConfig
//    UMSocialShareCancelControl --> UMSocialShareCancelControlConfig
    
    // 标题
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewTitleString = @"分享";
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewTitleColor = K_333Color;
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewFont = FONT_Medium(15);
    
    // 内容(2行 4列)
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForLandscapeAndMid = 2;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForLandscapeAndMid = 4;
    
    // 指示器
    [UMSocialShareUIConfig shareInstance].sharePageControlConfig.isShow = NO;
    
    // 取消按钮
    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.shareCancelControlText = @"取消分享";
    
}

@end


/**
 白名单
 
 <key>LSApplicationQueriesSchemes</key>
 <array>
 <!-- 微信 URL Scheme 白名单-->
 <string>wechat</string>
 <string>weixin</string>
 
 <!-- 新浪微博 URL Scheme 白名单-->
 <string>sinaweibohd</string>
 <string>sinaweibo</string>
 <string>sinaweibosso</string>
 <string>weibosdk</string>
 <string>weibosdk2.5</string>
 
 <!-- QQ、Qzone URL Scheme 白名单-->
 <string>mqqapi</string>
 <string>mqq</string>
 <string>mqqOpensdkSSoLogin</string>
 <string>mqqconnect</string>
 <string>mqqopensdkdataline</string>
 <string>mqqopensdkgrouptribeshare</string>
 <string>mqqopensdkfriend</string>
 <string>mqqopensdkapi</string>
 <string>mqqopensdkapiV2</string>
 <string>mqqopensdkapiV3</string>
 <string>mqqopensdkapiV4</string>
 <string>mqzoneopensdk</string>
 <string>wtloginmqq</string>
 <string>wtloginmqq2</string>
 <string>mqqwpa</string>
 <string>mqzone</string>
 <string>mqzonev2</string>
 <string>mqzoneshare</string>
 <string>wtloginqzone</string>
 <string>mqzonewx</string>
 <string>mqzoneopensdkapiV2</string>
 <string>mqzoneopensdkapi19</string>
 <string>mqzoneopensdkapi</string>
 <string>mqqbrowser</string>
 <string>mttbrowser</string>
 <string>tim</string>
 <string>timapi</string>
 <string>timopensdkfriend</string>
 <string>timwpa</string>
 <string>timgamebindinggroup</string>
 <string>timapiwallet</string>
 <string>timOpensdkSSoLogin</string>
 <string>wtlogintim</string>
 <string>timopensdkgrouptribeshare</string>
 <string>timopensdkapiV4</string>
 <string>timgamebindinggroup</string>
 <string>timopensdkdataline</string>
 <string>wtlogintimV1</string>
 <string>timapiV1</string>
 
 <!-- 支付宝 URL Scheme 白名单-->
 <string>alipay</string>
 <string>alipayshare</string>
 
 <!-- 钉钉 URL Scheme 白名单-->
 <string>dingtalk</string>
 <string>dingtalk-open</string>
 
 <!--Linkedin URL Scheme 白名单-->
 <string>linkedin</string>
 <string>linkedin-sdk2</string>
 <string>linkedin-sdk</string>
 
 <!-- 点点虫 URL Scheme 白名单-->
 <string>laiwangsso</string>
 
 <!-- 易信 URL Scheme 白名单-->
 <string>yixin</string>
 <string>yixinopenapi</string>
 
 <!-- instagram URL Scheme 白名单-->
 <string>instagram</string>
 
 <!-- whatsapp URL Scheme 白名单-->
 <string>whatsapp</string>
 
 <!-- line URL Scheme 白名单-->
 <string>line</string>
 
 <!-- Facebook URL Scheme 白名单-->
 <string>fbapi</string>
 <string>fb-messenger-api</string>
 <string>fb-messenger-share-api</string>
 <string>fbauth2</string>
 <string>fbshareextension</string>
 
 <!-- Kakao URL Scheme 白名单-->
 <!-- 注：以下第一个参数需替换为自己的kakao appkey-->
 <!-- 格式为 kakao + "kakao appkey"-->
 <string>kakaofa63a0b2356e923f3edd6512d531f546</string>
 <string>kakaokompassauth</string>
 <string>storykompassauth</string>
 <string>kakaolink</string>
 <string>kakaotalk-4.5.0</string>
 <string>kakaostory-2.9.0</string>
 
 <!-- pinterest URL Scheme 白名单-->
 <string>pinterestsdk.v1</string>
 
 <!-- Tumblr URL Scheme 白名单-->
 <string>tumblr</string>
 
 <!-- 印象笔记 -->
 <string>evernote</string>
 <string>en</string>
 <string>enx</string>
 <string>evernotecid</string>
 <string>evernotemsg</string>
 
 <!-- 有道云笔记-->
 <string>youdaonote</string>
 <string>ynotedictfav</string>
 <string>com.youdao.note.todayViewNote</string>
 <string>ynotesharesdk</string>
 
 <!-- Google+-->
 <string>gplus</string>
 
 <!-- Pocket-->
 <string>pocket</string>
 <string>readitlater</string>
 <string>pocket-oauth-v1</string>
 <string>fb131450656879143</string>
 <string>en-readitlater-5776</string>
 <string>com.ideashower.ReadItLaterPro3</string>
 <string>com.ideashower.ReadItLaterPro</string>
 <string>com.ideashower.ReadItLaterProAlpha</string>
 <string>com.ideashower.ReadItLaterProEnterprise</string>
 
 <!-- VKontakte-->
 <string>vk</string>
 <string>vk-share</string>
 <string>vkauthorize</string>
 
 <!-- Twitter-->
 <string>twitter</string>
 <string>twitterauth</string>
 </array>
 */
