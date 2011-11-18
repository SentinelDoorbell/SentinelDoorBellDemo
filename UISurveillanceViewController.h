//
//  UISurveillanceViewController.h
//  Sentinel
//
//  Created by Guest Account on 11/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface UISurveillanceViewController : UIViewController
{
	IBOutlet UIWebView *theWebView1;
	IBOutlet UIWebView *theWebView2;
	IBOutlet UIWebView *theWebView3;
	IBOutlet UIWebView *theWebView4;
	NSManagedObjectContext *context;

	NSURLConnection *theConnection1;
	NSURLConnection *theConnection2;
	NSURLConnection *theConnection3;
	NSURLConnection *theConnection4;
	
	NSURLRequest *theRequest;
	
	IBOutlet UILabel *cam1Label;
	IBOutlet UILabel *cam2Label;
	IBOutlet UILabel *cam3Label;
	IBOutlet UILabel *cam4Label;
}

@end
