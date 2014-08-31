//
//  ANUNetAvailability.m
//  ReadingRemoteJson
//
//  Created by Anuja on 8/31/14.
//  Copyright (c) 2014 AnujAroshA. All rights reserved.
//

#import "ANUNetAvailability.h"
#import "ANUAppConstants.h"
#import "Reachability.h"

static NSString *const TAG = @"ANUNetAvailability";

@implementation ANUNetAvailability

/**
 * This is a class method to check the device is connected to Internet or not.
 * Need this library @link https://github.com/tonymillion/Reachability @/link
 *
 * @return BOOL Yes, if device is connected
 */
+ (BOOL)isConnectedToInternet {
    if (debugEnable) NSLog(@"%@ * isConnectedToInternet", TAG);
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        return NO;
    } else {
        return YES;
    }
}

@end
