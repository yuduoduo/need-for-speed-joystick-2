//
//  MouseView.m
//  NFSJoystick
//
//  Created by hu yongchang on 5/4/10.
//  Copyright 2010 usa. All rights reserved.
//

#import "MouseView.h"
#import "MsgComm.h"
#import "DefineComm.h"
#define SHOW_300x250_AD 0
#define	kIPsoundKey		@"iIPsound"
#define degreesToRadians(x) (M_PI * x / 180.0)

#import "MsgComm.h"
@implementation MouseView
@synthesize mouseDownPoint;

@synthesize circlecount;

@synthesize backgroundView;
//sound
@synthesize soundFileURLRef;
@synthesize soundFileObject;
@synthesize soundFileURLRef2;
@synthesize soundFileObject2;


//adsense

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
	MoveImage.hidden = TRUE;
	circlecount = 0;
	
//sound
	[self setupApplicationAudio];

	self.view.backgroundColor = [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1.0] autorelease];
	
    UIButton *leftButton = [[[UIButton alloc]initWithFrame:CGRectMake(0, 427, 132, 52)]autorelease];
    [leftButton addTarget:self action:@selector(LeftMouseDownClick:) forControlEvents:UIControlEventTouchDown];
    [leftButton addTarget:self action:@selector(LeftMouseClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    UIButton *rightButton = [[[UIButton alloc]initWithFrame:CGRectMake(186, 427, 132, 52)]autorelease];
    [rightButton addTarget:self action:@selector(RightMouseDownClick:) forControlEvents:UIControlEventTouchDown];
    [rightButton addTarget:self action:@selector(RightMouseClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    UIButton *dragButton = [[[UIButton alloc]initWithFrame:CGRectMake(134, 427, 52, 52)]autorelease];
    [dragButton addTarget:self action:@selector(dragButtonDownClick:) forControlEvents:UIControlEventTouchDown];
    [dragButton addTarget:self action:@selector(dragButtonUpClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dragButton];
}
- (void)dragButtonDownClick:(id)sender
{
    isEnableDrag = TRUE;
    
}
- (void)dragButtonUpClick:(id)sender
{
    isEnableDrag = FALSE;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];  
        

    if ([self whetherMovedUp]) {
        //back
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }else {
        //up
        self.view.frame = CGRectMake(0, -SCROLL_BUTTON_VIEW_HEIGHT, 320, 480);
    }
    
    [UIView commitAnimations];
}
-(BOOL)whetherMovedUp
{
    CGRect rect = self.view.frame;
    int y = rect.origin.y;
    if (y == -SCROLL_BUTTON_VIEW_HEIGHT) {
        return YES;
    }
    return NO;
}

- (void)viewDidUnload {


}

- (void) setupApplicationAudio {
	// Get the main bundle for the app
	CFBundleRef mainBundle;
	mainBundle = CFBundleGetMainBundle ();
	
	// Get the URL to the sound file to play
	soundFileURLRef  =	CFBundleCopyResourceURL (
												 mainBundle,
												 CFSTR ("MouseDown"),
												 CFSTR ("aif"),
												 NULL
												 );
	
	// Create a system sound object representing the sound file
	AudioServicesCreateSystemSoundID (
									  soundFileURLRef,
									  &soundFileObject
									  );
	
	// Get the URL to the sound file to play
	soundFileURLRef2  =	CFBundleCopyResourceURL (
												 mainBundle,
												 CFSTR ("MouseUp"),
												 CFSTR ("aif"),
												 NULL
												 );
	
	// Create a system sound object representing the sound file
	AudioServicesCreateSystemSoundID (
									  soundFileURLRef2,
									  &soundFileObject2
									  );
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {  
    // 重新加载一个Nib文件 
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {  
        NSLog(@"横屏");
        
    }else {  
        NSLog(@"竖屏");
        
    }  
}*/
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	UITouch *touch = [touches anyObject]; 
	CGPoint pointInView = [touch locationInView:touch.view]; 
	if(pointInView.y > 420) return;
	MoveImage.hidden = TRUE;
	MoveImage.center = pointInView;
	
	
	self.mouseDownPoint = pointInView;
}
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    
    
	UITouch *touch = [touches anyObject]; 
	CGPoint pointInView = [touch locationInView:touch.view]; 
    
    if (isEnableDrag) {
        
        return;
    }
    
    
    
	MoveImage.hidden = FALSE;
	MoveImage.center = pointInView;


	{
		
        [SEND_MSG_PE sendMessageToServer: [NSString stringWithFormat:@"e%f,%f",3*(pointInView.x-self.mouseDownPoint.x) , 3*(pointInView.y-self.mouseDownPoint.y)]];

        self.mouseDownPoint = pointInView;
        
		
	}


}
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	// start new animation paths for all of the spheres
	UITouch *touch = [touches anyObject]; 
	CGPoint pointInView = [touch locationInView:touch.view]; 
	MoveImage.hidden = TRUE;
	MoveImage.center = pointInView;
	isEnableDrag = FALSE;
	//[SEND_MSG_PE sendMessageToServer:@"b"];
}

-(void)sendTouchMouseMessage
{

}

- (void)LeftMouseClick:(id)sender
{
    if ([self whetherMovedUp])
    {
        [self startAnimateFont:@"Left Click" frame:CGRectMake(0,200,320,100) transfrom:0];
    }else {
        [self startAnimateFont:@"Left Click" frame:CGRectMake(0,100,320,100) transfrom:0];
    }
    
    

    
    [SEND_MSG_PE sendMessageToServer:KEY_LEFT_MOUSE_CLICK_STR];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]  ) {
        AudioServicesPlaySystemSound (self.soundFileObject2);
    }

}
- (void)RightMouseClick:(id)sender
{

    if ([self whetherMovedUp])
    {
        [self startAnimateFont:@"Right Click" frame:CGRectMake(0,200,320,100) transfrom:0];
    }else {
        [self startAnimateFont:@"Right Click" frame:CGRectMake(0,100,320,100) transfrom:0];
    }
    
    [SEND_MSG_PE sendMessageToServer:KEY_RIGHT_MOUSE_CLICK_STR];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]  ) {
        AudioServicesPlaySystemSound (self.soundFileObject2);
    }
    
}
- (void)EnterMouseClick:(id)sender
{

    if ([self whetherMovedUp])
    {
        [self startAnimateFont:@"Enter Click" frame:CGRectMake(0,200,320,100) transfrom:0];
    }else {
        [self startAnimateFont:@"Enter Click" frame:CGRectMake(0,100,320,100) transfrom:0];
    }
    
	[SEND_MSG_PE sendMessageToServer:KEY_ENTER_MOUSE_CLICK_STR];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey] ) {
        AudioServicesPlaySystemSound (self.soundFileObject2);
    }
    
}

- (void)LeftMouseDownClick:(id)sender
{
	if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]) {
        AudioServicesPlaySystemSound (self.soundFileObject);
    }
	
}
- (void)RightMouseDownClick:(id)sender
{
	if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]) {
        AudioServicesPlaySystemSound (self.soundFileObject);
    }
	
}
- (void)EnterMouseDownClick:(id)sender
{
	if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey] ) {
        AudioServicesPlaySystemSound (self.soundFileObject);
    }
	
}

- (void)dealloc {
    [super dealloc];
	[backgroundView release];
    
	//sound
	AudioServicesDisposeSystemSoundID (soundFileObject);
	CFRelease (soundFileURLRef);
	//sound
	AudioServicesDisposeSystemSoundID (soundFileObject2);
	CFRelease (soundFileURLRef2);
}


@end


