//
//  MouseView.h
//  NFSJoystick
//
//  Created by hu yongchang on 5/4/10.
//  Copyright 2010 usa. All rights reserved.
//
#define AD_REFRESH_PERIOD 60 // display fresh ads every 12.5 seconds

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "NFSBaseViewController.h"



@interface MouseView : NFSBaseViewController {

	IBOutlet UIImageView *MoveImage;
	CGPoint mouseDownPoint;
	int circlecount;
	CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
	CFURLRef		soundFileURLRef2;
	SystemSoundID	soundFileObject2;

    BOOL isEnableDrag;
	IBOutlet UIImageView *backgroundView;
	//admob

}
@property CGPoint mouseDownPoint;

@property int circlecount;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (readwrite)	CFURLRef		soundFileURLRef2;
@property (readonly)	SystemSoundID	soundFileObject2;



//advi
@property (nonatomic, retain) UIImageView *backgroundView;


- (void) setupApplicationAudio;
@end



