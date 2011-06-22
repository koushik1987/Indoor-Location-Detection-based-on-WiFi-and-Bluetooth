//
//  ClientController.m
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ClientController.h"
#import "login.h"
#import "Scanning.h"
#import "post_scanwindow.h"
#import "threadclass.h"
#import <Foundation/Foundation.h>
#import "Location.h"
#import "scanwindow.h"
#import "scan.h"
#import "Reading.h"
#import "post_mylocation.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "BT_Window.h"
#import "BT_Scan.h"
#import "BluetoothDevice.h"

int mylocation_click;
int mylocation_found;
int y;
int size_array;
int wrong_user;
BOOL isSignedIn;

NSMutableArray *myLoc_globalArray;
NSWindow *Location_Window;
threadclass *threadclassObj;

@implementation ClientController

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification

     {
	// Insert code here to initialize your application 
	NSLog (@"hi welcome");
	
	}

- (IBAction)signin:(id)sender
{

	NSString *read_user_name = [username stringValue];
	NSString *read_password = [password stringValue];
	
	if([read_user_name length] == 0 || [read_password length] == 0)
	{
		
	//	wrong_user = 1;
	
	NSAlert *alert = [[[NSAlert alloc]init]autorelease];
	[alert setMessageText:@"Warning Message"];
	[alert setInformativeText:@" Enter Username and Password"];
	[alert addButtonWithTitle:@"OK"];
	int rcode = [alert runModal];
	if(rcode == NSAlertFirstButtonReturn)
		NSLog(@"First button pressed");
		}
	
	if ([read_user_name length]>0 && [read_password length]>0) 
		
	{
		bool success = false;
		const char *host_name = [@"google.com" cStringUsingEncoding:NSASCIIStringEncoding];
		
		SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL,host_name);
		SCNetworkReachabilityFlags flags;
		success = SCNetworkReachabilityGetFlags(reachability, &flags);
		bool isAvailable = success && (flags & kSCNetworkFlagsReachable) && 
		!(flags & kSCNetworkFlagsConnectionRequired);
		
		if (isAvailable)
			{
		
	login *login_obj = [[login alloc] authenticate:read_user_name :read_password];
		
		if ([login_obj authenticate_sucessful]) 
		{
			
	[login_obj SendUserProfile];
	
	[NSApp beginSheet:Location_Information modalForWindow:nil modalDelegate:self didEndSelector:nil contextInfo:nil];
			
			[User_Login orderOut: self];
			
			[NSApp endSheet:User_Login];
		
	[name setStringValue:[login_obj get_username]];
	
	[status setStringValue:[login_obj get_status]];
	
	[location setStringValue:[login_obj get_label]];
		
	}
		else
		{
			NSAlert *alert = [[[NSAlert alloc]init]autorelease];
			[alert setMessageText:@"Warning Message"];
			[alert setInformativeText:@" Invalid Username and Password"];
			[alert addButtonWithTitle:@"OK"];
			int rcode = [alert runModal];
			if(rcode == NSAlertFirstButtonReturn)
				NSLog(@"First button pressed");
		}
				
		
if([login_obj authenticate_sucessful])
	
	{
		// auth is successful, launch the thread for scanning nw in background and sending this infor to server
		
		 isSignedIn = YES;
		
		threadclassObj = [[threadclass alloc]init];
	 
		// create thread
		
		[NSThread detachNewThreadSelector:@selector(threadmethod:) toTarget:threadclassObj withObject:[NSArray arrayWithObjects:[login_obj get_userid],[login_obj get_cookie],nil]]; 
		
		[NSThread detachNewThreadSelector:@selector(threadmethod_bt:) toTarget:threadclassObj withObject:[NSArray arrayWithObjects:[login_obj get_userid],[login_obj get_cookie],nil]];  

		
	}
		}

	else
    {
		 // auh failed. Show failuer message ot user and await re-attempt
		
			
			NSAlert *alert = [[[NSAlert alloc]init]autorelease];
			[alert setMessageText:@"Warning Message"];
			[alert setInformativeText:@" Please connect to Wi-Fi Network"];
			[alert addButtonWithTitle:@"OK"];
			int rcode = [alert runModal];
			if(rcode == NSAlertFirstButtonReturn)
				NSLog(@"First button pressed");
			isSignedIn = NO;
	   
    }
}
	}
	
-(IBAction)signout:(id)sender
{
	
	NSLog(@" Entered sign out in controller");
	
	
	login *logout_obj = [[login alloc]init];
	
	int x;
	
	x = [logout_obj logout];
	
	if(x)
	{	
	// Write Code for stopping the thread of Scan Window..
		NSLog(@" Sign out Successful");
		isSignedIn = NO;
		
		[username setStringValue:@""];
		[password setStringValue:@""];
		[name setStringValue:@""];
		[status setStringValue:@""];
		[location setStringValue:@""];
	//	[mylocation setStringValue:@""];
	//	[NSThread sleepForTimeInterval:100];
		
		
		[Location_Information orderOut: self];
		[NSApp endSheet:Location_Information];	
		[NSApp beginSheet:User_Login modalForWindow:nil modalDelegate:self didEndSelector:nil contextInfo:nil];
             
		

		
		
		}
	else 
	{
		NSLog(@" Sign out Unsucessful");
	}

   }

-(IBAction)updatestatusandlocation:(id)sender

{
	if (isSignedIn) 
	 
	{
		
		int resultCode = 0;
		
		NSLog(@" Entered Function");
		NSString *location_label = [location stringValue];
		NSString *status_message = [status stringValue];
		NSString *securityToken = [login GetUserLocationSecurityToken];
		NSLog(@" value of security token is %@",securityToken);
		login *update_obj = [[login alloc]init];
		int success = [update_obj PostLocationLabelandStatus:location_label :status_message];
		if(success > 100)
			
		{
				resultCode = 3;
			NSLog(@" Event Updated Successfuly");
		/*	NSAlert *alert = [[[NSAlert alloc]init]autorelease];
			[alert setMessageText:@"Message"];
			[alert setInformativeText:@" Updated Status and Location "];
			[alert addButtonWithTitle:@"OK"];
			int rcode = [alert runModal];
			if(rcode == NSAlertFirstButtonReturn)
				NSLog(@"First button pressed"); */
			[bottom_text setStringValue:@""];
			[bottom_text setStringValue:@"Updated Label and Status Successfully"];
			
		}
		else 
		{
	        int updateStatusSuccess = [update_obj UpdateUserStatus:status_message];
			NSLog(@" update status success value is %d",updateStatusSuccess);
			
		}
		[update_obj SendUserProfile];
		
		[name setStringValue:[update_obj get_username]];
		
		[status setStringValue:[update_obj get_status]];
		
		[location setStringValue:[update_obj get_label]];
		
		NSLog(@" The value of result code is %d",resultCode);
		
}
}	

-(IBAction)enter_clicked:(id)sender
{
	
	NSLog(@" Entered enter clicked");
	
	NSString *locname_event = [location stringValue];
	
	NSLog(@" The Value of location is %@",locname_event);
	
	int eventid = 1;
	
	int event_return = [login PostEvent:eventid :locname_event];
	if(event_return) 
	{
		
		NSLog(@" Event Updated Successfuly");
	/*	NSAlert *alert = [[[NSAlert alloc]init]autorelease];
		[alert setMessageText:@"Message"];
		[alert setInformativeText:@" Event is Successfully Submitted"];
		[alert addButtonWithTitle:@"OK"];
		int rcode = [alert runModal];
		if(rcode == NSAlertFirstButtonReturn)
			NSLog(@"First button pressed");*/
		[bottom_text setStringValue:@""];
		[bottom_text setStringValue:@"Enter clicked Successfully"];
		
	}
	
}

-(IBAction)depart_clicked:(id)sender
{
	NSLog(@" Entered depart clicked");
	NSString *locname_event = [location stringValue];
	
	int eventid = 2;
	int event_return = [login PostEvent:eventid :locname_event];
	if(event_return) 
	{
		NSLog(@" Event Updated Successfuly");
		NSLog(@" Event Updated Successfuly");
	/*	NSAlert *alert = [[[NSAlert alloc]init]autorelease];
		[alert setMessageText:@"Message"];
		[alert setInformativeText:@" Event is Successfully Submitted"];
		[alert addButtonWithTitle:@"OK"];
		int rcode = [alert runModal];
		if(rcode == NSAlertFirstButtonReturn)
			NSLog(@"First button pressed"); */
		
		[bottom_text setStringValue:@""];
		[bottom_text setStringValue:@"Depart clicked Successfully"];
		
	}
	
}

-(IBAction)refresh_clicked:(id)sender
{
	login *refresh_obj = [[login alloc]init];
	
	[refresh_obj SendUserProfile];
	
	[name setStringValue:[refresh_obj get_username]];
	
	[status setStringValue:@""];
	
	[status setStringValue:[refresh_obj get_status]];
	
	[location setStringValue:@""];
	
	[location setStringValue:[refresh_obj get_label]];
	
	[bottom_text setStringValue:@"Refresh clicked Successfully"];
	
	// NEW Code Added for Testing Purpose
	
/*	BT_Scan *obj1 = [[BT_Scan alloc]init];
	
	NSString *temp = [[obj1 bt_scanning]tojson_btwindow];
	
	NSLog(@" The value of temp is %@",temp);  */
	
	
	
//	NSLog(@" The bt values of final are %@ %d",[cv getcapturedAt],[[cv getdeviceList]count]);
	
	
	}

-(IBAction)mylocation_clicked:(id)sender

   {
	
//	[mylocation setStringValue:@""];
	
	NSLog(@" Entered mylocation function");
	
	login *myloc_obj = [[login alloc]init];
	
	NSLog(@" %@",[myloc_obj get_userid]);
	
	threadclass *threadobj_mylocation = [[threadclass alloc]init];
	
	// create thread
	
	[NSThread detachNewThreadSelector:@selector(thread_mylocation:) toTarget:threadobj_mylocation withObject:[NSArray arrayWithObjects:[myloc_obj get_userid],[myloc_obj get_cookie],nil]];
	   
	[bottom_text setStringValue:@""];
	[bottom_text setStringValue:@"Mylocation updated Successfully"]; 
	
	
//}

//-(IBAction)Displaylocation_clicked :(id)sender
//{

if(y>4)
	{
		NSLog(@" The value of size_array is %d",size_array);
	NSMutableString *myloc_string = [[NSMutableString alloc]initWithString:@"Loc :"];
		int i;
		for(i=0;i<size_array;i++)
			
		{
						
		//	NSLog(@" The values of global_controller array is %@",[myLoc_globalArray objectAtIndex:i]);	
			
			[myloc_string appendString:[myLoc_globalArray objectAtIndex:i]];
			
			[myloc_string appendString:@","];
			
			NSLog(@" The locations in final string are %@",myloc_string);
			
		}
		
	//	NSString *str_label = @"My Location:";
//		str_label = [str_label stringByAppendingString:myloc_string];
		//[mylocation setStringValue:@"My Location:"];
			[location setStringValue:myloc_string];
		
			}
	else 
	{
		[location setStringValue:@"No Nearby Locations"];
	}
//}
}
@end
