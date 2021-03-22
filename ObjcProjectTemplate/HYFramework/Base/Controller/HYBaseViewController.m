//
//  HYBaseViewController.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "HYBaseViewController.h"

@interface HYBaseViewController ()

// 滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;

// scrollView内部背景视图，控制scrollView的contentSize
// 注:scrollContentView的高度没有添加约束，需要在内部添加子视图的时候设置约束把scrollContentView撑起来
@property (nonatomic, strong) UIView *scrollContentView;

// viewWillAppear记录导航栏状态 viewWillDisappear恢复，防止影响其他控制器显示
@property (nonatomic, assign) BOOL navOriginHiddenState;

@end

@implementation HYBaseViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 子视图设置
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 记录导航栏的显示状态
    self.navOriginHiddenState = self.navigationController.navigationBarHidden;
    
    // 去掉导航栏下面自带的线条
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 恢复导航栏进入该页面时的显示状态
    self.navigationController.navigationBarHidden = self.navOriginHiddenState;
}

#pragma mark - 设置子视图
// 子视图设置
- (void)setupSubviews
{
    // 默认白色view
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置返回按钮
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            UIBarButtonItem *leftTem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
            [self.navigationItem setLeftBarButtonItem:leftTem];
        }
    }
}

// 添加scroll(需要的时候主动调用)
- (void)addScrollView
{
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    [self.scrollView addSubview:self.scrollContentView];
    [self.scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView);
    }];
}

#pragma mark - 其他
// push
- (void)pushWithCotroller:(UIViewController *)ctr animated:(BOOL)animated
{
    ctr.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctr animated:animated];
}

// push
- (void)pushWithCotroller:(UIViewController *)ctr
{
    [self pushWithCotroller:ctr animated:YES];
}

/**
 如果是表单类型控制器，提交前需校验所有内容是否都填写完成
 * 哪一项内容没有填写,返回提示用户填写该项信息的文本,否则返回 nil
 */
- (NSString *)checkBeforeCommit
{
    return nil;
}

#pragma mark - 公用网络请求封装
/**
 * post请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param faile     请求失败回调
 * @param showHud   是否显示蒙板
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^ _Nullable)(id _Nullable result))success
               faile:(void (^ _Nullable)(void))faile
             showHud:(BOOL)showHud
{
    if (showHud) {
        WAITING
    }
    [WGAFttpTool POSTWithPath:UrlWithSuffix(path) params:params success:^(id responseObject) {
        NSDictionary *res = (NSDictionary *)responseObject;
        
        // 隐藏蒙板
        [MBProgressHUD hideHUDForView:kAppKeyWindow];
        
        if (RequestSuccess(responseObject)) {
            if ([res[@"code"] intValue] == 200) {
                // 请求成功
                if (success) {
                    success(responseObject);
                }
            }else {
                // 请求失败
                if (isKindOfClass(res, NSDictionary) && [res.allKeys containsObject:@"msg"]) {
                    ERRORWith(res[@"msg"]);
                }
                
                if (faile) {
                    faile();
                }
            }
        }else{
            // 请求失败
            NSString *errMsg = @"请求失败,请稍后重试";
            if (responseObject && isKindOfClass(responseObject,NSDictionary)) {
                NSArray *allKeys = [(NSDictionary *)responseObject allKeys];
                if ([allKeys containsObject:@"msg"]) {
                    errMsg = responseObject[@"msg"];
                }
            }
            ERRORWith(errMsg)
            
            if (faile) {
                faile();
            }
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:kAppKeyWindow];
        // 请求失败
        if (faile) {
            faile();
        }
    } dataType:ReturnDataType_DEFAULT showHUD:NO];
}

/**
 * post请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success
{
    [self postWithPath:path params:params success:success faile:nil showHud:YES];
}

/**
 * post请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param showHud   是否显示蒙板
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success
             showHud:(BOOL)showHud
{
    [self postWithPath:path params:params success:success faile:nil showHud:showHud];
}

/**
 * 上传图片
 * @param imageData 图片二进制
 * @param success 上传成功回调
 * @param faile 上传失败回调
 * @param showHud 是否显示蒙板
 */
- (void)uploadImage:(NSData *_Nullable)imageData
            success:(void (^_Nullable)(NSString * _Nullable imgUrl))success
              faile:(void (^_Nullable)(void))faile
            showHud:(BOOL)showHud
{
    if (showHud) {
        [MBProgressHUD showMessage:@"加载中" toView:kAppKeyWindow];
    }

    // 获取当前时间戳作为图片名
    [WGAFttpTool uploadWithParameters:@{} UrlString:UrlWithSuffix(URL_UploadImage) header:@{} upImg:imageData imgNamge:@"img" successBlock:^(id responseObject) {
        // 隐藏蒙板
        if (showHud) {
            [MBProgressHUD hideHUDForView:kAppKeyWindow];
        }

        NSDictionary *dict = (NSDictionary *)responseObject;
        if([dict[@"code"] intValue] == 200){
            // 成功
            NSString *url = dict[@"data"];
            if (StringEmpty(url)) {
                if (faile) {
                    faile();
                }
            }else {
                if (success) {
                    success(url);
                }
            }
        }else {
            if (faile) {
                faile();
            }
        }
    } failureBlock:^(id error) {
        // 隐藏蒙板
        if (showHud) {
            [MBProgressHUD hideHUDForView:kAppKeyWindow];
        }

        if (faile) {
            faile();
        }
    }];
}

/**
 * 上传文件
 * @param fileData 文件二进制
 * @param fileType 文件后缀名
 * @param success 上传成功回调
 * @param faile 上传失败回调
 * @param showHud 是否显示蒙板
 */
- (void)uploadFile:(NSData *_Nullable)fileData
          fileType:(NSString *_Nullable)fileType
           success:(void (^_Nullable)(NSString * _Nullable returnUrl))success
             faile:(void (^_Nullable)(void))faile
           showHud:(BOOL)showHud
{
    if (showHud) {
        [MBProgressHUD showMessage:@"加载中" toView:kAppKeyWindow];
    }
    
    // 获取当前时间戳作为图片名
    [WGAFttpTool uploadFileWithParameters:@{} UrlString:UrlWithSuffix(URL_UploadImage) header:@{} upData:fileData name:@"img" fileType:fileType successBlock:^(id responseObject) {
        // 隐藏蒙板
        [MBProgressHUD hideHUDForView:kAppKeyWindow];
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        if([dict[@"code"] intValue] == 200){
            NSString *url = dict[@"data"];
            if (StringEmpty(url)) {
                if (faile) {
                    faile();
                }
            }else {
                if (success) {
                    success(url);
                }
            }
        }else {
            if (faile) {
                faile();
            }
        }
    } failureBlock:^(id error) {
        // 隐藏蒙板
        [MBProgressHUD hideHUDForView:kAppKeyWindow];
        
        if (faile) {
            faile();
        }
    }];
}

/**
 * 用队列组异步上传多张图片或多个文件
 * @param filesArray 图片/视频文件模型数组
 * @param complete 所有图片/文件上传完成回调
 */
- (void)uploadMultiFile:(NSArray <ZhenImageOrVideoModel *>*)filesArray
               complete:(void (^)(BOOL hasFile))complete
{
    if (filesArray.count > 0) {
        // 队列组异步上传文件
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);

        WeakSelf
        [MBProgressHUD showMessage:@"请稍后" toView:kAppKeyWindow];
        for (ZhenImageOrVideoModel *imageModel in filesArray) {
            dispatch_group_enter(group);
        
            dispatch_group_async(group, queue, ^{
                // 执行异步上传任务
                if (imageModel.isVideo) {
                    // 上传视频
                    [Weakself uploadFile:imageModel.data fileType:imageModel.fileType success:^(NSString * _Nullable returnUrl) {
                        imageModel.imageOrVideoUrl = returnUrl;
                        dispatch_group_leave(group);
                    } faile:^{
                        dispatch_group_leave(group);
                    } showHud:NO];
                }else {
                    // 上传图片
                    [Weakself uploadImage:imageModel.data success:^(NSString * _Nullable imgUrl) {
                        imageModel.imageOrVideoUrl = imgUrl;
                        dispatch_group_leave(group);
                    } faile:^{
                        dispatch_group_leave(group);
                    } showHud:NO];
                }
            });
        }
        
        // 所有图片上传完成
        dispatch_group_notify(group,dispatch_get_main_queue(), ^{
            if (complete) {
                complete(YES);
            }
        });
    }else {
        // 没有附件
        if (complete) {
            complete(NO);
        }
    }
}


@end
