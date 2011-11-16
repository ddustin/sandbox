//
//  PresetConfirmationVC.h
//  Project3
//
//  Created by Jeffrey Lim on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresetConfirmation : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    //NSDictionary* myPresetDict;
}


-(id) initWithDicts:(NSDictionary*)mmyPresetDict existingDict:(NSMutableDictionary*)eexistingDict metaDict:(NSDictionary*)mmetaDict;
- (IBAction) confirmButtonClicked:(id) sender;
- (void) moreButtonClicked:(NSMutableArray*)bbefore after:(NSMutableArray*)aafter;


@property (nonatomic, retain) NSDictionary *myPresetDict;
@property (nonatomic, retain) NSMutableDictionary *existingDict;
@property (nonatomic, retain) NSDictionary *metaDict;

@property (nonatomic, retain) UITableView *confTableView;

@end
