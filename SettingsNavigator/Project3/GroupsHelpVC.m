//
//  GroupsHelpVC.m
//  Project3
//
//  Created by Jeffrey Lim on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GroupsHelpVC.h"

@implementation GroupsHelpVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

///*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Groups - Help";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 300, 400)];
    introLabel.text = @"Groups enable you to control the settings of multiple devices at once. If a device is a member of a group, then any changes made to settings on that device will automatically result in the same change being made to all the other devices in that group. Conversely, if this device is a member of a group, it will receive changes from the other devices in the same group.\n    If you create a new group, the new group's settings will be the same as the settings of the device you're using. If you join a group, this device's settings will be overwritten by the group's settings. If you delete a group, no settings will change, but all devices formerly in that group will now no longer belong to any group.";
    introLabel.numberOfLines = 0;
    introLabel.lineBreakMode = UILineBreakModeWordWrap;
    [self.view addSubview:introLabel];
    [introLabel release];
}
//*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
