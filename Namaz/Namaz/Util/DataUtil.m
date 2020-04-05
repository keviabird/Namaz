//
//  DataUtil.m
//  Namaz
//
//  Created by Elena Gracheva on 17.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import "DataUtil.h"

@implementation DataUtil

+(NSNumber *)getLastUpdated {
    NSNumber *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastUpdated"];
    if (result == nil) {
        return @0;
    }
    return result;
}

+(void)setLastUpdated:(NSNumber *)lastUpdated {
    [[NSUserDefaults standardUserDefaults] setObject:lastUpdated forKey:@"lastUpdated"];
}

+(NSNumber *)getCityId {
    NSNumber *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"];
    if (result == nil) {
        return @0;
    }
    return result;
}

+(void)setCityId:(NSNumber *)cityId {
    [[NSUserDefaults standardUserDefaults] setObject:cityId forKey:@"cityId"];
}

+(NSString *)getGender {
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"gender"];
    return result;
}

+(void)setGender:(NSString *)gender {
    [[NSUserDefaults standardUserDefaults] setObject:gender forKey:@"gender"];
}

+(NSString *)getGreetings {
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"greetings"];
    return result;
}

+(void)setGreetings:(NSString *)greetings {
    [[NSUserDefaults standardUserDefaults] setObject:greetings forKey:@"greetings"];
}

@end
