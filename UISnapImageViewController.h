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
}

@property (nonatomic, retain) NSString* imagePath;

- (void) onDeleteImage:(id) sender;

@end
