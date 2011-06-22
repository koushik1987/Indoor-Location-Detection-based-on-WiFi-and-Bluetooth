//
//  uni.m
//  unique_id
//
//  Created by Koushik Annapureddy on 8/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "uni.h"
#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>
#import <unistd.h>

#include <sys/sysctl.h>
#include <sys/resource.h>
#include <sys/vm.h>
#import <CommonCrypto/CommonDigest.h>
#include <openssl/md5.h>



@implementation uni

- (NSString *) MD5
{
	
	io_registry_entry_t     rootEntry = IORegistryEntryFromPath( kIOMasterPortDefault, "IOService:/" );
	CFTypeRef serialAsCFString = NULL;
	
	serialAsCFString = IORegistryEntryCreateCFProperty( rootEntry,
													   CFSTR(kIOPlatformSerialNumberKey),
													   kCFAllocatorDefault,
													   0);
	
	IOObjectRelease( rootEntry );
	NSLog(@" The value is %@",serialAsCFString);
	NSString *val = [[(id)CFMakeCollectable(serialAsCFString) retain] autorelease];
	NSLog(@" The values is aaa %@",val);
	
	const char *cStr = [val UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];  
}

@end
