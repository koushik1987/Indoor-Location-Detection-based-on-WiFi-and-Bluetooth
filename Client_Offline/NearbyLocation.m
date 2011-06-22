//
//  NearbyLocation.m
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NearbyLocation.h"


@implementation NearbyLocation

-(NearbyLocation *):(NSString *) a :(NSNumber *) b
{
	label = a;
	distance = b;
	return self;
}
-(NSString *)Label
{
    return label;	
}
-(NSNumber *)Distance
{
    return distance;	
}

@end
