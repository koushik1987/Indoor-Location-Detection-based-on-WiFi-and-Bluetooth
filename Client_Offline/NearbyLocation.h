//
//  NearbyLocation.h
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NearbyLocation : NSObject {
	
	NSString *label;
	NSNumber * distance;

}
-(NSString *)Label;
-(NSNumber *)Distance;
-(NearbyLocation *):(NSString *) a :(NSNumber *) b;

@end
