//
//  Location.h
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Location : NSObject {
	NSDate *updatedAt;
	NSNumber * latitude;
	NSNumber * longitude;
	NSString *label;

}

- (Location *)set_location:(NSDate *) a :(NSNumber *) b :(NSNumber *) c :(NSString *)d;
-(NSNumber *)Latitude;
-(NSNumber *)Longitude;
-(NSString *)Label;
-(NSDate *)UpdatedAt;

@end
