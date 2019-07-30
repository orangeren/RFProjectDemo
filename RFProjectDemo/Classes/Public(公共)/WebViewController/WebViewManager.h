//
//  WebViewManager.h
//  MaYiBang
//
//  Created by jiesheng on 2019/5/21.
//  Copyright © 2019 捷晟数据科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UIWebViewRefreshType) {
    UIWebViewRefreshNotRefreshType,         //不做刷新处理
    UIWebViewRefreshGoBackRefreshType       //返回刷新
};


typedef NS_ENUM(NSInteger, CYwebAddAppUINameType) {
    CYwebAddAppUINameTypeDef,               //不做任何处理
    CYwebAddAppUINameTypeShare,             //添加分享按钮
};


typedef NS_ENUM(NSInteger, CYWebOpennativeNameType) {
    COMMON_VIEW_CONTROLLER,         //不做任何处理
    APP_LOGIN,                      //登录
    APP_SHARE,                      //分享
    JUMP_HOMEPAGE,                  //跳转到首页
    RETURN_BACK                     //返回上一个页面 
};


@interface WebViewManager : NSObject

//配合H5 添加对应UI
+ (CYwebAddAppUINameType)addAppUINameTypeWithName:(NSString*)addUiName;
//打开原生UI
+ (CYWebOpennativeNameType)opennativeNameTypeWithName:(NSString *)name;

@end


