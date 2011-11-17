//
//  AppDelegate_iPhone.m
//  navS
//
//  Created by Researcher on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "UIMainViewController.h"
#import <coreData/CoreData.h>

@implementation AppDelegate_iPhone

@synthesize managedObjectContext;

#pragma mark -
#pragma mark Application lifecycle

- (NSManagedObjectContext *)managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }

	NSArray *paths = 
		NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *basePath = ([paths count] >0) ? 
		[paths objectAtIndex:0] : nil;
	NSURL *storeUrl = [NSURL fileURLWithPath:
		[basePath stringByAppendingPathComponent:@"Sentinel.sqlite"]];
	NSError *error; 
	
	NSPersistentStoreCoordinator *persistentStoreCoordinator = 
		[[NSPersistentStoreCoordinator alloc]
		initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
		[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
		[NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
	
	if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType 
									configuration:nil URL:storeUrl
									options:options error:&error])
	{
		NSLog(@"Error loading persistent store...");
	}
	
	managedObjectContext = [[NSManagedObjectContext alloc]init];
	[managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];

	#ifdef DEBUG
	{
		NSLog(@"Context allocated in delegate %@", managedObjectContext);
	}
	#endif
	
	return managedObjectContext;
}

- (BOOL)application:(UIApplication *)application 
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
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

