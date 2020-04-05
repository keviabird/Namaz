//
//  Tutorial+CoreDataProperties.h
//  Namaz
//
//  Created by Elena Gracheva on 13.06.16.
//  Copyright © 2016 Islam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tutorial.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tutorial (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *womanDescription;
@property (nullable, nonatomic, retain) NSData *womanPicture;
@property (nullable, nonatomic, retain) NSString *manDescription;
@property (nullable, nonatomic, retain) NSData *manPicture;
@property (nullable, nonatomic, retain) NSNumber *order;
@property (nullable, nonatomic, retain) Event *event;
@property (nullable, nonatomic, retain) NSSet<Part *> *parts;

@end

@interface Tutorial (CoreDataGeneratedAccessors)

- (void)addPartsObject:(Part *)value;
- (void)removePartsObject:(Part *)value;
- (void)addParts:(NSSet<Part *> *)values;
- (void)removeParts:(NSSet<Part *> *)values;

@end

NS_ASSUME_NONNULL_END
