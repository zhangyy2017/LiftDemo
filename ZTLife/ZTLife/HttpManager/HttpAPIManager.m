//
//  HttpAPIManager.m
//  ZTServiceProject
//
//  Created by zhangyy on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HttpAPIManager.h"
#import "YYRequest.h"
@implementation HttpAPIManager
ZX_IMPLEMENT_SINGLETON(HttpAPIManager);
- (void)postWithUrl:(NSString *)url
           paramter:(id)paramter
            success:(HttpRequestSuccess)success
            failure:(HttpRequestFailure)failure {
    
    NSString *newUrl = [self dealWithURL:url];
    id newParamter = [self dealWithParamter:paramter];
    [YYRequest requestPostWithURLString:newUrl paramater:newParamter success:^(YYNetWorkSuccess *successful) {
        NSLog(@"请求路径：%@ ************* 请求参数：%@  ********    请求返回的值：%@",newUrl,newParamter,successful.responseObject);
        if ([successful.responseObject[@"code"] integerValue]==200) {
            success(successful.responseObject[@"result"]);
        }
        else {
            failure(nil,successful.responseObject[@"message"]);
        }
    } failure:^(YYNetWorkFailure *failured) {
        NSLog(@"请求路径：%@ ************* 请求参数：%@  ******** 请求错误信息：%@",newUrl,newParamter,failured.error);
         failure(failured.error,nil);
    } progress:nil];
}

- (void)getWithUrl:(NSString *)url
          paramter:(id)paramter
           success:(HttpRequestSuccess)success
           failure:(HttpRequestFailure)failure {
    NSString *newUrl = [self dealWithURL:url];
    id newParamter = [self dealWithParamter:paramter];
    
    [YYRequest requestGETtWithURLString:newUrl paramater:newParamter success:^(YYNetWorkSuccess *successful) {
        NSLog(@"请求路径：%@ ************* 请求参数：%@  ********   请求返回的值：%@",newUrl,newParamter,successful.responseObject);
        if ([successful.responseObject[@"code"] integerValue]==200) {
            success(successful.responseObject[@"result"]);
        }
        else {
            failure(nil,successful.responseObject[@"message"]);
        }
    } failure:^(YYNetWorkFailure *failured) {
        NSLog(@"请求路径：%@ ************* 请求参数：%@  ******** 请求错误信息：%@",newUrl,newParamter,failured.error);
        failure(failured.error,nil);
    } progress:nil];
}

- (void)getWithOneUrl:(NSString *)url
          paramter:(id)paramter
           success:(HttpRequestSuccess)success
           failure:(HttpRequestFailure)failure {
    NSString *newUrl = [self dealWithURL:url];
    id newParamter = [self dealWithParamterOne:paramter];
    
    [YYRequest requestGETtWithURLString:newUrl paramater:newParamter success:^(YYNetWorkSuccess *successful) {
        NSLog(@"请求路径：%@ ************* 请求参数：%@  ********   请求返回的值：%@",newUrl,newParamter,successful.responseObject);
        if ([successful.responseObject[@"code"] integerValue]==200) {
            success(successful.responseObject[@"result"]);
        }
        else {
            failure(nil,successful.responseObject[@"message"]);
        }
    } failure:^(YYNetWorkFailure *failured) {
        NSLog(@"请求路径：%@ ************* 请求参数：%@  ******** 请求错误信息：%@",newUrl,newParamter,failured.error);
        failure(failured.error,nil);
    } progress:nil];
}


- (void)getWithTwoUrl:(NSString *)url
          paramter:(id)paramter
           success:(HttpRequestSuccess)success
           failure:(HttpRequestFailure)failure {
    NSString *newUrl = [self dealWithURL:url];
//    id newParamter = [self dealWithParamter:paramter];
    
    [YYRequest requestGETtWithURLString:newUrl paramater:paramter success:^(YYNetWorkSuccess *successful) {
        //NSLog(@"请求路径：%@ ************* 请求参数：%@  ********   请求返回的值：%@",newUrl,paramter,successful.responseObject);
        if ([successful.responseObject[@"code"] integerValue]==200) {
            success(successful.responseObject[@"result"]);
        }
        else {
            failure(nil,successful.responseObject[@"message"]);
        }
    } failure:^(YYNetWorkFailure *failured) {
        NSLog(@"请求路径：%@ ************* 请求参数：%@  ******** 请求错误信息：%@",newUrl,paramter,failured.error);
        failure(failured.error,nil);
    } progress:nil];
}

- (void)uploadDataWithUrl:(NSString *)url
                 fileData:(NSData *)data
                     type:(NSString *)type
                     name:(NSString *)name
                 mimeType:(NSString *)mimeType
                 paramter:(id)paramter
            progressBlock:(HttpRequestProgress)progressBlock
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailure)failure {
    
    NSString *newUrl = [self dealWithURL:url];
    id newParamter = [self dealWithParamter:paramter];

    [YYRequest uploadFileWithUrl:url fileData:data type:type name:name mimeType:mimeType paramter:newParamter progress:^(int64_t bytesRead, int64_t totalBytes) {
        progressBlock((CGFloat)bytesRead/totalBytes);
    } success:^(YYNetWorkSuccess *successful) {
        NSLog(@"请求路径：%@ ************* 请求参数：%@  ********   请求返回的值：%@",newUrl,newParamter,successful.responseObject);

        success(successful.responseObject);
    } failure:^(YYNetWorkFailure *failured) {
        NSLog(@"请求路径：%@ ************* 请求参数：%@  ******** 请求错误信息：%@",newUrl,newParamter,failured.error);
        failure(failured.error,nil);
    }];
    
}

- (void)uploadDataArrayWithUrl:(NSString *)url
                      fileData:(NSArray *)data
                          type:(NSString *)type
                          name:(NSString *)name
                      mimeType:(NSString *)mimeType
                      paramter:(id)paramter
                 progressBlock:(HttpRequestProgress)progressBlock
                       success:(HttpRequestSuccess)success
                       failure:(void(^)(NSArray *failure))failure {
    NSString *newUrl = [self dealWithURL:url];
    id newParamter = [self dealWithParamter:paramter];

    [YYRequest uploadFilesWithUrl:newUrl fileDatas:data type:type name:name mimeType:mimeType paramter:newParamter progress:^(int64_t bytesRead, int64_t totalBytes) {
        progressBlock((CGFloat)bytesRead/totalBytes);
    } success:^(YYNetWorkSuccess *successful) {
        NSLog(@"请求路径：%@ ************* 请求参数：%@  ********   请求返回的值：%@",newUrl,newParamter,successful.responseObject);

        success(successful.responseObject);
    } failure:^(NSArray *failureful) {
        NSLog(@"请求路径：%@ ************* 请求参数：%@  ********   请求返回的错误信息：%@",newUrl,newParamter,failureful);
        failure(failureful);
    }];
}

- (void)downloadDataWithUrl:(NSString *)url
                   savePath:(NSString *)savePath
                  paramater:(id)paramter
              progressBlock:(HttpRequestProgress)progressBlock
                    success:(HttpRequestCompletionBlock)success
                    failure:(HttpRequestFailure)failure {
    [YYRequest requestDownloadFileWithURLString:[self dealWithURL:url] savePath:savePath paramater:[self dealWithParamter:paramter] success:^(NSURLResponse *respose, NSURL *filePath, NSError *error) {
        if (error){
            failure(error,@"");
        }
        else {
            success(respose,filePath);
        }
    } progress:^(int64_t bytesRead, int64_t totalBytes) {
        progressBlock((CGFloat)bytesRead/totalBytes);
    }];
}

- (void)cancelAllRequest {
    [YYRequest cancleAllRequest];
}

//预留接口方便参数加密
//- (id)dealWithParamter:(id)paramter{
//    NSMutableDictionary *newParamter = [[NSMutableDictionary alloc]init];
//    if ([paramter isKindOfClass:[NSArray class]]) {
//    
//    }
//    else if ([paramter isKindOfClass:[NSDictionary class]]) {
//        [newParamter setValuesForKeysWithDictionary:paramter];
//        [newParamter setValue:@"1" forKey:@"token"];
//        [newParamter setValue:@"1" forKey:@"userId"];
//    }
//    else {
//    
//    }
//    
//    NSString *token = [newParamter objectForKey:@"token"];
//    NSString *userId = [newParamter objectForKey:@"userId"];
//    NSAssert(token.length>0, @"token不能为空");
//    NSAssert(userId.length>0, @"userId不能为空");
//    return newParamter;
//}
- (id)dealWithParamter:(NSDictionary *)paramter{
    if (!paramter) {
        return nil;
    }
    NSMutableDictionary *newParamter = [[NSMutableDictionary alloc]initWithDictionary:paramter];
//    [newParamter setValuesForKeysWithDictionary:paramter];
//    [newParamter setValue:@"20170607093552" forKey:@"userId"];
    
    [newParamter setValue:@"IMwMF9OpWmvOCzOofFSwAA==" forKey:@"token"];
    [newParamter setValue:@"1362111422120170322120834" forKey:@"userId"];

    //[UserInfoManager sharedUserInfoManager].userInfoModel.userId
//    [newParamter setValue:[UserInfoManager sharedUserInfoManager].userInfoModel.token forKey:@"token"];
//    [newParamter setValue:[UserInfoManager sharedUserInfoManager].userInfoModel.userId forKey:@"userId"];

    NSString *token = [newParamter objectForKey:@"token"];
    NSString *userId = [newParamter objectForKey:@"userId"];
    NSAssert(token.length>0, @"token不能为空");
    NSAssert(userId.length>0, @"userId不能为空");
    return newParamter;
}

- (id)dealWithParamterOne:(NSDictionary *)paramter{
    if (!paramter) {
        return nil;
    }
    NSMutableDictionary *newParamter = [[NSMutableDictionary alloc]initWithDictionary:paramter];
    //    [newParamter setValuesForKeysWithDictionary:paramter];
    //    [newParamter setValue:@"20170607093552" forKey:@"userId"];
    
    [newParamter setValue:@"1362111422120170322120834" forKey:@"userId"];
    
//    [newParamter setValue:[UserInfoManager sharedUserInfoManager].userInfoModel.userId forKey:@"userId"];

    
    NSString *userId = [newParamter objectForKey:@"userId"];
    NSAssert(userId.length>0, @"userId不能为空");
    return newParamter;
}

//为了URL管理
- (NSString *)dealWithURL:(NSString *)urlString {
    return MRRemote(urlString);
}




@end
