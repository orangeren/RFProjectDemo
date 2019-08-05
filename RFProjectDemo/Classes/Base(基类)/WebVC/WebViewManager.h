//
//  WebViewManager.h
//  RFProjectDemo
//
//  Created by 任 on 2019/7/31.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 添加右按钮的类型 */
typedef NS_ENUM(NSInteger, WebAddAppUINameType) {
    WebAddAppUINameTypeDef,               //不做任何处理
    WebAddAppUINameTypeShare,             //添加分享按钮
};


/** 原生操作类型 */
typedef NS_ENUM(NSInteger, WebOpenNativeNameType) {
    COMMON_VIEW_CONTROLLER,             //不做任何处理
    APP_LOGIN,                          //登录
    APP_SHARE,                          //分享
    JUMP_HOMEPAGE,                      //跳转到首页
    RETURN_BACK                         //返回上一个页面
};


@interface WebViewManager : NSObject
//打开原生UI
+ (WebOpenNativeNameType)opennativeNameTypeWithName:(NSString *)name;

//配合H5 添加对应UI
+ (WebAddAppUINameType)addAppUINameTypeWithName:(NSString *)addUiName;
@end

 
