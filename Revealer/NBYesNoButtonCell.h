//
//  NBYesNoButtonCell.h
//  Revealer
//
//  Created by Nano8Blazex on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>
#import "NBYesNoAnimation.h"

@interface NBYesNoButtonCell : NSButtonCell <NSAnimationDelegate> {
@private
    NBYesNoAnimation *theAnimator;
    NSMutableDictionary *collectionOfFrames;
    NSMutableArray *arrayOfKeysForFrames;
    NSImage *atlasImage;
    int currentFrameNumber;
}

-(void)updateAnimation:(NBYesNoAnimation *)animator;
-(NSMutableDictionary *)loadAtlasData:(NSString*)atlasName intoImage:(NSImage **)atlas intoArrayOfKeys:(NSMutableArray **)array;

@end
