//
//  view0.m
//  navS
//
//  Created by Researcher on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIMainViewController.h"
#import "UISelectCamViewController.h"
#import "UIConfigCamViewController.h"
#import "UIDefaultCameraViewController.h"
#import "UISnapshotsViewController.h"

@implementation UIMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) 
    {
		self.title = @"Sentinel";
    }

	self.navigationItem.leftBarButtonItem = nil;
    return self;
}

- (IBAction) selectCameraFromListPressed:(id)sender
{
	UISelectCamViewController *viewctr = [[UISelectCamViewController alloc] 
                                          initWithNibName:@"UISelectCamView" 
                                          bundle:nil];

	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

- (IBAction) configureCameraPressed:(id)sender
{
	UIConfigCamViewController *viewctr = [[UIConfigCamViewController alloc] 
                                          initWithNibName:@"UIConfigCamView" 
                                          bundle:nil];
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

- (IBAction) setDefaultCamera:(id)sender
{
	UIDefaultCameraViewController *viewctr = [[UIDefaultCameraViewController alloc] 
                                              initWithNibName:@"UIDefaultCameraView" 
                                              bundle:nil];
    
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

- (IBAction) viewSnapshots:(id)sender
{
	UISnapshotsViewController *viewctr = [[UISnapshotsViewController alloc] 
                                          initWithNibName:@"UISnapshotsView" 
                                          bundle:nil];
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
}

- (void)dealloc 
{
    [super dealloc];
}

@end
