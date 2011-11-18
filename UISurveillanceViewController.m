//
//  UISurveillanceViewController.m
//  Sentinel
//
//  Created by Guest Account on 11/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UISurveillanceViewController.h"
#import "AppDelegate_iPhone.h"
#import <CoreData/CoreData.h>
#import "SentinelInfo.h"
#import "EditInfoCameraView.h"
#import "ConfigAccess.h"

static NSString* CURRENT_BASE_URL;

@implementation UISurveillanceViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Surveillance Mode";	
	
	AppDelegate_iPhone *appDelegate =
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	context = [appDelegate managedObjectContext];
	
	NSError *error;
	NSFetchRequest *fetchRequest;
	NSEntityDescription *entity;
	NSArray *fetchedObjects;
	
	fetchRequest = [[NSFetchRequest alloc] init];
	context = [appDelegate managedObjectContext];
	entity = [NSEntityDescription entityForName:@"SentinelInfo" 
						 inManagedObjectContext:context];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	[fetchRequest release];
	fetchRequest = nil;
	
	CURRENT_BASE_URL = @"";
	
	int surCamIndex = 0;
	int max_cams = 4;
	
	for(SentinelInfo *mo in fetchedObjects)
	{
		if(surCamIndex >= max_cams)
			break;
		
		if(CURRENT_BASE_URL != @"")
		{
			[CURRENT_BASE_URL release];
		}

		CURRENT_BASE_URL =  [[NSString alloc] 
							 initWithString:[NSString 
							 localizedStringWithFormat:
							 @"http://%@", mo.ipAddress]];
		
		theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:CURRENT_BASE_URL] 	  
								cachePolicy:NSURLRequestUseProtocolCachePolicy						  
								timeoutInterval:60.0];
	
		if(surCamIndex == 0)
			theConnection1 = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
		else if(surCamIndex == 1)
			theConnection2 = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
		else if(surCamIndex == 2)
			theConnection3 = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
		else if(surCamIndex == 3)
			theConnection4 = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
		
		surCamIndex++;
	}
}


-(void)viewWillAppear :(BOOL)animated
{	
	AppDelegate_iPhone *appDelegate =
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	context = [appDelegate managedObjectContext];
	
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity;
	NSArray *fetchedObjects;

	entity = [NSEntityDescription entityForName:
			  @"SentinelInfo" inManagedObjectContext:context];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	CURRENT_BASE_URL = @"";
	
	int surCamIndex = 0;
	int max_cams = 4;
	
	for	(SentinelInfo *mo in fetchedObjects)
	{
		if(surCamIndex >= max_cams)
			break;

		if(CURRENT_BASE_URL != @"")
		{
			[CURRENT_BASE_URL release];
		}
		CURRENT_BASE_URL =  [[NSString alloc] 
							 initWithString:[NSString localizedStringWithFormat:
											 @"http://%@", mo.ipAddress]];

		NSURL *url = [ConfigAccess urlForAction:CURRENT_BASE_URL
                                     action:@"Default"];
	
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
		
		if(surCamIndex == 0)
		{
			theWebView1.hidden = NO;
			cam1Label.hidden = NO;
			cam1Label.text = mo.cameraName;
			[theWebView1 loadRequest:requestObj];
		}
		else if(surCamIndex == 1)
		{
			theWebView2.hidden = NO;
			cam2Label.hidden = NO;
			cam2Label.text = mo.cameraName;
			[theWebView2 loadRequest:requestObj];
		}
		else if(surCamIndex == 2)
		{
			theWebView3.hidden = NO;
			cam3Label.hidden = NO;
			cam3Label.text = mo.cameraName;
			[theWebView3 loadRequest:requestObj];
		}
		else if(surCamIndex == 3)
		{
			theWebView4.hidden = NO;
			cam4Label.hidden = NO;
			cam4Label.text = mo.cameraName;
			[theWebView4 loadRequest:requestObj];
		}
		#ifdef DEBUG
		NSLog(@"[Default]=%@", url);
		#endif
		
		for(int i = 3; i >= [fetchedObjects count]; i--)
		{
			if(i == 0)
			{
				cam1Label.hidden = YES;
				theWebView1.hidden = YES;
			}
			else if(i == 1)
			{
				cam2Label.hidden = YES;
				theWebView2.hidden = YES;
			}
			else if(i == 2)
			{
				cam3Label.hidden = YES;
				theWebView3.hidden = YES;
			}
			else if(i == 3)
			{
				cam4Label.hidden = YES;
				theWebView4.hidden = YES;
			}
		}

		surCamIndex++;
	}
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainviewbg.png"]];
	
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
		NSEntityDescription *entity;
		NSArray *fetchedObjects;
		
		entity = [NSEntityDescription entityForName:@"SentinelInfo" 
							 inManagedObjectContext:context];
		
		[fetchRequest setEntity:entity];
		[fetchRequest setReturnsObjectsAsFaults:NO];
		
		fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];

		CURRENT_BASE_URL = @"";
		
		int surCamIndex = 0;
		int max_cams = 4;
		
		for(SentinelInfo *mo in fetchedObjects)
		{
			if(surCamIndex >= max_cams)
				break;
			
			if(CURRENT_BASE_URL != @"")
			{
				[CURRENT_BASE_URL release];
			}
			CURRENT_BASE_URL =  [[NSString alloc] 
								 initWithString:[NSString localizedStringWithFormat:
												 @"http://%@", mo.ipAddress]];
			
			// Now authenticate the user
			NSURLCredential *newCredential;
			newCredential=[NSURLCredential credentialWithUser:mo.userName
												 password:mo.password
											  persistence:NSURLCredentialPersistenceForSession];
		
			[[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
        
			NSString *ipINnUrl = [NSString localizedStringWithFormat:
							  @"%@", CURRENT_BASE_URL]; 
		
			NSURL *url = [ConfigAccess urlForAction:ipINnUrl 
                                         action:@"Default"];
		
			NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
			if(surCamIndex == 0)
				[theWebView1 loadRequest:requestObj];
			else if(surCamIndex == 1)
				[theWebView2 loadRequest:requestObj];
			else if(surCamIndex == 2)
				[theWebView3 loadRequest:requestObj];
			else if(surCamIndex == 3)
				[theWebView4 loadRequest:requestObj];
			
			surCamIndex++;
		
			if (DEBUG)
			{
				NSLog(@"[Default]=%@", url);
			}
		}
			
		[fetchRequest release];
		fetchRequest = nil;
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

-(void)viewWillDisappear:(BOOL)animated
{
	if([theWebView1 isLoading])
		[theWebView1 stopLoading];
	
	if([theWebView2 isLoading])
		[theWebView2 stopLoading];

	if([theWebView3 isLoading])
		[theWebView3 stopLoading];
	
	if([theWebView4 isLoading])
		[theWebView4 stopLoading];
}

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
