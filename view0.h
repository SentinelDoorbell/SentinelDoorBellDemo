//
//  view0.h
//  navS
//
//  Created by Researcher on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface view0 : UIViewController {

	IBOutlet UIButton *selectCameraFromList;
	IBOutlet UIButton *configureCamera;
	IBOutlet UIButton *setDefaultCamera;
	IBOutlet UIButton *viewSnapshots;
}

- (IBAction) selectCameraFromListPressed:(id)sender;
- (IBAction) configureCameraPressed:(id)sender;
- (IBAction) setDefaultCamera:(id)sender;
- (IBAction) viewSnapshots:(id)sender;

@end
