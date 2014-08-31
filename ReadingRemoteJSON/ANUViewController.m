//
//  ANUViewController.m
//  ReadingRemoteJson
//
//  Created by Anuja on 8/31/14.
//  Copyright (c) 2014 AnujAroshA. All rights reserved.
//

#import "ANUViewController.h"
#import "ANUAppConstants.h"
#import "Reachability.h"
#import "ANUNetAvailability.h"
#import "ANUWebConnect.h"

static NSString *const TAG = @"ANUViewController";

@interface ANUViewController ()

@end


@implementation ANUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (debugEnable) NSLog(@"%@ * viewDidLoad", TAG);
    
    // Check whether device is connected to Internet
    if ([ANUNetAvailability isConnectedToInternet]) {
        NSLog(@"%@ * Connected", TAG);
        
        ANUWebConnect *webConnect = [ANUWebConnect alloc];
        
        // Detach sending server request from the main UI thread
        [NSThread detachNewThreadSelector:@selector(createSyncRequest) toTarget:webConnect withObject:nil];
        
        // Adds an entry to notification receiver’s dispatch
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSongs:) name:dataReadyNotifyStr object:nil];

    } else {
        _placeholderLabel.text = @"Not Connected To Internet";
    }
}

/** After dataReady noticifation fired, this method will execute
 * \param paramNotify Received data of song names
 */
- (void)updateSongs:(NSNotification *)paramNotify {
    if (debugEnable) NSLog(@"%@ * updateSongs:", TAG);
    
    // Extract real object passed through notification
    NSDictionary *receivedDic = [paramNotify userInfo];

    NSArray *receivedSongsArr = [receivedDic objectForKey:songsArrKey];

    // Update the main UI
    dispatch_async(dispatch_get_main_queue(), ^{
        _placeholderLabel.text = [NSString stringWithFormat:@"%@", receivedSongsArr];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
