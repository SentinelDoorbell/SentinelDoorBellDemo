/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Camera Selection View
 * Function: UIView with a table of all the camera configured and available
 *         : for live streaming. Selecting a camera will take the user to
 *         : to the live view. (Implementation)
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

#import "UISelectCamViewController.h"
#import "UILiveFeedViewController.h"
#import "SentinelInfo.h"
#import "EditInfoCameraView.h"
#import "AppDelegate_iPhone.h"
#import <CoreData/CoreData.h>


@implementation UISelectCamViewController

@synthesize context;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Select Camera";
}

- (void)viewWillAppear:(BOOL)animated {
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainviewbg.png"]];
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	AppDelegate_iPhone *appDelegate = 
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	context = [appDelegate managedObjectContext];
	NSError *error;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
	   entityForName:@"SentinelInfo" inManagedObjectContext:context];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest 
                                                     error:&error];
	[fetchRequest release];
	
	if(fetchedObjects != NULL)
	{
		#ifdef DEBUG
		NSLog(@"UISelectCamViewController: tableView:numberOfRowsInSection: returning: %d", 
			[fetchedObjects count]);
		#endif
		
		return [fetchedObjects count];
	}
	else 
	{
		#ifdef DEBUG
		NSLog(@"UISelectCamViewController: tableView:numberOfRowsInSection: returning: 0");
		#endif
		
		return 0;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
											reuseIdentifier:CellIdentifier] autorelease];
    }
    
	AppDelegate_iPhone *appDelegate = 
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	context = [appDelegate managedObjectContext];
	NSError *error;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"SentinelInfo" 
                                   inManagedObjectContext:context];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest 
                                                     error:&error];
	
	SentinelInfo *info = [fetchedObjects objectAtIndex: indexPath.row];
	
	[fetchRequest release];
	
    // Configure the cell...
	cell.text = info.cameraName;
	
	#ifdef DEBUG
	NSLog(@"UISelectCamViewController: returning %@ for index %d", cell.text, indexPath.row);
	#endif
	// Configure the cell...
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	#ifdef DEBUG
	NSLog(@"UISelectCamViewController: index %d pressed", indexPath.row);
	#endif
	
	AppDelegate_iPhone *appDelegate = 
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	context = [appDelegate managedObjectContext];
	
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
		entityForName:@"EditInfoCameraView" inManagedObjectContext:context];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest 
                                                     error:&error];
	
	#ifdef DEBUG
	NSLog(@"UISelectCamViewController: Editinfocameradetals count = %d %@",
		[fetchedObjects count], fetchedObjects);
	#endif
	
	EditInfoCameraView *mo;
	
	mo = [fetchedObjects objectAtIndex:0];
	
	unsigned int index = indexPath.row;
	[mo setValue:[NSNumber numberWithInteger:index] forKey:@"cameraIndex"];
	if(![context save:&error])
	{
		NSLog(@"UISelectCamViewController: didSelectRowAtIndexPath: CoreDataSaveError");
		NSLog(@"%@ and %@", error, [error userInfo]);
	}
	
	#ifdef DEBUG
	NSLog(@"UISelectCamViewController: Setting cameraIndex to %d", index);
	#endif
	
	[fetchRequest release];
	
	UILiveFeedViewController *viewctr = 
		[[UILiveFeedViewController alloc] initWithNibName:@"UILiveFeedView" 
                                                       bundle:nil];

	[UIView  beginAnimations:@"Showinfo" context: nil];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.75];
	[self.navigationController pushViewController:viewctr animated:NO];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight 
                           forView:self.navigationController.view cache:NO];
	[UIView commitAnimations];
	
	//[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc 
{
	[camArr release];
    [super dealloc];
}


@end

