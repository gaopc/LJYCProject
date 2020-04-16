//
//  CustomAnnotation.m
//  FlightProject
//
//  Created by admin on 12-11-15.
//
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation
@synthesize coordinate, title, subtitle,tag,type;
- (void)dealloc
{
	self.title = nil;
	self.subtitle = nil;
	self.tag = 0;
 
    [super dealloc];
}


- (id)initWithCoordinate:(CLLocationCoordinate2D)coords
{
	if (self = [super init]) {
		coordinate = coords;
	}
	return self;
}

+ (NSString *) reusableIdentifierforPinColor :(BMKPinAnnotationColor)paramColor{ NSString *result = nil;
	
	switch (paramColor){
			
		case BMKPinAnnotationColorRed:{
			
			result = PIN_RED;
			
			break;
			
		}
			
		case BMKPinAnnotationColorGreen:{
			
			result = PIN_GREEN;
			
			break;
			
		}
			
		case BMKPinAnnotationColorPurple:{
			
			result = PIN_PURPLE;
			
			break;
			
		}
			
	}
	
	return result;
	
}



@end