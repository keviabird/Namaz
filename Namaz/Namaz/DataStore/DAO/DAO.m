//
//  DAO.m
//  Namaz
//
//  Created by Elena Gracheva on 25.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//

#import "DAO.h"
#import "CoreData+MagicalRecord.h"
#import "NSManagedObject+MagicalFinders.h"
#import "Namaz.h"
#import "Schedule.h"
#import "City.h"
#import "Event.h"
#import "News.h"
#import "DataUtil.h"
#import "Const.h"


@implementation DAO

+(void)save:(NamazThriftThriftChangesResponse *)response withTimestamp:(long long)lastUpdated {
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd-MM-yyyy HH:mm";
    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSManagedObjectContext *moc = [NSManagedObjectContext MR_context];
    
    for (NSNumber *deleted in response.deletedCityIds) {
        [City MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"id = %@", deleted] inContext:moc];
    }
    for (NamazThriftThriftCity *thrift in response.updatedCities) {
        City *entity = [City MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithLongLong:thrift.id] inContext:moc];
        if (entity == nil) {
            entity = [City MR_createInContext:moc];
            entity.id = [NSNumber numberWithLongLong:thrift.id];
        }
        entity.name = thrift.name;
    }
    for (NSNumber *deleted in response.deletedScheduleIds) {
        [Schedule MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"id = %@", deleted] inContext:moc];
    }
    NSArray<Event *> *events = [Event MR_findByAttribute:@"forSchedule" withValue:@YES andOrderBy:@"id" ascending:YES inContext:moc];
    for (NamazThriftThriftSchedule *thrift in response.updatedSchedule) {
        
        Schedule *entity = [Schedule MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithLongLong:thrift.id] inContext:moc];
        if (entity == nil) {
            entity = [Schedule MR_createInContext:moc];
            entity.id = [NSNumber numberWithLongLong:thrift.id];
        }
        entity.date = [format dateFromString:thrift.date];
        entity.event = [events objectAtIndex:thrift.event];
    }
    
    for (NSObject *deleted in response.deletedNewsIds) {
        [News MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"identifier = %@", deleted] inContext:moc];
    }
    for (NamazThriftThriftNews *thrift in response.updatedNews) {
        News *object = [News MR_findFirstByAttribute:@"identifier" withValue:[NSNumber numberWithLongLong:thrift.id] inContext:moc];
        if (object == nil) {
            object = [News MR_createInContext:moc];
            object.identifier = [NSNumber numberWithLongLong:thrift.id];
        }
        object.date = [format dateFromString:thrift.date];
        object.title = thrift.title;
        object.text = thrift.text;
        object.important = [NSNumber numberWithBool:thrift.important];
        object.fullImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:thrift.pictureUrl]];
        if (object.fullImage == nil) {
            NSLog(@"second try to load image %@", thrift.pictureUrl);
            object.fullImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:thrift.pictureUrl]];
        }
        object.smallImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:thrift.smallPictureUrl]];
        if (object.smallImage == nil) {
            NSLog(@"second try to load image %@", thrift.smallPictureUrl);
            object.smallImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:thrift.smallPictureUrl]];
        }
    }
    
    [moc MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        if (contextDidSave) {
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NAMAZ_UPDATE_SUCCEEDED_NOTIFICATION object:nil]];
            [DataUtil setLastUpdated:[NSNumber numberWithLongLong:lastUpdated]];
            NSLog(@"Context saved successfully");
        } else if ( error != nil ) {
            NSLog(@"Failed to save context during the next error: %@", error);
        } else {
            NSLog(@"Context save finished successfully with no changes");
        }
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NAMAZ_UPDATE_FINISHED_NOTIFICATION object:nil]];
    }];
}

@end
