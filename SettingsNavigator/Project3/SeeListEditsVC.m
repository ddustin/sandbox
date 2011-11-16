//
//  SeeListEditsVC.m
//  Project3
//
//  Created by Jeffrey Lim on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SeeListEditsVC.h"
//#import "ArrayEditorVC.h"
#import "SingleCategoryEditorVC.h"
#import "ActiveSettingCell.h"


@implementation SeeListEditsVC
//@synthesize before;
//@synthesize after;
//@synthesize superior;



- (void)alert:(NSString*)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:text delegate:self cancelButtonTitle:@"OK"    otherButtonTitles:nil] ;
    [alert show];
    [alert release];
}




- (id) initWithArrays:(NSMutableArray*)bbefore after:(NSMutableArray*)aafter {
    self = [super init];
    before = bbefore;
    after = aafter;
    return self;
}




- (void) propagate {
    //Do stuff here to update or w/e
    
}




// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[arrayOfArrays objectAtIndex:section ] count];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return @"Changes";
    }
    else if (section == 1) {
        return @"Additions";
    }
    else {
        return @"Deletions";
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    
    ActiveSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ActiveSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[[arrayOfArrays objectAtIndex:[indexPath section]] objectAtIndex: [indexPath row]] objectForKey:@"title"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    cell.delegate = self;
    cell.dict = [[arrayOfArrays objectAtIndex:[indexPath section]] objectAtIndex: [indexPath row]];
    
    UIButton *cButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cButton.frame = CGRectMake(180, 5, 70, 32); // position in the parent view and set the size of the button
    [cButton setTitle:@"View" forState:UIControlStateNormal];
    [cButton addTarget:cell action:@selector(cButtonClicked:)forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:cButton];
    if ([[[arrayOfChecksArrays objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    
    
    return cell;
}

- (void) cButtonClicked:(NSMutableDictionary*)dict {
    SingleCategoryEditorVC* scPage = [[SingleCategoryEditorVC alloc] initWithSubdictsAndTitle:dict meta:nil title:@"View element"];
    scPage.editable = NO;
    [self.navigationController pushViewController:scPage animated:YES];
    [scPage release];
}


///*
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //remove the check mark, or add it if it's already been removed.
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if ([[[arrayOfChecksArrays objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]] boolValue]) {
        [newCell setAccessoryType:UITableViewCellAccessoryNone];
        [[arrayOfChecksArrays objectAtIndex:[indexPath section]] replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:NO]];
    }
    else {
        [newCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [[arrayOfChecksArrays objectAtIndex:[indexPath section]] replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:YES]];
    }
    
}
//*/

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
    //[self alert:[dict objectForKey:@"key1"]];
    
    self.title = @"Edit list";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //Compute changes, additions, deletions.
    
    /*
    NSMutableDictionary* d1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"changeme", @"title", nil];
    NSMutableDictionary* d2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"addme", @"title", nil];
    NSMutableDictionary* d3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"deleteme", @"title", nil];
    
    changes = [[NSMutableArray alloc] initWithObjects:d1, nil];
    additions = [[NSMutableArray alloc] initWithObjects:d2, nil];
    deletions = [[NSMutableArray alloc] initWithObjects:d3, nil];
    */
    
    changes = [[NSMutableArray alloc] init];
    additions = [[NSMutableArray alloc] init];
    deletions = [[NSMutableArray alloc] init];
    
    //additions = a copy of after
    for (id a in after) {
        [additions addObject:a];
    }
    
    for (NSMutableDictionary* d in before) {
        NSString* myTitle = [d objectForKey:@"title"];
        BOOL broke = NO;
        for (NSMutableDictionary* e in additions) {
            if ([myTitle isEqualToString:[e objectForKey:@"title"]]) {
                if ([d isEqualToDictionary:e]) {
                    //do nothing
                }
                else {
                    [changes addObject:d];
                }
                [additions removeObject:e];
                broke = YES;
                break;
            }
        }
        //if we got here naturally, without breaking, it's a deletion,
        //because the title was not found in "after".
        if (!broke) {
            [deletions addObject:d];
        }
    }
    
    changesChecks = [[NSMutableArray alloc] init];
    additionsChecks = [[NSMutableArray alloc] init];
    deletionsChecks = [[NSMutableArray alloc] init];
    
    
    for (id x in changes) {
        [changesChecks addObject:[NSNumber numberWithBool:YES]];
    }
    for (id x in additions) {
        [additionsChecks addObject:[NSNumber numberWithBool:YES]];
    }
    for (id x in deletions) {
        [deletionsChecks addObject:[NSNumber numberWithBool:YES]];
    }
    
    //[self alert:[NSString stringWithFormat:@"%d",[changes count]]];
    
    
    arrayOfArrays = [[NSMutableArray alloc] initWithObjects:changes,additions,deletions, nil];
    arrayOfChecksArrays = [[NSMutableArray alloc] initWithObjects:changesChecks,additionsChecks,deletionsChecks, nil];

    
    
    leTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,372) style:UITableViewStylePlain];
    leTableView.dataSource = self;
    leTableView.delegate = self;
    //scvcTableView.allowsMultipleSelection = YES;
    //myTableView.editing = YES;
    
    [self.view addSubview:leTableView];
    
    [leTableView release];
    
    
    
    /*
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(160, 0, 160, 44); // position in the parent view and set the size of the button
    [addButton setTitle:@"Add new element" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
     */
    
}
//*/



- (IBAction) addButtonClicked:(id) sender {
    //[self alert:@"Add new item!"];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [leTableView release];
    [changes release];
    [additions release];
    [deletions release];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
