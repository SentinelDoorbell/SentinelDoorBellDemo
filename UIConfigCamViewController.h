/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Config Camera View
 * Function: Table view with a list of all the cameras configured. It is used 
 *         : for modifying exiting configuration, adding new cameras or deleting 
 *         : existing ones. (Header)
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
#import <CoreData/CoreData.h>

/*
 * Table that is populated by the list of the camera configured. It allows
 * the user to select a camera for modifying its configuration or deleting it
 * It also allows the user to add configuration of new camera.
 */
@interface UIConfigCamViewController : UITableViewController {
	IBOutlet UITableView *camList;
	NSMutableArray *camArr;
	NSManagedObjectContext *context;
	NSManagedObjectContext *contextnew;
	NSManagedObjectContext *contextDefaultCam;
}

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSManagedObjectContext *contextnew;
@property (nonatomic, retain) NSManagedObjectContext *contextDefaultCam;

/*
 * Selector to handle when the user class the navigation add camera button.
 * It will replace the current view with the edit configuration view.
 */
- (void)addCamera:(id)sender;

@end
