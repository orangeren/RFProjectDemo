//
//  WebViewManager.m
//  AnhuiDaily
//
//  Created by 任 on 2019/7/31.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "WebViewManager.h"

@implementation WebViewManager

+ (WebOpenNativeNameType)opennativeNameTypeWithName:(NSString *)name {
    if ([name isEqualToString:@"APP_LOGIN"]) {
        return APP_LOGIN;
    } else if ([name isEqualToString:@"APP_SHARE"]) {
        return APP_SHARE;
    } else if ([name rangeOfString:@"APP_HOME"].location != NSNotFound) {
        return JUMP_HOMEPAGE;
    } else if ([name rangeOfString:@"RETURN_BACK"].location != NSNotFound) {
        return RETURN_BACK;
    }
    
    return COMMON_VIEW_CONTROLLER;
}


+ (WebAddAppUINameType)addAppUINameTypeWithName:(NSString *)addUiName {
    if ([addUiName isEqualToString:@"SHOWSHARE"]) {
        return WebAddAppUINameTypeShare;
    }
    return WebAddAppUINameTypeDef;
}

@end
