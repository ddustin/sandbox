//
//  ConfirmDeletionDelegate.h
//  Project3
//
//  Created by Jeffrey Lim on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupsVC.h"

@interface ConfirmDeletionDelegate : NSObject<UITextFieldDelegate>


-(id) initWithCallback:(GroupsVC*) ccallerbacker;
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;


@property (nonatomic, retain) GroupsVC* callerbacker;
//@property (nonatomic, retain) NSString* purpose;



@end
