//
//  RootViewController.h
//  NFSJoystick
//
//  Created by Jeff LaMarche on 7/24/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "NFSBaseViewController.h"
@class MainViewController;
//@class FlipsideViewController;
@class BoardViewController;
@class SettingViewController;

@interface RootViewController : NFSBaseViewController  <UIAlertViewDelegate>{


	MainViewController *mainViewController;
	//FlipsideViewController *flipsideViewController;
	UINavigationBar *flipsideNavigationBar;
	
    BoardViewController *boardViewController;
    
    
    
    SettingViewController *settingViewController;
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
	CFURLRef		soundFileURLRef2;
	SystemSoundID	soundFileObject2;
}

@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) UINavigationBar *flipsideNavigationBar;
//@property (nonatomic, retain) FlipsideViewController *flipsideViewController;
@property (nonatomic, retain) SettingViewController *settingViewController;
@property (nonatomic, retain) BoardViewController *boardViewController;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (readwrite)	CFURLRef		soundFileURLRef2;
@property (readonly)	SystemSoundID	soundFileObject2;

- (IBAction)toggleView;
//- (IBAction)moreAppView;

-(void)initRateView;
-(BOOL)whetherIsBuyed;
-(void)setMenuIAPState:(int)inivalue;
-(void)loadBoardViewController;
-(void)loadMainViewController;
- (void) setupApplicationAudio ;
-(void)playToggleSound;
-(void)TranslateToNews;
-(void)toggleToMain;

@end
