//
//  ScrollSubViewController.h
//  NFSJoystick
//
//  Created by yongchang hu on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollSubViewController : UIViewController
{
    NSInteger pageNumber;
}
- (id)initWithPageNumber:(int)page;
@end
