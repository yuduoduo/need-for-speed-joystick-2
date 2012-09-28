//
//  RJViewUtils.m
//  RuijiMOA
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJViewUtils.h"

//
//RJViewUtils
//
#define RJViewUtilsStringConfirm            @"确定"
#define RJViewUtilsStringCancel             @"取消"

//@implementation RJViewUtils
//+ (void)messageBox:(NSString*)aTitle message:(NSString*)aMessage
//{
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:aTitle message:aMessage delegate:nil cancelButtonTitle:RJViewUtilsStringConfirm otherButtonTitles:nil];
//    [alertView show];
//    [alertView release];
//}
//
//+ (void)messageBox:(NSString *)aTitle message:(NSString *)aMessage viewTag:(NSInteger)aViewTag delegate:(id/*<UIAlertViewDelegate>*/)aDelegate
//{
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:aTitle message:aMessage delegate:aDelegate cancelButtonTitle:RJViewUtilsStringConfirm otherButtonTitles:nil];
//    alertView.tag = aViewTag;
//    [alertView show];
//    [alertView release];
//}
//@end

//
//UIView (RJ_Additional)
//
@implementation UIView (RJ_Additional)
- (void)setViewOrigin:(CGPoint)point
{
    CGRect rect = self.frame;
    rect.origin = point;
    self.frame = rect;
}

- (void)setViewSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (BOOL)findAndResignFirstResponder
{
    if (self.isFirstResponder)
    {
        [self resignFirstResponder];
        return YES;     
    }
    for (UIView *subView in self.subviews) 
    {
    if ([subView findAndResignFirstResponder])
        return YES;
    }
    return NO;
}

@end

//
//UIBarButtonItem (XRJAddiational)
//
@implementation UIBarButtonItem (XRJAddiational)
- (id)initWithCustom:(UIImage*)aImageName  bgImage:(UIImage*)aBgImage
              target:(id)aTarget action:(SEL)aAction
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,38,28);
    [button setImage:aImageName forState:UIControlStateNormal];
    [button setBackgroundImage:aBgImage forState:UIControlStateNormal];
    [button addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
    
    self = [self initWithCustomView:button];
    self.target = aTarget;
    self.action = aAction;
    return self;
}

- (id)initWithCustomWithTitle:(NSString*)aTitle bgImage:(UIImage*)aBgImage
                       target:(id)aTarget action:(SEL)aAction
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIFont* font = [UIFont systemFontOfSize:13.0f];
    button.titleLabel.font = font;
    CGSize size = [aTitle sizeWithFont:font];
    NSInteger buttonWidth = 0;
    if (size.width < 41)
    {
        buttonWidth = 41;
    }
    else 
    {
        buttonWidth = 60;
    }
    
    button.frame = CGRectMake(0,0,buttonWidth,29);
    
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setBackgroundImage:aBgImage forState:UIControlStateNormal];
    [button addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
    
    self = [self initWithCustomView:button];
    self.target = aTarget;
    self.action = aAction;
    return self;
}
@end
