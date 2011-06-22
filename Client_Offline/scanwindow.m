//
//  scanwindow.m
//  wifi_scan
//
//  Created by Koushik Annapureddy on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "scanwindow.h"
#import "scan.h"
#import "Reading.h"
#import <Foundation/Foundation.h>
#import "Scanning.h"



@implementation scanwindow

- (scanwindow *)set_scanwindow:(NSDate *) a :(NSDate *) b :(NSMutableArray *) c
{
	
	starttime = a;
	
	
	endtime = b;

	scanwindowarray = c;
	
	return self;
	
}
-(NSDate *) getstarttime 
{
	return starttime;
}
-(NSDate *) getendtime 
{
	return endtime;
}
-(NSMutableArray *) getscanwindow 
{
	return scanwindowarray;
}
-(NSString *)tojson
{
   // NSLog(@" Entered tojson");
	NSString *time_start = [[self getstarttime] description];
	NSString *time_end = [[self getendtime]description];
	NSString* buffer=[[NSString alloc] initWithFormat:@"{\r\n\"start_time\":\"%@\",\r\n\"end_time\":\"%@\",\r\n\"scan_list\": [\r\n ",time_start,time_end];
	NSEnumerator *enumerator = [[self getscanwindow] objectEnumerator];
	id element;
	NSString *delimeter =@"";
	while(element = [enumerator nextObject] )
		{
		//	 NSLog(@" Entered tojson-1");
		buffer = [buffer stringByAppendingString:delimeter];
		buffer = [buffer stringByAppendingString:[element tojson_scan]];
		delimeter =@",\r\n";
}
	buffer = [buffer stringByAppendingString:@"]\r\n}"];
	
	return buffer;
	
	
}


@end
