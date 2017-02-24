//
//  ViewController.m
//  LHCalender
//
//  Created by 腾实信 on 2017/2/22.
//  Copyright © 2017年 ida. All rights reserved.
//

#import "ViewController.h"
#import "LHCalenderViewController.h"

@interface ViewController ()
{
    UIButton *calenderBtn;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"日历demo";
    calenderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calenderBtn.layer.borderColor = [UIColor blackColor].CGColor;
    calenderBtn.layer.borderWidth = 1;
    calenderBtn.frame = CGRectMake(self.view.center.x-50, self.view.center.y-20, 100, 40);
    [calenderBtn setTitle:@"查看日历" forState:UIControlStateNormal];
    [calenderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [calenderBtn addTarget:self action:@selector(calenderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:calenderBtn];
    
}

- (void)calenderBtnClick {

    LHCalenderViewController *calenderVC = [[LHCalenderViewController alloc]init];
    [self.navigationController pushViewController:calenderVC animated:YES];
    
}


@end
