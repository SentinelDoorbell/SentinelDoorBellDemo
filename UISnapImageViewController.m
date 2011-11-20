//
//  UISnapImageViewController.m
//  Sentinel
//
//  Created by Fekri Kassem on 11/19/11.
//  Copyright 2011 Self. All rights reserved.
//

#import "UISnapImageViewController.h"


@implementation UISnapImageViewController

@synthesize imagePath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) 
    {
        // Custom initialization
    }
    
    return self;
}

- (void)dealloc
{
    [imagePath release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    self.title = @"Image";
    [super viewDidLoad];
    self.view.backgroundColor = 
        [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainviewbg.png"]];
    
    // create a standard delete button with the trash icon
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                     target:self
                                     action:@selector(onDeleteImage:)];
    deleteButton.style = UIBarButtonItemStyleBordered;
    self.navigationItem.rightBarButtonItem = deleteButton;
    [deleteButton release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) onDeleteImage:(id) sender
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError       *error;
    BOOL           fileExists  = [fileManager fileExistsAtPath:imagePath];
    
    if (fileExists) 
    {
        BOOL success = [fileManager removeItemAtPath:imagePath error:&error];

        if (!success) 
        {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
