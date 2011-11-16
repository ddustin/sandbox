//
//  ActiveSettingCell.m
//  Project3
//
//  Created by Jeffrey Lim on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ActiveSettingCell.h"
#import "SingleCategoryEditorVC.h"
#import "PresetConfirmation.h"
#import "SeeListEditsVC.h"
@implementation ActiveSettingCell

@synthesize myDict;
@synthesize myKey;
@synthesize delegate;

@synthesize before;
@synthesize after;
@synthesize dict;


/*- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}*/



- (void)alert:(NSString*)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:text delegate:self cancelButtonTitle:@"OK"    otherButtonTitles:nil] ;
    [alert show];
    [alert release];
}



-(id) initWithStyleAndDictAndKey:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier myDict:(NSMutableDictionary*)mmyDict myKey:(NSString*)mmyKey {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.myDict = mmyDict;
    self.myKey = mmyKey;
    return self;
}

- (IBAction) switchClicked:(id) sender {
    //[self alert:@"AAAA"]; 
    NSNumber* original = [myDict objectForKey:myKey];
    [original release]; //Is that what you do?
    if ([((UISwitch*)sender) isOn]) {
        [myDict setObject:[[NSNumber alloc] initWithInt:1] forKey:myKey];
    }
    else {
        [myDict setObject:[[NSNumber alloc] initWithInt:0] forKey:myKey];
    }//How to dealloc these numbers?
    [(SingleCategoryEditorVC*)[self delegate] propagate];

}

- (IBAction)editButtonClicked:(id)sender {
    [(SingleCategoryEditorVC*)[self delegate] editButtonClicked];
}


- (IBAction) moreButtonClicked:(id)sender {
    [(PresetConfirmation*)[self delegate] moreButtonClicked:before after:after];
}

- (IBAction)cButtonClicked:(id)sender {
    [(SeeListEditsVC*)[self delegate] cButtonClicked:dict];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction) inputUnclicked:(id)sender {
    //[self alert:@"asfd"];
    //[self alert:((UITextField*)sender).text ];
    [myDict setObject:((UITextField*)sender).text forKey:myKey];
    [(SingleCategoryEditorVC*)[self delegate] propagate];
}


//- (IBAction) textBoxExited:(id) sender {
//    [self alert:self.textLabel.text]; 
//}



@end
