//
//  HYTextView.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "HYTextView.h"

@interface HYTextView ()

// 显示占位文本
@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation HYTextView

#pragma mark - 生命周期
// 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        // 默认占位文本颜色
        self.placeholderColor = [UIColor colorWithRed:206/255.0 green:206/255.0 blue:211/255.0 alpha:1];
        
        // 添加文本变化通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:nil];
        
        // 添加占位文本框
        [self addSubview:self.placeHolderLabel];
        [self sendSubviewToBack:self.placeHolderLabel];
        [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).mas_offset(8);
            make.bottom.right.equalTo(self).mas_offset(-8);
        }];
    }
    return self;
}

// 重绘
//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//
//    if (self.placeholder.length > 0) {
//        if (_placeHolderLabel == nil) {
//
//            [self addSubview:_placeHolderLabel];
//        }
//        _placeHolderLabel.text = self.placeholder;
//        [_placeHolderLabel sizeToFit];
//        [self sendSubviewToBack:_placeHolderLabel];
//    }
//
//    if ([[self text] length] == 0 && [[self placeholder] length] >0) {
//        [[self viewWithTag:999] setAlpha:1.0];
//    }
//
//}

// 释放，移除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - setter
// 设置占位文字
-(void)setPlaceholder:(NSString *)placeholder
{
    if (_placeholder != placeholder) {
        _placeholder = placeholder;
        [self.placeHolderLabel removeFromSuperview];
        self.placeHolderLabel = nil;
        [self setNeedsDisplay];
    }
}

// 设置占位文字颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeHolderLabel.textColor = placeholderColor;
}

// 设置字体
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    // 占位文字大小和textView文本大小一致
    self.placeHolderLabel.font = font;
}

#pragma mark - 事件
// 文本改变，显示或隐藏占位文本
- (void)textChanged
{
    if (self.text.length == 0) {
        self.placeHolderLabel.hidden = NO;
    }else{
        self.placeHolderLabel.hidden = YES;
    }
}

#pragma mark - 懒加载
// 占位文本显示框
- (UILabel *)placeHolderLabel
{
    if (!_placeHolderLabel) {
        _placeHolderLabel = UILabel.new;
        _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeHolderLabel.numberOfLines = 0;
        // 默认文本字体大小
        _placeHolderLabel.font = [UIFont systemFontOfSize:15];
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.hidden = YES;
    }
    
    return _placeHolderLabel;
}

@end
