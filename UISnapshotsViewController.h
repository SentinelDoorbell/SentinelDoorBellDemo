/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Snapshots View
 * Function: Table view with a list of all the snapshots taken. It allow the 
 *         : user to select and view single image which they can delete. It 
 *         : also supports slide show. (Header)
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

// Forward declaration
@class UISnapshotImageButton;

/*
 * Table view which is populated using the snapshots taken and saved. Each
 * row cell is a three pictures that the user can interact with.
 */
@interface UISnapshotsViewController : UITableViewController 
{
    NSArray*  theSnapshotsArray;
    
    NSString* theSnapshotsRootDir;
    
}

@property (retain) NSArray* theSnapshotsArray;

@property (retain) NSString* theSnapshotsRootDir; 

/*
 * Scans and populates the instance variable array with the all saved images.
 */
- (void) loadSnapshotsArray;

/*
 * Selector to handle when a snapshot view is clicked. It will replace the
 * current view with a single max image view. 
 */
- (void) onImageClick:(id) sender;

/*
 * Selector to handle when slide show button is pressed. It will replace the 
 * current view with a view that starts a slide show of all the snapshots.
 */
- (void) onSlideShowClick:(id) sender;

@end


/*
 * Represents a single table row cell which has three images.
 */
@interface UISnapshotViewCell : UITableViewCell 
{    
    IBOutlet UISnapshotImageButton* imageButton1;
    IBOutlet UISnapshotImageButton* imageButton2;
    IBOutlet UISnapshotImageButton* imageButton3;
}

@property (nonatomic, retain) UISnapshotImageButton* imageButton1;
@property (nonatomic, retain) UISnapshotImageButton* imageButton2;
@property (nonatomic, retain) UISnapshotImageButton* imageButton3;


@end

/*
 * Extends the UIButton to help with saving the selected image path in case of 
 * max or delete.
 */
@interface UISnapshotImageButton : UIButton
{
    NSString* imagePath;
}

@property (nonatomic, retain) NSString* imagePath;

@end