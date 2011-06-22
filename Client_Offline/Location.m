//
//  Location.m
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Location.h"


@implementation Location

- (Location *)set_location:(NSDate *) a :(NSNumber *) b :(NSNumber *) c :(NSString *)d
{
	updatedAt = a;
	
	latitude = b;
	
	longitude = c;
	
	label = d;
	
	return self;
}
-(NSNumber *)Latitude
{
	return latitude;
}
-(NSNumber *)Longitude
{
	return longitude;
}
-(NSString *)Label
{
	return label;
}
-(NSDate *)UpdatedAt
{
	return updatedAt;
}

@end
