//
//  UISnapImageViewController.h
//  Sentinel
//
//  Created by Fekri Kassem on 11/19/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>


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

- (void) onDeleteImage:(id) sender;

- (void) onDoneSlideShow:(id) sender;

@end
