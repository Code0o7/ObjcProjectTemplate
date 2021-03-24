//
//  HYBaseTableViewController.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "HYBaseViewController.h"
#import "ZhenTableDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseTableViewController : HYBaseViewController

#pragma mark - 属性
// table
@property (nonatomic, strong, readonly) UITableView *tableView;

// 页码
@property(nonatomic, assign, readonly) NSInteger pageIndex;

// dataSource对象
@property (nonatomic, strong, readonly) ZhenTableDataSource *dataSource;

// 行高
@property (nonatomic, assign) CGFloat rowHeight;

// 分割线边距
@property (nonatomic, assign) UIEdgeInsets separatorInset;

#pragma mark - 下拉刷新/上拉加载更多
// 添加头部刷新
- (void)addHeaderRefresh;

// 添加上拉加载更多
- (void)addFootRefresh;

// 头部开始刷新
- (void)startRefresh;

// 停止刷新(包括头部和尾部)
- (void)stopRefresh;

// 下拉刷新
- (void)reloadData;

// 上拉加载更多
- (void)loadMore;

#pragma mark - 其他
// 设置tableView高度自适应
- (void)setupTableViewHeightAutomatic;

// 注册 Nib cell(这里复用标识固定和cell类名一致)
- (void)registNibCell:(NSString *)className;

// 注册纯代码cell(这里复用标识固定和cell类名一致)
- (void)registCell:(NSString *)className;

// 设置table信息
- (void)setupTableInfo;

@end

NS_ASSUME_NONNULL_END
