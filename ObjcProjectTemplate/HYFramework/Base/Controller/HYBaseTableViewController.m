//
//  HYBaseTableViewController.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "HYBaseTableViewController.h"

@interface HYBaseTableViewController ()

// table
@property (nonatomic, strong) UITableView *tableView;

// dataSource对象
@property (nonatomic, strong) ZhenTableDataSource *dataSource;

// 页码
@property(nonatomic, assign) NSInteger pageIndex;

@end

@implementation HYBaseTableViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
}

// 设置cell分割线左右间隔
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:self.separatorInset];
    }

    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - setter
// 行高
- (void)setRowHeight:(CGFloat)rowHeight
{
    _rowHeight = rowHeight;
    self.tableView.rowHeight = rowHeight;
}

#pragma mark - 设置子views
- (void)setupSubviews
{
    [super setupSubviews];
    // 默认cell分割线左右边距
    self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 5);
    // 页码 默认从第一页开始
    self.pageIndex = 1;
    // 添加table
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    // 设置table信息
    [self setupTableInfo];
}

#pragma mark - 下拉刷新/上拉加载更多
// 添加头部刷新
- (void)addHeaderRefresh
{
    WeakSelf
    [self.tableView addHeaderRefreshBlock:^{
        if ([Weakself respondsToSelector:@selector(reloadData)]) {
            [Weakself reloadData];
        }
    }];
}

// 添加上拉加载更多
- (void)addFootRefresh
{
    WeakSelf
    [self.tableView addFootRefreshBlock:^{
        if ([Weakself respondsToSelector:@selector(loadMore)]) {
            [Weakself loadMore];
        }
    }];
}

// 头部开始刷新
- (void)startRefresh
{
    [self.tableView startRefresh];
}

// 停止刷新(包括头部和尾部)
- (void)stopRefresh
{
    [self.tableView stopRefresh];
}

// 下拉刷新
- (void)reloadData
{
    // 复位页码
    self.pageIndex = 1;
    [self.dataSource.dataSourceArray removeAllObjects];
}

// 上拉加载更多
- (void)loadMore
{
    self.pageIndex++;
}

#pragma mark - 其他
// 设置tableView高度自适应
- (void)setupTableViewHeightAutomatic
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
}

// 注册 Nib cell(这里复用标识固定和cell类名一致)
- (void)registNibCell:(NSString *)className
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(NSClassFromString(className).class) bundle:nil] forCellReuseIdentifier:className];
}

// 注册纯代码cell(这里复用标识固定和cell类名一致)
- (void)registCell:(NSString *)className
{
    [self.tableView registerClass:[NSClassFromString(className) class] forCellReuseIdentifier:className];
}

// 设置table信息
- (void)setupTableInfo
{
    
}

#pragma mark - 懒加载
// table
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = UIView.new;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = HYColorBgLight;
        // 分割线颜色
        _tableView.separatorColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0];
    }
    return _tableView;
}

// dataSource
- (ZhenTableDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [ZhenTableDataSource dataSourceWithTable:self.tableView];
    }
    return _dataSource;
}

@end
