//
//  HandleView.h
//  NFSJoystick
//
//  Created by hu yongchang on 5/4/10.
//  Copyright 2010 usa. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "NFSBaseViewController.h"


@interface HandleView : NFSBaseViewController<LSBaseAcceleEngineDelegate> {

	CGPoint deviceTilt;
	
	NSTimer *timer;
	
	IBOutlet UIButton *Object; CGPoint position;
	
	int circlecount;
	//roate
	UIView *Steeringwheel;
	bool circleLeft;
	bool circleRight;
	float oldAcleY;
	int controlSendSpeed;
	bool turnLeft;
	bool turnRight;
}

@property (nonatomic, retain) IBOutlet UIButton *Object;
@property int circlecount;
@property int controlSendSpeed;

@property (nonatomic, retain) IBOutlet UIView *Steeringwheel;
					
- (IBAction)LeftMouseDownClick:(id)sender;
- (IBAction)RightMouseDownClick:(id)sender;
- (IBAction)UpMouseDownClick:(id)sender;
- (IBAction)DowntMouseDownClick:(id)sender;

- (IBAction)LeftMouseUpClick:(id)sender;
- (IBAction)RightMouseUpClick:(id)sender;
- (IBAction)UpMouseUpClick:(id)sender;
- (IBAction)DowntMouseUpClick:(id)sender;
-(IBAction)goBackToMain:(id)sender;

-(void)SteeringwheelRoat:(int)angle;

@end
