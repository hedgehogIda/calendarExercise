//
//  LHCalendarModel.m
//  LHCalender
//
//  Created by 腾实信 on 2017/2/22.
//  Copyright © 2017年 ida. All rights reserved.
//

#import "LHCalendarModel.h"
#import "LHCalendarTool.h"
#import "LHDayDetailModel.h"

@implementation LHCalendarModel

+ (void)getCalenderDataWithDate:(NSDate *)date block:(CallBackBlock)block{

    NSMutableArray *array = [NSMutableArray array];
    NSDate *calculateDate = date;
    //当前日期所在的年
    NSInteger year = [LHCalendarTool year:calculateDate];
    //当前日期所在的月
    NSInteger month = [LHCalendarTool month:calculateDate];
    //当月第一天是周几
    NSInteger firstDay = [LHCalendarTool firstWeekdayInThisMonth:calculateDate];
    //当月共用多少天
    NSInteger totalDay = [LHCalendarTool totaldaysInMonth:calculateDate];
    
    NSInteger n=0;
    for (NSInteger y = year; y < year + 2; y++) {
        
        for (NSInteger i = month; i < 13; i++) {
            LHCalendarModel *model = [[LHCalendarModel alloc]init];
            model.year = y;
            model.month = i;
            model.firstday = firstDay;
            for (NSInteger j = 1; j < totalDay+1 ; j++) {
                LHDayDetailModel *daydetailModel = [[LHDayDetailModel alloc]init];
                daydetailModel.day = j;
                daydetailModel.price = [NSString stringWithFormat:@"¥1"];
                [model.dayDetailArray addObject:daydetailModel];
            }
            calculateDate = [LHCalendarTool nextMonth:calculateDate];
            firstDay = [LHCalendarTool firstWeekdayInThisMonth:calculateDate];
            totalDay = [LHCalendarTool totaldaysInMonth:calculateDate];
            [array addObject:model];
            n++;
            //共展示最近12个月的日历
            if (n==12) {
                break;
            }
        }
        month = 1;
    }
    block(array);
}

- (NSMutableArray *)dayDetailArray {
    if (!_dayDetailArray) {
        _dayDetailArray = [NSMutableArray array];
    }
    return _dayDetailArray;
}

@end
