//
//  BaseModel.h
//  FindmiWorkers
//
//  Created by 臻尚 on 2020/12/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseModel : NSObject

// id
@property (nonatomic, copy) NSString *ID;
// content
@property (nonatomic, copy) NSString *content;
// content2
@property (nonatomic, copy) NSString *content2;

// 额外数据
@property (nonatomic, strong) id extensionData;

// 是否选中
@property (nonatomic, assign) BOOL sel;

// 快速创建model
+ (instancetype)model;


@end

NS_ASSUME_NONNULL_END
