//
//  MsgComm.h
//  NFSJoystick
//
//  Created by yongchang hu on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



#import "SendMsgProcotolEngine.h"

#define SEND_MSG_PE [SendMsgProcotolEngine sharedInstance]

#define DISAPPEAR_VIEW [UIView beginAnimations:nil context:nil];\
[UIView setAnimationDuration:0.5];\
[UIView setAnimationBeginsFromCurrentState:YES];  \
self.view.center = CGPointMake(160,-240);\
[UIView setAnimationDelegate:self.view];\
[UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];\
[UIView commitAnimations];\

#define SCROLL_BUTTON_VIEW_HEIGHT 90

#define GET_LOCAL_LANGUAGE NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];\
NSArray* languages = [defs objectForKey:@"AppleLanguages"];\
NSString* currentLanguage = [languages objectAtIndex:0];
