//
//  scan.h
//  wifi_scan
//
//  Created by Koushik Annapureddy on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <Foundation/Foundation.h>

#import "Reading.h"


@interface scan : NSObject {
	
	NSDate *capturedAt;
	
	NSMutableArray *readinglist;

}

- (scan *)set_scan:(NSDate *) a :(NSMutableArray *) b;

-(NSDate *) getcapturedAt;

-(NSMutableArray *) getreadinglist;

-(NSString *)tojson_scan;


@end
