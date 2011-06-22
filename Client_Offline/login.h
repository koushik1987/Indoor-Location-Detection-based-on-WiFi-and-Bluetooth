//
//  login.h
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface login : NSObject {
	

	id userinfo;
	id location_info;
	id status_info;

}
-(login*)authenticate:(NSString *) a :(NSString *) b;
-(NSString*)get_userid;
-(NSString*)get_cookie;
-(NSString*)get_username;
-(NSString*)get_label;
-(NSString*)get_status;
-(int)authenticate_sucessful;
-(int)logout;
+(id)GetUserLocationSecurityToken;
-(int)PostLocationLabelandStatus:(NSString*) a :(NSString *) b;
-(int)UpdateUserStatus:(NSString*)a;
-(void)SendUserProfile;
+(int)PostEvent:(int) a :(NSString*) b;

@end
