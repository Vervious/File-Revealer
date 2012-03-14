//
//  NBCAYNCell.m
//  Revealer
//
//  Created by Nano8Blazex on 7/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NBCAYNCell.h"
#import "QuartzCore/QuartzCore.h"
#import "NBYesNoButton.h"

@implementation NBCAYNCell

@synthesize mobileImage, decoImage;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setImageScaling:NSImageScaleNone];
        [self setImage:[NSImage imageNamed:@"Base.png"]];
        [self setAlternateImage:[NSImage imageNamed:@"Base.png"]];
        [self setMobileImage:[NSImage imageNamed:@"MobileFrame.png"]];
        [self setDecoImage:[NSImage imageNamed:@"MobileWindow.png"]];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code here.
        [self setImageScaling:NSImageScaleNone];
        [self setImage:[NSImage imageNamed:@"Base.png"]];
        [self setAlternateImage:[NSImage imageNamed:@"Base.png"]];
        [self setMobileImage:[NSImage imageNamed:@"MobileFrame.png"]];
        [self setDecoImage:[NSImage imageNamed:@"MobileWindow.png"]];
    }
    
    return self;
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    
}

-(void)startAnimationInView:(NSView *)controlView {
    if ([controlView isKindOfClass:[NBYesNoButton class]]) {
        NSView *mobileView = [(NBYesNoButton *)controlView mobileView];
        NSView *decoView = [(NBYesNoButton *)controlView decoView];
        
        // start animation
        CABasicAnimation *theAnimation;
        
        // create the animation object, specifying the position property as the key path
        // the key path is relative to the target animation object (in this case a CALayer)
        theAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
        
        // set the fromValue and toValue to the appropriate points
        NSPoint startPoint = NSPointFromCGPoint([mobileView layer].position);
        theAnimation.fromValue=[NSValue valueWithPoint:startPoint];
        NSPoint endPoint;
        NSRect endRect = [mobileView frame];
        if ([(NSButton *)controlView state]==NSOnState) {
            endPoint = NSMakePoint(startPoint.x + [[self image] size].width - [[self mobileImage] size].width, startPoint.y);
            endRect.origin = NSMakePoint(endRect.origin.x + [[self image] size].width - [[self mobileImage] size].width, endRect.origin.y);
        } else if ([(NSButton *)controlView state]==NSOffState){
            endPoint = NSMakePoint(startPoint.x - ([[self image] size].width - [[self mobileImage] size].width), startPoint.y);
            endRect.origin = NSMakePoint(endRect.origin.x - ([[self image] size].width - [[self mobileImage] size].width), endRect.origin.y);
        }
        theAnimation.toValue=[NSValue valueWithPoint:endPoint];
        
        theAnimation.duration=0.3;
        theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        theAnimation.delegate = self;
        [[mobileView layer] addAnimation:theAnimation forKey:@"moveRight"]; //this also moves decoView
        [[decoView layer] addAnimation:theAnimation forKey:@"moveRight"]; //this also moves decoView
        [mobileView setFrame:endRect];
        [decoView setFrame:endRect];
    }
}

/*- (void)highlight:(BOOL)flag withFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    //[self startAnimation];
#include <execinfo.h>
    if (flag==NO) {
    void *addr[2];
    int nframes = backtrace(addr, sizeof(addr)/sizeof(*addr));
    if (nframes > 1) {
        char **syms = backtrace_symbols(addr, nframes);
        NSLog(@"%s: caller: %s", __func__, syms[1]);
        free(syms);
    } else {
        NSLog(@"%s: *** Failed to generate backtrace.", __func__);
    }
    }
}*/

- (BOOL)startTrackingAt:(NSPoint)startPoint inView:(NSView *)controlView {
    //BOOL startTracking = [super startTrackingAt:startPoint inView:controlView];
    [self setMobileImage:[NSImage imageNamed:@"MobileFramePressed.png"]];
    [self setDecoImage:[NSImage imageNamed:@"MobileWindowPressed.png"]];
    [controlView display];
    return YES;
}

-(BOOL)continueTracking:(NSPoint)lastPoint at:(NSPoint)currentPoint inView:(NSView *)view {
    return YES;
}

- (void)stopTracking:(NSPoint)lastPoint at:(NSPoint)stopPoint inView:(NSView *)controlView mouseIsUp:(BOOL)flag {
    [self setMobileImage:[NSImage imageNamed:@"MobileFrame.png"]];
    [self setDecoImage:[NSImage imageNamed:@"MobileWindow.png"]];
    [controlView display];
    if (flag) {
        [self startAnimationInView:controlView];
    }    
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView { //controlView is loked

    if ([controlView isKindOfClass:[NBYesNoButton class]]) {
        NSRect baseRect = [controlView bounds];
        baseRect.size = [[self image] size];
        [[self image] drawInRect:baseRect fromRect:NSZeroRect  operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
        //no alternate images implemented as they aren't needed

    } else if ([controlView isKindOfClass:[NBYesNoSecondaryView class]]) {        
        NSRect mobileRect = NSMakeRect(0, 0, 0, 0);
        mobileRect.size = [self.mobileImage size];    
        if ([((NBYesNoSecondaryView *) controlView).name isEqualToString:@"mobileView"]) {
            [[self mobileImage] drawInRect:mobileRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0  respectFlipped:YES hints:nil];
        } else if ([((NBYesNoSecondaryView *)controlView).name isEqualToString:@"decoView"]) {
            [[self decoImage] drawInRect:mobileRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0  respectFlipped:YES hints:nil];
        }

    }

}

@end
