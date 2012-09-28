//
//  MainViewController.h
//  NFSJoystick
//
//  Created by Jeff LaMarche on 7/24/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
#import "MouseView.h"
#include <AudioToolbox/AudioToolbox.h>
//#import <QuartzCore/QuartzCore.h>
#import "ChooseWhichVersion.h"
#import "HandleView2.h"
#import "HandleView3.h"
#import "QuickSwitchHelpView.h"
#import "KeyboardViewController.h"
#import "NFSBaseViewController.h"
#import "HelicopterAddViewController.h"
#import "SendMsgProcotolEngine.h"
@class MouseView;
@class HandleView;
@class HorizMouseView;
@class RootViewController;
@interface MainViewController : NFSBaseViewController <UIApplicationDelegate,ChooseWhichVersionDelegate,UITextFieldDelegate,UIActionSheetDelegate,LSBaseAcceleEngineDelegate,SendMSGEngineDelegate,UIScrollViewDelegate>{
	HandleView *handleViewController;
    HandleView2 *handleViewController2;
    HandleView3 *handleViewController3;
    QuickSwitchHelpView *quickSwitchHelpView;
    KeyboardViewController *keyboardViewController;
    HelicopterAddViewController *helicopterViewController;
    
	MouseView *mouseViewController;
	HorizMouseView *horizMouseViewController;
    
	IBOutlet UIButton *switchButton;
	
	//BOOL isSendMsg;
	CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;

    CFURLRef		soundFileURLRef2;
	SystemSoundID	soundFileObject2;
    
    CFURLRef		soundFileURLRef3;
	SystemSoundID	soundFileObject3;
    

	
    RootViewController *rootViewController;
    CGPoint deviceTilt;
 
    BOOL received_Msg;

    BOOL iphone_horiz_state;
    ChooseWhichVersion *chooseWhichVersion;
    BOOL pageControlUsed;
}
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, retain) UIScrollView *scrollButtonView;
@property (nonatomic, retain) MouseView *mouseViewController;
@property (nonatomic, retain) HandleView *handleViewController;
@property (nonatomic, retain) HandleView2 *handleViewController2;
@property (nonatomic, retain) HandleView3 *handleViewController3;
@property (nonatomic, retain) QuickSwitchHelpView *quickSwitchHelpView;
@property (nonatomic, retain) KeyboardViewController *keyboardViewController;
@property (nonatomic, retain) HorizMouseView *horizMouseViewController;
@property (nonatomic, retain) HelicopterAddViewController *helicopterViewController;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (readwrite)	CFURLRef		soundFileURLRef2;
@property (readonly)	SystemSoundID	soundFileObject2;

@property (readwrite)	CFURLRef		soundFileURLRef3;
@property (readonly)	SystemSoundID	soundFileObject3;

@property (nonatomic, retain) UIButton *switchButton;

@property (nonatomic, retain) ChooseWhichVersion *chooseWhichVersion;

@property (nonatomic) NSInteger socketPort;
-(void)refreshFields;
- (IBAction)SwitchView:(id)sender;
- (void)showAlertDialog;
- (void) setupApplicationAudio;
-(void)initActiveView;
-(BOOL)ConnectToSocket:(NSString*) socket;

-(void)setRootViewController:(RootViewController*)view;
@end