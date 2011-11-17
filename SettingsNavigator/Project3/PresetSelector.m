//
//  PresetSelectorVC.m
//  Project3
//
//  Created by Jeffrey Lim on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PresetSelector.h"
#import "PresetConfirmation.h"

@implementation PresetSelector

@synthesize presetDict, metaDict, existingDict;



- (void)alert:(NSString*)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:text delegate:self cancelButtonTitle:@"OK"    otherButtonTitles:nil] ;
    [alert show];
    [alert release];
}

- (void)viewWillAppear:(BOOL)animated {
    
    // Deselects the selected row.
    if(presetTableView.indexPathForSelectedRow)
        [presetTableView
         deselectRowAtIndexPath:presetTableView.indexPathForSelectedRow
         animated:YES];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[presetDict allKeys] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[presetDict allKeys] objectAtIndex: [indexPath row]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* t = [[presetDict allKeys] objectAtIndex: [indexPath row]];
    NSDictionary* myPresetDict = [presetDict objectForKey:t];
    //Create a PresetConfirmationVC using myPresetDict
    PresetConfirmation *confirmationPage = [[PresetConfirmation alloc] initWithDicts:myPresetDict existingDict:existingDict metaDict:metaDict];
    confirmationPage.title = t;
    [self.navigationController pushViewController:confirmationPage animated:YES];
    [confirmationPage release];

    
}

-(id) initWithDict:(NSDictionary*)ppresetDict metaDict:(NSDictionary*)mmetaDict {
    self = [super init];
    self.presetDict = ppresetDict;
    self.metaDict = mmetaDict;
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Choose preset";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    presetTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,416) style:UITableViewStylePlain];
    presetTableView.dataSource = self;
    presetTableView.delegate = self;

    
    [self.view addSubview:presetTableView];
    
    [presetTableView release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
