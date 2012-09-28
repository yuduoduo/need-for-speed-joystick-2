//
//  UIViewController+Alerts.m
//  NFSJoystick
//
//  Created by  on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+Alerts.h"

@implementation UIViewController (Alerts)

- (void)presentAlertViewController:(UIViewController *)alertViewController animated:(BOOL)animated
{
    // Setup frame of alert view we're about to display to just off the bottom of the view
    [alertViewController.view setFrame:CGRectMake(0, self.view.frame.size.height, alertViewController.view.frame.size.width, alertViewController.view.frame.size.height)];
    
    // Tag this view so we can find it again later to dismiss
    alertViewController.view.tag = 253;
    
    // Add new view to our view stack
    [self.view addSubview:alertViewController.view];
    
    // animate into position
    [UIView animateWithDuration:(animated ? 0.5 : 0.0) animations:^{
        [alertViewController.view setFrame:CGRectMake(0, (self.view.frame.size.height - alertViewController.view.frame.size.height) / 2, alertViewController.view.frame.size.width, alertViewController.view.frame.size.height)];
    }];      
}

- (void)dismissAlertViewControllerAnimated:(BOOL)animated
{
    UIView *alertView = nil;
    
    // find our tagged view
    for (UIView *tempView in self.view.subviews)
    {
        if (tempView.tag == 253)
        {
            alertView = tempView;
            break;
        }
    }
    
    if (alertView)
    {
        // clear tag
        alertView.tag = 0;
        
        // animate out of position
        [UIView animateWithDuration:(animated ? 0.5 : 0.0) animations:^{
            [alertView setFrame:CGRectMake(0, self.view.frame.size.height, alertView.frame.size.width, alertView.frame.size.height)];
        }];      
    }
}

@end
