//
//  NFSBaseViewController.m
//  NFSJoystick
//
//  Created by yongchang hu on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NFSBaseViewController.h"
#import "MBProgressHUD.h"
#import "RJViewUtils.h"

#import <QuartzCore/QuartzCore.h>

#define kAccelerometerFrequency     40
#define RJBaseViewControllerFontViewTag 9999
#define RJBaseViewControllerWaitingViewTag 9998
@interface NFSBaseViewController ()

@end

@implementation NFSBaseViewController
@synthesize delegate = _delegate;
@synthesize animateFinished = _animateFinished;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(2.0 / kAccelerometerFrequency)];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    
    self.animateFinished = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    [self.delegate didReceiveAccelerometer:acceleration];
}

#pragma mark - - - waiting
- (void)startWaiting
{
    if (_isWaiting)
    {
        return;
    }
    
    UIActivityIndicatorView* waitingView = nil;
    UIView* view = [self.view viewWithTag:RJBaseViewControllerWaitingViewTag];
    if (nil == view)
    {
        if ([UIActivityIndicatorView instancesRespondToSelector:@selector(setColor:)]) 
        {
            waitingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            waitingView.color = [UIColor grayColor];
        }
        else 
        {
            waitingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            waitingView.frame = CGRectMake(0,0,30,30);
        }
        waitingView.hidesWhenStopped = YES;
        waitingView.tag = RJBaseViewControllerWaitingViewTag;
        waitingView.center = self.view.center;
        [self.view addSubview:waitingView];
        [waitingView release];
    }
    
    [waitingView startAnimating];
    _isWaiting = YES;

}
- (void)startHUDWaiting:(NSString*)aText controller:(UIViewController*)controller
{
    if (_isWaiting)
    {
        return;
    }
    
   
    _hud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
	[controller.view addSubview:_hud];
    _hud.labelText = aText;
	[_hud show:YES];
}
- (void)stopHUDWaiting:(UIViewController*)controller
{
    [MBProgressHUD hideHUDForView:controller.view animated:YES];
    [_hud release];
    _hud = nil;
    
    _isWaiting = NO;
}
- (void)stopWaiting
{
    UIActivityIndicatorView*  waitingView = (UIActivityIndicatorView*)[self.view viewWithTag:RJBaseViewControllerWaitingViewTag];
    if (waitingView)
    {
        [waitingView stopAnimating];
    }
    [waitingView removeFromSuperview];
    waitingView = nil;
    



}

#pragma mark - - - animate font
-(void)initFontLable:(NSString*)str frame:(CGRect)frame transfrom:(CGAffineTransform)transfrom{
    
    
    UILabel * fontView = nil;
    UIView* view = [self.view viewWithTag:RJBaseViewControllerFontViewTag];
    if (nil == view)
    {
        
        fontView = [[UILabel alloc] init];
        fontView.text = str;
        
        fontView.frame = frame;

          
        fontView.tag = RJBaseViewControllerFontViewTag;
        fontView.center = self.view.center;
        [self.view addSubview:fontView];
        [fontView release];

        CATransform3D rotationTransform = CATransform3DIdentity;
        [fontView.layer removeAllAnimations];
        rotationTransform = CATransform3DRotate(rotationTransform, 90.0f * M_PI / 180.0f, 0.0, 0.0, 1);
        fontView.layer.transform = rotationTransform;
        
    }
    
}

-(void)removeFontLable{
    UILabel*  fontView = (UILabel*)[self.view viewWithTag:RJBaseViewControllerFontViewTag];

    [fontView removeFromSuperview];
    fontView = nil;
}

-(void)startAnimateFont:(NSString*)str frame:(CGRect)frame transfrom:(NSInteger)transfromType
{
    BOOL state = self.animateFinished;
    if (!state) {
        return;
    }
    
    [self removeFontLable];
//    [self initFontLable :str frame:frame transfrom: transfrom];
//    
//    UILabel*  fontView = (UILabel*)[self.view viewWithTag:RJBaseViewControllerFontViewTag];
    UILabel * fontView = nil;
    UIView* view = [self.view viewWithTag:RJBaseViewControllerFontViewTag];
    if (nil == view)
    {
        
        fontView = [[UILabel alloc] init];
        fontView.text = str;
        
        fontView.frame = frame;
        
        
        fontView.tag = RJBaseViewControllerFontViewTag;

        [self.view addSubview:fontView];
        [fontView release];
        
        
    }
    
    fontView.textAlignment = UITextAlignmentCenter;
    
    //    fontView.lineBreakMode = UILineBreakModeWordWrap;
    //    fontView.numberOfLines = 0;
    //    fontView.adjustsFontSizeToFitWidth = YES;
    fontView.alpha = 1.0;
    fontView.backgroundColor = [UIColor clearColor];
    self.animateFinished = FALSE;
    switch (transfromType) {
        case 0:
        {
            fontView.font = [UIFont systemFontOfSize:32];
            CGPoint point = self.view.center;
            point.y -= 100;
            fontView.center = point;
           //not roate
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationCurveEaseInOut 
                             animations:^{
                                 fontView.transform =    CGAffineTransformMakeScale(4,4);
                                 fontView.alpha = 0;
                             }completion:^(BOOL finished)
             {
                 self.animateFinished = TRUE;
             }];
        }
            break;
        case 1:
        {
            fontView.font = [UIFont systemFontOfSize:40];
            CGPoint point = self.view.center;
            point.x += 100;
            fontView.center = point;
            //roate
            CGAffineTransform transfrom = CGAffineTransformMakeRotation(M_PI/2);
            CGAffineTransform transfrom2 = CGAffineTransformMakeScale(.4,.4);
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationCurveEaseIn 
                             animations:^{
                                 fontView.transform =    CGAffineTransformConcat(transfrom,transfrom2);
                                 fontView.transform =    transfrom;
                                 fontView.alpha = 0;
                             }completion:^(BOOL finished)
             {
                 self.animateFinished = TRUE;
             }];
        }
            break;
        default:
            break;
    }
    

    
    
}

#pragma mark -----------------------


- (void)setNavigationBarButtonItemWithImage:(UIImage*)aIcon itemType:(LSNavigationbarButtonItemType)aType bgImage:(UIImage*)aBg
{
    UIBarButtonItem* item = nil;
    if (LSNavigationbarButtonItem_Left == aType)
    {
        item = [[UIBarButtonItem alloc] initWithCustom:aIcon 
                                               bgImage:aBg 
                                                target:self 
                                                action:@selector(navigationLeftButtonItemClicked:)];
        self.navigationItem.leftBarButtonItem = item;
        
    }
    else if (LSNavigationbarButtonItem_Right == aType)
    {
        item = [[UIBarButtonItem alloc] initWithCustom:aIcon 
                                               bgImage:aBg 
                                                target:self 
                                                action:@selector(navigationRightButtonItemClicked:)];
        self.navigationItem.rightBarButtonItem = item;
    }
    
    [item release];
}




@end
