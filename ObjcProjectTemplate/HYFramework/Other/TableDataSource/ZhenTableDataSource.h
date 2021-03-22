//
//  ZhenTableDataSource.h
//  findme
//
//  Created by 臻尚 on 2021/3/5.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhenTableDataSource : NSObject

// 数据集合
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

// 每一行样式
@property (nonatomic, copy) UITableViewCell* (^cellForRowAtIndexPath)(UITableView *table, NSIndexPath *indexPath);

// 点击一行回调
@property (nonatomic, copy) void(^didSelectRowAtIndexPath)(UITableView *table, NSIndexPath *indexPath);

// sectionHeader title
@property (nonatomic, copy) NSString *(^titleForHeaderInSection)(UITableView *table, NSInteger section);

// sectionHeader view
@property (nonatomic, copy) UIView *(^viewForHeaderInSection)(UITableView *table, NSInteger section);

//section header 高度
@property (nonatomic, copy) CGFloat (^heightForHeaderInSection)(UITableView *table, NSInteger section);


// section数量(默认1)
@property (nonatomic, assign) NSInteger sectionNumber;

// row数量(默认为dataSourceArray属性count)
@property (nonatomic, copy) NSInteger(^numberOfRowsInSection)(NSInteger section);

// 行高
@property (nonatomic, copy) CGFloat(^heightForRowAtIndexPath)(NSIndexPath *indexPath);

#pragma mark - 工厂方法
// 获取对象
+ (instancetype)dataSourceWithTable:(UITableView *)tableView;

#pragma mark - 其他
// 设置数据列表
- (void)resetDataWithArray:(NSArray *)array;

// 添加新数据
- (void)addDataWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
