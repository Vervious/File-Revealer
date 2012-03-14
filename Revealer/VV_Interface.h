//
//  VV_Interface.h
//  Verve
//
//  Created by Nano8Blazex on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "VV_InterfaceBackgroundView.h"

@interface VV_Interface : NSPanel {
    @private
    VV_InterfaceBackgroundView *interface;
}

@property (nonatomic, retain) IBOutlet VV_InterfaceBackgroundView *interface;

@end
