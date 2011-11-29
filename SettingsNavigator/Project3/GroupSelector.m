//
//  GroupSelectorVC.m
//  Project3
//
//  Created by Jeffrey Lim on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GroupSelector.h"
#import "SettingsCategories.h"



@implementation GroupSelector

@synthesize myGroup;
@synthesize groupsDict;

@synthesize metaDict;
@synthesize presetDict;


- (void)alert:(NSString*)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:text delegate:self cancelButtonTitle:@"OK"    otherButtonTitles:nil] ;
    [alert show];
    [alert release];
}




- (void) propagate {
    //Do stuff here to update or w/e
    [self alert:@"Just changed something!!!!"];
}





#pragma mark - Table View

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[groupsDict allKeys] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self alert:myGroup];

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[groupsDict allKeys] objectAtIndex: [indexPath row]];
    //[self alert:cell.textLabel.text];
    //[self alert:myGroup];
    if ([cell.textLabel.text isEqualToString:myGroup]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //You might want to "Cancel/OK" confirm this first.
    [myGroup release];
    myGroup = [[[groupsDict allKeys] objectAtIndex: [indexPath row]] copy];
    NSMutableDictionary *subDict = [groupsDict objectForKey:myGroup];

    
    SettingsCategories* settingsPage = [[SettingsCategories alloc] initWithDicts:subDict superior:self];
    
    [self.navigationController pushViewController:settingsPage animated:YES];
    [settingsPage release];
    [groupsTableView reloadData];
    
}


#pragma mark - Actions



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
        if ([self.groupsDict objectForKey:tempGroupName] != nil) {
            [self alert:@"That name is already taken."];
        }
        else if ([tempGroupName isEqualToString:@""]) {
            [self alert:@"Please enter a name for the new group."];
        }
        else {
            //[self alert:tempGroupName];
            NSMutableDictionary* newGroupSettings = [self deepCopySettingsFromGroup:myGroup];
            [groupsDict setObject:newGroupSettings forKey:tempGroupName];
            //There is no need to copy the metaDict, since it's the same for all groups.
            //[newGroupSettings release]; //Is it necessary/safe to do this?
            [myGroup release];
            myGroup = [tempGroupName copy];
            [groupsTableView reloadData];
        }
    }
}




#pragma mark - Helper functions



- (void) renameGroup:(NSString*)oldName to:(NSString*)newName {
    //[self alert:[oldName stringByAppendingString:newName]];
    id objectToPreserve = [groupsDict objectForKey:oldName];
    [groupsDict setObject:objectToPreserve forKey:newName];
    [groupsDict removeObjectForKey:oldName];
    [myGroup release];
    myGroup = [newName copy];
    [groupsTableView reloadData];
    //NOTE: You have to include here a method for communicating this change to the other devices, or else they might get a "no key by that name" error.
}



/* Creates and returns a copy of the settings dictionary for group "groupName",
 including a copy of all the strings and numbers in that dictionary. */
- (NSMutableDictionary*) deepCopySettingsFromGroup:(NSString*)groupName {
    NSMutableDictionary* original = [groupsDict objectForKey:groupName];
    return [self deepCopyDictionary:original]; 
}


- (NSMutableDictionary*) deepCopyDictionary:(NSMutableDictionary*)original {
    NSMutableDictionary* output = [[NSMutableDictionary alloc] init];
    for (NSString* k in [original allKeys]) {
        id item = [original objectForKey:k];
        if ([item isKindOfClass:[NSMutableDictionary class]]) {
            [output setObject:[self deepCopyDictionary:item] forKey:k];
        }
        else if ([item isKindOfClass:[NSMutableArray class]]) {
            [output setObject:[self deepCopyArray:item] forKey:k];
        }
        else { //It had better be an ordinary object!
            [output setObject:[item copy] forKey:k];
        }
    }
    return output;
}

- (NSMutableArray*) deepCopyArray:(NSMutableArray*)original {
    NSMutableArray* output = [[NSMutableArray alloc] init];
    for (id item in original) {
        if ([item isKindOfClass:[NSMutableDictionary class]]) {
            [output addObject:[self deepCopyDictionary:item]];
        }
        else if ([item isKindOfClass:[NSMutableArray class]]) {
            [output addObject:[self deepCopyArray:item]];
        }
        else { //It had better be an ordinary object!
            [output addObject:[item copy]];
        }
    }
    return output;
}




#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Settings";
    
    
    //Creating the example array (Would be extremely messy to do inline)
    NSMutableDictionary* a = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                              @"Cash",@"title",
                              [[NSNumber alloc] initWithInt:0],@"Opens cash drawer",nil];
    NSMutableDictionary* b = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                              @"Check",@"title",
                              [[NSNumber alloc] initWithInt:1],@"Opens ca$h drawer",nil];
    NSMutableDictionary* c = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                              @"Credit",@"title",
                              [[NSNumber alloc] initWithInt:0],@"Open$ ca$h drawer",nil];
    NSMutableArray* c3s1ExampleArray = [[NSMutableArray alloc] initWithObjects:a,b,c, nil];
    
    
    //Creating the example array (Would be extremely messy to do inline)
    NSMutableDictionary* d = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                              @"Cash",@"title",
                              [[NSNumber alloc] initWithInt:0],@"Opens cash drawer",nil];
    NSMutableDictionary* e = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                              @"Check",@"title",
                              [[NSNumber alloc] initWithInt:0],@"Opens ca$h drawer",nil];
    NSMutableDictionary* f = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                              @"Kredit",@"title",
                              [[NSNumber alloc] initWithInt:0],@"Open$ ca$h drawer",nil];
    NSMutableArray* c3s1EverythingOffArray = [[NSMutableArray alloc] initWithObjects:d,e,f, nil];
    
    
    //Bertrand Russell rolls over in his grave:
    //[c setObject:c3s1ExampleArray forKey:@"Yo Dawg"];
    
    
                                        
    groupsDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    [[NSNumber alloc] initWithInt:0],@"C1Setting1",
                    @"blank",@"C1Setting2",
                    nil],@"Category1", 
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    @"blank",@"C2Setting1",
                    [[NSNumber alloc] initWithInt:0],@"C2Setting2",
                    @"blank",@"C2Setting3",
                    [[NSNumber alloc] initWithInt:0],@"C2Setting4",
                    nil],@"Category2",
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    @"blank",@"C3Setting1",
                    @"blank",@"C3Setting2",
                    nil],@"Category3",
                   nil],@"Everything off group",
                  [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    [[NSNumber alloc] initWithInt:1],@"C1Setting1",
                    @"valueOfC1S2",@"C1Setting2",
                    nil],@"Category1", 
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    @"valueOfC2S1",@"C2Setting1",
                    [[NSNumber alloc] initWithInt:0],@"C2Setting2",
                    @"C2S3 string!!!",@"C2Setting3",
                    [[NSNumber alloc] initWithInt:1],@"C2Setting4",
                    nil],@"Category2",
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    c3s1ExampleArray,@"C3Setting1",
                    @"valueOfC3S2",@"C3Setting2",
                    nil],@"Category3",
                   nil],@"Default group",
                  nil];
    [groupsDict retain];
    
    
    metaDict = [NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDictionary dictionaryWithObjectsAndKeys:
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"",@"image",
                       @"C1S1 is a boolean field (actually stored as an NSInteger)",@"details",
                       nil],@"C1Setting1",
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       [UIImage imageNamed:@"happy.png"],@"image",
                       @"C1S2 is pretty cool, I guess",@"details",
                       nil],@"C1Setting2",
                      nil],@"Category1", 
                     [NSDictionary dictionaryWithObjectsAndKeys:
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       [UIImage imageNamed:@"happy.png"],@"image",
                       @"But I don't really like C2S1.",@"details",
                       nil],@"C2Setting1",
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       [UIImage imageNamed:@"happy.png"],@"image", /*[UIImage imageNamed:@"happy.png"]*/
                       @"You expected me to give you detailed information about Category 2 Setting 2? WWWWWWWWWWWWWWWWWWWWWWWWWWW WWWWWWWWWWWWWW WWWWWWWWW WWWWWW",@"details",
                       nil],@"C2Setting2",
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"",@"image",
                       @"Well, what do you know. Category 2, setting 3.",@"details",
                       nil],@"C2Setting3",
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"",@"image",
                       @"I didn't know that category 2 had a 4th setting. foiwfj slkf wfo wjfoa fodjfoa wf sd aeogijewoiawfo aog sokmd ofijwoef owaf xjfa ofi waofiw ofkoskdfnjosfhishgiuaehg oijwf owai fowaijefoijewoighoiewajgweafjosf,x fjof osafj oasdf .owfowefj.",@"details",
                       nil],@"C2Setting4",
                      nil],@"Category2",
                     [NSDictionary dictionaryWithObjectsAndKeys:
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       [UIImage imageNamed:@"happy.png"],@"image",
                       @"there's a lot more to be said about c3s1 than you might think. For example, c3s1 is one of them newfangled Array settings.",@"details",
                       nil],@"C3Setting1",
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       [UIImage imageNamed:@"happy.png"],@"image",
                       @"Category 3 Setting 2 is actually the least interesting setting",@"details",
                       nil],@"C3Setting2",
                      nil],@"Category3",
                     nil];
    [metaDict retain];
    
    
    presetDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    [[NSNumber alloc] initWithInt:0],@"C1Setting1",
                    @"blank",@"C1Setting2",
                    nil],@"Category1", 
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    @"blank",@"C2Setting1",
                    [[NSNumber alloc] initWithInt:0],@"C2Setting2",
                    @"blank",@"C2Setting3",
                    [[NSNumber alloc] initWithInt:0],@"C2Setting4",
                    nil],@"Category2",
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    c3s1EverythingOffArray,@"C3Setting1",
                    @"blank",@"C3Setting2",
                    nil],@"Category3",
                   nil],@"Everything off",
                  
                  [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    [[NSNumber alloc] initWithInt:1],@"C1Setting1",
                    @"stuff",@"C1Setting2",
                    nil],@"Category1", 
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    @"stuff",@"C2Setting1",
                    [[NSNumber alloc] initWithInt:1],@"C2Setting2",
                    @"stuff",@"C2Setting3",
                    [[NSNumber alloc] initWithInt:1],@"C2Setting4",
                    nil],@"Category2",
                   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    @"stuff",@"C3Setting1",
                    @"stuff",@"C3Setting2",
                    nil],@"Category3",
                   nil],@"Everything on",
                  
                  nil];
    [presetDict retain];
    
    //Dictionaries are done. Now the actual stuff:
    
    //[self alert:[NSString stringWithFormat:@"%d", [[self.groupsDict allKeys] count]]];
    myGroup = [[NSString alloc] initWithString:@"Default group"];
    //myGroup = @"Default group";
    //[myGroup retain];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(200, 0, 120, 44); // position in the parent view and set the size of the button
    [addButton setTitle:@"Create group" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];

    
    
    groupsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44,320,372) style:UITableViewStylePlain];
    groupsTableView.dataSource = self;
    groupsTableView.delegate = self;

    
    [self.view addSubview:groupsTableView];
    
    [groupsTableView release];

    
    
    
    
    
    
    
}

@end
