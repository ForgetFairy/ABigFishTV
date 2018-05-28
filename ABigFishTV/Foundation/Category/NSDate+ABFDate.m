//
//  NSDate+ABFDate.m
//  ABigFishTV
//
//  Created by 陈立宇 on 18/3/10.
//  Copyright © 2018年 陈立宇. All rights reserved.
//

#import "NSDate+ABFDate.h"

@implementation NSDate (ABFDate)

- (NSInteger)yearValue
{
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    NSInteger year = components.year;
    return year;
}

- (NSInteger)monthValue
{
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    NSInteger month = components.month;
    return month;
}

- (NSInteger)dayValue
{
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    // components.day会比实际的值大1，所以做处理
    NSInteger day = components.day;
    return day;
}

- (NSInteger)weekdayValue
{
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:self];
    
    NSInteger weekday = components.weekday;
    return weekday;
}

- (NSInteger)hourValue
{
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    
    NSInteger hour = components.hour;
    return hour;
}

- (NSInteger)minuteValue
{
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    
    NSInteger min = components.minute;
    return min;
}

- (NSInteger)secondValue
{
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    
    NSInteger sec = components.second;
    return sec;
}

- (NSDate *)beforeDays:(NSInteger)days
{
    // 前几天
    return [self intervalDays:-days];
}

- (NSDate *)afterDays:(NSInteger)days
{
    // 后几天
    return [self intervalDays:days];
}

- (NSDate *)intervalDays:(NSInteger)days
{
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([self timeIntervalSinceReferenceDate] + (24 * 3600 * days))];
    return newDate;
}

- (NSDate *)firstDayOfCurrentMonth
{
    // 返回当前月份的第一天
    NSInteger day = [self dayValue];
    NSDate *firstDay = [self beforeDays:day - 1];
    
    return firstDay;
}

- (NSDate *)lastDayOfCurrentMonth
{
    // 返回当前月份的最后一天
    NSInteger day = [self dayValue];
    NSInteger numberOfDays = [self numberOfDaysInCurrentMonth];
    
    NSDate *lastDay = [self afterDays:numberOfDays - day];
    return lastDay;
}

- (NSUInteger)numberOfDaysInCurrentMonth
{
    // 当前月一共有几天
    return [[self getCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

- (NSCalendar *)getCalendar
{
    return [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    // 将string转换成date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:zone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    return destDate;
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    // 将date转换成string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destString = [dateFormatter stringFromDate:date];
    return destString;
}

+ (NSDate *)dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *monthStr = (month >= 10) ? [NSString stringWithFormat:@"%@", @(month)] : [NSString stringWithFormat:@"0%@", @(month)];
    NSString *dayStr = (day >= 10) ? [NSString stringWithFormat:@"%@", @(day)] : [NSString stringWithFormat:@"0%@", @(day)];
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@", @(year), monthStr, dayStr];
    
    return [NSDate dateFromString:dateStr];
}

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}


@end
