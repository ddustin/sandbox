//
//  SettingsCategoryVC.h
//  Project3
//
//  Created by Jeffrey Lim on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SingleCategoryEditorVC.h"
#import "GroupSelectorVC.h"

@protocol SettingsCategoryVCDelegate <NSObject>
- (void) propagate;
@end



@interface SettingsCategoryVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, SettingsCategoryVCDelegate> {
    UITableView *scvcTableView;
    NSString* tempGroupName;
}


- (IBAction) presetsButtonClicked:(id) sender;
- (IBAction) renameButtonClicked:(id) sender;

- (id) initWithDicts:(NSMutableDictionary*)ssettingsDict superior:(GroupSelectorVC*)ssuperior;

@property (nonatomic, retain) NSMutableDictionary* settingsDict;
@property (nonatomic, retain) GroupSelectorVC* superior;


@end
