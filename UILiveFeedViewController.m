//
//  UILiveFeedViewController.m
//  Sentinel
//
//  Created by SentinelTeam on 11/9/11.
//  Copyright 2011 Self. All rights reserved.
//

#import "UILiveFeedViewController.h"
#import "UIMainViewController.h"
#import "UISnapshotsViewController.h"
#import "ConfigAccess.h"
#import "SentinelInfo.h"
#import "EditInfoCameraView.h"
#import <CoreData/CoreData.h>
#import "AppDelegate_iPhone.h"
#import "DefaultCamera.h"

// This will be set from the core data when a user selects a camera. 
//static NSString* CURRENT_BASE_URL = @"http://128.238.151.253/";
//static NSString* CURRENT_BASE_URL = @"http://60.45.63.26";
//static NSString* CURRENT_BASE_URL = @"http://62.131.113.213:81";
static NSString* CURRENT_BASE_URL = @"http://96.242.83.3";

static double TIMEOUT_INTERVAL = 5.0;

@implementation UILiveFeedViewController

@synthesize context;
@synthesize contextDefaultCam;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
    }
    return self;
}

- (void)viewDidLoad 
{
	
	[theWebView setDelegate:self];
	
	
	//check if the user navigated here from the tableview
	
	AppDelegate_iPhone *appDelegate =
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	context = [appDelegate managedObjectContext];
	NSError *error;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"EditInfoCameraView" inManagedObjectContext:context];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	
	EditInfoCameraView *obj = [fetchedObjects objectAtIndex:0];
	NSNumber *index = [NSNumber numberWithInteger:[obj.cameraIndex intValue]];
	NSLog(@"UILiveFeedViewController viewDidLoad EditInfoCameraView.cameraIndex = %d", [index intValue]);
	[fetchRequest release];
	
	
	if([index intValue] == -1)
	{
		//The user may have selected a default camera. Find its index
		AppDelegate_iPhone *appDelegateDC =
			(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
		contextDefaultCam = [appDelegateDC managedObjectContext];
	
		NSError *error;
		NSFetchRequest *fetchRequestDC = [[NSFetchRequest alloc] init];
		NSEntityDescription *entityDC = [NSEntityDescription 
								   entityForName:@"DefaultCamera" inManagedObjectContext:contextDefaultCam];
	
		[fetchRequestDC setEntity:entityDC];
		[fetchRequestDC setReturnsObjectsAsFaults:NO];
	
		NSArray *fetchedObjectsDC = [contextDefaultCam executeFetchRequest:fetchRequestDC error:&error];
		
		if([fetchedObjects count] == 0)
		{
			//There is no default camera to!! Something fishy!! Go back to main view
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"Error!" 
								  message:@"Could not find any cameras[1]"
								  delegate:self
								  cancelButtonTitle:@"Back to Main Menu" 
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
			return;
		}
		
		DefaultCamera *defaultCameraObj = [fetchedObjectsDC objectAtIndex:0];
		index = [NSNumber numberWithInteger:[defaultCameraObj.isDefaultCamera intValue]];
		[fetchRequestDC release];
	}
	/*
	if(([fetchedObjectsDC count] > 0) && ([index intValue] != -1)) {
		
		UIBarButtonItem *item = [[UIBarButtonItem alloc]   
								 initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
								 target:self   
								 action:@selector(OnSnapshot:)];
		self.navigationItem.rightBarButtonItem = item; 
		[item release];
		
		NSLog(@"DefaultCamera selected: LiveFeed: %d",[index intValue]);
	}
	 */
	/*End: check for default camera and start live feed*/
	
	//else 
	{
		/*
		if([index intValue] == -1)
		{
			AppDelegate_iPhone *appDelegate =
				(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
			context = [appDelegate managedObjectContext];
	
			NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
			NSEntityDescription *entity = [NSEntityDescription 
						entityForName:@"EditInfoCameraView" inManagedObjectContext:context];
	
			[fetchRequest setEntity:entity];
			[fetchRequest setReturnsObjectsAsFaults:NO];
	
			NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	
			EditInfoCameraView *obj = [fetchedObjects objectAtIndex:0];
			index = [NSNumber numberWithInteger:[obj.cameraIndex intValue]];
			NSLog(@"UILiveFeedViewController viewDidLoad No Default Camera, index = %d", [index intValue]);
			[fetchRequest release];
		}
		else {
			NSLog(@"UILiveFeedViewController viewDidLoad Using default camera, index = %d", [index intValue]);
		}

		*/
		#ifdef DEBUG
		NSLog(@"UILiveFeedViewController: viewDidLoad index: %d", [index intValue]);
		#endif	
	
		fetchRequest = [[NSFetchRequest alloc] init];
		context = [appDelegate managedObjectContext];
		entity = [NSEntityDescription entityForName:@"SentinelInfo" 
						 inManagedObjectContext:context];
	
		[fetchRequest setEntity:entity];
		[fetchRequest setReturnsObjectsAsFaults:NO];
		
		fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
		[fetchRequest release];
		fetchRequest = nil;
	
		SentinelInfo *mo = [fetchedObjects objectAtIndex:[index intValue]];
		
		self.title = mo.cameraName;
	
		if(CURRENT_BASE_URL != mo.ipAddress)
		{
			[CURRENT_BASE_URL release];
			CURRENT_BASE_URL =  [[NSString alloc] 
								 initWithString:[NSString 
												 localizedStringWithFormat:
												 @"http://%@", mo.ipAddress]];
		}

		theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:CURRENT_BASE_URL] 	  
									cachePolicy:NSURLRequestUseProtocolCachePolicy						  
								timeoutInterval:TIMEOUT_INTERVAL];
	
		theConnection = [[NSURLConnection alloc] initWithRequest:theRequest 
                                                    delegate:self];
	
		UIBarButtonItem *item = [[UIBarButtonItem alloc]   
								 initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
								 target:self   
								 action:@selector(OnSnapshot:)];
		self.navigationItem.rightBarButtonItem = item; 
		[item release];
	
		[theWebView addSubview:tmpview];
	
		UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] 
									 initWithTitle:@"Main Menu" 
											style:UIBarButtonItemStylePlain
											target:self   
											action:@selector(mainMenu:)];
		self.navigationItem.leftBarButtonItem = leftitem;
		[leftitem release];
		
	}//else
	[super viewDidLoad];
}

-(void) OnViewSnapshotsClick:(id) sender
{
	UISnapshotsViewController *viewctr = [[UISnapshotsViewController alloc] 
                                          initWithNibName:@"UISnapshotsView" 
                                          bundle:nil];
    
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

-(void) mainMenu:(id)sender
{
	int count = [self.navigationController.viewControllers count];
	
	#ifdef DEBUG
	NSLog(@"UILiveFeedViewController: mainMenu: view stack count: %d", count);
	#endif
	
	if(count > 1)
    {
		[self.navigationController popToViewController:
			[self.navigationController.viewControllers objectAtIndex:0] 
			animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
	if([theWebView isLoading])
		[theWebView stopLoading];
	
}

-(void)viewWillAppear :(BOOL)animated
{	
	AppDelegate_iPhone *appDelegate =
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	context = [appDelegate managedObjectContext];
	
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
		entityForName:@"EditInfoCameraView" inManagedObjectContext:context];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	
	EditInfoCameraView *obj = [fetchedObjects objectAtIndex:0];
	NSNumber *index = [NSNumber numberWithInteger:[obj.cameraIndex intValue]];
	
	#ifdef DEBUG
	NSLog(@"UILiveFeedViewController: viewWillAppear index: %d", [index intValue]);
	#endif
	
	[fetchRequest release];
	fetchRequest = nil;
	
	//If the index = -1, the live view was navigated to because a default camera
	//was selected. Work with the default camera instead
	if([index intValue] == -1)
	{
		context = [appDelegate managedObjectContext];
		fetchRequest = [[NSFetchRequest alloc] init];
		entity = [NSEntityDescription 
				  entityForName:@"DefaultCamera" inManagedObjectContext:context];
		[fetchRequest setEntity:entity];
		[fetchRequest setReturnsObjectsAsFaults:NO];
		
		fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
		[fetchRequest release];
		if([fetchedObjects count] == 0)
		{
			//something terribly wrong has happened.
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"Error!" 
								  message:@"Could not find any cameras"
								  delegate:self
								  cancelButtonTitle:@"Back to Main Menu" 
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
			return;
		}
		DefaultCamera *dc = [fetchedObjects objectAtIndex:0];
		index = [NSNumber numberWithInteger:[dc.isDefaultCamera intValue]];
	}
	
	fetchRequest = [[NSFetchRequest alloc] init];
	context = [appDelegate managedObjectContext];
	
	entity = [NSEntityDescription entityForName:
			  @"SentinelInfo" inManagedObjectContext:context];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	
	SentinelInfo *mo = [fetchedObjects objectAtIndex:[index intValue]];
	
	if(CURRENT_BASE_URL != mo.ipAddress)
	{
		[CURRENT_BASE_URL release];
		CURRENT_BASE_URL =  [[NSString alloc] 
							 initWithString:[NSString localizedStringWithFormat:
											 @"http://%@", mo.ipAddress]];
	}
	
	NSURL *url = [ConfigAccess urlForAction:CURRENT_BASE_URL
                                     action:@"Default"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url 
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy						  
                                            timeoutInterval:TIMEOUT_INTERVAL];
	[theWebView loadRequest:requestObj];

	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainviewbg.png"]];
	
	#ifdef DEBUG
	NSLog(@"[Default]=%@", url);
	#endif
}

- (void)connection:(NSURLConnection *)connection
			didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge 
{
	if ([challenge previousFailureCount] == 0)
	{
		AppDelegate_iPhone *appDelegate =
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
		context = [appDelegate managedObjectContext];
		
		NSError *error;
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription 
				entityForName:@"EditInfoCameraView" inManagedObjectContext:context];
		
		[fetchRequest setEntity:entity];
		[fetchRequest setReturnsObjectsAsFaults:NO];
		
		NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
		
		EditInfoCameraView *obj = [fetchedObjects objectAtIndex:0];
		NSNumber *index = [NSNumber numberWithInteger:[obj.cameraIndex intValue]];
		
		#ifdef DEBUG
		NSLog(@"UILiveFeedViewController: didReceiveAuthenticationChallenge index: %d",
			[index intValue]);
		#endif	
		
		[fetchRequest release];
		fetchRequest = nil;
		
		fetchRequest = [[NSFetchRequest alloc] init];
		context = [appDelegate managedObjectContext];
		entity = [NSEntityDescription entityForName:@"SentinelInfo" 
							 inManagedObjectContext:context];
		
		[fetchRequest setEntity:entity];
		[fetchRequest setReturnsObjectsAsFaults:NO];
		
		fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
		
		SentinelInfo *mo = [fetchedObjects objectAtIndex:[index intValue]];
		[fetchRequest release];
		fetchRequest = nil;
		
		// Now authenticate the user
		NSURLCredential *newCredential;
		newCredential=[NSURLCredential credentialWithUser:mo.userName
				password:mo.password
				persistence:NSURLCredentialPersistenceForSession];
		
		[[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
        
		/*
		NSString *ipINnUrl = [NSString localizedStringWithFormat:
							  @"%@%@", @"http://", CURRENT_BASE_URL];
		*/
		NSString *ipINnUrl = [NSString localizedStringWithFormat:
							  @"%@", CURRENT_BASE_URL];
		
		NSURL *url = [ConfigAccess urlForAction:ipINnUrl
                                         action:@"Default"];
		
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url  
                                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                timeoutInterval:TIMEOUT_INTERVAL];
		[theWebView loadRequest:requestObj];
		
        if (DEBUG)
        {
            NSLog(@"[Default]=%@", url);
        }
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Authentication Failure" 
							  message:@"Invalid username/password."
							  delegate:self
							  cancelButtonTitle:@"Back to Main Menu" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	 int count = [self.navigationController.viewControllers count];
	 
	 #ifdef DEBUG
	 NSLog(@"UILiveFeedViewController: clickedButtonAtIndex: view stack count: %d", count);
	 #endif
	 
	 if(count > 1)
	 {
		 [self.navigationController popToViewController:
		  [self.navigationController.viewControllers objectAtIndex:0] animated:YES];
	 }
}

- (IBAction) onTiltScanClick: (id) sender
{
	[ConfigAccess performAction:CURRENT_BASE_URL action:@"TiltScan"];
}

- (IBAction) onPanScanClick: (id) sender
{
    [ConfigAccess performAction:CURRENT_BASE_URL action:@"PanScan"];
}

- (IBAction) onBrightnessDarker:(id) sender
{
    [ConfigAccess performAction:CURRENT_BASE_URL action:@"BrightnessDarker"];
}

- (IBAction) onBrightnessReset:(id) sender
{
    [ConfigAccess performAction:CURRENT_BASE_URL action:@"BrightnessReset"];
}

- (IBAction) onBrightnessBrighter:(id) sender
{
    [ConfigAccess performAction:CURRENT_BASE_URL action:@"BrightnessBrighter"];
}


- (IBAction) OnNightModeSwitch: (id) sender
{
	UISwitch *nightSwitch = (UISwitch *) sender;

	if ([nightSwitch isOn] )
	{
        [ConfigAccess performAction:CURRENT_BASE_URL action:@"NightModeOn"];
	}
	else 
	{
        [ConfigAccess performAction:CURRENT_BASE_URL action:@"NightModeOff"];
	}
}

- (IBAction) OnAlarmClick: (id) sender
{
    [ConfigAccess performAction:CURRENT_BASE_URL action:@"Sound"];
}

- (IBAction) OnSnapshot: (id) sender
{
    UIAlertView *alert;
    
	alert = [[UIAlertView alloc] initWithTitle:@"Saving Snapshot"
                                       message:nil
                                      delegate:nil
                             cancelButtonTitle:nil
                             otherButtonTitles:nil];
	[alert show];
	
	
	UIActivityIndicatorView *indicator = 
        [[UIActivityIndicatorView alloc] 
        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	indicator.center = CGPointMake(alert.bounds.size.width / 2, 
                                   alert.bounds.size.height - 50);
	[indicator startAnimating];
	[alert addSubview:indicator];
	[alert dismissWithClickedButtonIndex:0 animated:YES];
	[indicator release];
	[alert release];

	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"yyyyMMMdd_HH_mm_ss"];
	
	NSDate *now = [NSDate date];
	
	NSString *dateString = [format stringFromDate:now];
    
	NSURL *url = [ConfigAccess urlForAction:CURRENT_BASE_URL 
                                     action:@"Snapshot"];
	NSData *data = [NSData dataWithContentsOfURL:url];
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                          NSUserDomainMask, 
                                                          YES)
                      objectAtIndex:0];

	NSString *str = [[NSString alloc] initWithFormat:@"/%@.jpg", dateString];
	path = [path stringByAppendingString:str];
	[str release];
	
	[data writeToFile:path atomically:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    static int STOPPED_LOAD_CODE = -999;
    
    if ([error code] != STOPPED_LOAD_CODE)
    {
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"Connection Error!" 
                              message:@"Camera is not available" 
                              delegate:self 
                              cancelButtonTitle:@"OK" 
                              otherButtonTitles: nil];
        [alert setDelegate:self];
        [alert show];
        [alert release];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
#ifdef DEBUG
    NSLog(@"WebView loading started.");
#endif
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
#ifdef DEBUG
    NSLog(@"WebView finished loading.");
#endif
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

- (void)dealloc 
{
    [super dealloc];
}

@end


@implementation SentinelTouchView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	CGPoint startLocation = [(UITouch*)[touches anyObject] locationInView:self];
	
	double x = startLocation.x;
	double y = startLocation.y;
	
	NSLog(@"%f %f", x, y);
	
	if(x >= 100 && x <= 210 && y >= 80 && y <= 160)
	{
		[self homePosition];
	}
	
	if (y >= 0 && y <= 80)
	{
		[self tiltUp];
	}
	else if(y >= 160 && y <= 240)
	{
		[self tiltDown];
	}
	
	if (x >= 0 & x <= 110)
	{
		[self PanLeft];
	}
	else if(x >= 210 && x <= 320)
	{
		[self PanRight];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	CGPoint startLocation = [(UITouch*)[touches anyObject] locationInView:self];
	
	double x = startLocation.x;
	double y = startLocation.y;
	
	NSLog(@"Ended: %f %f", x, y);
}

- (void) homePosition
{
    [ConfigAccess performAction:CURRENT_BASE_URL action:@"HomePosition"];
}

- (void) tiltUp
{
    [ConfigAccess performAction:CURRENT_BASE_URL action:@"TiltUp"];
}

- (void) tiltDown
{
    [ConfigAccess performAction:CURRENT_BASE_URL action:@"TiltDown"];
}

- (void) PanLeft
{
    [ConfigAccess performAction:CURRENT_BASE_URL action:@"PanLeft"];
}

- (void) PanRight
{
    [ConfigAccess performAction:CURRENT_BASE_URL action:@"PanRight"];
}

@end
