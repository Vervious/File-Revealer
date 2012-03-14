//
//  NBFilePanelController.h
//  Revealer
//  This is a modified version of NBFilePanelController in NanoCustomizer adapted to match a new user interface
//
//  Created by Ben on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NBFilePanelController: NSObject {
@private
    IBOutlet NSProgressIndicator *progress;
	IBOutlet NSButton *toggleButton;
	IBOutlet NSTextField *fileText;
    IBOutlet NSMenuItem *showItem;
    IBOutlet NSMenuItem *hideItem;
}

-(BOOL)filesAreHidden;
-(void)checkButtonState;
-(IBAction)hideOrShowFilesBasedOnStateOfButton:(id)sender;
-(IBAction)hideFiles:(id)sender;
-(IBAction)showFiles:(id)sender;

@end
