//
//  UISelectCamViewController.h
//  Sentinel
//
//  Created by SentinelTeam on 11/9/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface UISelectCamViewController : UITableViewController {

	IBOutlet UITableView *camList;
	NSMutableArray *camArr;
	NSManagedObjectContext *context;
}

@property (nonatomic, retain) NSManagedObjectContext *context;

@end
