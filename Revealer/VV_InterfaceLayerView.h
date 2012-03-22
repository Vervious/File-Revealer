//
//  VV_InterfaceLayerView.h
//  Revealer
//
//  Created by Nano8Blazex on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VV_InterfaceLayerView : NSView {
    NSButton *mainButton;
    NSImageView *frontUI;
}

@property (nonatomic, readonly) IBOutlet NSButton *mainButton;
@property (nonatomic, readonly) IBOutlet NSImageView *frontUI;


@end
