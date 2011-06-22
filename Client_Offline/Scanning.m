//
//  Scanning.m
//  wifi_scan
//
//  Created by Koushik Annapureddy on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Scanning.h"

#import "Reading.h"

#import "scan.h"

#import "scanwindow.h"

#import <Foundation/Foundation.h>

#import <CoreWLAN/CoreWLAN.h>


@implementation Scanning

-(scanwindow *)scanning_network
{
	
//	NSLog(@ "Entered my location scanning");
	
	NSError *err = nil;
	
	NSDictionary *params = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:kCWScanKeyMerge ];
	
	NSMutableArray *scanwindowarraytest = [[NSMutableArray alloc]init];
	
	NSDate *x = [NSDate date];

#ifdef DEBUG
//	int tmp;
#endif
	
// loop 6 times to scan for networks with interval of 5s
	for ( int i=0; i<6 ; i++)
	{
		// The reading list is per nw scan
		NSMutableArray *readinglist = [[NSMutableArray alloc]init];
#ifdef DEBUG
	//	printf("Time for scan.\n");
#endif
     	NSMutableArray* nw_array_returned_by_lib = [NSMutableArray arrayWithArray:[[CWInterface interface] scanForNetworksWithParameters:params error:&err]];

#ifdef DEBUG
	//	tmp = [nw_array_returned_by_lib count];
	//	printf("The API returned that %d networks have been found\n", tmp);
#endif
		
#ifdef DEBUG
	//	printf("   Adding the nw into array ... ");
	//	int count_reading_obj = 0;
#endif
		// Now take the selective values from each nw_info into Reading-object
		
		for ( int k=0; k<[nw_array_returned_by_lib count]; k++)
		{
			// create a temp nw object to copy selective info into Reading-object
			
			CWNetwork *net = [nw_array_returned_by_lib objectAtIndex:k];
			// create Reading object and use constructor to copy selective nw info
			
			Reading *reading_obj = [[Reading alloc] set:[net bssid] :[net ssid] :[net rssi]];
			// Add the object into an array
			
			[readinglist addObject:reading_obj];

#ifdef DEBUG
		//	printf("added %d ... ",count_reading_obj++);
#endif
		}

#ifdef DEBUG
	//	tmp = [readinglist count];
	//	printf("\n      The ReadingList has %d networks\n", tmp);
#endif
		// aggregage (Reading Array + date) into "scan" object
		
		scan *scan_obj = [[scan alloc] set_scan:[NSDate date] :readinglist];
		
		// add the "scan" object into a array
		
		[scanwindowarraytest addObject:scan_obj];

#ifdef DEBUG
	//	printf("Sleeping for 5s...\n");
		[readinglist release];  // added recently 
#endif
		// Next scan after 5s
		
		sleep(5);
	}
	
	scanwindow *scanwindow_obj = [[scanwindow alloc]set_scanwindow :x :[NSDate date] :scanwindowarraytest];
	
//	NSLog(@" returing scanwindow obj success");
	
	
	return scanwindow_obj;
	
	[scanwindow_obj autorelease];
	

	}



	@end
