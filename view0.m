//
//  view0.m
//  navS
//
//  Created by Researcher on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "view0.h"
#import "viewSelectCamera.h"
#import "configureCamera.h"
#import "defaultCamera.h"
#import "viewSnapshots.h"

@implementation view0

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = @"Sentinel";
    }
	self.navigationItem.leftBarButtonItem = nil;
    return self;
}

- (IBAction) selectCameraFromListPressed:(id)sender
{
	viewSelectCamera *viewctr = [[viewSelectCamera alloc] initWithNibName:@"viewSelectCamera" bundle:nil];
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

- (IBAction) configureCameraPressed:(id)sender
{
	configureCamera *viewctr = [[configureCamera alloc] initWithNibName:@"configureCamera" bundle:nil];
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

- (IBAction) setDefaultCamera:(id)sender
{
	defaultCamera *viewctr = [[defaultCamera alloc] initWithNibName:@"defaultCamera" bundle:nil];
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

- (IBAction) viewSnapshots:(id)sender
{
	viewSnapshots *viewctr = [[viewSnapshots alloc] initWithNibName:@"viewSnapshots" bundle:nil];
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
