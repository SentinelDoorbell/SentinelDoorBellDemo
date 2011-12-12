/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Surveillance View Controller
 * Function: UIView that allows users to view live stream from more than one 
 *         : at the same time. (Header)
 *
 * Modifications
 * 
 * Date   : December 2011
 * Change : New file
 * Author : SentinelTeam
 *
 * Date   :
 * Change :
 * Author :
 *
 */

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

/*
 * This view allows the user to view more than one camera at the same time
 * it is a container of multiple UIWebview that each connects to a different
 * camera for streaming.
 */
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
