//
//  Macros.h
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#ifndef Macros_h
#define Macros_h



#define KH                      [UIScreen mainScreen].bounds.size.height
#define KW                      [UIScreen mainScreen].bounds.size.width
#define fitW(x)                 ceilf((x) * (KW / 375.0))
#define fitH(x)                 ceilf((x) * (KH / 667.0))



// 状态栏高度
#define k_Status_BarHei         [[UIApplication sharedApplication] statusBarFrame].size.height
// 导航栏高度
#define k_Navigation_BarHei     (k_Status_BarHei + 44.0)
// 底部TabBar高度
#define k_TabBarHei             (k_Status_BarHei > 21.0 ? 83.0 : 49.0)
// Iphone X 底部TabBar增加的高度
#define k_TabBar_Addition_Hei   (k_Status_BarHei > 21.0 ? 34.0 : 0.0)
// 判断是否是IPHONEX
#define IS_IPHONEX              ((k_Status_BarHei == 44) ? YES : NO)



// 是否大于等于IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
// 是否大于IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 9.0)
// 是否大于IOS10
#define isIOS10                 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 10.0)
// 是否大于IOS11
#define isIOS11                 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 11.0)
// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)



// 字体大小
#define FONT_SYSTEM(A)          [UIFont systemFontOfSize:A]
#define FONT_LIGHT(A)           [UIFont fontWithName:@"PingFangSC-light" size:A] ? [UIFont fontWithName:@"PingFangSC-light" size:A] : [UIFont systemFontOfSize:A]
#define FONT_Regular(A)         [UIFont fontWithName:@"PingFangSC-Regular" size:A] ? [UIFont fontWithName:@"PingFangSC-Regular" size:A] : [UIFont systemFontOfSize:A]
#define FONT_Medium(A)          [UIFont fontWithName:@"PingFangSC-Medium" size:A] ? [UIFont fontWithName:@"PingFangSC-Medium" size:A] : [UIFont systemFontOfSize:A]



// 当前版本 (build)
#define SystemVersion           ([[UIDevice currentDevice] systemVersion])
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
// App版本号 (version)
#define AppVersion              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]



// 色值
#define Color_RGBA(r,g,b,a)     [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define Color_RGB(r,g,b)        Color_RGBA(r,g,b,1.0f)
#define Color_HEX(hex)          [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define COLOR_SRT(STR)          [UIColor colorWithHexString:STR]
// 随机色
#define Color_RandomColor       Color_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))



//一些缩写
#define GetImage(imageName)     [UIImage imageNamed:[NSString stringWithFormat:@"%@", imageName]]



// 文件路径
// 获取Library/Caches
#define FilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])
// 获取temp
#define kPathTemp NSTemporaryDirectory()
// 获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
// 获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]




//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))




// 弱引用/强引用
#define WeakSelf(type)      __weak typeof(type) weak##type = type;
#define StrongSelf(type)    __strong typeof(type) type = weak##type;

#define WeakObj(o)          autoreleasepool{} __weak typeof(o) o##Weak = o
#define StrongObj(o)        autoreleasepool{} __strong typeof(o) o = o##Weak










#endif /* Macros_h */
