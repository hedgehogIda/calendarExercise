//
//  LHCalendarModel.h
//  LHCalender
//
//  Created by 腾实信 on 2017/2/22.
//  Copyright © 2017年 ida. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CallBackBlock)(NSMutableArray *result);

@interface LHCalendarModel : NSObject
@property(nonatomic, assign)NSInteger year;
@property(nonatomic, assign)NSInteger month;
@property(nonatomic, assign)NSInteger firstday;
@property(nonatomic, strong)NSMutableArray *dayDetailArray;

+ (void)getCalenderDataWithDate:(NSDate *)date block:(CallBackBlock)block;
@end
