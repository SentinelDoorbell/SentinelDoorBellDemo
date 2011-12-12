/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Main
 * Function: Entry Point of the application (Implementation)
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

#import <UIKit/UIKit.h>
#import "ConfigAccess.h"

int main(int argc, char *argv[]) {
   
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
