//
//  PresetSelectorVC.h
//  Project3
//
//  Created by Jeffrey Lim on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Displays a list of presets (fixed lists of settings) to apply.
/// Upon selected a preset, an instance of PresetConfirmation is pushed.
@interface PresetSelector : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *presetTableView;

}


-(id) initWithDict:(NSDictionary*)ppresetDict metaDict:(NSDictionary*)mmetaDict;



@property (nonatomic, retain) NSDictionary *presetDict;
@property (nonatomic, retain) NSDictionary *metaDict;
@property (nonatomic, retain) NSMutableDictionary *existingDict;



@end
