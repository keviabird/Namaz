//
//  Event+CoreDataProperties.h
//  Namaz
//
//  Created by Elena Gracheva on 25.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *forSchedule;
@property (nullable, nonatomic, retain) NSNumber *forTutorial;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Schedule *> *schedule;

@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addScheduleObject:(Schedule *)value;
- (void)removeScheduleObject:(Schedule *)value;
- (void)addSchedule:(NSSet<Schedule *> *)values;
- (void)removeSchedule:(NSSet<Schedule *> *)values;

@end

NS_ASSUME_NONNULL_END
