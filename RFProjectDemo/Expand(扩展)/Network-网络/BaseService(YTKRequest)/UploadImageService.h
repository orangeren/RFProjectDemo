//
//  UploadImageService.h
//  RFProjectDemo
//
//  Created by 任 on 2019/7/31.
//  Copyright © 2019 ZXKJ. All rights reserved.
//


#import "BaseRequestSerivce.h"

@interface UploadImageService : YTKRequest

- (instancetype)initWithImage:(UIImage *)image name:(NSString *)name fileName:(NSString *)fileName reqParam:(NSDictionary *)reqParam reqUrl:(NSString *)reqUrl;

@end


