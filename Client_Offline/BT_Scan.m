//
//  BT_Scan.m
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 8/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BT_Scan.h"

#import <Foundation/Foundation.h>

#import <Cocoa/Cocoa.h> 

#include <IOBluetooth/objc/IOBluetoothDeviceInquiry.h> 

#import <IOBluetooth/IOBluetooth.h>

#import <IOBluetoothUI/IOBluetoothUI.h>

#import <IOBluetooth/IOBluetoothUserLib.h>

#import "BluetoothDevice.h"

#import "BT_Window.h"




@implementation BT_Scan

-(BT_Window *)bt_scanning

{
 
   NSLog(@"start1111"); 
	
	IOBluetoothDeviceInquiry *d = [[IOBluetoothDeviceInquiry alloc] init];

	[d setUpdateNewDeviceNames: TRUE];
	[d start];
	[NSThread sleepUntilDate: [NSDate dateWithTimeIntervalSinceNow: 30]];
	[d stop];
	
	id devs = [d foundDevices];
	NSLog(@" The number of devices found %d",[devs count]);
	int i;
	NSMutableArray *bt_list = [[NSMutableArray alloc]init];
	
	for (i=0;i<[devs count];i++)
	{ 
	  	
		id xx = [devs objectAtIndex:i];
		NSString *major;
		
		NSLog(@" The string is %@",[xx getAddressString]);
		NSLog(@" The class id is %d",[xx getClassOfDevice]);
		int check = [xx getDeviceClassMajor];
		NSLog(@" The value of check is %d",check);
		switch (check) {
			case 0:
				major = @"Miscellanous";
				break;
			case 1:
				major = @"Computer";
				break;
			case 2:
				major = @"Phone";
				break;
			case 5:
				major = @"Peripheral";
				break;
				
				
			default:
				major = @"other";
				break;
		}
		
		NSLog(@" The device_class is %@",major);
		NSLog(@" the name is %@",[xx getNameOrAddress]);
		int sd = [xx getClassOfDevice];
		
		BluetoothDevice *bt_obj = [[BluetoothDevice alloc] set_bt :[xx getAddressString] :major :sd :[xx getNameOrAddress]];
		
		[bt_list addObject:bt_obj];
		
		}
	
	BT_Window* btwindow_obj = [[BT_Window alloc]set_btwindow :[NSDate date] :bt_list];
	
	NSLog(@" A BT Object is created ");
	
	return btwindow_obj;
	

	
}


@end
