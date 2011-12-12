/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Camera Selection View
 * Function: UIView with a table of all the camera configured and available
 *         : for live streaming. Selecting a camera will take the user to
 *         : to the live view. (Header)
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
 * Table view that is populated with the list of cameras availabe for viewing
 * their live streams. 
 */
@interface UISelectCamViewController : UITableViewController {

	IBOutlet UITableView *camList;
	NSMutableArray *camArr;
	NSManagedObjectContext *context;
}

@property (nonatomic, retain) NSManagedObjectContext *context;

@end
