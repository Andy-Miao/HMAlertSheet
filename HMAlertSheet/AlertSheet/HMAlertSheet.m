//
//  HMAlertSheet.m
//  Class
//
//  Created by 胡苗 on 2015/4/11.
//  Copyright © 2015年 胡苗. All rights reserved.
//

#import "HMAlertSheet.h"

#define     BLACK_COLOR        [UIColor blackColor]
#define     WHITE_COLOR        [UIColor whiteColor]

@implementation UIColor (HM)
#pragma mark — 扩展十六进制颜色转换
+ (UIColor *)colorWithHex:(NSString *)color {
    return [self colorWithHex:color alpha:1.0f];
}

+ (UIColor *)colorWithHex:(NSString *)hexColor alpha:(CGFloat)alpha {
    
    //!< 删除字符串中的空格
    NSString *colorStr = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    //!< 字符串应该是6或8个字符
    if ([colorStr length] < 6){
        return [UIColor clearColor];
    }
    
    //!< 如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([colorStr hasPrefix:@"0X"]){
        colorStr = [colorStr substringFromIndex:2];
    }
    
    //!< 如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([colorStr hasPrefix:@"#"]){
        colorStr = [colorStr substringFromIndex:1];
    }
    
    //!< 最后判断字符串是否为六位字符
    if ([colorStr length] != 6){
        return [UIColor clearColor];
    }
    
    /**
     *  分离成R、G、B子字符串
     */
    NSString *redStr = [colorStr substringWithRange:NSMakeRange(0, 2)];    //!< red字符串
    NSString *greenStr = [colorStr substringWithRange:NSMakeRange(2, 2)];    //!< green字符串
    NSString *blueStr = [colorStr substringWithRange:NSMakeRange(4, 2)];    //!< blue字符串
    
    /**
     *  将十六进制的R、G、B转换为Int
     */
    unsigned int redInt, greenInt, blueInt;
    [[NSScanner scannerWithString:redStr] scanHexInt:&redInt];
    [[NSScanner scannerWithString:greenStr] scanHexInt:&greenInt];
    [[NSScanner scannerWithString:blueStr] scanHexInt:&blueInt];
    
    //!< 返回颜色值
    return [UIColor colorWith256RedValue:redInt greenValue:greenInt blueValue:blueInt alpha:alpha];
}

+ (UIColor *)colorWith256RedValue:(CGFloat)red greenValue:(CGFloat)green blueValue:(CGFloat)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:(red / 255.0f) green:(green / 255.0f) blue:(blue / 255.0f) alpha:alpha];
}

@end

@interface HMAlertSheet ()
{
    CGSize _size;
}

@property(nonatomic,strong)UIView *menuView;
@end

@implementation HMAlertSheet

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    
    if (self = [super initWithFrame:frame]) {
        
        //        _size = [UIScreen mainScreen].bounds.size;
        _size = frame.size;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenSheet)];
        [self addGestureRecognizer:tap];
        [self makeBaseUIWithTitleArr:titleArray];
        
    }
    return self;
}

- (void)makeBaseUIWithTitleArr:(NSArray*)titleArr {
    
    self.menuView = [[UIView alloc]initWithFrame:CGRectMake(0, _size.height, _size.width, titleArr.count * 45 + 60)];
    self.menuView.backgroundColor = BLACK_COLOR;
    [self addSubview:self.menuView];
    
    CGFloat y = [self createBtnWithTitle:@"取消" origin_y: _menuView.frame.size.height - 45 tag:-1 action:@selector(hiddenSheet)] - 60;
    for (int i = 0; i < titleArr.count; i++) {
        y = [self createBtnWithTitle:titleArr[i] origin_y:y tag:i action:@selector(click:)];
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.menuView.frame;
        frame.origin.y -= frame.size.height;
        self.menuView.frame = frame;
    }];
}

- (CGFloat)createBtnWithTitle:(NSString *)title origin_y:(CGFloat)y tag:(NSInteger)tag action:(SEL)method {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, y, _size.width, 45);
    btn.backgroundColor = [UIColor colorWithHex:@"#232320"];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    btn.tag = tag;
    [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [btn addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
    [_menuView addSubview:btn];
    
    return y -= tag == -1 ? 0 : 45.4;
}

- (void)hiddenSheet {

    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.menuView.frame;
        frame.origin.y += frame.size.height;
        self.menuView.frame = frame;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

- (void)click:(UIButton *)btn {
    if (self.ClickBlock) {
        self.ClickBlock(btn.tag);
    }
    [self hiddenSheet];//hidden
}

@end


