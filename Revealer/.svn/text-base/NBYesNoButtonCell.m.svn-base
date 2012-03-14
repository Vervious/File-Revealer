//
//  NBYesNoButtonCell.m
//  Revealer
//
//  Created by Nano8Blazex on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NBYesNoButtonCell.h"
#import "NBYesNoAnimation.h"

@implementation NBYesNoButtonCell

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code here.
        arrayOfKeysForFrames = nil;
        collectionOfFrames = nil;
        collectionOfFrames = [self loadAtlasData:@"NBYesNoButton.png" intoImage:&atlasImage intoArrayOfKeys:&arrayOfKeysForFrames];  //now atlasImage containsi an image and arrayOfFrames the data
        [self setImageScaling:NSImageScaleNone];
        currentFrameNumber = 0; // 0 to 82
    }
    
    return self;
}

#pragma mark ATLAS STUFF MATERIAL MANAGEMENT



-(NSMutableDictionary *)loadAtlasData:(NSString*)atlasName intoImage:(NSImage **)atlas intoArrayOfKeys:(NSMutableArray **)array
{
	NSAutoreleasePool * apool = [[NSAutoreleasePool alloc] init];	
	NSMutableDictionary *frameFrames = [[NSMutableDictionary alloc] init];
    if (*array!=nil) {
        [*array release];
    }
    *array = [[NSMutableArray alloc] init];
	
    *atlas = [NSImage imageNamed:atlasName];	
	NSDictionary *items = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] 
																	  pathForResource:[atlasName stringByDeletingPathExtension] 
																	  ofType:@"plist"]];
	
    NSDictionary * itemData = [items objectForKey:@"frames"]; //frames
    NSString *frame; NSRect rect;
	for (id key in itemData){
		
		NSDictionary * record = [itemData objectForKey:key];
		if ([record count]>0) {
			rect = NSRectFromString([record objectForKey:@"textureRect"]);
            rect.origin.y = [*atlas size].height - rect.origin.y - rect.size.height; // to "unflip" the coordinates (the system is kinda weird... nsbutton is flipped I think.)
            frame = NSStringFromRect(rect);
			[frameFrames setObject:frame forKey:key]; // first frame is "YES" state, last is "NO" state
		}
		
	}
    
    // now get key names in order
    
    for (int i=0; i<[itemData count]; i++) {
        [*array addObject:[NSString stringWithFormat:@"YesNoButton_%04d_Frame-%d.png", i, 83-i]];
    }
    
	[apool drain];
    return frameFrames;
}

                     

#pragma mark ANIMATION AND UI

-(void)startAnimation {
    // start animation
    theAnimator = [[NBYesNoAnimation alloc] initWithDuration:1.0
                                         animationCurve:NSAnimationEaseIn];
    [theAnimator setFrameRate:60.0];
    [theAnimator setAnimationBlockingMode:NSAnimationNonblocking];
    [theAnimator setDelegate:self];
    
    [theAnimator startAnimation];
    [theAnimator release]; //theAnimator retains itself in startAnimation and then autoreleases
}

- (void)highlight:(BOOL)flag withFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    [self startAnimation];
}

- (void)updateAnimation:(NBYesNoAnimation *)animator {
    currentFrameNumber = (int)([animator currentValue]*82);
    [[self controlView] display]; //immediate, syncrhonous redraw of the view
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    NSRect frameRect = NSRectFromString([collectionOfFrames objectForKey:[arrayOfKeysForFrames objectAtIndex:currentFrameNumber]]);
    NSRect destinationRect = [controlView bounds];
    [controlView lockFocus];
    [atlasImage drawInRect:destinationRect fromRect:frameRect  operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
    [controlView unlockFocus];
}

                                                         
- (void) dealloc {
    if (arrayOfKeysForFrames!=nil) [arrayOfKeysForFrames release];
    if (collectionOfFrames!=nil) [collectionOfFrames release];
}

@end
