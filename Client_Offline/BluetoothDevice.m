//
//  BluetoothDevice.m
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 8/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BluetoothDevice.h"


@implementation BluetoothDevice

- (BluetoothDevice *)set_bt:(NSString *) a :(NSString *) b :(int) c :(NSString *)d
{
	
	name = d;
    address = a;
	classId = c;
	deviceClass = b;
	return self;
	
}



- (NSString *) getname 

{
	
	return name;
}

- (NSString *) getaddress

{
	
	return address;
	
}

- (int) getclassId 

{
	
	return classId;
	
}	

- (NSString *) getdeviceClass

{
	
	return deviceClass;
	
}

- (NSString *) tojson_bt

{
	
	NSLog(@" entered inner json");
	NSString* buffer=[[NSString alloc] initWithFormat:@"{\"name\": \"%@\", \"address\": \"%@\", \"class_id\": \"%d\", \"dev_class\": %@}",[self getname],[self getaddress],[self getclassId],[self getdeviceClass]];
	return buffer;
	
	
	
}




@end
