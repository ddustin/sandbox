//
//  SettingsCategoryVC.h
//  Project3
//
//  Created by Jeffrey Lim on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleCategoryEditor.h"
#import "GroupSelector.h"





@interface ArrayEditorVC : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *scvcTableView;
}


- (IBAction) addButtonClicked:(id) sender;
-(void) propagate;

- (id) initWithArray:(NSMutableArray*)mmyArray;
@property (nonatomic, retain) NSMutableArray* myArray;
@property (nonatomic, retain) SingleCategoryEditor* superior;



@end
