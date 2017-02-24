//
//  LHCollectionViewCell.m
//  LHCalender
//
//  Created by 腾实信 on 2017/2/22.
//  Copyright © 2017年 ida. All rights reserved.
//

#import "LHCollectionViewCell.h"

@implementation LHCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dateL = [[UILabel  alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, 16)];
        self.dateL.textAlignment = NSTextAlignmentCenter;
        self.dateL.backgroundColor = [UIColor clearColor];
        self.dateL.font = [UIFont systemFontOfSize:14];
        self.priceL = [[UILabel alloc] initWithFrame:CGRectMake(0, 16,frame.size.width, 16)];
        self.priceL.textAlignment = NSTextAlignmentCenter;
        self.priceL.backgroundColor = [UIColor clearColor];
        self.priceL.textColor = [UIColor blackColor];
        self.priceL.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:self.dateL];
        [self addSubview:self.priceL];
    }
    return self;
}


@end
