//
//  VV_StatusItemView.h
//  Verve
//
//  Created by Nano8Blazex on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*
 NOTE: Code borrowed from Shpakovski's "In Code We Trust"
 http://blog.shpakovski.com/2011/07/cocoa-popup-window-in-status-bar.html
 All credit goes to him.
 */

@interface VV_StatusItemView : NSView {
    @private
    NSImage *_image;
    NSImage *_alternateImage;
    NSStatusItem *_statusItem;
    BOOL _isHighlighted;
    SEL _action;
    id _target;
}

- (id)initWithStatusItem:(NSStatusItem *)statusItem;

@property (nonatomic, readonly) NSStatusItem *statusItem;
@property (nonatomic, retain) NSImage *image;
@property (nonatomic, retain) NSImage *alternateImage;
@property (nonatomic, setter = setHighlighted:) BOOL isHighlighted;
@property (nonatomic) SEL action;
@property (nonatomic, assign) id target;
@property (nonatomic, readonly) NSRect screenRect; // our coordinates
@property (nonatomic, readonly) NSPoint referencePoint; // a point that other windows can position themselves in reference to

@end
