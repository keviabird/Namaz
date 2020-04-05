//
//  DataUtil.h
//  Namaz
//
//  Created by Elena Gracheva on 17.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtil : NSObject


+(NSNumber *)getLastUpdated;
+(void)setLastUpdated:(NSNumber *)lastUpdated;

+(NSNumber *)getCityId;
+(void)setCityId:(NSNumber *)cityId;

+(NSString *)getGender;
+(void)setGender:(NSString *)gender;

+(NSString *)getGreetings;
+(void)setGreetings:(NSString *)greetings;

@end
