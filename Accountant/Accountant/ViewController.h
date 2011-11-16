//
//  ViewController.h
//  Accountant
//
//  Created by Jeffrey Lim on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
}


- (void)refreshRunningTotals;

- (IBAction) numberButtonClicked:(id) sender;
- (IBAction) backButtonClicked:(id) sender;
- (IBAction) addButtonClicked:(id) sender;
- (IBAction) delButtonClicked:(id) sender;
- (void)addOnTop:(NSDictionary*)entry;
@property (nonatomic, retain) UITextView *runningTotals;
@property (nonatomic, retain) UITextView *terminal;
@property (nonatomic, retain) NSMutableArray *ticker;


@end
