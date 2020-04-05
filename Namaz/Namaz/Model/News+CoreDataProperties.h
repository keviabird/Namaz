//
//  News+CoreDataProperties.h
//  Namaz
//
//  Created by Elena Gracheva on 25.02.16.
//  Copyright © 2016 Islam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface News (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSData *fullImage;
@property (nullable, nonatomic, retain) NSString *fullUrl;
@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSNumber *important;
@property (nullable, nonatomic, retain) NSData *smallImage;
@property (nullable, nonatomic, retain) NSString *smallUrl;
@property (nullable, nonatomic, retain) NSString *source;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) NSString *title;

@end

NS_ASSUME_NONNULL_END
