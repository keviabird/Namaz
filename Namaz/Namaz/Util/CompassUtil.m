//
//  Util.m
//  Namaz
//
//  Created by Elena Gracheva on 14.03.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import "CompassUtil.h"
#include <math.h>

#define MEKKA_LON 39.825818
#define MEKKA_LAT 21.422478

#define CONST_E 0.0067385254
#define CONST_P 57.2958333333333
#define CONST_C 6399698.9018

@implementation CompassUtil


+ (double)angleFromLocation:(CLLocationCoordinate2D)coordinate andHeading:(double)heading
{
    double ourLatitude = coordinate.latitude;
    double ourLongitude = coordinate.longitude;
    
    // вычисляем катеты и гипотенузу
    double cathetusA = ABS(ourLongitude - MEKKA_LON);
    double cathetusB = ABS(ourLatitude - MEKKA_LAT);
    double hypotenuse = sqrt(cathetusA * cathetusA + cathetusB * cathetusB);
    
    // вычисляем угол α
    double angle1 = asin(cathetusA/hypotenuse) * 180/M_PI;
    double angle2; // насколько направление на Мекку отклонено от направления на север
    double angle3; // результат
    
    // перебираем все возможные варианты расположения относительно Мекки, и производим дополнительные вычисления
    if (ourLatitude > MEKKA_LAT) {
        if (ourLongitude > MEKKA_LON) {
            angle2 = 180.0 + angle1;
        }
        else if (ourLongitude < MEKKA_LON) {
            angle2 = 180.0 - angle1;
        }
        else {
            angle2 = 180.0;
        }
    }
    else if (ourLatitude < MEKKA_LAT) {
        if (ourLongitude > MEKKA_LON) {
            angle2 = 360.0 - angle1;
        }
        else if (ourLongitude < MEKKA_LON) {
            angle2 = angle1;
        }
        else {
            angle2 = 0.0;
        }
    }
    else {
        if (ourLongitude > MEKKA_LON) {
            angle2 = 270.0;
        }
        else if (ourLongitude < MEKKA_LON) {
            angle2 = 90.0;
        }
        else {
            angle2 = 0.0;
        }
    }
    
    angle3 = heading - angle2; // насколько утсройство отклонено от направления на Мекку
    angle3 = -angle3 * M_PI / 180.0f; // на какой угол нужно повернуть картинку компаса
    return angle3;
}

@end
