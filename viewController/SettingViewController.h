//
//  SettingViewController.h
//  NFSJoystick
//
//  Created by  on 11-10-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFSBaseViewController.h"
@class FlipsideViewController;
@class SupportViewController;
@class RootViewController;
@interface SettingViewController : NFSBaseViewController<UIScrollViewDelegate>
{
        UIScrollView *settingScrollView;
    FlipsideViewController *flipsideViewController;
    SupportViewController *supportViewController;
    RootViewController *rootviewController;
}
@property (nonatomic, retain) FlipsideViewController *flipsideViewController;
@property (nonatomic, retain) SupportViewController *supportViewController;

-(void)loadSettingScrollView;
- (void)loadFlipsideViewController ;
- (void)loadSupportViewController ;
-(void)setRootViewController:(RootViewController*)controller;
@end
