//
//  threadclass.m
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "threadclass.h"
#import "Scanning.h"
#import "post_scanwindow.h"
#import "login.h"
#import "post_mylocation.h"
#import "scanwindow.h"
#import "ClientController.h"
#import "Sqlite.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "uni.h"
#import "BluetoothDevice.h"
#import "BT_Scan.h"
#import "BT_Window.h"
extern int mylocation_click;
extern int mylocation_found;
extern BOOL isSignedIn;
NSMutableString *scanwindow_string_bkp;
NSLock *mylock;
NSString *writableDBPath;



@implementation threadclass

-(void)threadmethod:o
{
	
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	int i = 0;
  Scanning *scanner = [[Scanning alloc]init];
	
	Sqlite *sqlite = [[Sqlite alloc] init];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"OtaSizzle_database.db"];
//	NSString *Host_Unique_Name = @"PC:D2248C4A-0FB4-5CEE-AD42-AA22AA6FCEA7";
	NSString *Host_Unique_Name = @"PC:";
	uni *uni_obj = [[[uni alloc]init]autorelease];
	Host_Unique_Name = [Host_Unique_Name stringByAppendingString:[uni_obj MD5]];
	
	

 
	
		
	//	NSLog(@"The value of bol is %d",isSignedIn);	
	
	
	while(1)
  {	
	
	 NSLog(@"The value of bol is %d",isSignedIn);
	
	  if (isSignedIn)
		  
	  {
		  
	  bool success = false;
	  const char *host_name = [@"stackoverflow.com" cStringUsingEncoding:NSASCIIStringEncoding];
	  
	  SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL,host_name);
	  SCNetworkReachabilityFlags flags;
	  success = SCNetworkReachabilityGetFlags(reachability, &flags);
	  bool isAvailable = success && (flags & kSCNetworkFlagsReachable) && 
	  !(flags & kSCNetworkFlagsConnectionRequired);
	  post_scanwindow *send_scan;
	  
	   NSString *scanwindow_string = [[scanner scanning_network]tojson];
	  
	  if (isAvailable) 
	  {
		  NSLog(@"Host is reachable: %d", flags);
		  
		  NSLog(@" The value of scanwindow is %@",scanwindow_string);
		  
	      send_scan = [[post_scanwindow alloc] postscan:Host_Unique_Name :scanwindow_string :[o objectAtIndex:0] :[o objectAtIndex:1]];
		  
		  if ([sqlite open:writableDBPath])
			  
		  {
			   NSArray *db_results = [sqlite executeQuery:@"SELECT * FROM test;"];
			  
			  int db_size = [db_results count];
		  
	          if(db_size > 0)
				   
			  {
			  
			  for (int i=0; i<db_size; i++)
				 {  
			  
			  NSDictionary *dict_db = [db_results objectAtIndex:i];
			  
			  NSLog(@" The value for the num is %@",[dict_db objectForKey:@"num"]);
			  NSLog(@" The entry for the value  is %@",[dict_db objectForKey:@"value"]);
			send_scan = [[post_scanwindow alloc] postscan:Host_Unique_Name :[dict_db objectForKey:@"value"] :[o objectAtIndex:0] :[o objectAtIndex:1]];
					 NSLog(@" Posted Database Scan Window Sucessfully");
					 
					 

			   }
				  [sqlite executeQuery:@"DELETE FROM test;"];
		  }
		  
		  else 
		  {
			  NSLog(@"DB is not present already");
		  }
		  }
  
			 else 
			 {
				 NSLog(@" DB Path could not be opened");
			 }
 


			  
		  

    if([send_scan get_post_response])
    {
	
	   NSLog(@" Posted Scan Window Sucessfully");
		
	   [mylock lock];
		
		scanwindow_string_bkp = [[NSMutableString alloc] initWithString:scanwindow_string];
		
		[mylock unlock];
	
    }
    else
    {
		
		
	 NSLog(@" Posted Scan Window Unsucessfully");
	  	  
	  
    }
			  
	  }
 
	else 
	{
		NSLog(@" Host is unreachable");
		if ([sqlite open:writableDBPath])
			
		{
			[sqlite executeNonQuery:@"CREATE TABLE test (num INTEGER, value TEXT);"];
			
			 NSArray *results = [sqlite executeQuery:@"SELECT * FROM test;"];
			
			int db_count = [results count];
			
			i = db_count;
			
		[sqlite executeNonQuery:@"INSERT INTO test VALUES (?, ?);",[NSNumber numberWithInt:i],scanwindow_string];
		
		i = i+1;
			}
		
	}
	  
  }
	  else {
		  NSLog(@"user not signed in");
		  break;
	  }

}
//	[scanwindow_string_bkp retain];
	[pool release];
//}
	}



-(void)thread_mylocation:oo
{
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSLog(@" Entered Thread Method");

//	NSString *Host_Unique_Name = @"PC:D2248C4A-0FB4-5CEE-AD42-AA22AA6FCEA7";
	
	NSString *Host_Unique_Name = @"PC:";
	uni *uni_obj = [[[uni alloc]init]autorelease];
	Host_Unique_Name = [Host_Unique_Name stringByAppendingString:[uni_obj MD5]];
	
	NSLog(@"received Arguements %@",[oo objectAtIndex:0]);
	
	NSLog(@" The value of global string is %@",scanwindow_string_bkp);
	
	if ([scanwindow_string_bkp length]< 10) {
		NSAlert *alert = [[[NSAlert alloc]init]autorelease];
		[alert setMessageText:@"Message"];
		[alert setInformativeText:@" Please wait for a minute till ScanWindow is created "];
		[alert addButtonWithTitle:@"OK"];
		int rcode = [alert runModal];
		if(rcode == NSAlertFirstButtonReturn)
			NSLog(@"First button pressed");
	}
	
	else {
		
	

	post_mylocation *postloc_scan = [[post_mylocation alloc] postlocation:Host_Unique_Name :scanwindow_string_bkp :[oo objectAtIndex:0] :[oo objectAtIndex:1]];
	
	NSLog(@" The key is pressed");

	if([postloc_scan get_post_response])
	{
				
		NSLog(@" Posted location Scan Window Sucessfully");
		NSLog(@" Event Updated Successfuly");
	/*	NSAlert *alert = [[[NSAlert alloc]init]autorelease];
		[alert setMessageText:@"Message"];
		[alert setInformativeText:@"  Sent MyLocation Query "];
		[alert addButtonWithTitle:@"OK"];
		int rcode = [alert runModal];
		if(rcode == NSAlertFirstButtonReturn)
			NSLog(@"First button pressed"); */
		
		
		
	}
	 else
	  {
		NSLog(@" Posted location Scan Window Unsucessfully");
		}
		}
	
			
[pool release];


}

-(void)threadmethod_bt:ooo
{

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
//	BT_Scan *obj1 = [[BT_Scan alloc]init];
	
//	NSString *temp = [[obj1 bt_scanning]tojson_btwindow];
	
//	NSLog(@" The value of temp is %@",temp);
	
	NSString *Host_Unique_Name = @"PC:";
	
	uni *uni_obj = [[[uni alloc]init]autorelease];
	
	Host_Unique_Name = [Host_Unique_Name stringByAppendingString:[uni_obj MD5]];
	
	post_scanwindow *temp_obj = [[post_scanwindow alloc]init];
	
	NSLog(@" Object at Index 0 is %@ and at index 1 is %@",[ooo objectAtIndex:0],[ooo objectAtIndex:1]);
	
	NSString *temp_id = [ooo objectAtIndex:0];
	
	NSString *temp_cookie = [ooo objectAtIndex:1];
	
	
	
	
	while(1)
	{	
		
		NSLog(@"The value of bol is %d",isSignedIn);
		
		
		
		if (isSignedIn)
			
		{
			BT_Scan *obj1 = [[BT_Scan alloc]init];
			
			NSString *temp = [[obj1 bt_scanning]tojson_btwindow];
			
			NSLog(@" The value of temp is %@",temp);
			
			NSLog(@"The length is %d",[temp length]);
			
			if ([temp length] > 80) 
			
			{
				
                int send_bt;
				
				
			//	send_bt = [[post_scanwindow alloc] postscan_bt:Host_Unique_Name :temp :[ooo objectAtIndex:0] :[ooo objectAtIndex:1]];
				
				send_bt = [temp_obj postscan_bt:Host_Unique_Name :temp :temp_id :temp_cookie];
				
              			
				NSLog(@" The value of final BT is %d",send_bt);
				sleep(30);
			
			}
			
	else {
		
		NSLog(@" BT not available");
		sleep(30);
	}
			
			}
			else
			{
				
				NSLog(@" User Not Signed in ");
				break;
			}
		}
	[pool release];
	
	
}


@end













