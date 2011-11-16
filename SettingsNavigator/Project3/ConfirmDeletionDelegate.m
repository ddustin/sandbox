//
//  ConfirmDeletionDelegate.m
//  Project3
//
//  Created by Jeffrey Lim on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ConfirmDeletionDelegate.h"
#import "GroupsVC.h"

@implementation ConfirmDeletionDelegate

@synthesize callerbacker;

-(id) initWithCallback:(GroupsVC*) ccallerbacker {
    self = [super init];
    self.callerbacker = ccallerbacker;
    return self;
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.callerbacker deleteGroup];
    }
}


@end
