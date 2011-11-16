//
//  SeeListEditsVC.h
//  Project3
//
//  Created by Jeffrey Lim on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeeListEditsVC : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray* before;
    NSMutableArray* after;

    
    NSMutableArray* changes;
    NSMutableArray* additions;
    NSMutableArray* deletions;
    NSMutableArray* arrayOfArrays;
    
    
    NSMutableArray* changesChecks;
    NSMutableArray* additionsChecks;
    NSMutableArray* deletionsChecks;
    NSMutableArray* arrayOfChecksArrays;

    UITableView *leTableView;

}
- (void) cButtonClicked:(NSMutableDictionary*)dict;

- (id) initWithArrays:(NSMutableArray*)bbefore after:(NSMutableArray*)aafter;



@end
