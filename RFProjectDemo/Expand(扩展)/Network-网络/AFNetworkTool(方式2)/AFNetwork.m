//
//  AFNetwork.m
//  RFProjectDemo
//
//  Created by 任 on 2019/8/1.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "AFNetwork.h"
#import <objc/runtime.h>

@implementation AFNetwork

//普通get方法请求网络数据
+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(ResponseSuccess)success fail:(ResponseFail)fail {
    AFHTTPSessionManager *manager = [AFNetwork sharedManager];
    
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithDictionary:params];
    NSString *askUrl = [self askURL:url];
    
    [manager GET:askUrl parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [AFNetwork responseConfiguration:responseObject];
        NSLog(@"dic - %@", dic);
        success(task,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}


//普通post方法请求网络数据
+ (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)params success:(ResponseSuccess)success fail:(ResponseFail)fail {
    AFHTTPSessionManager *manager = [AFNetwork sharedManager];
    
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithDictionary:params];
    NSString *askUrl = [self askURL:url];
    
    NSURLSessionDataTask *dataTask = [manager POST:askUrl parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [AFNetwork responseConfiguration:responseObject];
        NSLog(@"\nURL \nparams - %@ %@ \ndic - %@", askUrl, paramDict, dic);
        
        success(task, dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSInteger code = error.code;
        if (code == -999) {
            // @"已取消"
        } else if (code == -1009) {
            [[UIApplication sharedApplication].keyWindow makeCenterToast:kNetworkConnectFailure];
        } else {
            NSString *errorDesc = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            [[UIApplication sharedApplication].keyWindow makeCenterToast:[NSString stringWithFormat:@"%@", errorDesc]];
        }
        
        fail(task, error);
    }];
    
    return dataTask;
}




// 普通路径上传文件
+ (void)uploadWithURL:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)filedata name:(NSString *)name fileName:(NSString *)filename mimeType:(NSString *) mimeType progress:(RFProgress)progress success:(ResponseSuccess)success fail:(ResponseFail)fail {
    AFHTTPSessionManager *manager = [AFNetwork sharedManager];
    
    NSString *askUrl = [self askURL:url];
    [manager POST:askUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [AFNetwork responseConfiguration:responseObject];
        NSLog(@"\nURL - %@ \n responseDic - %@", askUrl, dic);
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}


//下载文件
+ (NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                 savePathURL:(NSURL *)fileURL
                                    progress:(RFProgress)progress
                                     success:(void (^)(NSURLResponse *, NSURL *))success
                                        fail:(void (^)(NSError *))fail {
    AFHTTPSessionManager *manager = [AFNetwork sharedManager];
    
    NSURL *urlpath = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlpath];
    
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [fileURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            fail(error);
        } else {
            success(response,filePath);
        }
    }];
    [downloadtask resume];
    
    return downloadtask;
}




#pragma mark - Private

+ (AFHTTPSessionManager *)sharedManager {
    static AFHTTPSessionManager *afManager = nil;
    static dispatch_once_t onceToken;
    if (afManager == nil) {
        dispatch_once(&onceToken, ^{
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.requestSerializer.timeoutInterval = 20;
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            //增加AFSecurityPolicy设置
            AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
            securityPolicy.allowInvalidCertificates = YES;
            securityPolicy.validatesDomainName = NO;
            manager.securityPolicy = securityPolicy;
            
            afManager = manager;
        });
    }
    return afManager;
}

+ (id)responseConfiguration:(id)responseObject {
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    //string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}

+ (NSString *)askURL:(NSString *)relativeURL {
    return [NSString stringWithFormat:@"%@/%@", BaseUrl, relativeURL];
}







#pragma mark - 网络请求队列管理

// 添加队列
+ (void)addTask:(NSURLSessionDataTask *)task {
    NSMutableDictionary *taskQue = [self taskQueue];
    [taskQue setObject:task forKey:@(task.taskIdentifier)];
}

// 删除队列
+ (void)removeTask:(NSURLSessionDataTask *)task {
    if ([self ifRequesting]) {
        NSMutableDictionary *taskQue = [self taskQueue];
        [taskQue removeObjectForKey:@(task.taskIdentifier)];
    }
}

// 队列管理容器
+ (NSMutableDictionary *)taskQueue {
    NSMutableDictionary *taskDict = objc_getAssociatedObject(self, @selector(addTask:));
    if (!taskDict) {
        taskDict = @{}.mutableCopy;
        objc_setAssociatedObject(self, @selector(addTask:), taskDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return taskDict;
}

// 判读有没有执行中的队列
+ (BOOL)ifRequesting {
    NSMutableDictionary *taskDict = objc_getAssociatedObject(self, @selector(addTask:));
    if (taskDict.allValues.count > 0) {
        return YES;
    }
    return NO;
}

// 取消队列中的所有请求
+ (void)cancelAllRequest {
    if ([AFNetwork ifRequesting]) {
        NSMutableDictionary *taskQue = [AFNetwork taskQueue];
        [taskQue enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
            NSURLSessionDataTask *dataTask = (NSURLSessionDataTask *)obj;
            if (dataTask.state != NSURLSessionTaskStateCompleted) {
                [dataTask cancel];
                NSLog(@"取消了一个请求！dataTask - %@", dataTask.currentRequest.URL.absoluteString);
            }
        }];
        [taskQue removeAllObjects];
    }
}

// 取消指定请求
+ (void)cancelRequest:(NSURLSessionDataTask *)task {
    if (task.state != NSURLSessionTaskStateCompleted) {
        [task cancel];
    }
}

@end
