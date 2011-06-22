//
//  LocationBased_ClientAppDelegate.m
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LocationBased_ClientAppDelegate.h"

@implementation LocationBased_ClientAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	NSLog (@"hi welcome");
	
	
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)theApplication
{
	return YES;
}



@end
