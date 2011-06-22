//
//  login.m
//  LocationBased_Client
//
//  Created by Koushik Annapureddy on 7/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "login.h"
#import "SBJSON.h"
#import "uni.h"


@implementation login

NSString *cookie;
NSString *userid;

-(login*)authenticate:(NSString *) a :(NSString *) b
{
	
	// 'a' is the username .. 'b' is the password
	
	
	// Reading the Application name and Password	
	
	NSString *app_name=@"indoor";
	
	NSString *app_password=@"bja23Iei2I";
	
	SBJSON *parser = [[SBJSON alloc] init];
	
	
	// Creating the HTTP Body to be sent
	
	NSString* post_login=[[NSString alloc] initWithFormat:@"session[app_name]=%@&session[app_password]=%@&session[username]=%@&session[password]=%@",app_name,app_password,a,b];
	
	NSData *postData_login = [post_login dataUsingEncoding:NSASCIIStringEncoding];
	
	NSString *postLength_login = [NSString stringWithFormat:@"%d", [postData_login length]];
	
	
	// Initializing the HTTP Request
	
	NSMutableURLRequest *request_login = [[[NSMutableURLRequest alloc] init] autorelease];
	
	
	// Setting Header values to the Request
	
	[request_login setURL:[NSURL URLWithString:@"https://cos.sizl.org/session"]];
	
	[request_login setHTTPMethod:@"POST"];
	
	[request_login setValue:postLength_login forHTTPHeaderField:@"Content-Length"];
	
	[request_login setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	[request_login setHTTPBody:postData_login];
	
	
	
	// Initializing the Response Object
	

	NSError *oError_login = [[NSError alloc] init];
	
	NSHTTPURLResponse *oResponseCode_login = nil;
	
	// Sending the Request and Saving the Response value
	
	NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request_login returningResponse:&oResponseCode_login error:&oError_login];
	
	NSString * login_response = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
	
	NSDictionary *statuses_login = [parser objectWithString:login_response error:nil];
	
	NSDictionary *response_entry = [statuses_login objectForKey:@"entry"];
	
	userid = [response_entry objectForKey:@"user_id"];
	
	NSDictionary *header = [oResponseCode_login allHeaderFields];
	
	cookie = [header valueForKey:@"Set-Cookie"];
	
	return self;
	
	
}
	
-(void)SendUserProfile

{	
	
	SBJSON *parser = [[SBJSON alloc] init];
	
// Initiaizing the Get Request URL....
	
    NSString* url_get=[[NSString alloc] initWithFormat:@"http://cos.sizl.org/people/%@/@self",userid];
	
//	cookie = [header valueForKey:@"Set-Cookie"];
	
	NSURLRequest *request_get = [NSURLRequest requestWithURL:[NSURL URLWithString:url_get]];
	
	
	// Sending the Get Request
	
	NSData *response_get = [NSURLConnection sendSynchronousRequest:request_get returningResponse:nil error:nil];
	
	
	// Saving the Response in string format..
	
	NSString *get_string = [[NSString alloc] initWithData:response_get encoding:NSUTF8StringEncoding];
	
	NSDictionary *statuses1 = [parser objectWithString:get_string error:nil];
	
	NSDictionary *data1 = [statuses1 objectForKey:@"entry"];
	
	NSDictionary *data2 = [data1 objectForKey:@"name"];
	
	userinfo = [data2 objectForKey:@"unstructured"];
	
	NSDictionary *data3 = [data1 objectForKey:@"location"];
	
	location_info = [data3 objectForKey:@"label"];
	
	NSDictionary *data4 = [data1 objectForKey:@"status"];
	
	status_info = [data4 objectForKey:@"message"];
	
   
	
	
	
//	id givenname = [data2 objectForKey:@"given_name"];
	
//	return self;
	
	
		}
-(NSString*)get_userid
{
	
	return userid;
}

-(NSString*)get_cookie
{
	
	return cookie;
}

-(NSString*)get_username
{
	
	return userinfo;
}

-(NSString*)get_label
{
	
	return location_info;
}

-(NSString*)get_status
{
	
	return status_info;
}


-(int)authenticate_sucessful
{
	
	if (userid)
		{
		return 1;
			}
	else {
		return 0;
		}
	
	}

-(int)logout
{
	
	
	NSLog(@" Entered logout method");
	
		
	// Initiaizing the Get Request URL....
	
    NSString* get_logout=[[NSString alloc] initWithFormat:@"http://indoor.cs.hut.fi/cgi-bin/location_service/signout_cgi.py"];
	
	
	
	NSMutableURLRequest *request_logout = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:get_logout]];
	
	[request_logout setValue:cookie forHTTPHeaderField:@"Cookie"];
	
	
	// Sending the Get Request
	
	NSData *response_logout = [NSURLConnection sendSynchronousRequest:request_logout returningResponse:nil error:nil];
	
	
	// Saving the Response in string format..
	
	NSString *str_logout = [[NSString alloc] initWithData:response_logout encoding:NSUTF8StringEncoding];	
	
	NSLog(@" value of log out is %@",str_logout);
	
	return 1;
}

+(id) GetUserLocationSecurityToken
{
	
//	if(userid)
//		{
			
	SBJSON *parser = [[SBJSON alloc] init];
			
	NSString* locationSecurityTokenURL=[[NSString alloc] initWithFormat:@"http://cos.sizl.org/people/%@/@location/@location_security_token",userid];
	
	NSURLRequest *securityTokenRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:locationSecurityTokenURL]];
			
	// Sending the Get Request
			
	NSData *securityTokenResponse = [NSURLConnection sendSynchronousRequest:securityTokenRequest returningResponse:nil error:nil];
			
	// Saving the Response in string format..
			
	NSString *securityTokenResponse_string = [[NSString alloc] initWithData:securityTokenResponse encoding:NSUTF8StringEncoding];
			
	NSDictionary *parse_response = [parser objectWithString:securityTokenResponse_string error:nil];
			
	id locationSecurityToken = [parse_response objectForKey:@"location_security_token"];	
				
			return locationSecurityToken;		
	}

-(int)PostLocationLabelandStatus:(NSString *) a :(NSString *) b	
	{
// 'a' represents the location label and 'b' represents the status message
		
		// URL Encoding the Values in the Body...
		
	//	NSString *HOST_UNIQUE_NAME = @"PC:D2248C4A-0FB4-5CEE-AD42-AA22AA6FCEA7";
		
		NSString *HOST_UNIQUE_NAME = @"PC:";
		uni *uni_obj = [[[uni alloc]init]autorelease];
		HOST_UNIQUE_NAME = [HOST_UNIQUE_NAME stringByAppendingString:[uni_obj MD5]];
		
		NSString *user_id = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)userid, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
		
		NSString *device = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)HOST_UNIQUE_NAME, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
		
		NSString *location = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)a, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
		
		NSString *status = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)b, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);

	    // Creating the HTTP Body
		
		NSString* location_body=[[NSString alloc] initWithFormat:@"status=%@&location=%@&user_id=%@&device=%@",status,location,user_id,device];
		
		NSData *location_body_encoded = [location_body dataUsingEncoding:NSASCIIStringEncoding];
		
		NSString *location_body_length = [NSString stringWithFormat:@"%d", [location_body_encoded length]];
		
		// Initializing the HTTP Request
		
		NSMutableURLRequest *locationRequest = [[[NSMutableURLRequest alloc] init] autorelease];
		
		// Setting Header values to the Request
		
		[locationRequest setURL:[NSURL URLWithString:@"http://indoor.cs.hut.fi/cgi-bin/location_service/location_label_cgi.py"]];
		
		[locationRequest setHTTPMethod:@"POST"];
		
		[locationRequest setValue:location_body_length forHTTPHeaderField:@"Content-Length"];
		
		[locationRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		
		[locationRequest setValue:cookie forHTTPHeaderField:@"Cookie"];
		
		[locationRequest setHTTPBody:location_body_encoded];
		
		NSError *oError_locationRequest = [[NSError alloc] init];
		
		NSHTTPURLResponse *oResponseCode_locationRequest = nil;
		
		// Sending the Request and Saving the Response value
		
		NSData *oResponseData_locationRequest = [NSURLConnection sendSynchronousRequest:locationRequest returningResponse:&oResponseCode_locationRequest error:&oError_locationRequest];
		
		NSString *location_response = [[NSString alloc] initWithData:oResponseData_locationRequest encoding:NSUTF8StringEncoding];
		
		NSLog(@" The value of location response is %@",location_response);
		
		int response_statuscode = [oResponseCode_locationRequest statusCode];
		
		NSLog(@"The value of status code is %d",response_statuscode);
					 
			return response_statuscode;
		
		}
-(int)UpdateUserStatus:(NSString*)a 
{
		
	NSString* userLocationURL =[[NSString alloc] initWithFormat:@"http://cos.sizl.org/people/%@/@self",userid];
	
	
	NSString *statusMessage = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)a, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);

	// Creating the HTTP Body
	
	NSString* userStatus_body=[[NSString alloc] initWithFormat:@"status_message=%@",statusMessage];
	
	NSData *userStatus_body_encoded = [userStatus_body dataUsingEncoding:NSASCIIStringEncoding];
	
	NSString *userStatus_body_length = [NSString stringWithFormat:@"%d", [userStatus_body_encoded length]];
	
	// Initializing the HTTP Request
	
	NSMutableURLRequest *userProfileRequest = [[[NSMutableURLRequest alloc] init] autorelease];
	
	// Setting Header values to the Request
	
//	[userProfileRequest setURL:userLocationURL];
	
	[userProfileRequest setURL:[NSURL URLWithString:userLocationURL]];
	
	[userProfileRequest setHTTPMethod:@"PUT"];
	
	[userProfileRequest setValue:userStatus_body_length forHTTPHeaderField:@"Content-Length"];
	
	[userProfileRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
//	[locationRequest setValue:cookie forHTTPHeaderField:@"Cookie"];
	
	[userProfileRequest setHTTPBody:userStatus_body_encoded];
	
	NSError *oError_userProfile = [[NSError alloc] init];
	
	NSHTTPURLResponse *oResponseCode_userProfile = nil;
	
	// Sending the Request and Saving the Response value
	
	NSData *oResponseData_userProfile = [NSURLConnection sendSynchronousRequest:userProfileRequest returningResponse:&oResponseCode_userProfile error:&oError_userProfile];
	
	NSString *userProfile_response = [[NSString alloc] initWithData:oResponseData_userProfile encoding:NSUTF8StringEncoding];
	
	NSLog(@" The value of location response is %@",userProfile_response);
	
	int userProfile_statuscode = [oResponseCode_userProfile statusCode];
	
	NSLog(@"The value of status code is %d",userProfile_statuscode);
	
	return userProfile_statuscode;
	
}

+(int)PostEvent:(int)a :(NSString*) b
{
	// 'a' represents the event type 1 represents the 'Enter' Event.. 'b' represents the Location label
	// URL Encoding the Values in the Body...
	
	
    int id_event = a;
	
//	NSString *device_id = @"PC:D2248C4A-0FB4-5CEE-AD42-AA22AA6FCEA7";
	
	NSString *device_id = @"PC:";
	uni *uni_obj = [[[uni alloc]init]autorelease];
	device_id = [device_id stringByAppendingString:[uni_obj MD5]];
	
	NSString *user_id_event = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)userid, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	NSString *deviceid_event = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)device_id, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	NSString *locationlabel_event = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)b, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	NSDate *occur_at = [NSDate date];
	
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
	NSString *timestamp_str = [outputFormatter stringFromDate:occur_at];
	
	[outputFormatter release];
	
	NSString *occur_at_event = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)timestamp_str, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
     // Creating the HTTP Body
	
	NSString* event_body=[[NSString alloc] initWithFormat:@"occur_at=%@&event_type=%d&location_label=%@&user_id=%@&device=%@",occur_at_event,id_event,locationlabel_event,user_id_event,deviceid_event];
	
    NSData *event_body_encoded = [event_body dataUsingEncoding:NSASCIIStringEncoding];
	
	NSString *event_body_length = [NSString stringWithFormat:@"%d", [event_body_encoded length]];
	
	// Initializing the HTTP Request
	
	NSMutableURLRequest *request_event = [[[NSMutableURLRequest alloc] init] autorelease];
	
	// Setting Header values to the Request
	
	[request_event setURL:[NSURL URLWithString:@"http://indoor.cs.hut.fi/cgi-bin/location_service/event_cgi.py"]];
	
	[request_event setHTTPMethod:@"POST"];
	
	[request_event setValue:event_body_length forHTTPHeaderField:@"Content-Length"];
	
	[request_event setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	[request_event setValue:cookie forHTTPHeaderField:@"Cookie"];
	
	[request_event setHTTPBody:event_body_encoded];
	
	NSError *oError_postevent = [[NSError alloc] init];
	
	NSHTTPURLResponse *oResponseCode_postevent = nil;
	
	// Sending the Request and Saving the Response value
	
	NSData *oResponseData_postevent = [NSURLConnection sendSynchronousRequest:request_event returningResponse:&oResponseCode_postevent error:&oError_postevent];
	
	NSString *event_response = [[NSString alloc] initWithData:oResponseData_postevent encoding:NSUTF8StringEncoding];
	
	NSLog(@" Value of response is %@",event_response);
	
    int event_statuscode = [oResponseCode_postevent statusCode];
	
	return event_statuscode;
	
}



@end
