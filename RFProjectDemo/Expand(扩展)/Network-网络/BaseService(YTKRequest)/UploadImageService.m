//
//  UploadImageService.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/31.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "UploadImageService.h"

@interface UploadImageService ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSDictionary *reqParam;
@property (nonatomic, strong) NSString *reqUrl;
@end

@implementation UploadImageService

- (instancetype)initWithImage:(UIImage *)image name:(NSString *)name fileName:(NSString *)fileName reqParam:(NSDictionary *)reqParam reqUrl:(NSString *)reqUrl {
    self = [super init];
    if (self) {
        _image = image;
        _name = name;
        _fileName = fileName;
        _reqParam = reqParam;
        _reqUrl = reqUrl;
    }
    return self;
}

- (id)requestArgument {
    return self.reqParam;
}

- (NSString *)requestUrl {
    return self.reqUrl;
}


- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(self.image, 1);
        NSString *name = self.name;
        NSString *formKey = self.fileName;
        NSString *type = @"image/jpg/png/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}





#pragma mark -- Base Config ---------------------------

//超时时间
- (NSTimeInterval)requestTimeoutInterval {
    return 300.;
}

// 设置请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

// 设置json数据格式请求
- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}


@end
