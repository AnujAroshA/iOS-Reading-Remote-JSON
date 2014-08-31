//
//  ANUWebConnect.m
//  ReadingRemoteJson
//
//  Created by Anuja on 8/31/14.
//  Copyright (c) 2014 AnujAroshA. All rights reserved.
//

#import "ANUWebConnect.h"
#import "ANUAppConstants.h"
#import "ANUJsonReader.h"

static NSString *const TAG = @"ANUWebConnect";

@implementation ANUWebConnect

/**
 * Using the string URL, create external server request to gather data
 */
- (void)createSyncRequest {
    if (debugEnable) NSLog(@"%@ * createSyncRequest", TAG);
    
    // Create URL object using the real world URL string
    NSURL *url = [NSURL URLWithString:[ANUAppConstants jsonUrl]];
    
    // Creates and returns a URL request for a specified URL with default cache policy and timeout value.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response;
    NSError *error;
    
    // There are Async and Synchronous requests for URLConnection.
    // Here I've used Synchrounous request because I'm ruiing this process in a separate thread.
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    ANUJsonReader *jsonReader = [ANUJsonReader alloc];
    [jsonReader readJsonStr:responseData];
}


@end
