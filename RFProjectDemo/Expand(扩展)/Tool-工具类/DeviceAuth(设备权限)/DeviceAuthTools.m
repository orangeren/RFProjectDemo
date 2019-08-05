//
//  DeviceAuthTools.m
//  RFProjectDemo
//
//  Created by 任 on 2019/8/2.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "DeviceAuthTools.h"
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <CoreTelephony/CTCellularData.h>

@implementation DeviceAuthTools

/** 判断定位权限 */
+ (BOOL)Device_Permission_LocationAuth {
    if (![CLLocationManager locationServicesEnabled]) {
        return NO;
    }
    CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
    if (CLstatus == kCLAuthorizationStatusDenied || CLstatus == kCLAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}



/** 判断【消息推送】权限 */
+ (BOOL)Device_Permission_NotificationAuth {
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone == setting.types) { //推送关闭
        return NO;
    }
    return YES;
}


/** 判断【相册】权限 */
+ (BOOL)Device_Permission_AlbumAuth {
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}


/** 判断【摄像头】权限 */
+ (void)Device_Permission_CaptureAuth_Block:(AuthIsOpenBlock)isOpenBlock {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) { //第一次授权
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (isOpenBlock) {
                isOpenBlock(granted);
            }
        }];
    } else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        isOpenBlock(NO);
    } else {
        isOpenBlock(YES);
    }
}


/** 判断【麦克风】权限 */
+ (void)Device_Permission_RecordAuth_Block:(AuthIsOpenBlock)isOpenBlock {
    AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
    if (permissionStatus == AVAudioSessionRecordPermissionUndetermined) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (isOpenBlock) {
                isOpenBlock(granted);
            }
        }];
    } else if (permissionStatus == AVAudioSessionRecordPermissionDenied) {
        isOpenBlock(NO);
    } else {
        isOpenBlock(YES);
    }
}


/** 判断【通讯录】权限 */
+ (void)Device_Permission_ContactsAuth_Block:(AuthIsOpenBlock)isOpenBlock {
    if (@available(iOS 9.0, *)) {
        
        CNAuthorizationStatus cnAuthStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (cnAuthStatus == CNAuthorizationStatusNotDetermined) {
            CNContactStore *store = [[CNContactStore alloc] init];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError *error) {
                if (isOpenBlock) {
                    isOpenBlock(granted);
                }
            }];
        } else if (cnAuthStatus == CNAuthorizationStatusRestricted || cnAuthStatus == CNAuthorizationStatusDenied) {
            if (isOpenBlock) {
                isOpenBlock(NO);
            }
        } else {
            if (isOpenBlock) {
                isOpenBlock(YES);
            }
        }
    } else {
        // Fallback on earlier versions
        
        ABAddressBookRef addressBook = ABAddressBookCreate();
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        if (authStatus != kABAuthorizationStatusAuthorized) {
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error) {
                        NSLog(@"Error: %@", (__bridge NSError *)error);
                        if (isOpenBlock) {
                            isOpenBlock(NO);
                        }
                    } else {
                        if (isOpenBlock) {
                            isOpenBlock(YES);
                        }
                    }
                });
            });
        } else {
            if (isOpenBlock) {
                isOpenBlock(YES);
            }
        }
    }
}



/** 判断【联网】权限 */
+ (void)Device_Permission_NetworkAuth_Block:(AuthIsOpenBlock)isOpenBlock {
    if (@available(iOS 9.0, *)) {
        CTCellularData *cellularData = [[CTCellularData alloc] init];
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state){
            if (state == kCTCellularDataRestrictedStateUnknown || state == kCTCellularDataNotRestricted) {
                if (isOpenBlock) {
                    isOpenBlock(NO);
                }
            } else {
                if (isOpenBlock) {
                    isOpenBlock(YES);
                }
            }
        };
        CTCellularDataRestrictedState state = cellularData.restrictedState;
        if (state == kCTCellularDataRestrictedStateUnknown || state == kCTCellularDataNotRestricted) {
            if (isOpenBlock) {
                isOpenBlock(NO);
            }
        } else {
            if (isOpenBlock) {
                isOpenBlock(YES);
            }
        }
    } else {
        // Fallback on earlier versions
    }
}










/** 去设置页面 */
+ (void)openSetting { 
    NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}


@end
