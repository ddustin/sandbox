//
//  SettingsCategoryVC.m
//  Project3
//
//  Created by Jeffrey Lim on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ArrayEditorVC.h"
#import "PresetSelector.h"
#import "GroupsVC.h"


@implementation ArrayEditorVC

@synthesize myArray;
@synthesize superior;

- (void)alert:(NSString*)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:text delegate:self cancelButtonTitle:@"OK"    otherButtonTitles:nil] ;
    [alert show];
    [alert release];
}





- (void) propagate {
    //Do stuff here to update or w/e
    [scvcTableView reloadData];
    [superior propagate];
}



#pragma mark - Table View
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [myArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[myArray objectAtIndex: [indexPath row]] objectForKey:@"title"];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *subDict = [myArray objectAtIndex: [indexPath row]];
    
    SingleCategoryEditor *singleArrayEditor =
    [[SingleCategoryEditor alloc] initWithSubdictsAndTitle:subDict meta:nil
     title:@"Edit list element"];
    
    
    singleArrayEditor.superior = self;
    [self.navigationController pushViewController:singleArrayEditor animated:YES];
    [singleArrayEditor release];
    
}

#pragma mark - Actions

- (IBAction) addButtonClicked:(id) sender {
    [self alert:@"Add new item!"];
}



#pragma mark - View lifecycle



- (id) initWithArray:(NSMutableArray*)mmyArray {
    self = [super init];
    self.myArray = mmyArray;
    return self;
}



- (void)viewWillAppear:(BOOL)animated {
    
    if(scvcTableView.indexPathForSelectedRow)
        [scvcTableView deselectRowAtIndexPath:scvcTableView.indexPathForSelectedRow animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self alert:[dict objectForKey:@"key1"]];
    
    self.title = @"Edit list";
    self.view.backgroundColor = [UIColor whiteColor];
    
    scvcTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44,320,372) style:UITableViewStylePlain];
    scvcTableView.dataSource = self;
    scvcTableView.delegate = self;
    //scvcTableView.allowsMultipleSelection = YES;
    //myTableView.editing = YES;
    
    [self.view addSubview:scvcTableView];
    
    [scvcTableView release];
    
    
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(160, 0, 160, 44); // position in the parent view and set the size of the button
    [addButton setTitle:@"Add new element" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
}
//*/






- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [scvcTableView release];
    [myArray release];
    
    
}


@end
