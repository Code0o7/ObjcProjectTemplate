//
//  HYBaseViewController.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <UIKit/UIKit.h>
#import "UIViewController+HYNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseViewController : UIViewController

#pragma mark - 属性
// 滚动视图
@property (nonatomic, strong, readonly) UIScrollView * _Nullable scrollView;

// scrollView内部背景视图，控制scrollView的contentSize
// 注:scrollContentView的高度没有添加约束，需要在内部添加子视图的时候设置约束把scrollContentView撑起来
@property (nonatomic, strong, readonly) UIView * _Nullable scrollContentView;

#pragma mark - 设置子视图
// 子视图设置
- (void)setupSubviews;

// 添加scroll(需要的时候主动调用)
- (void)addScrollView;

#pragma mark - 其他
// push
- (void)pushWithCotroller:(UIViewController *_Nullable)ctr animated:(BOOL)animated;

// push
- (void)pushWithCotroller:(UIViewController *_Nullable)ctr;

/**
 如果是表单类型控制器，提交前需校验所有内容是否都填写完成
 * 哪一项内容没有填写,返回提示用户填写该项信息的文本,否则返回 nil
 */
- (NSString *)checkBeforeCommit;

@end

NS_ASSUME_NONNULL_END
