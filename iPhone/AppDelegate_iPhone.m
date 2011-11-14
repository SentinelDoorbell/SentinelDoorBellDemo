//
//  AppDelegate_iPhone.m
//  navS
//
//  Created by Researcher on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "UIMainViewController.h"

@implementation AppDelegate_iPhone


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	navctr = [[UINavigationController alloc] init];
	UIMainViewController *myview = [[UIMainViewController alloc] 
                                    initWithNibName:@"UIMainView" 
                                    bundle:nil];

	[navctr pushViewController:myview animated:NO];
	[myview release];
	[self.window addSubview:navctr.view];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application 
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application 
{
	[super applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application 
{
}


- (void)applicationDidBecomeActive:(UIApplication *)application 
{

}

- (void)applicationWillTerminate:(UIApplication *)application 
{
	[super applicationWillTerminate:application];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
    [super applicationDidReceiveMemoryWarning:application];
}


- (void)dealloc 
{
	[super dealloc];
}


@end

