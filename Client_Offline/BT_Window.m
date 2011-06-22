//
//  BT_Window.m
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 8/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BT_Window.h"
#import "BT_Scan.h"
#import "BluetoothDevice.h"




@implementation BT_Window

- (BT_Window *)set_btwindow:(NSDate *) a :(NSMutableArray *) b;
{
	
	capturedAt = a;
    deviceList = b;
	
	return self;
	
}



- (NSDate *) getcapturedAt 

{
	
	return capturedAt;
}

- (NSMutableArray *) getdeviceList

{
	
	return deviceList;
	
}

-(NSString *)tojson_btwindow
{
	 NSLog(@" Entered tojson");
	NSString *time_start1 = [[self getcapturedAt] description];
	NSLog(@" the value of time is %@",time_start1);
//	NSString *time_end = [[self getendtime]description];
	NSString* buffer=[[NSString alloc] initWithFormat:@"{\r\n\"captured_at\":\"%@\",\r\n\"device_list\": [\r\n ",time_start1];
	NSLog(@" the value of buffer at start is %@",buffer);
	NSEnumerator *enumerator = [[self getdeviceList] objectEnumerator];
	NSLog(@" test 2");
	id element;
	NSString *delimeter =@"";
	while(element = [enumerator nextObject] )
	{
			 NSLog(@" Entered tojson-1");
		buffer = [buffer stringByAppendingString:delimeter];
		buffer = [buffer stringByAppendingString:[element tojson_bt]];
		delimeter =@",\r\n";
	}
	buffer = [buffer stringByAppendingString:@"]\r\n}"];
//	NSLog(@" The value of buffer is %@",buffer);
	return buffer;
	
	
}

@end
