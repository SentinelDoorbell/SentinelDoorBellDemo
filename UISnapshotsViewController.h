//
//  UISnapshotsViewController.h
//  Sentinel
//
//  Created by SentinelTeam on 11/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

// Forward declaration
@class UISnapshotImageButton;

@interface UISnapshotsViewController : UITableViewController 
{
    NSArray*  theSnapshotsArray;
    
    NSString* theSnapshotsRootDir;
    
}

@property (retain) NSArray* theSnapshotsArray;

@property (retain) NSString* theSnapshotsRootDir; 

- (void) loadSnapshotsArray;

- (void) onImageClick:(id) sender;

- (void) onSlideShowClick:(id) sender;

@end

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

@interface UISnapshotImageButton : UIButton
{
    NSString* imagePath;
}

@property (nonatomic, retain) NSString* imagePath;

@end