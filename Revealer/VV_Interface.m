//
//  VV_Interface.m
//  Verve
//
//  Created by Nano8Blazex on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VV_Interface.h"

@implementation VV_Interface

@synthesize interface;

- (BOOL)canBecomeKeyWindow {
    return YES; // need to set this because titleless is default NO
}

@end
