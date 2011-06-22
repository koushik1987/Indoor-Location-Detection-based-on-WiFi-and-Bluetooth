//
//  reading.m
//  wifi_scan
//
//  Created by Koushik Annapureddy on 6/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Reading.h"

#import <Foundation/Foundation.h>

#import "Scanning.h"


@implementation Reading


 - (Reading*)set:(NSString *) a :(NSString *) b :(NSNumber *) c
   
   {
	
	mac = a;
    ssid = b;
	rssi = c;
	
	return self;
	
	}


 
- (NSString *) getmac 
  
   {
	
	   return mac;
    }

- (NSString *) getssid 

  {
	
	  return ssid;

  }

- (NSNumber *) getrssi 

   {
	
	return rssi;

   }	

- (NSString *) tojson_reading

 {
	NSString* buffer=[[NSString alloc] initWithFormat:@"{\"mac\": \"%@\", \"ssid\": \"%@\", \"rssi\": %@}",[self getmac],[self getssid],[self getrssi]];
	
	return buffer;
	 
	 
	
 }
	@end
