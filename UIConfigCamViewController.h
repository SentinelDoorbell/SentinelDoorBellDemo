//
//  UIConfigCameraViewController.h
//  Sentinel
//
//  Created by SentinelTeam on 11/9/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface UIConfigCamViewController : UITableViewController {
	IBOutlet UITableView *camList;
	NSMutableArray *camArr;
	NSManagedObjectContext *context;
	NSManagedObjectContext *contextnew;
	NSManagedObjectContext *contextDefaultCam;
}

- (void)saveCredentials:(id)sender;

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSManagedObjectContext *contextnew;
@property (nonatomic, retain) NSManagedObjectContext *contextDefaultCam;

@end
