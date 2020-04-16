//
//  CustomAnnotation.h
//  FlightProject
//
//  Created by admin on 12-11-15.
//
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"
#define PIN_RED @"Red"
#define PIN_GREEN @"Green"
#define PIN_PURPLE @"Purple"

@interface CustomAnnotation : NSObject <BMKAnnotation>
@property (nonatomic, readonly)    CLLocationCoordinate2D coordinate;
@property (nonatomic) int tag;
@property (nonatomic, copy)  NSString *title;
@property (nonatomic, copy)  NSString *subtitle;

@property (nonatomic, assign)int type;//0----pin  1---pop
@property (nonatomic, unsafe_unretained) BMKPinAnnotationColor pinColor;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coords;
+ (NSString *) reusableIdentifierforPinColor :(BMKPinAnnotationColor)paramColor;

@end
