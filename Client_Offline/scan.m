//
//  scan.m
//  wifi_scan
//
//  Created by Koushik Annapureddy on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "scan.h"

#import "Reading.h"

#import <Foundation/Foundation.h>

#import "Scanning.h"


@implementation scan

- (scan *)set_scan:(NSDate *) a :(NSMutableArray *) b 
{
	
	capturedAt = a;

	readinglist = b;

	return self;
	
}

-(NSDate *) getcapturedAt 
{
	return capturedAt;
}

-(NSMutableArray *) getreadinglist
{
	return readinglist;
}

-(NSString *)tojson_scan
   
  {
	
	NSString *time_captured_at = [[self getcapturedAt] description];
	
	NSString* buffer=[[NSString alloc] initWithFormat:@"{\r\n\"captured_at\":\"%@\",\r\n\"reading_list\": [\r\n ",time_captured_at];
	
	NSEnumerator *enumerator = [[self getreadinglist] objectEnumerator];
	
	id element;
	
	NSString *delimeter =@"";
	
	while(element = [enumerator nextObject] )
	{
		
		buffer = [buffer stringByAppendingString:delimeter];
		
		buffer = [buffer stringByAppendingString:[element tojson_reading]];
		
		delimeter =@",\r\n";
	}
	
	buffer = [buffer stringByAppendingString:@"]\r\n}"];
	
	return buffer;
	  
	  
	
	
}




@end
