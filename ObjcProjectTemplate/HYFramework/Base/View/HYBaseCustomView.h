//
//  MyBaseCustemView.h
//  findme
//
//  Created by 臻尚 on 2021/2/20.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseCustomView : UIView

// 主背景
@property (nonatomic, weak) UIView *mainBgView;

#pragma mark - 工厂方法
// 自定义view初始化
+ (instancetype)view;

#pragma mark - 设置子视图
// 添加子视图
- (void)setupSubViews;

#pragma mark - 其他


@end

NS_ASSUME_NONNULL_END
