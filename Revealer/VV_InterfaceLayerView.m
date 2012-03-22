//
//  VV_InterfaceLayerView.m
//  Revealer
//
//  Created by Nano8Blazex on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VV_InterfaceLayerView.h"

@implementation VV_InterfaceLayerView

@synthesize mainButton, frontUI;


- (void)awakeFromNib {
    [self setWantsLayer:YES]; //we want a CALayer to be able to z-index subviews correctly
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        // now get z-indexes correct
        [[mainButton layer] setZPosition:0]; //for somereason the overlay on the button dies if we use this
        [[frontUI layer] setZPosition:3];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

@end
