//
//  UIViewController+Alerts.h
//  NFSJoystick
//
//  Created by  on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alerts)

- (void)presentAlertViewController:(UIViewController *)alertViewController animated:(BOOL)animated;
- (void)dismissAlertViewControllerAnimated:(BOOL)animated;

@end
