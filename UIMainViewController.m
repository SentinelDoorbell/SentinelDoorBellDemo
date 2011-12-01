//
//  UIMainViewController.m
//  Sentinel
//
//  Created by SentinelTeam on 11/9/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "UIMainViewController.h"
#import "UISelectCamViewController.h"
#import "UIConfigCamViewController.h"
#import "UIDefaultCameraViewController.h"
#import "UISnapshotsViewController.h"
#import "UISurveillanceViewController.h"
#import "AppDelegate_iPhone.h"
#import "DefaultCamera.h"
#import "UILiveFeedViewController.h"
#import	"TutorialViewController.h"
#import "AboutViewController.h"

static UILabel *toolTipGlobal;
CGRect myFrame;

@implementation UIMainViewController

@synthesize contextDefaultCam;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) 
    {
		self.title = @"Sentinel";
    }


	UIBarButtonItem *item = [[UIBarButtonItem alloc]   
							 initWithTitle:@"Tutorial" 
							 style:UIBarButtonSystemItemDone target:self action:@selector(tutorialPressed:)];
	self.navigationItem.rightBarButtonItem = item; 
	[item release];
	
	item = [[UIBarButtonItem alloc]   
							 initWithTitle:@"About" 
			style:UIBarButtonSystemItemDone target:self action:@selector(aboutPressed:)];
	self.navigationItem.leftBarButtonItem = item; 
	[item release];
	
    return self;
}

- (void) tutorialPressed:(id)sender
{
	NSLog(@"Tutorial");
	TutorialViewController *tutorialController = [[TutorialViewController alloc] init];
	
	[UIView  beginAnimations:@"Showinfo" context: nil];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.75];
	[self.navigationController pushViewController:tutorialController animated:NO];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:NO];
	[UIView commitAnimations];
	
	//[self.navigationController pushViewController:tutorialController animated:YES];
	[tutorialController release];
}

- (void) aboutPressed:(id)sender
{
	NSLog(@"About");
	
	AboutViewController *aboutController = [[AboutViewController alloc] init];
	
	[UIView  beginAnimations:@"Showinfo" context: nil];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.75];
	[self.navigationController pushViewController:aboutController animated:NO];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:NO];
	[UIView commitAnimations];
	
	
	//[self.navigationController pushViewController:aboutController animated:YES];
	[aboutController release];
}

- (IBAction) selectCameraFromListPressed:(id)sender
{
	//validate camera name
	AppDelegate_iPhone *appDelegate =
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	contextDefaultCam = [appDelegate managedObjectContext];
	
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"SentinelInfo" inManagedObjectContext:contextDefaultCam];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [contextDefaultCam executeFetchRequest:fetchRequest error:&error];
	[fetchRequest release];
	
	if([fetchedObjects count] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"No Cameras found" 
							  message:@"Select the 'Configure' button and\nadd a camera"
							  delegate:self
							  cancelButtonTitle:@"Ok" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	
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
	AppDelegate_iPhone *appDelegate =
	(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	contextDefaultCam = [appDelegate managedObjectContext];
	
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"SentinelInfo" inManagedObjectContext:contextDefaultCam];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [contextDefaultCam executeFetchRequest:fetchRequest error:&error];
	[fetchRequest release];
	
	if([fetchedObjects count] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"No Cameras found" 
							  message:@"Select the 'Configure' button and\nadd a camera"
							  delegate:self
							  cancelButtonTitle:@"Ok" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	
	UISurveillanceViewController *viewctr = [[UISurveillanceViewController alloc] 
                                          initWithNibName:@"UISurveillanceView" 
                                          bundle:nil];
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

- (void)viewDidLoad 
{
	[super viewDidLoad];
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
	
	/*test: vijay - begin*/
	AppDelegate_iPhone *appDelegate =
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	contextDefaultCam = [appDelegate managedObjectContext];
	
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"DefaultCamera" inManagedObjectContext:contextDefaultCam];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [contextDefaultCam executeFetchRequest:fetchRequest error:&error];
	
	/*Check for Default Camera*/	
	
	if([fetchedObjects count] == 0) {
		NSLog(@"MainView DefaultCamera Empty");
		
		DefaultCamera *mo = 
		[NSEntityDescription insertNewObjectForEntityForName:@"DefaultCamera"
									  inManagedObjectContext:contextDefaultCam];
		
		[mo setValue:[NSNumber numberWithInt:-1] forKey:@"isDefaultCamera"];
		
	}
	
	else {
		
		DefaultCamera *defaultCameraObj = [fetchedObjects objectAtIndex:0];
		
		NSNumber *currentDefaultCamera = [NSNumber numberWithInteger:[defaultCameraObj.isDefaultCamera intValue]];
		
		if([currentDefaultCamera intValue] == -1) {
			NSLog(@"DefaultCamera not set: MainView: %d",[currentDefaultCamera intValue]);
		}
		
		else if([currentDefaultCamera intValue] > -1) {
			NSLog(@"DefaultCamera is set: MainView: %d",[currentDefaultCamera intValue]);
			
			UILiveFeedViewController *viewctr = [[UILiveFeedViewController alloc] 
												 initWithNibName:@"UILiveFeedView" 
												 bundle:nil];
			[self.navigationController pushViewController:viewctr animated:YES];
			[viewctr release];
		}
	}
	
	//DefaultCamera *defaultCameraObj = [fetchedObjects objectAtIndex:0];
	/*End: Check for Default Camera*/
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
