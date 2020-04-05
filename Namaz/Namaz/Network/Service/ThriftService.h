//
//  ThriftService.h
//  Namaz
//
//  Created by Elena Gracheva on 17.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NamazThriftThriftRequestBase, NamazThriftThriftPingResponse, NamazThriftThriftChangesResponse;

@interface ThriftService : NSObject

+(NamazThriftThriftRequestBase *)getBase;
+(void)pingWithSuccess:(void (^)(NamazThriftThriftPingResponse*))successBlock andFail:(void (^)(NSException*))failBlock;
+(void)changesWithSuccess:(void (^)(NamazThriftThriftChangesResponse*))successBlock andFail:(void (^)(NSException*))failBlock;

@end
