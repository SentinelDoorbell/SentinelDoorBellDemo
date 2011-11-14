//
//  configureCamera.h
//  navS
//
//  Created by Researcher on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIConfigCamViewController : UITableViewController {
	IBOutlet UITableView *camList;
	NSMutableArray *camArr;
}

- (void)saveCredentials:(id)sender;

@end
