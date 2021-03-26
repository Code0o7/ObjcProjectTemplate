//
//  UIViewController+HYNetwork.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "UIViewController+HYNetwork.h"

@implementation UIViewController (HYNetwork)

#pragma mark - POST请求
/**
 * post请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param faile     请求失败回调
 * @param showHud   是否显示蒙板
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^ _Nullable)(id _Nullable result))success
               faile:(void (^ _Nullable)(void))faile
             showHud:(BOOL)showHud
{
    if (showHud) {
        WAITING
    }
    [HYAFttpTool POSTWithPath:HYAPI_FULL_URL(path) params:params success:^(id responseObject) {
        NSDictionary *res = (NSDictionary *)responseObject;
        
        // 隐藏蒙板
        DISMISS
        
        if ([[NSString stringWithFormat:@"%@",res[@"code"]] isEqualToString:@"200"]) {
            if ([res[@"code"] intValue] == 200) {
                // 请求成功
                if (success) {
                    success(responseObject);
                }
            }else {
                // 请求失败
                if (HYObjIsKindOfClass(res, NSDictionary) && [res.allKeys containsObject:@"msg"]) {
                    ERRORWith(res[@"msg"]);
                }
                
                if (faile) {
                    faile();
                }
            }
        }else{
            // 请求失败
            NSString *errMsg = @"请求失败,请稍后重试";
            if (responseObject && HYObjIsKindOfClass(responseObject,NSDictionary)) {
                NSArray *allKeys = [(NSDictionary *)responseObject allKeys];
                if ([allKeys containsObject:@"msg"]) {
                    errMsg = responseObject[@"msg"];
                }
            }
            ERRORWith(errMsg)
            
            if (faile) {
                faile();
            }
        }
    } failure:^(NSError *error) {
        DISMISS
        // 请求失败
        if (faile) {
            faile();
        }
    } dataType:ReturnDataType_DEFAULT showHUD:NO];
}

/**
 * post请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success
{
    [self postWithPath:path params:params success:success faile:nil showHud:YES];
}

/**
 * post请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param showHud   是否显示蒙板
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success
             showHud:(BOOL)showHud
{
    [self postWithPath:path params:params success:success faile:nil showHud:showHud];
}

#pragma mark - GET请求
/**
 * get请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param faile     请求失败回调
 * @param showHud   是否显示蒙板
 */
- (void)getWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^ _Nullable)(id _Nullable result))success
               faile:(void (^ _Nullable)(void))faile
             showHud:(BOOL)showHud
{
    if (showHud) {
        WAITING
    }
    [HYAFttpTool GETWithPath:HYAPI_FULL_URL(path) params:params success:^(id responseObject) {
        NSDictionary *res = (NSDictionary *)responseObject;
        
        // 隐藏蒙板
        DISMISS
        
        if ([[NSString stringWithFormat:@"%@",res[@"code"]] isEqualToString:@"200"]) {
            if ([res[@"code"] intValue] == 200) {
                // 请求成功
                if (success) {
                    success(responseObject);
                }
            }else {
                // 请求失败
                if (HYObjIsKindOfClass(res, NSDictionary) && [res.allKeys containsObject:@"msg"]) {
                    ERRORWith(res[@"msg"]);
                }
                
                if (faile) {
                    faile();
                }
            }
        }else{
            // 请求失败
            NSString *errMsg = @"请求失败,请稍后重试";
            if (responseObject && HYObjIsKindOfClass(responseObject,NSDictionary)) {
                NSArray *allKeys = [(NSDictionary *)responseObject allKeys];
                if ([allKeys containsObject:@"msg"]) {
                    errMsg = responseObject[@"msg"];
                }
            }
            ERRORWith(errMsg)
            
            if (faile) {
                faile();
            }
        }
    } failure:^(NSError *error) {
        DISMISS
        // 请求失败
        if (faile) {
            faile();
        }
    } dataType:ReturnDataType_DEFAULT showHUD:NO];
}

/**
 * get请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 */
- (void)getWithPath:(NSString *_Nullable)path
             params:(NSDictionary *_Nullable)params
            success:(void (^_Nullable)(id _Nullable result))success
{
    [self getWithPath:path params:params success:success faile:nil showHud:YES];
}

/**
 * get请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param showHud   是否显示蒙板
 */
- (void)getWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success
             showHud:(BOOL)showHud
{
    [self getWithPath:path params:params success:success faile:nil showHud:showHud];
}

#pragma mark - 上传文件/图片
/**
 * 上传图片
 * @param imageData 图片二进制
 * @param success 上传成功回调
 * @param faile 上传失败回调
 * @param showHud 是否显示蒙板
 */
- (void)uploadImage:(NSData *_Nullable)imageData
            success:(void (^_Nullable)(NSString * _Nullable imgUrl))success
              faile:(void (^_Nullable)(void))faile
            showHud:(BOOL)showHud
{
    if (showHud) {
        WAITING
    }

    // 获取当前时间戳作为图片名
    [HYAFttpTool uploadWithParameters:@{} UrlString:HYAPI_FULL_URL(HYAPI_UploadImage) header:@{} upImg:imageData imgNamge:@"img" successBlock:^(id responseObject) {
        // 隐藏蒙板
        if (showHud) {
            DISMISS
        }

        NSDictionary *dict = (NSDictionary *)responseObject;
        if([dict[@"code"] intValue] == 200){
            // 成功
            NSString *url = dict[@"data"];
            if (HYStringEmpty(url)) {
                if (faile) {
                    faile();
                }
            }else {
                if (success) {
                    success(url);
                }
            }
        }else {
            if (faile) {
                faile();
            }
        }
    } failureBlock:^(id error) {
        // 隐藏蒙板
        if (showHud) {
            DISMISS
        }

        if (faile) {
            faile();
        }
    }];
}

/**
 * 上传文件
 * @param fileData 文件二进制
 * @param fileType 文件后缀名
 * @param success 上传成功回调
 * @param faile 上传失败回调
 * @param showHud 是否显示蒙板
 */
- (void)uploadFile:(NSData *_Nullable)fileData
          fileType:(NSString *_Nullable)fileType
           success:(void (^_Nullable)(NSString * _Nullable returnUrl))success
             faile:(void (^_Nullable)(void))faile
           showHud:(BOOL)showHud
{
    if (showHud) {
        WAITING
    }
    
    // 获取当前时间戳作为图片名
    [HYAFttpTool uploadFileWithParameters:@{} UrlString:HYAPI_FULL_URL(HYAPI_UploadImage) header:@{} upData:fileData name:@"img" fileType:fileType successBlock:^(id responseObject) {
        // 隐藏蒙板
        DISMISS
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        if([dict[@"code"] intValue] == 200){
            NSString *url = dict[@"data"];
            if (HYStringEmpty(url)) {
                if (faile) {
                    faile();
                }
            }else {
                if (success) {
                    success(url);
                }
            }
        }else {
            if (faile) {
                faile();
            }
        }
    } failureBlock:^(id error) {
        // 隐藏蒙板
        DISMISS
        
        if (faile) {
            faile();
        }
    }];
}

/**
 * 用队列组异步上传多张图片或多个文件
 * @param filesArray 图片/视频文件模型数组
 * @param complete 所有图片/文件上传完成回调
 */
- (void)uploadMultiFile:(NSArray <HYImageVideoModel *>*)filesArray
               complete:(void (^)(BOOL hasFile))complete
{
    if (filesArray.count > 0) {
        // 队列组异步上传文件
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);

        WeakSelf
        WAITING
        for (HYImageVideoModel *imageModel in filesArray) {
            dispatch_group_enter(group);
        
            dispatch_group_async(group, queue, ^{
                // 执行异步上传任务
                if (imageModel.isVideo) {
                    // 上传视频
                    [Weakself uploadFile:imageModel.data fileType:imageModel.fileType success:^(NSString * _Nullable returnUrl) {
                        imageModel.imageVideoUrl = returnUrl;
                        dispatch_group_leave(group);
                    } faile:^{
                        dispatch_group_leave(group);
                    } showHud:NO];
                }else {
                    // 上传图片
                    [Weakself uploadImage:imageModel.data success:^(NSString * _Nullable imgUrl) {
                        imageModel.imageVideoUrl = imgUrl;
                        dispatch_group_leave(group);
                    } faile:^{
                        dispatch_group_leave(group);
                    } showHud:NO];
                }
            });
        }
        
        // 所有图片上传完成
        dispatch_group_notify(group,dispatch_get_main_queue(), ^{
            if (complete) {
                complete(YES);
            }
        });
    }else {
        // 没有附件
        if (complete) {
            complete(NO);
        }
    }
}

#pragma mark - 下载文件
/**
 * 下载文件
 * @param fileUrl 文件地址
 * @param saveDirPath 文件保存的文件夹路径
 * @param fileN 指定文件名,如果不指定,默认截取文件下载地址最后的文件名
 * @param comple 下载完成回调
 */
- (void)downloadFile:(NSString *)fileUrl
         saveDirPath:(NSString *)saveDirPath
            fileName:(NSString *)fileN
            complete:(void (^)(BOOL success, NSString *fileP))comple
{
    // 创建文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];

    // 创建目录
    [fileManager createDirectoryAtPath:saveDirPath withIntermediateDirectories:YES attributes:nil error:nil];
   
    // 下载文件
    NSString *fileName = fileN;
    if (fileN == nil || HYStringEmpty(fileN)) {
        // 不指定文件名,截取文件地址附带的文件名
        fileName = [fileUrl lastPathComponent];
    }
    
    // 文件保存路径
    NSString *fileFullPath = [saveDirPath stringByAppendingPathComponent:fileName];
    // 如果文件存在 直接返回文件地址
    if ([fileManager fileExistsAtPath:fileFullPath]) {
        if (comple) {
            comple(YES,fileFullPath);
        }
    }else {
        // 下载文件
        [HYAFttpTool downloadFile:fileUrl savePath:fileFullPath downProgress:^(NSString *pro) {
        } complete:^(BOOL suc) {
            if (comple) {
                comple(suc,fileFullPath);
            }
        }];
    }
}

/**
 * 下载文件到cache目录
 * @param fileUrl 文件地址
 * @param saveDirName 文件保存的文件夹名称
 * @param fileN 指定文件名,如果不指定,默认截取文件下载地址最后的文件名
 * @param comple 下载完成回调
 */
- (void)downloadFileToCacheDir:(NSString *)fileUrl
                   saveDirName:(NSString *)saveDirName
                      fileName:(NSString *)fileN
                      complete:(void (^)(BOOL success, NSString *fileP))comple
{
    // 获取cache文件夹路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    NSString *dirPath = [cachePath stringByAppendingPathComponent:saveDirName];
    
    // 下载
    [self downloadFile:fileUrl saveDirPath:dirPath fileName:fileN complete:comple];
}

#pragma mark - 其他
/**
 * json转model
 * @param response 网络请求结果
 * @param modelClass model类
 */
- (id)jsonToModel:(id)response modelClass:(Class)modelClass
{
    id obj = nil;
    if (response && HYObjIsKindOfClass(response, NSDictionary)) {
        NSDictionary *dict = (NSDictionary *)response;
        if ([dict.allKeys containsObject:@"AppendData"]) {
            id data = dict[@"AppendData"];
            if (HYObjIsKindOfClass(data, NSDictionary)) {
                obj = [modelClass yy_modelWithDictionary:data];
            }else if (HYObjIsKindOfClass(data, NSArray)){
                // 数组转换
                obj = [NSArray yy_modelArrayWithClass:modelClass json:data];
            }else {
                NSLog(@"不支持转换的json格式:%@",data);
            }
        }
    }
    
    return obj;
}

@end
