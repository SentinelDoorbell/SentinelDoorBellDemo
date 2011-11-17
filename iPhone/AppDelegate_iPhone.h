//
//  AppDelegate_iPhone.h
//  Sentinel
//
//  Created by SentinelTeam on 11/9/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate_Shared.h"

@interface AppDelegate_iPhone : AppDelegate_Shared {
	UINavigationController *navctr;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end