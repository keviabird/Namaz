//
//  TimerUtil.h
//  Namaz
//
//  Created by Elena Gracheva on 05.04.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Schedule;

@interface TimerUtil : NSObject

+(Schedule *)getCurrentSchedule;
+(NSString *)getNameForSchedule:(Schedule *)next;
+(NSString *)stringFromTimeInterval:(NSTimeInterval)interval;

@end
