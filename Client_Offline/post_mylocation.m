//
//  post_mylocation.m
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "post_mylocation.h"
#import "SBJSON.h"
extern int y;
extern int size_array;
extern NSMutableArray *myLoc_globalArray;



@implementation post_mylocation


-(post_mylocation*)postlocation: (NSString *) a :(NSString *) b :(NSString *)c :(NSString *)d

{
	
	/* 'a' represents the host unique identifier
	 'b' represents the scan window in JSON format 
	 'c' represents the user id 
	 'd' represents the cookie of the session     */
	
	// URL Encoding the Values in the Body...	
	
	NSString *userid_urlencoded = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)c, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	NSString *hui_urlencoded = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)a, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	NSString *scanwindow_urlencoded = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)b, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	
	// Creating the HTTP Body
	
	NSString* post_body=[[NSString alloc] initWithFormat:@"user_id=%@&device=%@&scan_window=%@",userid_urlencoded,hui_urlencoded,scanwindow_urlencoded];
	
    NSData *post_body_encoded = [post_body dataUsingEncoding:NSASCIIStringEncoding];
	
	NSString *post_body_length = [NSString stringWithFormat:@"%d", [post_body_encoded length]];
	
	// Initializing the HTTP Request
	
	NSMutableURLRequest *request_postscan = [[[NSMutableURLRequest alloc] init] autorelease];
	
	// Setting Header values to the Request
	
	[request_postscan setURL:[NSURL URLWithString:@"http://indoor.cs.hut.fi/cgi-bin/location_service/nearby_locations_cgi.py"]];
	
	[request_postscan setHTTPMethod:@"POST"];
	
	[request_postscan setValue:post_body_length forHTTPHeaderField:@"Content-Length"];
	
	[request_postscan setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	[request_postscan setValue:d forHTTPHeaderField:@"Cookie"];
	
	[request_postscan setHTTPBody:post_body_encoded];
	
	NSError *oError_postscan = [[NSError alloc] init];
	
	NSHTTPURLResponse *oResponseCode_postscan = nil;
	
	// Sending the Request and Saving the Response value
	
	NSData *oResponseData_postscan = [NSURLConnection sendSynchronousRequest:request_postscan returningResponse:&oResponseCode_postscan error:&oError_postscan];
	
	post_response = [[NSString alloc] initWithData:oResponseData_postscan encoding:NSUTF8StringEncoding];
	
	NSLog(@" The value of response is %@",post_response);
	
	NSLog(@" The value of response length is %d",[post_response length]);
	
    response_statuscode = [oResponseCode_postscan statusCode];
	
	NSLog(@" The value of response code is %d",response_statuscode);
	
	SBJSON *parser = [[SBJSON alloc] init];
	
	y = [post_response length];
	
	NSLog(@" the value of y at start is %d",y);
	
	
	if([post_response length] > 4)
	{
		
	NSDictionary *mylocation_json = [parser objectWithString:post_response error:nil];
		
		
		myLoc_globalArray = [[NSMutableArray alloc]init];
		
		
		for (NSDictionary *status in mylocation_json)
		{
						NSLog(@" Entered JSON For loop");
			
			NSLog(@"%@ and  %@", [status objectForKey:@"location_label"], [status objectForKey:@"distance"]);
		
			
			[myLoc_globalArray addObject:[status objectForKey:@"location_label"]];

			
		}
		}
	else 
	{
		NSLog(@" No Likely Locations are updated");
	}

	
	size_array = [myLoc_globalArray count];
	
	for(int i=0;i<size_array;i++)
		
	{
		NSLog(@" The values in location_array are %@",[myLoc_globalArray objectAtIndex:i]);
			  
	
	}
	
	return self;
	
}
-(int)get_post_response
{
	return response_statuscode;
}
-(NSString*)get_indoordata_response
{
	return strResult_indoordata;
}

@end



