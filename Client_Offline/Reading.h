//
//  reading.h
//  wifi_scan
//
//  Created by Koushik Annapureddy on 6/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>


  @interface Reading : NSObject {
	
  NSString *mac;
  NSString *ssid;
  NSNumber *rssi;

     }
 
  -(Reading *)set:(NSString *) a :(NSString *) b :(NSNumber *) c;
  -(NSString *) getmac;
  -(NSString *) getssid;
  -(NSNumber *) getrssi;
  -(NSString *) tojson_reading;

@end
