//
//  NBYesNoSecondaryView.h
//  Revealer
//
//  Created by Nano8Blazex on 7/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "NBCAYNCell.h"

@interface NBYesNoSecondaryView : NSView {
    NBCAYNCell *cell;
    NSString *name;
}

@property (nonatomic, retain) NBCAYNCell *cell;
@property(nonatomic, retain) NSString *name;

@end
