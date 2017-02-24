//
//  LHCollectionHeaderView.m
//  LHCalender
//
//  Created by 腾实信 on 2017/2/23.
//  Copyright © 2017年 ida. All rights reserved.
//

#import "LHCollectionHeaderView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation LHCollectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dateL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, frame.size.height/2)];
        self.dateL.textAlignment = NSTextAlignmentCenter;
        self.dateL.textColor = [UIColor blackColor];
        self.dateL.font = [UIFont systemFontOfSize:18];
        self.dateL.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.dateL];
        
        NSArray * wekAr = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height/2, WIDTH, frame.size.height/2)];
        titleView.backgroundColor = [UIColor whiteColor];
        for (NSInteger i = 0; i < 7; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((WIDTH / 7) * i,0, WIDTH / 7, frame.size.height/2 - 20);
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            [btn setTitle:wekAr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [titleView addSubview:btn];
        }
        [self addSubview:titleView];
        
    }
    return self;
}

@end
