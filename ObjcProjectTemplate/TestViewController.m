//
//  TestViewController.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/1/16.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    NSLog(@"%@",NSStringFromCGSize([UIScreen mainScreen].currentMode.size));
    NSLog(@"%d", HYDEVICE_IS_iPhone12_Max);

}


@end
