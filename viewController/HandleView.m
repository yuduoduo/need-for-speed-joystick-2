//
//  HandleView.m
//  NFSJoystick
//
//  Created by hu yongchang on 5/4/10.
//  Copyright 2010 usa. All rights reserved.
//

#import "HandleView.h"
#import "MsgComm.h"
#import "DefineComm.h"
#define degressToRadian(x) (M_PI * (x)/180.0)

@implementation HandleView

@synthesize Object;
@synthesize circlecount;
@synthesize controlSendSpeed;
@synthesize Steeringwheel;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];


	position = CGPointMake(0,0);
	circlecount = 0;
	controlSendSpeed = 0;
	
	//roate
	//[self SteeringwheelRoat:-90];
	//roate
	CGAffineTransform transform = Steeringwheel.transform;
    transform = CGAffineTransformRotate(transform, degressToRadian(-90));
    Steeringwheel.transform = transform;

	
	circleLeft = FALSE;
	circleRight = FALSE;
	turnLeft = FALSE;
	turnRight = FALSE;
	oldAcleY = 0.0f;

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
	[timer invalidate]; 
	timer = nil; // ensures we never invalidate an already invalid Timer 
}

// UIAccelerometerDelegate method, called when the device accelerates.
- (void)didReceiveAccelerometer:(UIAcceleration *)acceleration {
    // Update the accelerometer graph view
	deviceTilt.x = acceleration.x;
	deviceTilt.y = acceleration.y;
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)ControlSentMsg:(char*)sendToMSG
{
	
}

-(void)onTimer{

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//whether is open
	//BOOL acclec = [[defaults objectForKey:kAcceleKey] boolValue] ;
	//if(!acclec)
	{
	//	return;
	}
	BOOL x = [[defaults objectForKey:kViewSwitchKey] boolValue];
	if(x)//if not handle view 
	{
		return;
	}
	if(circlecount  > 0)
	{
		circlecount += 1;
		if(circlecount > 10)
		{
			circlecount = 0;
			
		}
	}
	
	if(controlSendSpeed  > 0)
	{
		controlSendSpeed += 1;
		if(controlSendSpeed > 10)
		{
			controlSendSpeed = 0;
			
		}
	}
	//NSLog(@"onTimer:x: %f",deviceTilt.x);
	NSLog(@"onTimer:y: %f",deviceTilt.y);
	NSLog(@"oldAcleY:y: %f",oldAcleY);
	
/*
	if(position.x > 240  && circlecount == 0)
	{//up
		circlecount = 1;
		[[self delegate] sendMessageToServer:KEY_UP_CLICK_DOWN_STR];
	}else if(position.x < 60  && circlecount == 0)
	{
	//down
		circlecount = 1;
		[[self delegate] sendMessageToServer:KEY_DOWN_CLICK_DOWN_STR];
	}
	
	if(position.y > 420  && circlecount == 0)
	{//left
		circlecount = 1;
		[[self delegate] sendMessageToServer:KEY_LEFT_CLICK_DOWN_STR];
	}else if(position.y < 60  && circlecount == 0)
	{
		//right
		circlecount = 1;
		[[self delegate] sendMessageToServer:KEY_RIGHT_CLICK_DOWN_STR];
	}
*/
	/*
	if(deviceTilt.y > 0.15f)
	{
		if(deviceTilt.y > oldAcleY)
		{
			//if right is on,turn down
			if(turnRight ==  TRUE && controlSendSpeed == 0)
			{
				//stop right
				turnRight =  FALSE;
				controlSendSpeed = 1;
				[[self delegate] sendMessageToServer:KEY_RIGHT_CLICK_UP_STR];
			}
			//left
			if(turnLeft ==  FALSE && controlSendSpeed == 0)
			{
				turnLeft =  TRUE;
				controlSendSpeed = 1;
				[[self delegate] sendMessageToServer:KEY_LEFT_CLICK_DOWN_STR];
			}
		}else
		{
			//stop
			if(turnLeft ==  TRUE && controlSendSpeed == 0)
			{
				turnLeft =  FALSE;
				controlSendSpeed = 1;
				[[self delegate] sendMessageToServer:KEY_LEFT_CLICK_UP_STR];
			}
		}
	}else if(deviceTilt.y < -0.15f)
	{
		if(deviceTilt.y < oldAcleY)
		{
			//if left is on,turn down
			if(turnLeft ==  TRUE && controlSendSpeed == 0)
			{
				//stop left
				turnLeft =  FALSE;
				[[self delegate] sendMessageToServer:KEY_LEFT_CLICK_UP_STR];
			}
			//right
			if(turnRight ==  FALSE && controlSendSpeed == 0)
			{
				turnRight =  TRUE;
				controlSendSpeed = 1;
				[[self delegate] sendMessageToServer:KEY_RIGHT_CLICK_DOWN_STR];
			}
		}else
		{
			//stop
			if(turnRight ==  TRUE && controlSendSpeed == 0)
			{
				turnRight =  FALSE;
				controlSendSpeed = 1;
				[[self delegate] sendMessageToServer:KEY_RIGHT_CLICK_UP_STR];
			}
		}
	}
	*/
	if(deviceTilt.y > 0.15f && deviceTilt.y < 0.35f)
	{
		if( deviceTilt.y > (oldAcleY +0.1f) )
		{
			//if right is on,turn down
			if(turnRight ==  TRUE )
			{
				//stop right
				turnRight =  FALSE;
				controlSendSpeed = 1;
				[SEND_MSG_PE sendMessageToServer:KEY_RIGHT_CLICK_UP_STR];
			}else
			{
				//left
				if(turnLeft ==  FALSE)
				{
					turnLeft =  TRUE;
					controlSendSpeed = 1;
					[SEND_MSG_PE sendMessageToServer:KEY_LEFT_CLICK_DOWN_STR];
				}
			}
			
		}else
		{
			//stop
			if(turnLeft ==  TRUE)
			{
				turnLeft =  FALSE;
				controlSendSpeed = 1;
				[SEND_MSG_PE sendMessageToServer:KEY_LEFT_CLICK_UP_STR];
			}
			
		}
	}else if(deviceTilt.y < -0.15f && deviceTilt.y > - 0.35f)
	{
		if( deviceTilt.y < (oldAcleY - 0.1f) )
		{
			//if left is on,turn down
			if(turnLeft ==  TRUE)
			{
				//stop left
				turnLeft =  FALSE;
				[SEND_MSG_PE sendMessageToServer:KEY_LEFT_CLICK_UP_STR];
			}else
			{
				//right
				if(turnRight ==  FALSE)
				{
					turnRight =  TRUE;
					controlSendSpeed = 1;
					[SEND_MSG_PE sendMessageToServer:KEY_RIGHT_CLICK_DOWN_STR];
				}
			}
			
		}else
		{
			
			//stop
			if(turnRight ==  TRUE)
			{
				turnRight =  FALSE;
				controlSendSpeed = 1;
				[SEND_MSG_PE sendMessageToServer:KEY_RIGHT_CLICK_UP_STR];
			}
		}
	}else if(deviceTilt.y > 0.35f)
	{
		//left
		//if right is on,turn down
		if(turnRight ==  TRUE )
		{
			//stop right
			turnRight =  FALSE;
			controlSendSpeed = 1;
			[SEND_MSG_PE sendMessageToServer:KEY_RIGHT_CLICK_UP_STR];
		}else
		{
			//left
			if(turnLeft ==  FALSE)
			{
				turnLeft =  TRUE;
				controlSendSpeed = 1;
				[SEND_MSG_PE sendMessageToServer:KEY_LEFT_CLICK_DOWN_STR];
			}
		}
	}else if(deviceTilt.y < - 0.35f)
	{
		//right
		//if left is on,turn down
		if(turnLeft ==  TRUE)
		{
			//stop left
			turnLeft =  FALSE;
			[SEND_MSG_PE sendMessageToServer:KEY_LEFT_CLICK_UP_STR];
		}else
		{
			//right
			if(turnRight ==  FALSE)
			{
				turnRight =  TRUE;
				controlSendSpeed = 1;
				[SEND_MSG_PE sendMessageToServer:KEY_RIGHT_CLICK_DOWN_STR];
			}
		}
	}
	else
	{
		//stop
		if(turnRight ==  TRUE)
		{
			turnRight =  FALSE;
			[SEND_MSG_PE sendMessageToServer:KEY_RIGHT_CLICK_UP_STR];
		}
		if(turnLeft ==  TRUE)
		{
			//stop left
			turnLeft =  FALSE;
			[SEND_MSG_PE sendMessageToServer:KEY_LEFT_CLICK_UP_STR];
		}
	}
	
	oldAcleY = deviceTilt.y;
	
	
	

	
	
	if(deviceTilt.y > 0.2f  && circlecount == 0)
	{//left
		circlecount = 1;
		if(!circleLeft)
		{
			//[SEND_MSG_PE sendMessageToServer:KEY_LEFT_CLICK_DOWN_STR];
		
			if(circleRight)
			{
				circleRight = FALSE;
				[self SteeringwheelRoat:-160];
			}else
			{
				[self SteeringwheelRoat:-80];
			}
			
			circleLeft = TRUE;
		}
	}else if(deviceTilt.y < -0.2f  && circlecount == 0)
	{
		//right
		circlecount = 1;
		
		if(!circleRight)
		{
			//[[self delegate] sendMessageToServer:KEY_RIGHT_CLICK_DOWN_STR];
			if(circleLeft)
			{
				circleLeft = FALSE;
				[self SteeringwheelRoat:160];
			}else
			{
				[self SteeringwheelRoat:80];
			}
			circleRight = TRUE;
		
		}
	}else if(deviceTilt.y > -0.2f && deviceTilt.y < 0.2f)
	{
		
		if(circleRight)
		{
			//[[self delegate] sendMessageToServer:KEY_RIGHT_CLICK_UP_STR];
			[self SteeringwheelRoat:-80];
			circleRight = FALSE;
		}
		if(circleLeft)
		{
			//[[self delegate] sendMessageToServer:KEY_LEFT_CLICK_UP_STR];
			[self SteeringwheelRoat:80];
			circleLeft = FALSE;
		}
		circleRight = FALSE;circleLeft = FALSE;
		 
	}

	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [Steeringwheel release];
    [super dealloc];
}

-(void)SteeringwheelRoat:(int)angle
{
	CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3]; 
	
	//roate
	CGAffineTransform transform = Steeringwheel.transform;
    transform = CGAffineTransformRotate(transform, degressToRadian(angle));
    Steeringwheel.transform = transform;
	
}

//down click
- (IBAction)LeftMouseDownClick:(id)sender
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//whether is open
	BOOL acclec = [[defaults objectForKey:kAcceleKey] boolValue];
	if(acclec)
	{
		return;
	}
	[SEND_MSG_PE sendMessageToServer:KEY_LEFT_CLICK_DOWN_STR];
	[self SteeringwheelRoat:-60];

}
- (IBAction)RightMouseDownClick:(id)sender
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//whether is open
	BOOL acclec = [[defaults objectForKey:kAcceleKey] boolValue];
	if(acclec)
	{
		return;
	}
	[SEND_MSG_PE sendMessageToServer:KEY_RIGHT_CLICK_DOWN_STR];
	[self SteeringwheelRoat:60];

}

- (IBAction)UpMouseDownClick:(id)sender
{
	[SEND_MSG_PE sendMessageToServer:KEY_UP_CLICK_DOWN_STR];
	
}
- (IBAction)DowntMouseDownClick:(id)sender
{
	[SEND_MSG_PE sendMessageToServer:KEY_DOWN_CLICK_DOWN_STR];
}
//up click
- (IBAction)LeftMouseUpClick:(id)sender
{
	[SEND_MSG_PE sendMessageToServer:KEY_LEFT_CLICK_UP_STR];
	
}
- (IBAction)RightMouseUpClick:(id)sender
{
	[SEND_MSG_PE sendMessageToServer:KEY_RIGHT_CLICK_UP_STR];
}

- (IBAction)UpMouseUpClick:(id)sender
{
	[SEND_MSG_PE sendMessageToServer:KEY_UP_CLICK_UP_STR];
	
}
- (IBAction)DowntMouseUpClick:(id)sender
{
	[SEND_MSG_PE sendMessageToServer:KEY_DOWN_CLICK_UP_STR];
}

-(IBAction)goBackToMain:(id)sender
{
    DISAPPEAR_VIEW

}

@end
