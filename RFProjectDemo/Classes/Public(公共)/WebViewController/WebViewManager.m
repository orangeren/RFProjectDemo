//
//  WebViewManager.m
//  MaYiBang
//
//  Created by jiesheng on 2019/5/21.
//  Copyright © 2019 捷晟数据科技. All rights reserved.
//

#import "WebViewManager.h"

@implementation WebViewManager
+ (CYwebAddAppUINameType)addAppUINameTypeWithName:(NSString*)addUiName {
    if ([addUiName isEqualToString:@"SHOWSHARE"]) {
        return CYwebAddAppUINameTypeShare;
    }
    return CYwebAddAppUINameTypeDef;
}

+ (CYWebOpennativeNameType)opennativeNameTypeWithName:(NSString *)name {
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
@end
