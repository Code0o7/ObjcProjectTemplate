//
//  BaseModel.m
//  FindmiWorkers
//
//  Created by 臻尚 on 2020/12/3.
//

#import "HYBaseModel.h"

@implementation HYBaseModel

// 快速创建model
+ (instancetype)model
{
    id model = [[self alloc]init];
    return model;
}


// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"stuTrackingFlowList" : [ZhenTrakingFlowModel class]};
//}

// model ID属性取json中id键对应的值(该方法适用于yymodel)
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID":@"id"};
}

@end
