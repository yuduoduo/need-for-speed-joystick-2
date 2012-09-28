//
//  ScrollSubViewController.m
//  NFSJoystick
//
//  Created by yongchang hu on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScrollSubViewController.h"
#import "MsgComm.h"
@interface ScrollSubViewController ()

@end

@implementation ScrollSubViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"MyView" bundle:nil]) {
        pageNumber = page;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    if (pageNumber == 0) 
    {
        NSString* innumber = [NSString stringWithFormat:@"%i", pageNumber + 1];
        NSString *pictrureName = @"image";
        pictrureName = [pictrureName stringByAppendingString:innumber];
        pictrureName = [pictrureName stringByAppendingString:@".png"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:pictrureName]];
    }
//    else {
//        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"scroll_back.png"]];
//    }
    
    switch (pageNumber) {
        case 0:
            [self loadScrollView1];
            break;
        case 1:
            [self loadScrollView2];
            break;
        case 2:
            [self loadScrollView3];
            break;
        default:
            break;
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark ----------------
#pragma mark scroll view 1
-(void)loadScrollView1
{
//    UIImage *stetchLeftTrack= [[UIImage imageNamed:@"2.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0]; 
//	UIImage *stetchRightTrack = [[UIImage imageNamed:@"2.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0];
    
    
	//Slider: Top 
	
	UISlider *slider1=[[[UISlider alloc]initWithFrame:CGRectMake(32, 32, 255, 17)] autorelease];
    slider1.backgroundColor = [UIColor clearColor]; 
	[slider1 setThumbImage: [UIImage imageNamed:@"1.png"] forState:UIControlStateNormal]; 
//	[slider1 setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal]; 
//	[slider1 setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal]; 
	slider1.minimumValue = 0.0; 
	slider1.maximumValue = 200.0; 
	slider1.continuous = YES; 
	slider1.value = 20.0;
    [slider1 addTarget:self action:@selector(slideValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider1];
}
-(void)slideValueChanged
{
    //send to server
    [SEND_MSG_PE sendMessageToServerWithAnimate:@"XXX" showAnimate:@"Volume Change"];
}
#pragma mark ----------------
#pragma mark scroll view 2//for music
-(void)loadScrollView2{
    UIButton *button = [self dynamicCreateButton:CGRectMake(13, 8, 68, 67) tag:111];
    UIButton *button2 = [self dynamicCreateButton:CGRectMake(91, 21, 43, 43) tag:112];
    UIButton *button3 = [self dynamicCreateButton:CGRectMake(141, 22, 40, 42) tag:113];
    UIButton *button4 = [self dynamicCreateButton:CGRectMake(185, 19, 40, 40) tag:114];
    
    [self.view  addSubview:button];
    [self.view  addSubview:button2];
    [self.view  addSubview:button3];
    [self.view  addSubview:button4];
}
-(void)loadScrollView3
{
    UIButton *button = [self dynamicCreateButton:CGRectMake(13, 8, 68, 67) tag:115];
    UIButton *button2 = [self dynamicCreateButton:CGRectMake(233, 10, 67, 67) tag:116];

    
    [self.view  addSubview:button];
    [self.view  addSubview:button2];

}
#pragma mark ----------------
#pragma mark dynamic button
-(UIButton*)dynamicCreateButton:(CGRect)frame tag:(NSInteger)tag
{
    UIButton *button = [[[UIButton alloc]initWithFrame:frame] autorelease];
    

    button.tag = tag;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
-(void)buttonAction:(id)sender
{
    UIButton *button = (UIButton*)sender;
    NSInteger tag = button.tag;

    [SEND_MSG_PE sendMessageToServerWithAnimate:[self getStrFromTag:tag] showAnimate:[self getAnimateStrFromTag:tag]];
}
-(NSString*)getStrFromTag:(NSInteger)tag
{
    switch (tag) {
        case 111:
            return @"ja";//@"Open";
            break;
        case 112:
            return @"jb";//@"Back";
            break;
        case 113:
            return @"jc";//@"Play";
            break;
        case 114:
            return @"jd";//@"Forward";
            break;
        case 115:
            return @"je";//@"Shutdown";
            break;
        case 116:
            return @"jf";//@"Boot";
            break;
        default:
            break;
    }
    return @"ja";//@"Open";
}
-(NSString*)getAnimateStrFromTag:(NSInteger)tag
{
    switch (tag) {
        case 111:
            return @"Open";
            break;
        case 112:
            return @"Back";
            break;
        case 113:
            return @"Play";
            break;
        case 114:
            return @"Forward";
            break;
        case 115:
            return NSLocalizedString(@"Shutdown", @"Shutdown");
            break;
        case 116:
            return NSLocalizedString(@"Boot", @"Boot");
            break;
        default:
            break;
    }
    return @"Open";
}
@end
