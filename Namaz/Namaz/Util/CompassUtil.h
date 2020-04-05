//
//  Util.h
//  Namaz
//
//  Created by Elena Gracheva on 14.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CompassUtil : NSObject

+ (double)angleFromLocation:(CLLocationCoordinate2D)coordinate andHeading:(double)heading;

@end
