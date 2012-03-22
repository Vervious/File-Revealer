//
//  NBYesNoButton.m
//  Revealer
//
//  Created by Nano8Blazex on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NBYesNoButton.h"
#import "NBYesNoSecondaryView.h"
#import "QuartzCore/CIFilter.h"
#import "QuartzCore/QuartzCore.h"
#import "Quartz/Quartz.h"

@implementation NBYesNoButton
@synthesize mobileView, decoView;

- (void)awakeFromNib {
    // now set decoView to have a blending mode of "overlay" (making sure 200%)
    
    CIFilter *overlay = [CIFilter filterWithName:@"CIOverlayBlendMode" 
                                   keysAndValues:nil];;
    [[decoView layer] setCompositingFilter:overlay ];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        [self setBordered:NO];
        [self setWantsLayer:YES]; //this screws up the overlay fro some reason
        NSRect subviewRect = [self frame];
        subviewRect.origin = NSMakePoint(0, -1);
        mobileView = [[NBYesNoSecondaryView alloc] initWithFrame:subviewRect];
        [mobileView setCell:[self cell]];
        [mobileView setName:@"mobileView"];
        [self addSubview:mobileView];
        decoView = [[NBYesNoSecondaryView alloc] initWithFrame:subviewRect]; //this is for the blue window "glas/hole"
        [decoView setCell:[self cell]];
        [decoView setName:@"decoView"];
        [self addSubview:decoView];
        [decoView setWantsLayer:YES];
        
        // now set decoView to have a blending mode of "overlay"
        
        CIFilter *overlay = [CIFilter filterWithName:@"CIOverlayBlendMode" 
                                       keysAndValues:nil];;
        [[decoView layer] setCompositingFilter:overlay ];
        
    }
    
    return self;
}

- (void)checkState {
    NSRect mobileRect;
    if ([self state]==NSOffState) {
       mobileRect = NSMakeRect(([[[self cell] image] size].width - [[[self cell] mobileImage] size].width), [mobileView frame].origin.y, [mobileView frame].size.width, [mobileView frame].size.height);
        
    } else if ([self state]==NSOnState) {
        mobileRect = NSMakeRect(0, [mobileView frame].origin.y, [mobileView frame].size.width, [mobileView frame].size.height);
    }
    [mobileView setFrame:mobileRect]; //mobile adn decoview alaways have the same frame
    [decoView setFrame:mobileRect];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code here.
        [self setBordered:NO];
        [self setWantsLayer:YES];
        NSRect subviewRect = [self frame];
        subviewRect.origin = NSMakePoint(0, -1);
        mobileView = [[NBYesNoSecondaryView alloc] initWithFrame:subviewRect];
        [mobileView setCell:[self cell]];
        [mobileView setName:@"mobileView"];
        [self addSubview:mobileView];
        decoView = [[NBYesNoSecondaryView alloc] initWithFrame:subviewRect]; //this is for the blue window "glas/hole"
        [decoView setCell:[self cell]];
        [decoView setName:@"decoView"];
        [self addSubview:decoView];
        [decoView setWantsLayer:YES];
        
        // now set decoView to have a blending mode of "overlay"
        
        CIFilter *overlay = [CIFilter filterWithName:@"CIOverlayBlendMode" 
                                       keysAndValues:nil];;
        [[decoView layer] setCompositingFilter:overlay ];
        

    }
    
    return self;
}

- (void)setState:(NSInteger)value {
    [super setState:value];
    [self checkState];
}

- (void) display {
    [super display];
}

- (void)mouseDown:(NSEvent *)theEvent {
    [super mouseDown:theEvent];
}

- (void)dealloc {
    [mobileView release];
    [super dealloc];
}

@end
