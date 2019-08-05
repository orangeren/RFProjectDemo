//
//  DeviceAuthTools.h
//  RFProjectDemo
//
//  Created by 任 on 2019/8/2.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#if NS_BLOCKS_AVAILABLE
typedef void(^AuthIsOpenBlock)(BOOL isOpen);
#endif

@interface DeviceAuthTools : NSObject

/** 判断【定位】权限
 Privacy - Location Always and When In Use Usage Description    // 获取定位
 Privacy - Location Always Usage Description                    // 后台定位
 Privacy - Location When In Use Usage Description               // 前台定位
 Privacy - Location Usage Description
*/
+ (BOOL)Device_Permission_LocationAuth;


/** 判断【消息推送】权限
 */
+ (BOOL)Device_Permission_NotificationAuth;


/** 判断【相册】权限
 Privacy - Photo Library Usage Description // 无需添加。默认开启访问相册权限（读）
 Privacy - Photo Library Additions Usage Description // 添加内容到相册（写）
 */
+ (BOOL)Device_Permission_AlbumAuth;


/** 判断【摄像头】权限
 Privacy - Camera Usage Description
 */
+ (void)Device_Permission_CaptureAuth_Block:(AuthIsOpenBlock)isOpenBlock;


/** 判断【麦克风】权限
 Privacy - Microphone Usage Description
 */
+ (void)Device_Permission_RecordAuth_Block:(AuthIsOpenBlock)isOpenBlock;


/** 判断【通讯录】权限
 Privacy - Contacts Usage Description
 */
+ (void)Device_Permission_ContactsAuth_Block:(AuthIsOpenBlock)isOpenBlock;


/** 判断【联网】权限 */
+ (void)Device_Permission_NetworkAuth_Block:(AuthIsOpenBlock)isOpenBlock;




/** 去设置页面 */
+ (void)openSetting;

@end


