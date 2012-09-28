//
//  main.m
//  NFSJoystick
//
//  Created by Jeff LaMarche on 7/24/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFSJoystickAppDelegate.h"
int main(int argc, char *argv[]) {
	
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([NFSJoystickAppDelegate class]));
	[pool release];
	return retVal;
}
