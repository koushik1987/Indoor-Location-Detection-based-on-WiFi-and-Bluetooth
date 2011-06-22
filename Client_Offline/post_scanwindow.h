//
//  post_scanwindow.h
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface post_scanwindow : NSObject {
	
	NSString *post_response;
	NSString *strResult_indoordata;
	int response_statuscode;

}
-(post_scanwindow*)postscan: (NSString *) a :(NSString *) b :(NSString *)c :(NSString *)d;
-(int)get_post_response;
-(NSString*)get_indoordata_response;
-(int)postscan_bt: (NSString *) a :(NSString *) b :(NSString *)c :(NSString *)d;
@end
