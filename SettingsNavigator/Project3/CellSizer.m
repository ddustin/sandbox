//
//  CellSizer.m
//  Project3
//
//  Created by Jeffrey Lim on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CellSizer.h"

@implementation CellSizer

-(float) bestSizeForCell:(NSString*)details hasImage:(BOOL)hasImage {
    
    float output = 200.0;
    if (hasImage) {
        
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,145,300)];
        myLabel.numberOfLines = 0;
        myLabel.lineBreakMode = UILineBreakModeWordWrap;
        myLabel.text = details;
        CGSize labelSize = [myLabel.text sizeWithFont:myLabel.font 
                                    constrainedToSize:myLabel.frame.size 
                                        lineBreakMode:UILineBreakModeWordWrap];
        CGFloat labelHeight = labelSize.height;
        [myLabel release];
        if (labelHeight > 150.0) {
            output = 40.0 + labelHeight;
        }
        
    }    
    else {
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,300,300)];
        myLabel.numberOfLines = 0;
        myLabel.lineBreakMode = UILineBreakModeWordWrap;
        myLabel.text = details;
        CGSize labelSize = [myLabel.text sizeWithFont:myLabel.font 
                                    constrainedToSize:myLabel.frame.size 
                                        lineBreakMode:UILineBreakModeWordWrap];
        CGFloat labelHeight = labelSize.height;
        [myLabel release];
        output = 40.0 + labelHeight;
        
    }
    return output;
}

@end
