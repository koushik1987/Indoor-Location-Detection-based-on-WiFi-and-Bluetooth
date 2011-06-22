//
//  ClientController.h
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>



@interface ClientController : NSObject {
	
	
	
 IBOutlet id username;
 IBOutlet id password;
 IBOutlet id name;
 IBOutlet id status;
 IBOutlet id location;
 //BOOL isSignedIn;
// IBOutlet id mylocation;
 IBOutlet id bottom_text;
	
 IBOutlet NSWindow *User_Login;
 IBOutlet NSWindow *Location_Information;
	
	
	
}
-(IBAction)signin:(id)sender;
-(IBAction)signout:(id)sender;
-(IBAction)updatestatusandlocation:(id)sender;
-(IBAction)enter_clicked:(id)sender;
-(IBAction)depart_clicked:(id)sender;
-(IBAction)refresh_clicked:(id)sender;
-(IBAction)mylocation_clicked:(id)sender;
//-(IBAction)Displaylocation_clicked:(id)sender;



@end
