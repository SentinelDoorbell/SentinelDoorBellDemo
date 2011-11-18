//
//  UIMainViewController.m
//  Sentinel
//
//  Created by SentinelTeam on 11/9/11.
//  Copyright 2011 Self. All rights reserved.
//

#import "UIMainViewController.h"
#import "UISelectCamViewController.h"
#import "UIConfigCamViewController.h"
#import "UIDefaultCameraViewController.h"
#import "UISnapshotsViewController.h"
#import "UISurveillanceViewController.h"

static UILabel *toolTipGlobal;
CGRect myFrame;

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

- (IBAction) surveillancePressed:(id)sender
{
	UISurveillanceViewController *viewctr = [[UISurveillanceViewController alloc] 
                                          initWithNibName:@"UISurveillanceView" 
                                          bundle:nil];
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

- (void)viewDidLoad 
{
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainviewbg.png"]];
	
	UINavigationBar *navBar = [self.navigationController navigationBar];
    [navBar setTintColor:kSCNavBarColor];
	
	/*
	UIImageView *imageView = (UIImageView *)[navBar viewWithTag:kSCNavBarImageTag];
	if (imageView == nil)
	{
		imageView = [[UIImageView alloc] initWithImage:
					 [UIImage imageNamed:@"mainviewbg.png"]];
		[imageView setTag:kSCNavBarImageTag];
		[navBar insertSubview:imageView atIndex:0];
		[imageView release];
	}
	*/
    [super viewDidLoad];
}

-(void)viewWillAppear :(BOOL)animated
{
	tooltip.hidden = YES;
	toolTipGlobal = tooltip;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
}

- (void)infoSelectCamPressed:(id)sender
{
	tooltip.hidden = NO;
	[tooltip setText:@"Select and View live feed from preconfigured camera"];
	
	CGRect frame = CGRectMake(20, infoSelectCam.frame.origin.y+20, 280, 100);
	tooltip.frame = frame;
}

- (void)infoConfigCamPressed:(id)sender
{
	tooltip.hidden = NO;
	[tooltip setText:@"Add/Delete/Update camera camera configuration"];
	
	CGRect frame = CGRectMake(20, infoConfigCam.frame.origin.y+20, 280, 100);
	tooltip.frame = frame;
}

- (void)infoDefaultCamPressed:(id)sender
{
	tooltip.hidden = NO;
	[tooltip setText:@"Select a camera to be the default camera. Live feed from this camera will be displayed directly henceforth"];
	CGRect frame = CGRectMake(20, infoDefaultCam.frame.origin.y-100, 280, 100);
	tooltip.frame = frame;
}

- (void)infoSnapShotPressed:(id)sender
{
	tooltip.hidden = NO;
	[tooltip setText:@"View all snapshots"];
	
	CGRect frame = CGRectMake(20, infoSnapShot.frame.origin.y+20, 280, 100);
	tooltip.frame = frame;
}

- (void)infoSurveillancePressed:(id)sender
{
	tooltip.hidden = NO;
	[tooltip setText:@"View live feed from the first four cameras (if present) in the camera list simultaneously"];
	
	CGRect frame = CGRectMake(20, infoSurveillance.frame.origin.y - 100, 280, 100);
	tooltip.frame = frame;
}

- (void)dealloc 
{
    [super dealloc];
}

@end

@implementation ToolTipExit
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	CGPoint startLocation = [(UITouch*)[touches anyObject] locationInView:self];
	
	double x = startLocation.x;
	double y = startLocation.y;
	
	NSLog(@"%f %f", x, y);
	
	toolTipGlobal.text = @"";
	toolTipGlobal.hidden = YES;
}
@end
