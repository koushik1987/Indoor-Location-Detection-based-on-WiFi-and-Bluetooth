//
//  BluetoothDevice.h
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 8/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BluetoothDevice : NSObject {
	
	NSString *name;
	NSString *address;
	int classId;
	NSString *deviceClass;
	
}

 -(BluetoothDevice *)set_bt:(NSString *) a :(NSString *) b :(int) c :(NSString *)d;
 -(NSString *) getname;
 -(NSString *) getaddress;
 -(int) getclassId;
 -(NSString *) getdeviceClass;
- (NSString *) tojson_bt;



@end
