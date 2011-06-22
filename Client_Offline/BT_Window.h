//
//  BT_Window.h
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 8/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BT_Scan.h"
#import "BluetoothDevice.h"
#import "BT_Window.h"


@interface BT_Window : NSObject {
	
	NSDate *capturedAt;
	NSMutableArray *deviceList;
	}
-(BT_Window *)set_btwindow:(NSDate *) a :(NSMutableArray *) b;
-(NSDate *) getcapturedAt;
-(NSMutableArray *) getdeviceList;
-(NSString *)tojson_btwindow;


@end
