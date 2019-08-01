//
//  AFNetwork.h
//  RFProjectDemo
//
//  Created by 任 on 2019/8/1.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 *  宏定义请求成功的block
 *  @param responseObject 请求成功返回的数据
 */
typedef void (^ResponseSuccess)(NSURLSessionDataTask *task, id responseObject);

/**
 *  宏定义请求失败的block
 *  @param error 报错信息
 */
typedef void (^ResponseFail)(NSURLSessionDataTask *task, NSError *error);

/**
 *  上传或者下载的进度
 *  @param progress 进度
 */
typedef void (^RFProgress)(NSProgress *progress);



@interface AFNetwork : NSObject

/**
 *  普通get方法请求网络数据
 */
+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(ResponseSuccess)success fail:(ResponseFail)fail;

/**
 *  普通post方法请求网络数据
 */
+ (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)params success:(ResponseSuccess)success fail:(ResponseFail)fail;

/**
 *  普通路径上传文件
 */
+ (void)uploadWithURL:(NSString *)url
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType progress:(RFProgress)progress success:(ResponseSuccess)success fail:(ResponseFail)fail;

/**
 *  下载文件
 */
+ (NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                 savePathURL:(NSURL *)fileURL
                                    progress:(RFProgress)progress
                                     success:(void (^)(NSURLResponse *, NSURL *))success
                                        fail:(void (^)(NSError *))fail;





#pragma mark - 网络请求队列管理
// 添加队列
+ (void)addTask:(NSURLSessionDataTask *)task;
// 删除队列
+ (void)removeTask:(NSURLSessionDataTask *)task;
// 队列管理容器
+ (NSMutableDictionary *)taskQueue;
// 判读有没有执行中的队列
+ (BOOL)ifRequesting;
// 取消队列中的所有请求
+ (void)cancelAllRequest;
// 取消指定请求
+ (void)cancelRequest:(NSURLSessionDataTask *)task;

@end


