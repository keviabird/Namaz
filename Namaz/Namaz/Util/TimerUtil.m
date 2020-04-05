//
//  TimerUtil.m
//  Namaz
//
//  Created by Elena Gracheva on 05.04.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import "TimerUtil.h"
#import "CoreData+MagicalRecord.h"
#import "Event.h"
#import "Schedule.h"

@implementation TimerUtil

+(Schedule *)getCurrentSchedule {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"event.forTutorial = 1 and event.forSchedule = 1 and date > %@", [NSDate date]];
    return [Schedule MR_findFirstWithPredicate:predicate sortedBy:@"date" ascending:YES];
}

+(NSString *)getNameForSchedule:(Schedule *)next {
    if ([next.event.id isEqualToNumber:@4]) {
        return @"night";
    } else if ([next.event.id isEqualToNumber:@5]) {
        return @"morning";
    } else if ([next.event.id isEqualToNumber:@6]) {
        return @"day";
    } else if ([next.event.id isEqualToNumber:@7]) {
        return @"afternoon";
    } else if ([next.event.id isEqualToNumber:@8]) {
        return @"evening";
    } else if ([next.event.id isEqualToNumber:@9]) {
        return @"night";
    }
    return @"day";
}

+(NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)hours, (long)minutes];
}

@end
