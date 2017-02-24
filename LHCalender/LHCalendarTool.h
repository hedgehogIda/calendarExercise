//
//  LHCalendarTool.h
//  LHCalender
//
//  Created by 腾实信 on 2017/2/22.
//  Copyright © 2017年 ida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCalendarTool : NSObject
/** 获取天 */
+ (NSInteger)day:(NSDate *)date;

/** 获取月*/
+ (NSInteger)month:(NSDate *)date;

/** 获取年*/
+ (NSInteger)year:(NSDate *)date;

/** 获取某个月的第一天是周几*/
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

/** 获取某个月的所有总天数*/
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

/** 获取某个月的上个月*/
+ (NSDate *)lastMonth:(NSDate *)date;

/** 获取某个月的下个月*/
+ (NSDate*)nextMonth:(NSDate *)date;

/** String 转 Date */
+ (NSDate *)dateFromString:(NSString *)dateString;

/** Date 转 String*/
+ (NSString *)stringFromDate:(NSDate *)date;


@end
