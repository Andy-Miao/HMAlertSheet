//
//  ViewController.m
//  HMAlertSheet
//
//  Created by humiao on 2019/8/1.
//  Copyright © 2019 humiao. All rights reserved.
//

#import "ViewController.h"
#import "HMAlertSheet.h"

@interface ViewController ()
@property (nonatomic, strong) HMAlertSheet *sheet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.sheet = [[HMAlertSheet alloc] initWithFrame:[UIScreen mainScreen].bounds titleArray:@[@"相册",  @"拍照"]];
    
    self.sheet.ClickBlock = ^(NSInteger clickIndex) {
        if (clickIndex == 0) {
            NSLog(@"选择相册");
        }else {
            NSLog(@"选择拍照");
        }
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.sheet];
}

@end
