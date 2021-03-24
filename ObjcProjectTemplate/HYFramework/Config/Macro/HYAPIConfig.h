//
//  HYAPIConfig.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/1/16.
//

#ifndef HYAPIConfig_h
#define HYAPIConfig_h

#pragma mark - Base
// 服务器地址
#define HYAPI_BASE_URL @""

// 完整url,前面拼接baseUrl
#define HYAPI_FULL_URL(suffix) [NSString stringWithFormat:@"%@/%@",HYAPI_BASE_URL,suffix]

#pragma mark - 上传图片/文件
// 上传图片
#define HYAPI_UploadImage @""

/**
 * 登录
 */
#define HYAPI_loginUrl [NSString stringWithFormat:@"%@/login/loginByPhone",HYAPI_BaseUrl]


#endif /* HYAPIConfig_h */
