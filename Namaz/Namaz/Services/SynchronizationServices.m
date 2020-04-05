//
//  SynchronizationServices.m
//  Namaz
//
//  Created by Elena Gracheva on 09.03.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import "SynchronizationServices.h"
#import "ThriftService.h"
#import "Namaz.h"
#import "DAO.h"
#import "Const.h"

@implementation SynchronizationServices

+(void)synchronize {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        [ThriftService pingWithSuccess:^(NamazThriftThriftPingResponse *pingResponse) {

                [ThriftService changesWithSuccess:^(NamazThriftThriftChangesResponse *updateResponse) {
                    [DAO save:updateResponse withTimestamp:pingResponse.serverTimestamp];
                } andFail:^(NSException *exception) {
                    // TODO process exception
                    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NAMAZ_UPDATE_FINISHED_NOTIFICATION object:nil]];
                }];
            
        } andFail:^(NSException *exception) {
            // TODO process exception
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NAMAZ_UPDATE_FINISHED_NOTIFICATION object:nil]];
        }];
        
    });
}

@end
