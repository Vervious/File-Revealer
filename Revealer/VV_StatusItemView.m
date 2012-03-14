//
//  VV_StatusItemView.m
//  Verve
//
//  Created by Nano8Blazex on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VV_StatusItemView.h"

@implementation VV_StatusItemView

@synthesize statusItem = _statusItem;
@synthesize image = _image;
@synthesize alternateImage = _alternateImage;
@synthesize isHighlighted = _isHighlighted;
@synthesize action = _action;
@synthesize target = _target;

#pragma mark -

- (id)initWithStatusItem:(NSStatusItem *)statusItem
{
    CGFloat itemWidth = [statusItem length];
    CGFloat itemHeight = [[NSStatusBar systemStatusBar] thickness];
    NSRect itemRect = NSMakeRect(0.0, 0.0, itemWidth, itemHeight);
    self = [super initWithFrame:itemRect];
    
    if (self != nil)
    {
        _statusItem = [statusItem retain];
    }
    return self;
}

- (void)dealloc
{
    [_statusItem release];
    [_image release];
    [_alternateImage release];
    
    [super dealloc];
}

#pragma mark -

- (void)drawRect:(NSRect)dirtyRect
{
	[self.statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:self.isHighlighted];
    
    NSImage *icon = self.isHighlighted ? self.alternateImage : self.image;
    NSSize iconSize = [icon size];
    NSRect bounds = self.bounds;
    CGFloat iconX = roundf((NSWidth(bounds) - iconSize.width) / 2);
    CGFloat iconY = roundf((NSHeight(bounds) - iconSize.height) / 2);
    NSPoint iconPoint = NSMakePoint(iconX, iconY);
    [icon compositeToPoint:iconPoint operation:NSCompositeSourceOver];
}

#pragma mark -
#pragma mark Mouse tracking

- (void)mouseDown:(NSEvent *)theEvent
{
    [NSApp sendAction:self.action to:self.target from:self];
}

#pragma mark -
#pragma mark Accessors

- (void)setHighlighted:(BOOL)newFlag
{
    if (_isHighlighted == newFlag) return;
    _isHighlighted = newFlag;
    [self setNeedsDisplay:YES];
}

- (NSRect)screenRect {
    return [self.window convertRectToScreen:[self frame]];
}

// a point that other windows can position themselves in reference to
- (NSPoint)referencePoint {
    return NSMakePoint(NSMidX(self.screenRect),
                       NSMinY(self.screenRect));
}

#pragma mark -

- (void)setImage:(NSImage *)newImage
{
    [newImage retain];
    [_image release];
    _image = newImage;
    [self setNeedsDisplay:YES];
}

- (void)setAlternateImage:(NSImage *)newImage
{
    [newImage retain];
    [_alternateImage release];
    _alternateImage = newImage;
    if (self.isHighlighted)
        [self setNeedsDisplay:YES];
}


@end
