//
//  NBCAYNCell.h
//  Revealer
//
//  Created by Nano8Blazex on 7/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NBCAYNCell : NSButtonCell {
    @private
    NSImage *mobileImage;
    NSImage *decoImage;
}

@property(retain, nonatomic) NSImage *mobileImage;
@property(retain, nonatomic) NSImage *decoImage;


@end
