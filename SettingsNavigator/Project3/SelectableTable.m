//
//  SettingsCategoryVC.m
//  Project3
//
//  Created by Jeffrey Lim on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectableTable.h"
#import "SingleCategoryEditor.h"
#import "PresetSelector.h"
#import "GroupsVC.h"


@implementation SelectableTable

@synthesize settingsDict;
@synthesize superior;

- (void)alert:(NSString*)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:text delegate:self cancelButtonTitle:@"OK"    otherButtonTitles:nil] ;
    [alert show];
    [alert release];
}








- (void) propagate {
    //Do stuff here to update or w/e
    [superior propagate];
}


#pragma mark - TableView

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [settingsDict count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
    cell.textLabel.text = [[settingsDict allKeys] objectAtIndex: [indexPath row]];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *subDict =
    [settingsDict objectForKey:[[settingsDict allKeys] objectAtIndex: [indexPath row]]];
    
    NSDictionary *subMeta =
    [superior.metaDict objectForKey:[[settingsDict allKeys] objectAtIndex: [indexPath row]]];    
    SingleCategoryEditor *editorPage =
    [[SingleCategoryEditor alloc]
     initWithSubdictsAndTitle:subDict meta:subMeta
     title:[settingsDict.allKeys objectAtIndex:indexPath.row]];
    
    
    editorPage.superior = self;
    [self.navigationController pushViewController:editorPage animated:YES];
    [editorPage release];
    
}






#pragma mark - View lifecycle


- (id) initWithDicts:(NSMutableDictionary*)ssettingsDict superior:(GroupSelector*)ssuperior {
    self = [super init];
    self.settingsDict = ssettingsDict;
    self.superior = ssuperior;
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
    
    self.title = [@"Group: " stringByAppendingString:superior.myGroup];
    self.view.backgroundColor = [UIColor whiteColor];
    
    scvcTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44,320,372) style:UITableViewStylePlain];
    scvcTableView.dataSource = self;
    scvcTableView.delegate = self;
    //scvcTableView.allowsMultipleSelection = YES;
    //myTableView.editing = YES;
    
    [self.view addSubview:scvcTableView];
    
    [scvcTableView release];
    
    
    
    UIButton *presetsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    presetsButton.frame = CGRectMake(200, 0, 120, 44); // position in the parent view and set the size of the button
    [presetsButton setTitle:@"Presets" forState:UIControlStateNormal];
    [presetsButton addTarget:self action:@selector(presetsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presetsButton];
    
    UIButton *renameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    renameButton.frame = CGRectMake(0, 0, 120, 44); // position in the parent view and set the size of the button
    [renameButton setTitle:@"Rename" forState:UIControlStateNormal];
    [renameButton addTarget:self action:@selector(renameButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:renameButton];
    
    
    
}
//*/






- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [scvcTableView release];
    [settingsDict release];
    
    
    
}

#pragma mark - Actions


- (IBAction) presetsButtonClicked:(id) sender {
    //[self alert:@"So you want presets?"];
    //[self alert:myGroup];
    PresetSelector *presetPage = [[PresetSelector alloc] initWithDict:superior.presetDict metaDict:superior.metaDict];
    //editorPage.delegate = self;
    presetPage.existingDict = settingsDict;
    [self.navigationController pushViewController:presetPage animated:YES];
    [presetPage release];
    
}


- (IBAction) renameButtonClicked:(id) sender {
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
        if ([superior.groupsDict objectForKey:tempGroupName] != nil) {
            [self alert:@"That name is already taken."];
        }
        else if ([tempGroupName isEqualToString:@""]) {
            [self alert:@"Please enter a name."];
        }
        else {
            [superior renameGroup:superior.myGroup to:tempGroupName];
            self.title = [@"Group: " stringByAppendingString:superior.myGroup];
        }
    }
}




@end
