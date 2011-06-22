//
//  scanwindow.h
//  wifi_scan
//
//  Created by Koushik Annapureddy on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "Reading.h"
#import "scan.h"


@interface scanwindow : NSObject {
NSDate *starttime;
	NSDate *endtime;
	NSMutableArray *scanwindowarray;
}
- (scanwindow *)set_scanwindow:(NSDate *) a :(NSDate *) b :(NSMutableArray *) c;
-(NSDate *) getstarttime;
-(NSDate *) getendtime;
-(NSMutableArray *) getscanwindow;
-(NSString *)tojson;

@end
