//
//  VV_InterfaceBackgroundView.m
//  Verve
//
//  Created by Nano8Blazex on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VV_InterfaceBackgroundView.h"

// we will use CALayers to draw so that z-positions aren't messed up
// but we will use NSViews at the same time


// interface view specifics
#define FILL_OPACITY .95
#define STROKE_OPACITY 1
#define SHADOW_OPACITY .5
#define LINE_THICKNESS 0
#define CORNER_RADIUS 15
#define ARROW_WIDTH 15
#define ARROW_HEIGHT 10
#define FILL 0.95
#define STROKE 1
#define SHADOW 1


@implementation VV_InterfaceBackgroundView

@synthesize arrowXLocation, layerView;


#pragma mark CALayers

- (CALayer *)newRootLayer {
    CALayer *rootLayer = [CALayer layer];
    return rootLayer;
}


- (CALayer *)prepareAndReturnRootLayer {
    CALayer *rootLayer = [self newRootLayer];
    rootLayer.masksToBounds = NO;
    return rootLayer;
}

#pragma mark initializationa and drawing

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        arrowXLocation = NSMidX(frame);
    }
    
    return self;
}

// draw the background/shape of the interface
- (void)drawRect:(NSRect)dirtyRect
{
    int _arrowX = arrowXLocation;
    
    NSRect contentRect = NSInsetRect([self bounds], LINE_THICKNESS, LINE_THICKNESS);
    NSBezierPath *path = [NSBezierPath bezierPath];
    
    // start to draw the arrow and the top
    [path moveToPoint:NSMakePoint(_arrowX, NSMaxY(contentRect))];
    [path lineToPoint:NSMakePoint(_arrowX + ARROW_WIDTH / 2, NSMaxY(contentRect) - ARROW_HEIGHT)];
    [path lineToPoint:NSMakePoint(NSMaxX(contentRect) - CORNER_RADIUS, NSMaxY(contentRect) - ARROW_HEIGHT)];
    
    // draw the top right
    NSPoint topRightCorner = NSMakePoint(NSMaxX(contentRect), NSMaxY(contentRect) - ARROW_HEIGHT);
    [path curveToPoint:NSMakePoint(NSMaxX(contentRect), NSMaxY(contentRect) - ARROW_HEIGHT - CORNER_RADIUS)
         controlPoint1:topRightCorner controlPoint2:topRightCorner];
    
    // draw the right
    [path lineToPoint:NSMakePoint(NSMaxX(contentRect), NSMinY(contentRect) + CORNER_RADIUS)];
    
    // draw the bottom right
    NSPoint bottomRightCorner = NSMakePoint(NSMaxX(contentRect), NSMinY(contentRect));
    [path curveToPoint:NSMakePoint(NSMaxX(contentRect) - CORNER_RADIUS, NSMinY(contentRect))
         controlPoint1:bottomRightCorner controlPoint2:bottomRightCorner];
    
    // draw the bottom
    [path lineToPoint:NSMakePoint(NSMinX(contentRect) + CORNER_RADIUS, NSMinY(contentRect))];
    
    // draw the bottom left
    [path curveToPoint:NSMakePoint(NSMinX(contentRect), NSMinY(contentRect) + CORNER_RADIUS)
         controlPoint1:contentRect.origin controlPoint2:contentRect.origin];
    
    // draw left
    [path lineToPoint:NSMakePoint(NSMinX(contentRect), NSMaxY(contentRect) - ARROW_HEIGHT - CORNER_RADIUS)];
    
    // draw top left
    NSPoint topLeftCorner = NSMakePoint(NSMinX(contentRect), NSMaxY(contentRect) - ARROW_HEIGHT);
    [path curveToPoint:NSMakePoint(NSMinX(contentRect) + CORNER_RADIUS, NSMaxY(contentRect) - ARROW_HEIGHT)
         controlPoint1:topLeftCorner controlPoint2:topLeftCorner];
    
    // finish top
    [path lineToPoint:NSMakePoint(_arrowX - ARROW_WIDTH / 2, NSMaxY(contentRect) - ARROW_HEIGHT)];
    
    [path closePath];
    
    // fill with white
    [[NSColor colorWithDeviceWhite:FILL alpha:FILL_OPACITY] setFill];
    [path fill];
    
    
    // now stroke/shadow it
    // the shadow of the window adds a dark stroke
    // so note that this is the "inner stroke"
    [NSGraphicsContext saveGraphicsState];
    
    [path addClip];
    
    NSShadow * shadow = [[[NSShadow alloc] init] autorelease];
    [shadow setShadowColor:[NSColor colorWithDeviceWhite:SHADOW alpha:SHADOW_OPACITY]];
    [shadow setShadowBlurRadius:20.0];
    [shadow set];
    
    [path setLineWidth:LINE_THICKNESS];
    [[NSColor colorWithDeviceWhite:STROKE alpha:STROKE_OPACITY] setStroke];
    [path stroke];
    
    [NSGraphicsContext restoreGraphicsState];
    
}

@end
