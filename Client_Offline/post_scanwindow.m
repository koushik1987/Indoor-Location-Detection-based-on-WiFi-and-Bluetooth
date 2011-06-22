//
//  post_scanwindow.m
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "post_scanwindow.h"


@implementation post_scanwindow

-(post_scanwindow*)postscan: (NSString *) a :(NSString *) b :(NSString *)c :(NSString *)d

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
	
	[request_postscan setURL:[NSURL URLWithString:@"http://indoor.cs.hut.fi/cgi-bin/location_service/scan_window_cgi.py"]];
	
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
	
    response_statuscode = [oResponseCode_postscan statusCode];
	
	
	
	
	
	// Sending the Scan Window to other URL also for tracking the scan windows
	
	NSMutableURLRequest *request_indoordata = [[[NSMutableURLRequest alloc] init] autorelease];
	
	[request_indoordata setURL:[NSURL URLWithString:@"http://indoor-data.cs.hut.fi/cgi-bin/location_service/scan_window_cgi.py"]];
	
	[request_indoordata setHTTPMethod:@"POST"];
	
	[request_indoordata setValue:post_body_length forHTTPHeaderField:@"Content-Length"];
	
	[request_indoordata setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	[request_indoordata setValue:d forHTTPHeaderField:@"Cookie"];
	
	[request_indoordata setHTTPBody:post_body_encoded];
	
	
	NSError *oError_indoordata = [[NSError alloc] init];
	
	NSHTTPURLResponse *oResponseCode_indoordata = nil;
	
	// Sending the Request and Saving the Response value
	
	NSData *oResponse_indoordata = [NSURLConnection sendSynchronousRequest:request_indoordata returningResponse:&oResponseCode_indoordata error:&oError_indoordata];
	
	strResult_indoordata = [[NSString alloc] initWithData:oResponse_indoordata encoding:NSUTF8StringEncoding];
	
		
	
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

-(int)postscan_bt: (NSString *) a :(NSString *) b :(NSString *)c :(NSString *)d

{
	
	/* 'a' represents the host unique identifier
	 'b' represents the scan window in JSON format 
	 'c' represents the user id 
	 'd' represents the cookie of the session     */
	
	// URL Encoding the Values in the Body...	
	
	NSLog(@" Entered inside postscan_bt");
	
	NSString *userid_urlencoded = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)c, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	NSString *hui_urlencoded = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)a, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	NSString *btwindow_urlencoded = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)b, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	
	// Creating the HTTP Body
	
	NSString* post_body=[[NSString alloc] initWithFormat:@"user_id=%@&device=%@&bluetooth_scan=%@",userid_urlencoded,hui_urlencoded,btwindow_urlencoded];
	
    NSData *post_body_encoded = [post_body dataUsingEncoding:NSASCIIStringEncoding];
	
	NSString *post_body_length = [NSString stringWithFormat:@"%d", [post_body_encoded length]];
	
	// Initializing the HTTP Request
	
	NSMutableURLRequest *request_postbt = [[[NSMutableURLRequest alloc] init] autorelease];
	
	// Setting Header values to the Request
	
	[request_postbt setURL:[NSURL URLWithString:@"http://indoor.cs.hut.fi/cgi-bin/location_service/bluetooth_scan_cgi.py"]];
	
	[request_postbt setHTTPMethod:@"POST"];
	
	[request_postbt setValue:post_body_length forHTTPHeaderField:@"Content-Length"];
	
	[request_postbt setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	[request_postbt setValue:d forHTTPHeaderField:@"Cookie"];
	
	[request_postbt setHTTPBody:post_body_encoded];
	
	NSError *oError_postbt = [[NSError alloc] init];
	
	NSHTTPURLResponse *oResponseCode_postbt = nil;
	
	// Sending the Request and Saving the Response value
	
	NSData *oResponseData_postbt = [NSURLConnection sendSynchronousRequest:request_postbt returningResponse:&oResponseCode_postbt error:&oError_postbt];
	
	post_response = [[NSString alloc] initWithData:oResponseData_postbt encoding:NSUTF8StringEncoding];
	
	int response_statuscode_bt;
	
    response_statuscode_bt = [oResponseCode_postbt statusCode];
	
	
	
	
	
	// Sending the Scan Window to other URL also for tracking the scan windows
	
	NSMutableURLRequest *request_indoordata = [[[NSMutableURLRequest alloc] init] autorelease];
	
	[request_indoordata setURL:[NSURL URLWithString:@"http://indoor-data.cs.hut.fi/cgi-bin/location_service/bluetooth_scan_cgi.py"]];
	
	[request_indoordata setHTTPMethod:@"POST"];
	
	[request_indoordata setValue:post_body_length forHTTPHeaderField:@"Content-Length"];
	
	[request_indoordata setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	[request_indoordata setValue:d forHTTPHeaderField:@"Cookie"];
	
	[request_indoordata setHTTPBody:post_body_encoded];
	
	
	NSError *oError_indoordata = [[NSError alloc] init];
	
	NSHTTPURLResponse *oResponseCode_indoordata = nil;
	
	// Sending the Request and Saving the Response value
	
	NSData *oResponse_indoordata = [NSURLConnection sendSynchronousRequest:request_indoordata returningResponse:&oResponseCode_indoordata error:&oError_indoordata];
	
	strResult_indoordata = [[NSString alloc] initWithData:oResponse_indoordata encoding:NSUTF8StringEncoding];
	
	
	
	return response_statuscode_bt;
	
}


@end
