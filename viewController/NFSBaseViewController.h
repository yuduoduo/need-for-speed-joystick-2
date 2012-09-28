//
//  NFSBaseViewController.h
//  NFSJoystick
//
//  Created by yongchang hu on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    LSNavigationbarButtonItem_Left,
    LSNavigationbarButtonItem_Right
}LSNavigationbarButtonItemType;

@protocol LSBaseAcceleEngineDelegate
@optional
- (void)didReceiveAccelerometer:(UIAcceleration *)acceleration;

@end

@class MBProgressHUD;

@interface NFSBaseViewController : UIViewController<UIAccelerometerDelegate>{
    MBProgressHUD* _hud;
    BOOL _isWaiting;
    BOOL completeRoate;
}
@property (nonatomic, assign) id<LSBaseAcceleEngineDelegate> delegate;
@property (nonatomic) BOOL animateFinished;
-(void)startAnimateFont:(NSString*)str frame:(CGRect)frame transfrom:(NSInteger)transfromType;
- (void)startHUDWaiting:(NSString*)aText  controller:(UIViewController*)controller;
- (void)stopHUDWaiting:(UIViewController*)controller;
- (void)stopWaiting;
- (void)startWaiting;
@end
