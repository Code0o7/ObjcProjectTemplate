//
//  UIViewController+HYNetwork.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import <UIKit/UIKit.h>
#import "HYImageVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HYNetwork)

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
             showHud:(BOOL)showHud;

/**
 * post请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success;

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
             showHud:(BOOL)showHud;


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
            showHud:(BOOL)showHud;

/**
 * get请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 */
- (void)getWithPath:(NSString *_Nullable)path
             params:(NSDictionary *_Nullable)params
            success:(void (^_Nullable)(id _Nullable result))success;

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
            showHud:(BOOL)showHud;


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
            showHud:(BOOL)showHud;

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
           showHud:(BOOL)showHud;

/**
 * 用队列组异步上传多张图片或多个文件
 * @param filesArray 图片/视频文件模型数组
 * @param complete 所有图片/文件上传完成回调
 */
- (void)uploadMultiFile:(NSArray <HYImageVideoModel *>*)filesArray
               complete:(void (^)(BOOL hasFile))complete;


#pragma mark - 下载文件
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
                      complete:(void (^)(BOOL success, NSString *fileP))comple;


#pragma mark - 其他
/**
 * json转model
 * @param response 网络请求结果
 * @param modelClass model类
 */
- (id)jsonToModel:(id)response modelClass:(Class)modelClass;

@end

NS_ASSUME_NONNULL_END
