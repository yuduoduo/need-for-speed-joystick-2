//
//  ChooseWhichVersion.m
//  NFSJoystick
//
//  Created by  on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChooseWhichVersion.h"
#import "MsgComm.h"
@implementation ChooseWhichVersion
@synthesize delegate,hidenButton;
@synthesize AdsButton = _AdsButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)setBackgroundToClearForView:(UIView *)view {
    if ([view subviews]) {
        for (UIView *subView in [view subviews]) {
            [self setBackgroundToClearForView:subView];
        }
    }
    
    if ([view respondsToSelector:@selector(setBackgroundColor:)]) {
        [view performSelector:@selector(setBackgroundColor:)
                   withObject:[UIColor clearColor]];
    }
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView
//{
//    [super loadView];
//    CGRect myImageRect = CGRectMake(-15.0f, 89.0f, 351.0f, 302.0f);
//    UIImageView *myImage = [[UIImageView alloc] initWithFrame:myImageRect];
//    [myImage setImage:[UIImage imageNamed:@"quickswitch.png"]];
//    myImage.opaque = YES; // explicitly opaque for performance
//    [self.view addSubview:myImage];
////    self.view.backgroundColor=[UIColor clearColor];
////    self.view.userInteractionEnabled = YES;
//}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self setBackgroundToClearForView:self.view];
    if([self.delegate Noza_f_whether_Lock_Level_6])
    {
//        hidenImage.hidden = true;
        hidenButton.hidden = true;
//        hidenButton.frame = CGRectMake(-100, -100, 0, 0);
//        hidenButton.alpha = 0.0;
    }
    
    GET_LOCAL_LANGUAGE
    NSLog(@"language %@",currentLanguage);

    if ([currentLanguage isEqualToString: @"zh-Hans"]) {
        self.AdsButton.hidden = NO;
    }else if ([currentLanguage isEqualToString: @"zh-Hant"]) {
       self.AdsButton.hidden = NO;
    }else
    {
        self.AdsButton.hidden = YES;
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
//	UITouch *touch = [touches anyObject]; 
//	CGPoint pointInView = [touch locationInView:touch.view]; 

}
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
//	UITouch *touch = [touches anyObject]; 
//	CGPoint pointInView = [touch locationInView:touch.view]; 

    
}
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	// start new animation paths for all of the spheres
//	UITouch *touch = [touches anyObject]; 


}
-(IBAction)icon1Click:(id)sender{
[self.delegate GoBackToMainViewKeyboard];
    
}
-(IBAction)icon2Click:(id)sender{
   [self.delegate GoBackToMainViewNo1];
}
-(IBAction)icon3Click:(id)sender{
    [self.delegate GoBackToMainViewNo2];
}
-(IBAction)icon4Click:(id)sender{
//     [self.delegate GoBackToMainViewNo3];
    [self.delegate buyTheAppAndSwitch];
    
}
-(IBAction)icon5Click:(id)sender{
    [self.delegate GoBackToMainViewNo4];
}
-(IBAction)icon6Click:(id)sender{
    [self.delegate GoBackToMainToHelicopter];
}
-(IBAction)goBack1Click:(id)sender
{
    [self.delegate GoBackToMainView];
}
-(IBAction)goBack2Click:(id)sender
{
    [self.delegate GoBackToMainView];
}
@end
