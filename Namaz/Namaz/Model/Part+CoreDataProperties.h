//
//  Part+CoreDataProperties.h
//  Namaz
//
//  Created by Elena Gracheva on 13.06.16.
//  Copyright © 2016 Islam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Part.h"

NS_ASSUME_NONNULL_BEGIN

@interface Part (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *order;
@property (nullable, nonatomic, retain) NSString *arabian;
@property (nullable, nonatomic, retain) NSString *russian;
@property (nullable, nonatomic, retain) NSString *transcription;
@property (nullable, nonatomic, retain) Tutorial *tutorial;

@end

NS_ASSUME_NONNULL_END
