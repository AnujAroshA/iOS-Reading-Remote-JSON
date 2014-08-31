//
//  ANUJsonReader.m
//  ReadingRemoteJson
//
//  Created by Anuja on 8/31/14.
//  Copyright (c) 2014 AnujAroshA. All rights reserved.
//

#import "ANUJsonReader.h"
#import "ANUAppConstants.h"

static NSString *const TAG = @"ANUJsonReader";

@interface ANUJsonReader(){
    NSMutableArray *songNamesMutArr;
}

@end

@implementation ANUJsonReader

/**
 * Iterate through the received JSON
 * \param paramResponseData Server response data
 */
- (void)readJsonStr:(NSData *)paramResponseData {
    if (debugEnable) NSLog(@"%@ * readJsonStr:", TAG);
    
    songNamesMutArr = [[NSMutableArray alloc] init];
    
    NSError *readError;
    
    // Returns a Foundation object from given JSON data.
    NSDictionary *fullJsonDic = [NSJSONSerialization JSONObjectWithData:paramResponseData options:0 error:&readError];

    NSArray *songArray = [fullJsonDic objectForKey:jsonObjSong];

    // Loop through the JSON array to collect song names
    for (int i=0; i<songArray.count; i++) {
        
        NSDictionary *songElementDic = [songArray objectAtIndex:i];

        NSString *songName = [songElementDic objectForKey:jsonObjSongName];

        [songNamesMutArr addObject:songName];
    }

    NSArray *songsArray = [NSArray arrayWithArray:songNamesMutArr];
    
    NSDictionary *userInfoDic = @{songsArrKey: songsArray};

    // After completing the data, notify to all subscribers
    [[NSNotificationCenter defaultCenter] postNotificationName:dataReadyNotifyStr object:nil userInfo:userInfoDic];
}

@end
