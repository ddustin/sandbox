//
//  GroupSelectorVC.h
//  Project3
//
//  Created by Jeffrey Lim on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupSelectorVC : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    UITableView *groupsTableView;
    NSString *tempGroupName;

}

- (void) propagate;
- (IBAction) addButtonClicked:(id) sender;
- (void) renameGroup:(NSString*)oldName to:(NSString*)newName;
- (NSMutableDictionary*) deepCopySettingsFromGroup:(NSString*)groupName;
- (NSMutableDictionary*) deepCopyDictionary:(NSMutableDictionary*)original;
- (NSMutableArray*) deepCopyArray:(NSMutableArray*)original;


@property (nonatomic, retain) NSString* myGroup;
@property (nonatomic, retain) NSMutableDictionary* groupsDict;
@property (nonatomic, retain) NSDictionary* metaDict;
@property (nonatomic, retain) NSMutableDictionary* presetDict;


@end
