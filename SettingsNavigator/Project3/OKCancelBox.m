//
//  OKCancelBox.m
//  Project3
//
//  Created by Jeffrey Lim on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OKCancelBox.h"

@implementation OKCancelBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithActions:(NSString*)title message:(NSString*)mmessage okAction:(void (*)())ookAction cancelAction:(void (*)())ccancelAction {
    self = [super initWithTitle:title message:mmessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    //self.okAction = ookAction;
    //self.cancelAction = ccancelAction;
    return self;
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //They pressed Cancel
    }
    else if (buttonIndex == 1) {
        //They pressed OK
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
