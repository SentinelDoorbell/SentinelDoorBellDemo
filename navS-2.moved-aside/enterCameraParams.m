//
//  enterCameraParams.m
//  navS
//
//  Created by Guest Account on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "enterCameraParams.h"
#import "configCamera.h"

@implementation enterCameraParams


#pragma mark -
#pragma mark View lifecycle

- (void)saveCamera:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Camera Details";
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	UIBarButtonItem *item = [[UIBarButtonItem alloc]   
                             initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                             target:self   
                             action:@selector(saveCamera:)];
	self.navigationItem.rightBarButtonItem = item; 
	[item release];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 8;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	if(indexPath.row == 0)
		cell.text = @"IP Address";
	else if(indexPath.row == 1)
		cell.text = @"Available with the Camera Guide";
	else if(indexPath.row == 2)
		cell.text = @"User Name";
	else if(indexPath.row == 3)
		cell.text = @"Available with the Camera Guide";
	else if(indexPath.row == 4)
		cell.text = @"Password";
	else if(indexPath.row == 5)
		cell.text = @"Available with the Camera Guide";
	else if(indexPath.row == 6)
		cell.text = @"Camera Name";
	else if(indexPath.row == 7)
		cell.text = @"Your identification for the camera";
    
	cell.font = [UIFont boldSystemFontOfSize:15.0f];
	UITextField *a = [[UITextField alloc] init];
	CGRect b = CGRectMake(120, 5, 190, 40); 
	[a setFrame:b];
	a.backgroundColor = [UIColor colorWithRed:0 green:0.01 blue:0.01 alpha:0.1];
	
	if(indexPath.row%2 == 0)
		[cell.contentView addSubview:a];
	
	[a release];
	
	return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	NSLog(@"haha");
	[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

