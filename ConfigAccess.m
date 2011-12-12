/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Configuration Access
 * Function: This is a singleton object that is shared by all the components in 
 *         : the application. It reads xml file which has the configurations for
 *         : camera models supported by the app. (Implementation)
 *
 * Modifications
 * 
 * Date   : December 2011
 * Change : New file
 * Author : SentinelTeam
 *
 * Date   :
 * Change :
 * Author :
 *
 */

#import "ConfigAccess.h"


@implementation ConfigAccess

@synthesize theDctRoot;
@synthesize theCurrentCam;


- (ConfigAccess *) initWithFile:(NSString *)fileName
{
    self = [super init];
    
    if (self)
    {
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"CamModels" 
                                                              ofType:@"plist"];
        self.theDctRoot = [NSDictionary dictionaryWithContentsOfFile:filePath];

        if ([theDctRoot retainCount] > 0)
        {
            // Set the current camera to bet the first one in the list;
            id key = [[theDctRoot allKeys] objectAtIndex:0];
            self.theCurrentCam = [theDctRoot  objectForKey:key];
        }
    }
    
    return self;
}

+ (ConfigAccess *) instance
{
    static ConfigAccess *theConfigAccess;
    
    @synchronized(self)
    {
        if (!theConfigAccess) 
        {
            theConfigAccess = [[ConfigAccess alloc] initWithFile:@"CamModels"];
        }
        
        return theConfigAccess;
    }
}

+ (NSURL *) urlForAction:(NSString *) baseUrl action:(NSString *) action
{
    NSString* url = baseUrl;
    
    if ([[ConfigAccess instance] theCurrentCam])
    {
        NSString* subUrl = [[[ConfigAccess instance] theCurrentCam] 
                            objectForKey:action];

        if (subUrl)
        {
            url = [url stringByAppendingString:subUrl];
        }
    }

    return [NSURL URLWithString:url];
}

+ (void) performAction:baseUrl action:(NSString *) action
{    
    NSURL *url = [ConfigAccess urlForAction:baseUrl action:action];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    NSURLConnection* connection = [[NSURLConnection alloc]
                                   initWithRequest:requestObj 
                                   delegate:nil
                                   startImmediately:YES];
    
    [connection release];
    
    if (DEBUG)
    {
        NSLog(@"[%@]=%@", action, url);
    }
}

- (void) dealloc
{
    [theCurrentCam dealloc];
    [theDctRoot dealloc];
    [super dealloc];
}

@end