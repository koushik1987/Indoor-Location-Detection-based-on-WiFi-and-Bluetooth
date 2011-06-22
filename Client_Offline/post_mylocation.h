//
//  post_mylocation.h
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface post_mylocation : NSObject {
	
	NSString *post_response;
	NSString *strResult_indoordata;
	int response_statuscode;
	IBOutlet id mylocation;
	
	

	
}
-(post_mylocation*)postlocation: (NSString *) a :(NSString *) b :(NSString *)c :(NSString *)d;
-(int)get_post_response;
-(NSString*)get_indoordata_response;



@end
