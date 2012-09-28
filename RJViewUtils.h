//
//  RJViewUtils.h
//  RuijiMOA
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//
//RJViewUtils
//
//@interface RJViewUtils : NSObject
//+ (void)messageBox:(NSString*)aTitle message:(NSString*)aMessage;
//+ (void)messageBox:(NSString *)aTitle message:(NSString *)aMessage viewTag:(NSInteger)aViewTag delegate:(id/*<UIAlertViewDelegate>*/)aDelegate;
//@end

//
//UIView (RJ_Additional)
//
@interface UIView (RJ_Additional)
- (void)setViewOrigin:(CGPoint)point;
- (void)setViewSize:(CGSize)size;

- (BOOL)findAndResignFirstResponder;
@end

//
//UIBarButtonItem (RJAddiational)
//
@interface UIBarButtonItem (RJAddiational)
- (id)initWithCustom:(UIImage*)aImageName  bgImage:(UIImage*)aBgImage
              target:(id)aTarget action:(SEL)aAction;
- (id)initWithCustomWithTitle:(NSString*)aTitle bgImage:(UIImage*)aBgImage
                       target:(id)aTarget action:(SEL)aAction;
@end