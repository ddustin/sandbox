//
//  SingleCategoryEditorVC.m
//  Project3
//
//  Created by Jeffrey Lim on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SingleCategoryEditor.h"
#import "ActiveSettingCell.h"
#import "SettingsCategories.h"
#import "ArrayEditorVC.h"
#import "CellSizer.h"

@interface SingleCategoryEditor ()



@end

@implementation SingleCategoryEditor

@synthesize myDict, myMetaDict;
@synthesize superior;
@synthesize editable;



- (void)alert:(NSString*)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:text delegate:self cancelButtonTitle:@"OK"    otherButtonTitles:nil] ;
    [alert show];
    [alert release];
}

-(void) propagate {
    //do stuff
    //[self alert:@"First level propagation"];
    [superior propagate];
}



#pragma mark - Table View

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //self.colorNames = [[NSUserDefaults standardUserDefaults] objectForKey:@"data"];
    //return [self.colorNames count];
    return [ [myDict allKeys] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    ActiveSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    

    NSString* k = [[myDict allKeys] objectAtIndex: [indexPath row]];
    id settingValue = [myDict objectForKey:k];
    
    if (cell == nil) {
        cell = [[[ActiveSettingCell alloc] initWithStyleAndDictAndKey:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier myDict:myDict myKey:k] autorelease];
    }
    
    for (UIView* v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    
    
    // Configure the cell.
    //cell.textLabel.text = [self.colorNames objectAtIndex: [indexPath row]];
    
    
    //cell.textLabel.text = [[myDict allKeys] objectAtIndex: [indexPath row]];
    
    //cell.textLabel.textAlignment = 
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 400, 40)];
    titleLabel.text = [[myDict allKeys] objectAtIndex: [indexPath row]];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [cell.contentView addSubview:titleLabel];
    //(10, 35, 300, 50)
    
    id img = [[myMetaDict objectForKey:titleLabel.text] objectForKey:@"image"];
    
    
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
    //NSArray* maa = [myMetaDict allKeys];
    NSDictionary* mmm = [myMetaDict objectForKey:titleLabel.text];
    //NSArray* aaa = [mmm allKeys];
    detailLabel.text = [mmm objectForKey:@"details"];
    
                        //@"Shoreditch sustainable beard, +1 terry richardson trust fund mlkshk freegan.";// art party raw denim vice skateboard tattooed.";// Thundercats etsy biodiesel readymade butcher, banksy next level you probably haven't heard of them 8-bit. Salvia gluten-free etsy lomo squid 3 wolf moon before they sold out retro, mlkshk lo-fi wes anderson ethical keffiyeh.";
    detailLabel.numberOfLines = 0;
    [detailLabel sizeToFit];
    detailLabel.backgroundColor = [UIColor clearColor];

    [detailLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [cell.contentView addSubview:detailLabel];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //[self alert:detailLabel.text];

  
    //UIImage* img = [UIImage imageNamed:@"happy.png"];
    
    
    //[self alert:settingValue];
    
    if ([settingValue isKindOfClass:[NSNumber class]]) { //If the setting is a "boolean" (actually an NSInteger valued 0 or 1)
        UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(230, 7, 0, 0)];    
        [mySwitch setOn:[settingValue boolValue] animated:YES];
    
        [mySwitch addTarget:cell action:@selector(switchClicked:) forControlEvents:UIControlEventTouchUpInside];
        [mySwitch setUserInteractionEnabled:editable];

        [cell.contentView addSubview:mySwitch];
        [mySwitch release];
    }
    
    if ([settingValue isKindOfClass:[NSString class]]) { //If the setting is an NSString
        //[self alert:settingValue];
        UITextField *myInput = [[UITextField alloc] initWithFrame:CGRectMake(160, 10, 150, 25)]; 
        myInput.borderStyle = UITextBorderStyleRoundedRect;
        myInput.returnKeyType = UIReturnKeyDone;
        myInput.delegate = cell;
        myInput.text = settingValue;
        [myInput addTarget:cell action:@selector(inputUnclicked:) forControlEvents:UIControlEventEditingDidEnd];
        [myInput setUserInteractionEnabled:editable];
        [cell.contentView addSubview:myInput];
        [myInput release];
    }
    
    if ([settingValue isKindOfClass:[NSMutableArray class]]) { //If the setting is an array
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        editButton.frame = CGRectMake(190, 5, 120, 32); // position in the parent view and set the size of the button
        tempArray = settingValue;
        [editButton setTitle:@"Edit list >>" forState:UIControlStateNormal];
        [editButton addTarget:cell action:@selector(editButtonClicked:)forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:editButton];
    }
    
    [detailLabel release];
    [titleLabel release];
    cell.delegate = self;
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellSizer* cs = [[CellSizer alloc] init];
    
    NSString* setting = [[myDict allKeys] objectAtIndex: [indexPath row]];
    NSString* details = [[myMetaDict objectForKey:setting] objectForKey:@"details"];    
    id img = [[myMetaDict objectForKey:setting] objectForKey:@"image"];
    BOOL hasImage = [img isKindOfClass:[UIImage class]];
    float output = [cs bestSizeForCell:details hasImage:hasImage];
    [cs release];
    
    return output;
}



#pragma mark - Actions

- (void) editButtonClicked {
    //[self alert:[NSString stringWithFormat:@"%d",[tempArray count]] ];
    ArrayEditorVC* aePage = [[ArrayEditorVC alloc] initWithArray:tempArray];
    aePage.superior = self;
    [self.navigationController pushViewController:aePage animated:YES];
    [aePage release];
}


- (IBAction) switchClicked:(id) sender {
    [self alert:@"Toggle!"]; 
}


#pragma mark - View lifecycle



- (id)initWithSubdictsAndTitle: (NSMutableDictionary *)sd meta:(NSDictionary *)md
                         title:(NSString*)ttitle {
    
    if((self = [super init])) {
        
        self.title = ttitle;
        
        self.myDict = sd;
        self.myMetaDict = md;
        self.editable = YES;
    }
    
    return self;
}



///*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.title = 
    
    UITableView *sicevcTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,416) style:UITableViewStylePlain];
    
    sicevcTableView.dataSource = self;
    sicevcTableView.delegate = self;
    //scvcTableView.allowsMultipleSelection = YES;
    //myTableView.editing = YES;
    
    [self.view addSubview:sicevcTableView];
    [sicevcTableView release];
}
//*/


- (void)dealloc {
    
    self.myDict = nil;
    self.myMetaDict = nil;
    
    [super dealloc];
}




@end
