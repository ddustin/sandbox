//
//  ActiveSettingCell.h
//  Project3
//
//  Created by Jeffrey Lim on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiveSettingCell : UITableViewCell <UITextFieldDelegate> {
}

-(id) initWithStyleAndDictAndKey:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier myDict:(NSMutableDictionary*)mmyDict myKey:(NSString*)mmyKey;


- (IBAction) switchClicked:(id) sender;
- (IBAction) inputUnclicked:(id)sender;
- (IBAction) moreButtonClicked:(id)sender;
- (IBAction)cButtonClicked:(id)sender;


- (BOOL)textFieldShouldReturn:(UITextField *)textField;


@property (nonatomic, retain) id myDict;
@property (nonatomic, retain) id myKey;
@property (nonatomic, retain) id delegate;

@property (nonatomic, retain) NSMutableArray* before;
@property (nonatomic, retain) NSMutableArray* after;
@property (nonatomic, retain) NSMutableDictionary* dict;



@end
