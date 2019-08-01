//
//  HMAlertSheet.h
//  Class
//
//  Created by 胡苗 on 2015/4/11.
//  Copyright © 2015年 胡苗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAlertSheet : UIView

@property(nonatomic,copy)void (^ClickBlock)(NSInteger clickIndex);

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray*)titleArray;

- (void)hiddenSheet;

@end
