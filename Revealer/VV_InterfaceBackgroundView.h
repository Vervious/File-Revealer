//
//  VV_InterfaceBackgroundView.h
//  Verve
//
//  Created by Nano8Blazex on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VV_InterfaceLayerView.h"

@interface VV_InterfaceBackgroundView : NSView {
    int arrowXLocation;
    VV_InterfaceLayerView *layerView;
}

@property (assign) int arrowXLocation;
@property (nonatomic, readonly) IBOutlet VV_InterfaceLayerView *layerView;

@end
