//
//  ChooseWhichVersion.h
//  NFSJoystick
//
//  Created by  on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChooseWhichVersionDelegate <NSObject>
@required
- (void) GoBackToMainView;
- (void) GoBackToMainViewNo1;
-(BOOL) Noza_f_whether_Lock_Level_6;
- (void) GoBackToMainViewKeyboard;
- (void) GoBackToMainViewNo2;
- (void) buyTheAppAndSwitch;
- (void) GoBackToMainViewNo4;
-(void) GoBackToMainToHelicopter;
@end

@interface ChooseWhichVersion : UIViewController{
    id <ChooseWhichVersionDelegate> delegate;
// IBOutlet   UIImageView *hidenImage;
    IBOutlet UIButton *hidenButton;
    
}
@property (nonatomic, retain) id <ChooseWhichVersionDelegate> delegate;
//@property (nonatomic, retain) UIImageView *hidenImage;
@property (nonatomic, retain) UIButton *hidenButton;
@property (nonatomic, retain) IBOutlet UIButton *AdsButton;

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event;
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event;


@end
