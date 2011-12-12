/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Single Image View Or Slide Show
 * Function: This UIView that works in two modes: a selecetd one image that can
 *         : be deleted or a slide show mode which animates the saved snapshots.
 *         : (Header)
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

/*
 * UIView controller for displaying a single image or animating to simulate
 * slide show of the saved snapshots.
 */
@interface UISnapImageViewController : UIViewController 
{
    NSString* imagePath;
	IBOutlet UILabel *snapDate;
	IBOutlet UILabel *snapTime;
	IBOutlet UILabel *snapCamera;
	NSString *imageInfo;
}

@property (nonatomic, retain) NSString* imagePath;
@property (nonatomic, retain) UILabel *snapDate;
@property (nonatomic, retain) UILabel *snapTime;
@property (nonatomic, retain) UILabel *snapCamera;
@property (nonatomic, retain) NSString *imageInfo;

/*
 * Selector to handle delete image event. It will remove the snapshot from
 * the device.
 */
- (void) onDeleteImage:(id) sender;

/*
 * Selector to handle slide show done event. It will stop slide show animation
 * and return to the snapshots view.
 */
- (void) onDoneSlideShow:(id) sender;

@end
