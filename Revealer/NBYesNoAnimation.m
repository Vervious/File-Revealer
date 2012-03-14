//
//  NBYesNoAnimation.m
//  Revealer
//
//  Created by Nano8Blazex on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NBYesNoAnimation.h"
#import "NBYesNoButtonCell.h"

@implementation NBYesNoAnimation

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

//WARMING: This class is built for exclusive use with NBYesNoButton and NBYesNoButtonCell
- (void)setCurrentProgress:(NSAnimationProgress)progress {
    // First, invoke super's implementation, so that the NSAnimation will remember the proposed progress value and hand it back to us when we ask for it in NBButtonCell's -drawRect: method.
    [super setCurrentProgress:progress];
    
    // Now ask the NBButtonCell (which set itself as our delegate) to display.  Sending a -display message differs from sending -setNeedsDisplay: or -setNeedsDisplayInRect: in that it demands an immediate, syncrhonous redraw of the view.  Most of the time, it's preferrable to send a -setNeedsDisplay... message, which gives AppKit the opportunity to coalesce potentially numerous display requests and update the window efficiently when it's convenient.  But for a syncrhonously executing animation, it's appropriate to use -display.
    [(NBYesNoButtonCell *)[self delegate] updateAnimation:self];
}

@end
