//
//  MyBaseTableViewCell.m
//  findme
//
//  Created by 臻尚 on 2021/3/1.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import "HYBaseTableViewCell.h"

@implementation HYBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置子视图
        [self setupViews];
    }
    return self;
}

// 设置子视图
- (void)setupViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setModel:(HYBaseModel *)model
{
    _model = model;
    
}

@end
