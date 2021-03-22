//
//  HYAFttpTool.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 返回数据接收类型
typedef NS_ENUM(NSInteger, ReturnDataType) {
    ReturnDataType_DEFAULT,         //默认
    ReturnDataType_TEXT_HTML,       // text/html
    ReturnDataType_XML,             // xml
    ReturnDataType_HTML             // html
};

// 请求类型
typedef NS_ENUM(NSInteger, RequestType) {
    RequestType_POST,       // post
    RequestType_GET         // get
};

@interface AFHttpClient : AFHTTPSessionManager

// 单利
+ (instancetype)sharedClient;

@end

@interface HYAFttpTool : NSObject

/**
 AFN 请求
 
 @param requestType 请求类型
 @param path URL地址
 @param params 请求参数 (NSDictionary)
 @param success 请求成功返回值（type）
 @param failure 请求失败值 (NSError)
 */
+ (void)requestWithType:(RequestType)requestType
            networkPath:(NSString *)path
                 params:(NSDictionary *)params
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure
               dataType:(ReturnDataType )type
                showHUD:(BOOL)isShow;

/**
 AFN post请求
 
 @param path URL地址
 @param params 请求参数 (NSDictionary)
 @param success 请求成功返回值（type）
 @param failure 请求失败值 (NSError)
 */
+ (void)POSTWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure
            dataType:(ReturnDataType )type
             showHUD:(BOOL)isShow;

/**
 AFN get请求
 
 @param path URL地址
 @param params 请求参数 (NSDictionary)
 @param success 请求成功返回值（type）
 @param failure 请求失败值 (NSError)
 */
+ (void)GETWithPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(HttpSuccessBlock)success
                   failure:(HttpFailureBlock)failure
                  dataType:(ReturnDataType)type
                   showHUD:(BOOL)isShow;
/**
 AFN 请求 -- GCD队列请求

 @param type 请求类型-- POST GET
 @param urls URL地址-- 数组
 @param paras 请求参数 --数组
 @param success 请求成功返回值
 @param failure 请求失败值
 */
+ (void)runDispatchTestWithType:(RequestType)type
                          Paths:(NSArray *)urls
                           paras:(NSArray *)paras
                         success:(HttpSuccessBlock)success
                         failure:(HttpFaultBlock)failure;

/**
 图片上传 -- GCD队列请求
 
 @param urls URL地址-- 数组
 @param paras 请求参数 --数组
 @param success 请求成功返回值
 @param failure 请求失败值
 */
+ (void)upLoadWithPaths:(NSArray *)urls
                  paras:(NSArray *)paras
                success:(HttpSuccessBlock)success
                failure:(HttpFaultBlock)failure;
/**
 图片上传
 
 @param image 图片
 @param imageName 图片名称
 @param url 请求地址
 @param success 请求成功返回值
 @param failure 请求失败值
 */
+ (void)uploadImage:(UIImage *)image
          imageName:(NSString *)imageName
                url:(NSString *)url
           progress:(HttpProgressBlock)progress
            success:(HttpSuccessBlock)success
            failure:(HttpFaultBlock)failure;

/**
 图片、视频上传 -- GCD队列请求
 
 @param urls URL地址-- 数组
 @param paras 请求参数 --数组
 @param success 请求成功返回值
 @param failure 请求失败值
 */
+ (void)upLoadMoviePhotoWithPaths:(NSArray *)urls
                            paras:(NSArray *)paras
                          success:(HttpSuccessBlock)success
                          failure:(HttpFaultBlock)failure;
/**
 视频上传
 
 @param videoPath 视频地址
 @param videoName 视频名称
 @param url 请求地址
 @param success 请求成功返回值
 @param failure 请求失败值
 */
+ (void)uploadMovieWithParam:(NSString *)videoPath
                     movieName:(NSString *)videoName
                           url:(NSString *)url
                       success:(HttpSuccessBlock)success
                       failure:(HttpFaultBlock)failure;

/**
 上传图片
 */
+ (void)uploadWithParameters:(id)parameters UrlString:(NSString *)urlString header:(NSDictionary *)header upImg:(NSData *)upImg imgNamge:(NSString *)imgName successBlock:(HttpSuccessBlock)successBlock failureBlock:(HttpFaultBlock)failure;

/**
 上传视频等文件
 */
+ (void)uploadFileWithParameters:(id)parameters
                   UrlString:(NSString *)urlString
                      header:(NSDictionary *)header
                      upData:(NSData *)upData
                        name:(NSString *)name
                    fileType:(NSString *)fileType
                successBlock:(HttpSuccessBlock)successBlock
                failureBlock:(HttpFaultBlock)failure;

/**
 取消网络请求
 */
+ (void)cancelAllRequest;

/**
 网络状态

 @param state 状态
 */
+ (void)NetworkMonitoringStatus:(TheNetworkStatusBlock)state;

@end

NS_ASSUME_NONNULL_END