//
//  NBFilePanelController.m
//  NanoCustomizer
//
//  Created by Ben on 3/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NBFilePanelController.h"
#import <OSAKit/OSAKit.h>
#import "Constants.h"


@implementation NBFilePanelController

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)inCoder {
    return [self init];
}



-(void)awakeFromNib { //awaked every time app is started
    [self checkButtonState];
    [fileText setAlphaValue:0.0];
    [progress setAlphaValue:0.0]; 
    
    // register self for a notification just in case another process has also revealed/hidden the file
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(checkButtonState) name:@"FileRevealerStatusChanged" object:nil suspensionBehavior:NSNotificationSuspensionBehaviorCoalesce];
}


- (void)dealloc
{
    [[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}



#pragma mark state Methods

- (void)checkButtonState {
    // check if files are hidden and hide buttons accordingly
    if ([self filesAreHidden]==YES) {
        [toggleButton setState:NSOnState]; //offer user to show files
        [showItem setEnabled:YES];
        [hideItem setEnabled:NO];
    } else {
        [toggleButton setState:NSOffState]; //offer user to hide files
        [showItem setEnabled:NO];
        [hideItem setEnabled:YES];
    }
}

- (BOOL)filesAreHidden {	
	NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Library/Preferences/com.apple.finder.plist"];	
	if(filePath==nil){
		return YES;
	}
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    id value = [plistDict objectForKey:settingsKey];
	if(value==[NSNumber numberWithBool:(BOOL)YES]) {
        if (plistDict) [plistDict release];
		return NO; //already visible
	}
    if ([value isKindOfClass:[NSString class]]) { // just in case its written as a string
        if ([(NSString *)value isEqualToString:@"YES"]) {
            if (plistDict) [plistDict release];
            return NO; //already visible
        }
    }
    if (plistDict) [plistDict release];
    return YES; //already hidden, default (if key not set)
    
    //Version: USE THE TERMINAL METHOD INSTEAD: 
    /*NSString *terminalScript = @"defaults read com.apple.finder AppleShowAllFiles";
    OSAScript *checkStatus = [[OSAScript alloc] initWithSource:[NSString stringWithFormat:@"do shell script \"%@\"", terminalScript]];
    NSAppleEventDescriptor *result = [checkStatus executeAndReturnError:nil];
    NSString *value = [result stringValue];
    [checkStatus release];
    
    if ([value isEqualToString:@"YES"]) return NO;
    else if ([value isEqualToString:@"NO"]) return YES;
    else if ([value isEqualToString:@"1"]) return NO;
    else if ([value isEqualToString:@"0"]) return YES;
    return YES; //already hidden since key is not set*/
}

-(void)startAnimation {
    [progress startAnimation:self];
    [[progress animator] setAlphaValue:1.0]; 
    [[fileText animator] setAlphaValue:1.0];
    [toggleButton setEnabled:NO];
}

-(void)stopAnimation {
    [progress stopAnimation:self]; 
	[self checkButtonState]; //to reset Button enabling
	[[fileText animator] setAlphaValue:0.0];
    [[progress animator] setAlphaValue:0.0]; 
    [toggleButton setEnabled:YES];
    //[[NSApplication sharedApplication] deactivate];
}

#pragma mark Worker Methods

-(void)quitFinder {
    /*NSAppleScript *restartFinder = [[NSAppleScript alloc] initWithSource:@"tell application \"Finder\" to quit"];
	[restartFinder executeAndReturnError:nil];
    [restartFinder release];*/
    
    //Let's use OSAScript since NSAppleScript seems to leak
    OSAScript *restartFinder = [[OSAScript alloc] initWithSource:@"tell application \"Finder\" to quit"];
    [restartFinder executeAndReturnError:nil];
    [restartFinder release];
}

-(void)startFinder {
    /*NSAppleScript *restartFinder = [[NSAppleScript alloc] initWithSource:@"tell application \"Finder\" to activate"];
	[restartFinder executeAndReturnError:nil];
	//tell Finder to activate
	[restartFinder release];*/
    
    //Let's use OSAScript since NSAppleScript seems to leak
    OSAScript *restartFinder = [[OSAScript alloc] initWithSource:@"tell application \"Finder\" to activate"];
    [restartFinder executeAndReturnError:nil];
    [restartFinder release];
}

-(void)restartFinder {
    //tell Finder to quit
	[self performSelectorOnMainThread:@selector(quitFinder) withObject:nil waitUntilDone:YES]; //NSApplescript Must be used on the main thread
	sleep(2);
    [self performSelectorOnMainThread:@selector(startFinder) withObject:nil waitUntilDone:YES];
	sleep(3);
    //all that sleep! to make sure Finder starts
    
}

- (BOOL)setShowFiles:(BOOL)should {
    
    /*
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Library/Preferences/com.apple.finder.plist"];
	if(filePath==nil){
		return NO;
	}	
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];	
    if(plistDict==nil){
		return NO;
	}
	[plistDict setObject:[NSNumber numberWithBool:(BOOL)should] forKey:settingsKey];
	BOOL returnValue = [plistDict writeToFile:filePath atomically:YES];
    if (plistDict) [plistDict release];
    return returnValue;
     */
    NSString *terminalScript = @"defaults write com.apple.finder AppleShowAllFiles ";
    if(should) {
        terminalScript = [terminalScript stringByAppendingString:@"YES"];
    } else {
        terminalScript = [terminalScript stringByAppendingString:@"NO"];
    }
    OSAScript *setStatus = [[OSAScript alloc] initWithSource:[NSString stringWithFormat:@"do shell script \"%@\"", terminalScript]];
    NSAppleEventDescriptor *result = [setStatus executeAndReturnError:nil];
    [setStatus release];
    if(result) return YES;
    else return NO;
}

-(void)performShowFiles:(NSNumber *)shouldShow {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    BOOL show = [shouldShow boolValue];
    BOOL successful = [self setShowFiles:show];
    if (successful) [self restartFinder];
    else {
        // there was an error writing the plist file
        NSString *appName = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
        NSString *errorText = [appName stringByAppendingString:@" was not successful in "];
        
        if (show) {
            errorText = [errorText stringByAppendingString:@"revealing hidden files and directories."];
        } else errorText = [errorText stringByAppendingString:@"hiding hidden files and directories."];
        
        NSArray *keys = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, NSLocalizedRecoverySuggestionErrorKey, nil];
        NSArray *objects = [NSArray arrayWithObjects:errorText, @"Please try restarting your computer and trying again. If that fails, contact support using details given in the Help menu.", nil];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        NSError *error = [NSError errorWithDomain:@"com.nano8blazex.revealer" code:1 userInfo:userInfo];
        if (error) [[NSAlert alertWithError:error] runModal];
    }
    [self performSelectorOnMainThread:@selector(stopAnimation) withObject:nil waitUntilDone:YES];
    [pool drain];
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"FileRevealerStatusChanged" object:nil];
}

#pragma mark IBActions

-(IBAction)showFiles:(id)sender {
    [self performSelectorInBackground:@selector(performShowFiles:) withObject:[NSNumber numberWithBool:YES]];
}

-(IBAction)hideFiles:(id)sender {
    [self performSelectorInBackground:@selector(performShowFiles:) withObject:[NSNumber numberWithBool:NO]];
}

-(IBAction)hideOrShowFilesBasedOnStateOfButton:(id)sender {
    if (![sender isKindOfClass:[NSButton class]]) return;
    [self startAnimation];
    if ([(NSButton *)sender state]==NSOffState) { // user intends to show hidden items
        [self showFiles:sender];
    } else if ([(NSButton *)sender state]==NSOnState){ // user intends to hide hidden items
        [self hideFiles:sender];
    }
}




@end
