//
//  SingleCategoryEditorVC.h
//  Project3
//
//  Created by Jeffrey Lim on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsCategoryVC.h"

@protocol SingleCategoryEditorVCDelegate <NSObject>
- (void) propagate;
@end

@interface SingleCategoryEditorVC : UIViewController <UITableViewDataSource, UITableViewDelegate, SingleCategoryEditorVCDelegate> {
    NSMutableArray* tempArray;
    
}


- (id) initWithSubdictsAndTitle:(NSDictionary*)sd meta:(NSDictionary *)md title:(NSString*)ttitle;
- (void) editButtonClicked;


@property (nonatomic, retain) id superior;
@property (nonatomic, retain) NSMutableDictionary *myDict;
@property (nonatomic, retain) NSDictionary *myMetaDict;
@property (nonatomic) BOOL editable;

@end
