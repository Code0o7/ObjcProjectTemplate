//
//  HYAPIConfig.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/1/16.
//

#ifndef HYAPIConfig_h
#define HYAPIConfig_h

// 服务器地址
#define HYAPI_BASE_URL @""

//baseUrl
#define HYAPI_BaseUrl [NSString stringWithFormat:@"%@",HYAPI_IP_ADDRESS]

/**
 * 登录
 */
#define HYAPI_loginUrl [NSString stringWithFormat:@"%@/login/loginByPhone",HYAPI_BaseUrl]


#endif /* HYAPIConfig_h */
