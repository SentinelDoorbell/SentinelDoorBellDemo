//
//  UISnapshotsViewController.h
//  Sentinel
//
//  Created by SentinelTeam on 11/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UISnapshotsViewController : UITableViewController 
{
    NSArray*  theSnapshotsArray;
    
    NSString* theSnapshotsRootDir;
    
}

@property (retain) NSArray* theSnapshotsArray;

@property (retain) NSString* theSnapshotsRootDir; 

- (void) loadSnapshotsArray;

@end


@interface UISnapshotViewCell : UITableViewCell 
{
    //UIImageView *imageView;
    
    IBOutlet UIImageView* imageView1;
    IBOutlet UIImageView* imageView2;
    IBOutlet UIImageView* imageView3;
}

@property (nonatomic, retain) UIImageView* imageView1;
@property (nonatomic, retain) UIImageView* imageView2;
@property (nonatomic, retain) UIImageView* imageView3;

@end