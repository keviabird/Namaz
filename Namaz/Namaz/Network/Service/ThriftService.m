//
//  ThriftService.m
//  Namaz
//
//  Created by Elena Gracheva on 17.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import "ThriftService.h"
#import "Namaz.h"
#import "THTTPClient.h"
#import "TBinaryProtocol.h"
#import "Reachability.h"
#import "ConnectionUnreachableException.h"
#import "DataUtil.h"

#define PROTOCOL_VERSION @"namaz_basics_2015-08-16-001"
#define URL @"http://83.220.168.190:8080/namaz/"
//#define URL @"http://namazapps.fvds.ru:8080/namaz/"
//#define URL @"http://localhost:8080/namaz/"

@implementation ThriftService

+(NamazThriftThriftRequestBase *)getBase {
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    NamazThriftThriftRequestBase *base = [[NamazThriftThriftRequestBase alloc] initWithProtocolVersion:PROTOCOL_VERSION deviceId:[[[UIDevice currentDevice] identifierForVendor] UUIDString] userLogin:@"" authToken:@"" clientPlatform:ThriftPlatformType_IPHONE pushToken:@"" currentLanguage:language clientVersion:minorVersion];
    return base;
}

+(NamazThriftThriftNamazServiceClient *)getClient {
    NSURL *url = [NSURL URLWithString:[URL stringByAppendingString:@"thrift"]];
    THTTPClient *transport = [[THTTPClient alloc] initWithURL:url userAgent:@"iClient" timeout:300];
    TBinaryProtocol *protocol = [[TBinaryProtocol alloc] initWithTransport:transport strictRead:YES strictWrite:YES];
    return [[NamazThriftThriftNamazServiceClient alloc] initWithProtocol:protocol];
}

+(NamazThriftThriftChangesRequest *)getUpdatesRequest {
    NamazThriftThriftChangesRequest *request = [[NamazThriftThriftChangesRequest alloc] initWithCommonBase:[self getBase] lastUpdated:[[DataUtil getLastUpdated] longLongValue] cityId:[[DataUtil getCityId] longLongValue]];
    return request;
}

+(void)pingWithSuccess:(void (^)(NamazThriftThriftPingResponse*))successBlock andFail:(void (^)(NSException*))failBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"Send ping starting");
        NSString *name = @"ping";
        if ([self checkReachabilityInServiceNamed:name withFail:failBlock]) {
            NamazThriftThriftNamazServiceClient *client = [self getClient];
            @try {
                NamazThriftThriftPingResponse *result = [client ping:[self getBase]];
                if (successBlock != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        successBlock(result);
                    });
                }
            } @catch (NSException *exception) {
                [self processThriftException:exception inServiceNamed:name withFail:failBlock];
            }
        }
        NSLog(@"Send ping finished");
    });
}

+(void)changesWithSuccess:(void (^)(NamazThriftThriftChangesResponse*))successBlock andFail:(void (^)(NSException*))failBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"Send update starting");
        NSString *name = @"update";
        if ([self checkReachabilityInServiceNamed:name withFail:failBlock]) {
            NamazThriftThriftNamazServiceClient *client = [self getClient];
            @try {
                NamazThriftThriftChangesResponse *result = [client getChanged:[self getUpdatesRequest]];
                if (successBlock != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        successBlock(result);
                    });
                }
            } @catch (NSException *exception) {
                [self processThriftException:exception inServiceNamed:name withFail:failBlock];
            }
        }
        NSLog(@"Send update finished");
    });
    
}

+(BOOL)checkReachabilityInServiceNamed:(NSString *)name withFail:(void (^)(NSException*))failBlock {
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        ConnectionUnreachableException *ex = [[ConnectionUnreachableException alloc] init];
        [self processThriftException:ex inServiceNamed:@"alert" withFail:failBlock];
        return NO;
    }
    return YES;
}

+(void)processThriftException:(NSException *)e inServiceNamed:(NSString *)name withFail:(void (^)(NSException*))failBlock {
    if ([e isKindOfClass:[NamazThriftThriftException class]]) {
        NamazThriftThriftException *ex = (NamazThriftThriftException *)e;
        NSLog(@"Error in %@: %@", name, ex.logMessage);

    } else {
        NSLog(@"Error in %@: %@", name, e);
    }
    if (failBlock != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failBlock(e);
        });
    }
}

@end
