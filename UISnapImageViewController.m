//
//  UISnapImageViewController.m
//  Sentinel
//
//  Created by SentinelTeam on 11/19/11.
//  Copyright 2011 Self. All rights reserved.
//

#import "UISnapImageViewController.h"


@implementation UISnapImageViewController

@synthesize imagePath;
@synthesize snapDate;
@synthesize snapTime;
@synthesize snapCamera;
@synthesize imageInfo;


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
    if (imagePath)
    {
        [imagePath release];
    }
    
    if (imageInfo)
    {
        [imageInfo release];
    }
    
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

    if (imagePath)
    {
        // Single image view
        // create a standard delete button with the trash icon
        UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                         target:self
                                         action:@selector(onDeleteImage:)];
        deleteButton.style = UIBarButtonItemStyleBordered;
        self.navigationItem.rightBarButtonItem = deleteButton;
        [deleteButton release];
    }
    else
    {
        // Slide show
        // create a standard delete button with the trash icon
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                       target:self
                                       action:@selector(onDoneSlideShow:)];
        doneButton.style = UIBarButtonItemStyleBordered;
        self.navigationItem.rightBarButtonItem = doneButton;
        [doneButton release];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    // Not slide show
    if (imagePath)
    {
        int index = 0;
        for (NSUInteger x = 0; x < [imagePath length]; ++x)
        {
            if([imagePath characterAtIndex:x] == '/')			
                index = x;
        }
        imageInfo = [[NSMutableString alloc] 
                     initWithString:[imagePath 
                 substringWithRange:NSMakeRange(index+1, 9)]];
        snapDate.text = [NSString stringWithFormat:@"%@",imageInfo];
        NSMutableString *str = [NSString stringWithFormat:@"%@:%@:%@",
                                [imagePath substringWithRange:NSMakeRange(index+11, 2)],
                                [imagePath substringWithRange:NSMakeRange(index+14, 2)],
                                [imagePath substringWithRange:NSMakeRange(index+17, 2)]];
        snapTime.text = [NSString stringWithFormat:@"%@",str];
    }
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
    NSLog(@"%@", imagePath);
    if (fileExists) 
    {
        BOOL success = [fileManager removeItemAtPath:imagePath error:&error];

        if (!success) 
        {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
    }
    
	UIAlertView *alert;
    
	alert = [[UIAlertView alloc] initWithTitle:@"Deleting Image"
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

    [self.navigationController popViewControllerAnimated:YES];
}

- (void) onDoneSlideShow:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
