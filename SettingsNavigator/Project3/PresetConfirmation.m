//
//  PresetConfirmationVC.m
//  Project3
//
//  Created by Jeffrey Lim on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PresetConfirmation.h"
#import "SettingsCategoryVC.h"
#import "CellSizer.h"
#import "ActiveSettingCell.h"
#import "SeeListEditsVC.h"


@implementation PresetConfirmation



@synthesize myPresetDict;
@synthesize existingDict;
@synthesize metaDict;
@synthesize confTableView;

NSMutableArray* changes;
NSMutableArray* checks;

NSMutableArray* listToChangeBefore;
NSMutableArray* listToChangeAfter;

- (void)alert:(NSString*)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:text delegate:self cancelButtonTitle:@"OK"    otherButtonTitles:nil] ;
    [alert show];
    [alert release];
}




// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ changes count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    ActiveSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    //NSString* k = [[myPresetDict allKeys] objectAtIndex: [indexPath row]];
    //id settingValue = [myDict objectForKey:k];
    
    if (cell == nil) {
        cell = [[[ActiveSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    for (UIView* v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    
    // Configure the cell.
    //cell.textLabel.text = [self.colorNames objectAtIndex: [indexPath row]];
    
    
    //cell.textLabel.text = [[myDict allKeys] objectAtIndex: [indexPath row]];
    
    //cell.textLabel.textAlignment = 
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 400, 40)];
    
    NSString* category = [[changes objectAtIndex:[indexPath row]] objectAtIndex:0];
    NSString* setting = [[changes objectAtIndex:[indexPath row]] objectAtIndex:1];
    id beforeValue = [[changes objectAtIndex:[indexPath row]] objectAtIndex:2];
    id afterValue = [[changes objectAtIndex:[indexPath row]] objectAtIndex:3];
    
    titleLabel.text = category;
    titleLabel.text = [titleLabel.text stringByAppendingString:@" > "];
    titleLabel.text = [titleLabel.text stringByAppendingString:setting];
    
    
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [cell.contentView addSubview:titleLabel];
    //(10, 35, 300, 50)
    
    id img = [[[metaDict objectForKey:category] objectForKey:setting] objectForKey:@"image"];
    
    
    UILabel *detailLabel;
    if ([img isKindOfClass:[UIImage class]]) {
        detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 35, 145, 50)];
        UIImageView *myImg = [[UIImageView alloc] initWithImage:img];
        myImg.frame = CGRectMake(10, 40, 150, 150);
        [cell.contentView addSubview:myImg];
        [myImg release];
    }
    else {
        detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 300, 50)];   
    }
    //UILabel *detailLabel = [[UILabel alloc] initWithFrame:detailRect];
    detailLabel.text = [[[metaDict objectForKey:category] objectForKey:setting] objectForKey:@"details"];    
    detailLabel.numberOfLines = 0;
    [detailLabel sizeToFit];
    detailLabel.backgroundColor = [UIColor clearColor];
    
    [detailLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [cell.contentView addSubview:detailLabel];
    //[cell setSelected:YES];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //[self alert:detailLabel.text];
    
    
    CGSize labelSize = [detailLabel.text sizeWithFont:detailLabel.font 
                                    constrainedToSize:detailLabel.frame.size 
                                        lineBreakMode:UILineBreakModeWordWrap];
    CGFloat labelHeight = labelSize.height;
    
    
    
    
    if ([img isKindOfClass:[UIImage class]]) {
        if (labelHeight < 150.0) {
            labelHeight = 150.0;
        }
    }
    int bottomLabelY = labelHeight + 50;

    //UIImage* img = [UIImage imageNamed:@"happy.png"];
    

    
    if ([beforeValue isKindOfClass:[NSNumber class]]) { //If the setting is a "boolean" (actually an NSInteger valued 0 or 1)
        UISwitch *mySwitch1 = [[UISwitch alloc] initWithFrame:CGRectMake(10, bottomLabelY, 0, 0)];    
        [mySwitch1 setOn:[beforeValue boolValue] animated:NO];
        [mySwitch1 setUserInteractionEnabled:NO];
        [cell.contentView addSubview:mySwitch1];
        [mySwitch1 release];
        
        UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, bottomLabelY, 150, 25)];
        middleLabel.text = @"will change to";
        middleLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:middleLabel];
        [middleLabel release];
        
        UISwitch *mySwitch2 = [[UISwitch alloc] initWithFrame:CGRectMake(220, bottomLabelY, 0, 0)];    
        [mySwitch2 setOn:[afterValue boolValue] animated:NO];
        [mySwitch2 setUserInteractionEnabled:NO];
        [cell.contentView addSubview:mySwitch2];
        [mySwitch2 release];
    }
    
    if ([beforeValue isKindOfClass:[NSString class]]) { //If the setting is an NSString
        //[self alert:settingValue];
        UITextField *myInput1 = [[UITextField alloc] initWithFrame:CGRectMake(10, bottomLabelY, 120, 25)]; 
        myInput1.borderStyle = UITextBorderStyleRoundedRect;
        myInput1.text = beforeValue;
        [myInput1 setUserInteractionEnabled:NO];
     
        
        [cell.contentView addSubview:myInput1];
        [myInput1 release];
        
        UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, bottomLabelY-20, 60, 60)];
        middleLabel.text = @"will change to";
        middleLabel.lineBreakMode = UILineBreakModeWordWrap;
        middleLabel.numberOfLines = 0;
        middleLabel.textAlignment = UITextAlignmentCenter;
        middleLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:middleLabel];
        [middleLabel release];
        
        UITextField *myInput2 = [[UITextField alloc] initWithFrame:CGRectMake(190, bottomLabelY, 120, 25)]; 
        myInput2.borderStyle = UITextBorderStyleRoundedRect;
        myInput2.text = afterValue;
        [myInput2 setUserInteractionEnabled:NO];
        
        [cell.contentView addSubview:myInput2];
        [myInput2 release];
    }
    
    if ([beforeValue isKindOfClass:[NSMutableArray class]]) { //If the setting is an array
        //Include a button telling us to view the change in further detail, as part of an "ArrayChangeConfirmationVC", which itself contains buttons pointing towards "PresetConfirmationVC" instances for each element being changed, or "SingleCategoryEditorVC" for each added or deleted element. Pass in a nil metadict to these instances.
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        moreButton.frame = CGRectMake(160, bottomLabelY, 140, 32); // position in the parent view and set the size of the button
        //listToChangeBefore = beforeValue;
        //listToChangeAfter = afterValue;
        cell.before = beforeValue;
        cell.after = afterValue;
        [moreButton setTitle:@"View list changes" forState:UIControlStateNormal];
        [moreButton addTarget:cell action:@selector(moreButtonClicked:)forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:moreButton];

    }
    
    [detailLabel release];
    [titleLabel release];
    cell.delegate = self;
    //[cell setSelected:YES];
    if ([[checks objectAtIndex:[indexPath row]] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void) moreButtonClicked:(NSMutableArray*)bbefore after:(NSMutableArray*)aafter {
    SeeListEditsVC* morePage = [[SeeListEditsVC alloc] initWithArrays: bbefore after:aafter];
    [self.navigationController pushViewController:morePage animated:YES];
    //[self alert:@"View MORE!!!!"];
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //remove the check mark, or add it if it's already been removed.
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if ([[checks objectAtIndex:[indexPath row]] boolValue]) {
        [newCell setAccessoryType:UITableViewCellAccessoryNone];
        [checks replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:NO]];
    }
    else {
        [newCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [checks replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:YES]];
    }
    //[self alert:[NSString stringWithFormat:@"%d", [checks count]] ];
    
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    /*//remove the check mark, or add it if it's already been removed.
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if ([checks objectAtIndex:[indexPath row]]) {
        [newCell setAccessoryType:UITableViewCellAccessoryNone];
        [checks replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:NO]];
    }
    else {
        [newCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [checks replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:YES]];
    }
    //[self alert:[NSString stringWithFormat:@"%d", [checks count]] ];
    */
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 240.0;
    CellSizer* cs = [[CellSizer alloc] init];
    NSString* category = [[changes objectAtIndex:[indexPath row]] objectAtIndex:0];
    NSString* setting = [[changes objectAtIndex:[indexPath row]] objectAtIndex:1];
    NSString* details = [[[metaDict objectForKey:category] objectForKey:setting] objectForKey:@"details"];
    id img = [[[metaDict objectForKey:category] objectForKey:setting] objectForKey:@"image"];
    BOOL hasImage = [img isKindOfClass:[UIImage class]];
    float output = [cs bestSizeForCell:details hasImage:hasImage];
    [cs release];
    
    return 50.0+output;
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

- (IBAction) confirmButtonClicked:(id) sender {
    for (NSUInteger i = 0; i < [changes count]; i++) {
        if ([[checks objectAtIndex:i] boolValue]) {
            //[self alert:@"Changing"];
            //[self alert:[NSString stringWithFormat:@"%d", i] ];
            NSArray* change = [changes objectAtIndex:i];
            //[self alert:@"wut"];
            NSString* category = [change objectAtIndex:0];
            //[self alert:@"Did we do that?"];
            NSMutableDictionary* catdict = [existingDict objectForKey:category];
            NSString* setting = [change objectAtIndex:1];
            [catdict setObject:[change objectAtIndex:3] forKey:setting];
            
        }
    }
    
    SettingsCategoryVC* scvc = [[self.navigationController viewControllers] objectAtIndex:([[self.navigationController viewControllers] count] - 3 )];
    [scvc propagate];
    [self.navigationController popToViewController:scvc animated:YES];
    
}







///*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    changes = [[NSMutableArray alloc] init];
    checks = [[NSMutableArray alloc] init];

    //For each category in the dictionary of settings for this preset...
    for (NSString* category in [myPresetDict allKeys]) {
        NSDictionary* pCatDict = [myPresetDict objectForKey:category];
        NSDictionary* xCatDict = [existingDict objectForKey:category];
        //and for each setting within that category...
        for (NSString* setting in [pCatDict allKeys]) {
            //Check to see if the Preset value matches the eXisting one.
            NSString* afterValue = [pCatDict objectForKey:setting];
            NSString* beforeValue = [xCatDict objectForKey:setting];
            if ([beforeValue isEqual:afterValue]) {
                //do nothing
            }
            else {
                //add this setting to the list of changes.
                //[self alert:@"Difference detected"];
                NSArray* newChange = [[NSArray alloc] initWithObjects:category,setting,beforeValue,afterValue, nil ];
                //[changes addObject:newChange];
                [changes addObject:newChange];
                [checks addObject:[NSNumber numberWithBool:YES]]; //
                [newChange release];
                //[self alert:[NSString stringWithFormat:@"%d", [checks count]] ];

                
            }
        }
    }
    
    
    confTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,416) style:UITableViewStylePlain];
    confTableView.dataSource = self;
    confTableView.delegate = self;
    confTableView.allowsMultipleSelection = YES;
    //myTableView.editing = YES;
    
    
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(-10,0,-100,80)];
    headerLabel.lineBreakMode = UILineBreakModeWordWrap;
    headerLabel.numberOfLines = 0;
    if ([changes count] == 0) {
        headerLabel.text = @"   This preset is already loaded; there are\n                no changes to make.";
    }
    else {
        headerLabel.text = @"   The following settings will be changed.\n Uncheck any you do not wish to change.";
    }
    confTableView.tableHeaderView = headerLabel;
    [headerLabel release];
    
    
    if ([changes count] != 0) {
        UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        confirmButton.frame = CGRectMake(0, 0, 0, 40); // position in the parent view and set the size of the button
        [confirmButton setTitle:@"Confirm checked changes" forState:UIControlStateNormal];
        [confirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        confTableView.tableFooterView = confirmButton;
    }

    
    
    
    
    [self.view addSubview:confTableView];
    
    [confTableView release];
    

}
//*/



-(id) initWithDicts:(NSDictionary*)mmyPresetDict existingDict:(NSMutableDictionary*)eexistingDict metaDict:(NSDictionary*)mmetaDict {
    self = [super init];
    self.myPresetDict = mmyPresetDict;
    self.existingDict = eexistingDict;
    self.metaDict = mmetaDict;
    return self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [changes release];
    [checks release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
