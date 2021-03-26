//
//  MyBaseTableViewCell.h
//  findme
//
//  Created by 臻尚 on 2021/3/1.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseTableViewCell : UITableViewCell

// 数据模型
@property (nonatomic, weak) HYBaseModel *model;

// 设置子视图
- (void)setupViews;

@end

NS_ASSUME_NONNULL_END
