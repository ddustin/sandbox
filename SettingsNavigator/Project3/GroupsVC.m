//
//  GroupsVC.m
//  Project3
//
//  Created by Jeffrey Lim on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GroupsVC.h"
#import "GroupsHelpVC.h"
#import "ConfirmDeletionDelegate.h"

@implementation GroupsVC

@synthesize groupList;


@synthesize settingsDict;
@synthesize groupsDict;
@synthesize callerbacker;

NSString *tempGroupName = nil;
UIPickerView *myPickerView = nil;
ConfirmDeletionDelegate* cdd = nil;
NSString *groupToDelete = nil;
NSString *groupToJoin = nil;
UILabel *introLabel = nil;

- (void)alert:(NSString*)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:text delegate:self cancelButtonTitle:@"OK"    otherButtonTitles:nil] ;
    [alert show];
    [alert release];
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = [self.groupsDict allKeys].count+1;
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    //[self alert:[NSString stringWithFormat:@"%d",row]];
    if (row == 0) {
        title = @"[NO GROUP]";
    }
    else {
        title = [[self.groupsDict allKeys] objectAtIndex:row-1];
    }
    //[@"" stringByAppendingFormat:@"%d",row];
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}






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



-(void) refreshIntroLabel {
    introLabel.text = @"This device is in: ";
    if (![self.callerbacker.myGroup isEqualToString:@""]) {
        introLabel.text = [introLabel.text stringByAppendingString:self.callerbacker.myGroup];
    }
    else {
        introLabel.text = [introLabel.text stringByAppendingString:@"[NO GROUP]"];
    }
}



///*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Manage groups";
    self.view.backgroundColor = [UIColor whiteColor];

    cdd = [[ConfirmDeletionDelegate alloc] initWithCallback:self];

    self.groupList = [[NSMutableArray alloc] init];
    [self.groupList addObject:@"[NO GROUP]"];
    [self.groupList addObject:@"Front"];
    [self.groupList addObject:@"Middle"];
    [self.groupList addObject:@"Back"];
    [self.groupList addObject:@"Left"];
    [self.groupList addObject:@"Right"];

    
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    if (self.callerbacker.myGroup) {
        int newlySelected = 1+[[groupsDict allKeys] indexOfObject:self.callerbacker.myGroup];
        [myPickerView selectRow:newlySelected inComponent:0 animated:NO];
    }
    
    
    
    [self.view addSubview:myPickerView];
    [myPickerView release];
    
    
    UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    helpButton.frame = CGRectMake(0, 0, 120, 44); // position in the parent view and set the size of the button
    [helpButton setTitle:@"What is this?" forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(helpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:helpButton];
    //[helpButton release];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(150, 0, 170, 44); // position in the parent view and set the size of the button
    [addButton setTitle:@"Create new group" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    //[addButton release];

    introLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 50)];
    introLabel.font = [introLabel.font fontWithSize:20.0];
    introLabel.numberOfLines = 1;
    [self refreshIntroLabel];
    [self.view addSubview:introLabel];
    [introLabel release];
    
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteButton.frame = CGRectMake(0, 300, 120, 44); // position in the parent view and set the size of the button
    [deleteButton setTitle:@"Delete group" forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(delButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    //[deleteButton release];
    
    UIButton *joinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    joinButton.frame = CGRectMake(200, 300, 120, 44); // position in the parent view and set the size of the button
    [joinButton setTitle:@"Join group" forState:UIControlStateNormal];
    [joinButton addTarget:self action:@selector(joinButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:joinButton];
    //[joinButton release];


    
}
//*/



- (IBAction) helpButtonClicked:(id) sender {
    GroupsHelpVC *groupsHelpPage = [[GroupsHelpVC alloc] init];
    [self.navigationController pushViewController:groupsHelpPage animated:YES];
    [groupsHelpPage release];
}


- (IBAction) delButtonClicked:(id) sender {
    int selectedIndex = [myPickerView selectedRowInComponent:0];
    if (selectedIndex == 0) {
        //[self alert:@"You can't delete no group"];
    }
    else {
        groupToDelete = [[groupsDict allKeys] objectAtIndex:selectedIndex-1];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete group" message:[[@"Delete group " stringByAppendingString:groupToDelete] stringByAppendingString:@"?"] delegate:cdd cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
    }
}
- (void) deleteGroup {
    [groupsDict removeObjectForKey:groupToDelete];
    [myPickerView reloadAllComponents];
    if ([groupToDelete isEqualToString:self.callerbacker.myGroup]) {
        self.callerbacker.myGroup = @"";
        [myPickerView selectRow:0 inComponent:0 animated:YES];
        [self refreshIntroLabel];
    }
    else {
        int s = 1+[[groupsDict allKeys] indexOfObject:self.callerbacker.myGroup];
        [myPickerView selectRow:s inComponent:0 animated:YES];
    }
}


- (IBAction) addButtonClicked:(id) sender {
    //[self.navigationController popViewControllerAnimated:YES];

    //[self alert:@"New group?"];
    
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"Create new group" message:@"\n\n\n"
                                                         delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
    
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,40,260,25)];
    promptLabel.font = [UIFont systemFontOfSize:16];
    promptLabel.numberOfLines = 3;
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.backgroundColor = [UIColor clearColor];
    promptLabel.shadowColor = [UIColor blackColor];
    promptLabel.shadowOffset = CGSizeMake(0,-1);
    promptLabel.textAlignment = UITextAlignmentCenter;
    promptLabel.text = @"Enter the name of the new group:";
    [promptAlert addSubview:promptLabel];
    
    UIImageView *promptImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"passwordfield" ofType:@"png"]]];
    promptImage.frame = CGRectMake(11,79,262,31);
    [promptAlert addSubview:promptImage];
    
    UITextField *promptField = [[UITextField alloc] initWithFrame:CGRectMake(16,83,252,25)];
    promptField.font = [UIFont systemFontOfSize:18];
    promptField.backgroundColor = [UIColor whiteColor];
    //promptField.secureTextEntry = YES;
    promptField.keyboardAppearance = UIKeyboardAppearanceAlert;
    promptField.delegate = self;
    [promptField becomeFirstResponder];
    [promptAlert addSubview:promptField];
    
    //[promptAlert setTransform:CGAffineTransformMakeTranslation(0,109)];
    [promptAlert show];
    [promptAlert release];
    [promptField release];
    [promptImage release];
    [promptLabel release];

}
- (void)textFieldDidEndEditing:(UITextField*)textField {
    //[self alert:textField.text];
    tempGroupName = textField.text;
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //[self alert:tempGroupName];
        //"New Group" function continues here.
        if ([self.groupsDict objectForKey:tempGroupName] != nil || [tempGroupName isEqualToString:@"[NO GROUP]"]) {
            [self alert:@"That name is already taken."];
        }
        else {
            NSMutableDictionary* thisGroupDict = [self.settingsDict copy];
            [self.groupsDict setObject:thisGroupDict forKey:tempGroupName];
            self.callerbacker.myGroup = tempGroupName;
            [myPickerView reloadAllComponents];
            int newlySelected = 1+[[groupsDict allKeys] indexOfObject:tempGroupName];
            [myPickerView selectRow:newlySelected inComponent:0 animated:YES];
            [self refreshIntroLabel];
        }
    }
}







- (IBAction) joinButtonClicked:(id) sender {
    int selectedIndex = [myPickerView selectedRowInComponent:0];
    if (selectedIndex == 0) {
        groupToJoin = @"";
        if ([@"" isEqualToString:self.callerbacker.myGroup]) {
            [self alert:@"This device is already in no group."];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Join group" message:@"Remove this device from its group?" delegate:cdd cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
        }
    }
    else {
        groupToJoin = [[groupsDict allKeys] objectAtIndex:selectedIndex-1];
        if ([groupToJoin isEqualToString:self.callerbacker.myGroup]) {
            [self alert:@"This device is already in this group."];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Join group" message:[[@"Join group " stringByAppendingString:groupToJoin] stringByAppendingString:@"? (This will override the settings on this device.)"] delegate:cdd cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
        }
    }
}
- (void) joinGroup {
    [groupsDict removeObjectForKey:groupToDelete];
    [myPickerView reloadAllComponents];
    if ([groupToDelete isEqualToString:self.callerbacker.myGroup]) {
        self.callerbacker.myGroup = @"";
        [myPickerView selectRow:0 inComponent:0 animated:YES];
        [self refreshIntroLabel];
    }
    else {
        int s = 1+[[groupsDict allKeys] indexOfObject:self.callerbacker.myGroup];
        [myPickerView selectRow:s inComponent:0 animated:YES];
    }
}











- (void) dealloc {
    [super dealloc];
    //[groupList release];
}


-(id) initWithDicts:(NSMutableDictionary*)ssettingsDict groupsDict:(NSMutableDictionary*)ggroupsDict callerbacker:(SettingsCategoryVC*)ccallerbacker {
    self = [super init];
    self.settingsDict = ssettingsDict;
    self.groupsDict = ggroupsDict;
    self.callerbacker = ccallerbacker;
    return self;
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    //[groupList release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //groupList = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
