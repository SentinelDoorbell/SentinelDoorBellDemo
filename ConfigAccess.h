//
//  ConfigAccess.h
//  Sentinel
//
//  Created by SentinelTeam on 11/12/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEBUG 1

@interface ConfigAccess : NSObject 
{
    NSDictionary* theDctRoot;
    
    NSDictionary* theCurrentCam;
}

@property (retain) NSDictionary* theDctRoot;

@property (retain) NSDictionary* theCurrentCam;

- (ConfigAccess *) initWithFile:(NSString *)fileName;

+ (NSURL *) urlForAction:(NSString*) baseUrl action:(NSString *) action;

+ (void) performAction:(NSString *)baseUrl action:(NSString *) action;

+ (ConfigAccess *) instance;

@end