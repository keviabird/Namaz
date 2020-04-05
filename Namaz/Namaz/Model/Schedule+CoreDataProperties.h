//
//  Schedule+CoreDataProperties.h
//  Namaz
//
//  Created by Elena Gracheva on 25.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Schedule.h"

NS_ASSUME_NONNULL_BEGIN

@interface Schedule (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) Event *event;

@end

NS_ASSUME_NONNULL_END
