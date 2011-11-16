//
//  GroupsVC.h
//  Project3
//
//  Created by Jeffrey Lim on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsCategoryVC.h"

@interface GroupsVC : UIViewController<UIPickerViewDelegate, UITextFieldDelegate> {
    //NSMutableArray *groupList;
}

- (IBAction) helpButtonClicked:(id) sender;
- (IBAction) addButtonClicked:(id) sender;
-(id) initWithDicts:(NSMutableDictionary*)ssettingsDict groupsDict:(NSMutableDictionary*)ggroupsDict callerbacker:(SettingsCategoryVC*)callerbacker;
- (IBAction) delButtonClicked:(id) sender;
- (void) deleteGroup;
- (IBAction) joinButtonClicked:(id) sender;
- (void) joinGroup;

@property (nonatomic, retain) SettingsCategoryVC* callerbacker;

@property (nonatomic, retain) NSMutableArray* groupList;

@property (nonatomic, retain) NSMutableDictionary* settingsDict;
@property (nonatomic, retain) NSMutableDictionary* groupsDict;


@end
