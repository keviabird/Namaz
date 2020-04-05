//
//  DAO.h
//  Namaz
//
//  Created by Elena Gracheva on 25.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NamazThriftThriftChangesResponse;

@interface DAO : NSObject

+(void)save:(NamazThriftThriftChangesResponse *)response withTimestamp:(long long)lastUpdated;

@end
