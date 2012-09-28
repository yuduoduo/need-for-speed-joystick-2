//
//  MainViewController.m
//  NFSJoystick
//
//  Created by Jeff LaMarche on 7/24/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "MainViewController.h"

#import "TroubleShootViewController.h"
#import "HandleView.h"
#import "HorizMouseView.h"
#import "NFSJoystickAppDelegate.h"
#import "ChooseWhichVersion.h"
#import "UIViewController+Alerts.h"
#import "MsgComm.h"
#import "ScrollSubViewController.h"
#import "DefineComm.h"
//#import "CircleRoundViewController.h"
#import "FlurryAppCircle.h"
#import "NFSJoystickAppDelegate.h"
#define TEXTFIELDTAG	100
#define GOTO_WEBSITE 444
#define UNLOCK_ADS 333
#define UNBALE_CONNECT 222
@implementation MainViewController

@synthesize mouseViewController;
@synthesize handleViewController,handleViewController2,handleViewController3,quickSwitchHelpView,helicopterViewController,keyboardViewController;
@synthesize horizMouseViewController;


//sound
@synthesize soundFileURLRef;
@synthesize soundFileObject;

//sound
@synthesize soundFileURLRef2;
@synthesize soundFileObject2;
//sound
@synthesize soundFileURLRef3;
@synthesize soundFileObject3;
//
@synthesize switchButton;
@synthesize chooseWhichVersion,socketPort;
@synthesize scrollButtonView = _scrollButtonView;
@synthesize viewControllers = _viewControllers;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Custom initialization
		//isSendMsg = FALSE;
	}
	return self;
}

-(void)textEditShow
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey] ) {
        AudioServicesPlaySystemSound (self.soundFileObject3);
    }
    
//    self.mouseViewController.view.center = CGPointMake(160, 240-216);
	UITextField *textField = (UITextField *)[self.view viewWithTag:TEXTFIELDTAG];
	[textField becomeFirstResponder];
    
}

-(void)textEditHide
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]) {
            AudioServicesPlaySystemSound (self.soundFileObject2);
    }

	UITextField *textField = (UITextField *)[self.view viewWithTag:TEXTFIELDTAG];
	[textField resignFirstResponder];
//    self.mouseViewController.view.center = CGPointMake(160, 240);
}
#pragma mark text file methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    

    
	return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{

    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string// return NO to not change text
{
    //send to server
    NSString *tex=@"g";

    [self sendMessageToServer:[tex stringByAppendingString:string]];
    

    [self startAnimateFont:string frame:CGRectMake(0,100,320,100) transfrom:0];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	// return NO to disallow editing.
    
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    
	return YES;
}
-(void)loadShowKeyboard
{
    UITextField *textfield = [[[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)] autorelease];
    textfield.tag = TEXTFIELDTAG;
    textfield.delegate = self;
    textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textfield.enablesReturnKeyAutomatically = YES;
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.returnKeyType = UIReturnKeySend;
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    textfield.keyboardAppearance = UIKeyboardAppearanceAlert; 
    [self.view addSubview:textfield];

    
    deviceTilt.y =0;deviceTilt.x = 0;
    
    
}
- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [self.scrollButtonView subviews];
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (320);
		}
	}
	
	// set the content size so it can be scrollable
	[self.scrollButtonView setContentSize:CGSizeMake((3 * 320), [self.scrollButtonView bounds].size.height)];
}
#define kNumberOfPages 3

-(void)initScrollButtonView
{
    self.scrollButtonView = [[[UIScrollView alloc]initWithFrame:CGRectMake(0, 480-SCROLL_BUTTON_VIEW_HEIGHT, 320, SCROLL_BUTTON_VIEW_HEIGHT)] autorelease];
    [self.scrollButtonView setBackgroundColor:[UIColor blackColor]];
	[self.scrollButtonView setCanCancelContentTouches:NO];
	self.scrollButtonView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	self.scrollButtonView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	self.scrollButtonView.scrollEnabled = YES;
	self.scrollButtonView.showsHorizontalScrollIndicator = FALSE;
	// pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
	// if you want free-flowing scroll, don't set this property.
	self.scrollButtonView.pagingEnabled = YES;
	self.scrollButtonView.delegate = self;
    
	// view controllers are created lazily 将要加载的内容先置为空
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++)
    {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
    
    [self layoutScrollImages];
    
    // 然后先加载第一页和第二页
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
    [self.view insertSubview:self.scrollButtonView atIndex:0];
}

- (void)loadScrollViewWithPage:(int)page
{
    // 判断内容页面是否到了第一或者最后一页
    if (page < 0)
        return;
    if (page >= kNumberOfPages)
        return;
    
    // replace the  if necessary         加载scrollView里的该page内容页面，自定义的MyViewController
    ScrollSubViewController *controller = [self.viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[ScrollSubViewController alloc] initWithPageNumber:page];//自定义的viewController初始方法
        [self.viewControllers replaceObjectAtIndex:page withObject:controller];//替换之前内容置为空的相应页面
        [controller release];
    }
    
    // add the controller's view to the scroll view 将已替换的页面再加入到scrollView中显示
    if (controller.view.superview == nil)
    {
        CGRect frame = self.scrollButtonView.frame;//设定该page的frame
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.scrollButtonView addSubview:controller.view];
        

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //scroll view
    [self initScrollButtonView];
	MouseView *viewController = [[MouseView alloc] initWithNibName:@"MouseView" bundle:nil];
	self.mouseViewController = viewController;
	[viewController release];
	

    
	[self.view insertSubview:mouseViewController.view atIndex:1];
//	[self.view insertSubview:mouseViewController.view belowSubview:infoButton];

	//mouseViewController.SetMainView(self.superclass);
	[mouseViewController setDelegate:self];
	

    
	//sound
	[self setupApplicationAudio];
    
    [self loadShowKeyboard];

    iphone_horiz_state = FALSE;
    UIButton *infoButton = [[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)] autorelease];
    [infoButton addTarget:self action:@selector(toggleView) forControlEvents:UIControlEventTouchUpInside];
    [infoButton setBackgroundImage:[UIImage imageNamed:@"optionsTabBarIcon.png"] forState:UIControlStateNormal];
    [self.view addSubview:infoButton];
    
    [SendMsgProcotolEngine sharedInstance].delegate = self;
 }
-(void)toggleView
{
    [rootViewController toggleView];
}
-(void)setRootViewController:(RootViewController*)view
{
    rootViewController = view;
}
- (void) setupApplicationAudio {
	// Get the main bundle for the app
	CFBundleRef mainBundle;
	mainBundle = CFBundleGetMainBundle ();
	
	// Get the URL to the sound file to play
	soundFileURLRef  =	CFBundleCopyResourceURL (
												 mainBundle,
												 CFSTR ("tock"),
												 CFSTR ("caf"),
												 NULL
												 );
	
	// Create a system sound object representing the sound file
	AudioServicesCreateSystemSoundID (
									  soundFileURLRef,
									  &soundFileObject
									  );
	//shake
    // Get the URL to the sound file to play
	soundFileURLRef2  =	CFBundleCopyResourceURL (
												 mainBundle,
												 CFSTR ("keyboard_hidden"),
												 CFSTR ("caf"),
												 NULL
												 );
	
	// Create a system sound object representing the sound file
	AudioServicesCreateSystemSoundID (
									  soundFileURLRef2,
									  &soundFileObject2
									  );
    // Get the URL to the sound file to play
	soundFileURLRef3  =	CFBundleCopyResourceURL (
												 mainBundle,
												 CFSTR ("keyboard_shown"),
												 CFSTR ("caf"),
												 NULL
												 );
	
	// Create a system sound object representing the sound file
	AudioServicesCreateSystemSoundID (
									  soundFileURLRef3,
									  &soundFileObject3
									  );

}

- (void)viewDidAppear:(BOOL)animated
{


	[super viewDidAppear:animated]; 
    
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];	
    
    int i = [app firstRunState];
    if (i == 11) {
        
        [self AutoSearchServer];
    }else {
        [app setFirstRunState:11];
        //alarm and go to website
        //http://phonegamesoftware.cn
        UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"View tutorial and video", @"View tutorial and video") 
                                                       delegate:self cancelButtonTitle:@"Cancel" 
                                              otherButtonTitles:@"OK", nil] autorelease];
        alert.tag = GOTO_WEBSITE;
        [alert show];
    }
    
    

}
- (void)help_buttonPressed:(UIButton *)button
{
    [self dismissModalViewControllerAnimated:YES];
}


-(void)trubleshootingshow
{
    TroubleShootViewController *viewcontrol = [[TroubleShootViewController alloc] init];
    // Set the Button Type.
    UIButton* help_next = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Position the button - I found these numbers align fine (0, 0 = top left of keyboard)
    help_next.frame = CGRectMake(240, 430, 65, 39);
    help_next.bounds = CGRectMake(0, 0, 65, 39);
    [help_next addTarget:self action:@selector(help_buttonPressed:) forControlEvents:UIControlEventTouchDown];
    help_next.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    
    [help_next.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    [help_next setTitle:NSLocalizedString(@"Done", @"button done") forState:UIControlStateNormal];
    [help_next setBackgroundImage:[[UIImage imageNamed:@"help_next_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [help_next setBackgroundImage:[[UIImage imageNamed:@"help_next_highlighted_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    
    [viewcontrol.view addSubview:help_next];
    
    viewcontrol.modalPresentationStyle = UIModalPresentationFormSheet;
    viewcontrol.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentModalViewController:viewcontrol animated:YES];
    [viewcontrol release];
    
}
#pragma mark -------------
#pragma mark socket

-(void)AutoSearchServer
{

    if([SEND_MSG_PE whetherConnected])
	{
        
		return ;
	}


    [self startHUDWaiting:NSLocalizedString(@"Searching", @"search") controller:self];
 
    //auto search
    [SEND_MSG_PE searchStart];
    
}
-(void)researchServerStarted
{
    [self startHUDWaiting:NSLocalizedString(@"Searching", @"search") controller:self];
    //auto search
    [SEND_MSG_PE searchStart];
}
-(BOOL)whetherRecivedMsg
{
    return received_Msg;
}

-(BOOL)sendMessageToServer:(NSString*)sendToMSG
{

    if(![SEND_MSG_PE whetherConnected])
	{
		return FALSE;
	}
    //是否等待接收消息
    if (![self whetherRecivedMsg]) {
        return FALSE;
    }
    NSLog(@"send %@",sendToMSG);
	
    [SEND_MSG_PE sendMessageToServer:sendToMSG];
    
    received_Msg = FALSE;
    
	
    return TRUE;
}
#pragma mark -----------------

-(void)hidenTwoButton
{
	switchButton.hidden = TRUE;
}

-(void)showTwoButton
{
	switchButton.hidden = FALSE;
}

- (void)showAlertDialog
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] 
								  initWithTitle:@"Are you sure?" 
								  delegate:self 
								  cancelButtonTitle:@"No Way!"
								  destructiveButtonTitle:@"Yes, I'm Sure!" 
								  otherButtonTitles:nil];
	[actionSheet showInView:self.view];
	[actionSheet release];
}

-(void)setIPAdressPort:(NSString*) host port:(UInt16)port
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:host forKey:kIPadressKey];
    [defaults setValue:[NSString stringWithFormat:@"%d",port] forKey:kPortKey];
    [defaults synchronize];
}
#pragma mark --------------
-(void)didConnectToHost:(NSString *)host port:(UInt16)port {

    [self stopHUDWaiting:self];
	{
        
        NSLog(@"AsyncSocket didConnectToHost: %@ port: %d",host, port);

        
        [self startAnimateFont:@"Connected" frame:CGRectMake(0,100,320,100) transfrom:0];
        
        [self setIPAdressPort:host port:port];

        //connected
//        [self isConnected];
    }
}
-(void)isConnected
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:IS_CONNECTED];
    [defaults synchronize];
}

-(void)showAnimateStr:(NSString*)str
{

    [self startAnimateFont:str frame:CGRectMake(0,100,320,100) transfrom:0];
}
-(void)didSocketReceiveData {

	received_Msg = TRUE;
    [self stopHUDWaiting:self];
}
-(void)socketDidDisconnect
{
    [self stopHUDWaiting:self];
}
-(void)searchServerFailed {
	
    {

        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""   
                                                       message:NSLocalizedString(@"troubleshooting", @"show troubleshooting")    
                                                      delegate:self   
                                             cancelButtonTitle:@"Cancel"   
                                             otherButtonTitles:NSLocalizedString(@"troubleshooting alarm", @"troubleshooting"),nil];  
        //设置标题与信息，通常在使用frame初始化AlertView时使用  
//        alert.title = @"AlertViewTitle";  
//        alert.message = @"AlertViewMessage";  
        
        //这个属性继承自UIView，当一个视图中有多个AlertView时，可以用这个属性来区分  
        alert.tag = UNBALE_CONNECT;  
        
        //通过给定标题添加按钮  
        [alert addButtonWithTitle:NSLocalizedString(@"Help", @"show Help")];  
        
        //显示AlertView  
        [alert show];  
        
        [alert release]; 
        
        [self stopHUDWaiting:self];
    }
    
}

-(void)disconnectSocketWithError {
	
    received_Msg = FALSE;
}
#pragma mark --------------
-(void)loadHelicopterViewController
{
    if (helicopterViewController == nil) {
        HelicopterAddViewController *viewController = [[HelicopterAddViewController alloc] initWithNibName:@"HelicopterAddViewController" bundle:nil];
        self.helicopterViewController = viewController;
        [viewController release];

    }

	[self.view addSubview:self.helicopterViewController.view];
	[helicopterViewController setDelegate:self];
}
-(void)loadHandleViewController{
    if (handleViewController == nil) {
        HandleView *viewController = [[HandleView alloc] initWithNibName:@"HandleView" bundle:nil];
        self.handleViewController = viewController;
        [viewController release];
    }
	
	[self.view addSubview:self.handleViewController.view];

}
-(void)loadHandleViewController2{
    if (handleViewController2 ==  nil) {
        HandleView2 *viewController = [[HandleView2 alloc] initWithNibName:@"HandleView2" bundle:nil];
        self.handleViewController2 = viewController;
        [viewController release];
    }
	
	[self.view addSubview:self.handleViewController2.view];

}
-(void)loadHandleViewController3{
    if (handleViewController3 == nil) {
        HandleView3 *viewController = [[HandleView3 alloc] initWithNibName:@"HandleView3" bundle:nil];
        self.handleViewController3 = viewController;
        [viewController release];
    }
	
	[self.view addSubview:self.handleViewController3.view];

}

-(void)loadQuickSwitchHelpView{
    if (quickSwitchHelpView == nil) {
        QuickSwitchHelpView *viewController = [[QuickSwitchHelpView alloc] initWithNibName:@"QuickSwitchHelpView" bundle:nil];
        self.quickSwitchHelpView = viewController;
        [viewController release];
    }
	
	[self.view addSubview:self.quickSwitchHelpView.view];

}

-(void)loadKeyboardViewController{
    if (keyboardViewController == nil) {
        KeyboardViewController *viewController = [[KeyboardViewController alloc] initWithNibName:@"KeyboardViewController" bundle:nil];
        self.keyboardViewController = viewController;
        [viewController release];
    }
	
	[self.view addSubview:self.keyboardViewController.view];
	[keyboardViewController setDelegate:self];
}

-(BOOL) Noza_f_whether_Lock_Level_6
{
    //whether purchase
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    int i = [app MenuIAPState];
    switch(i)
    {
        case 0://not buy
            return false;
            break;
        case 11://buyed
            return true;
            break;
            
    }
    return false;
}
- (ChooseWhichVersion *)chooseWhichVersion {
    // Instantiate the detail view controller if necessary.
    if (chooseWhichVersion == nil) {
        chooseWhichVersion = [[ChooseWhichVersion alloc] initWithNibName:@"ChooseWhichVersion" bundle:nil];
    }
    return chooseWhichVersion;
}
- (IBAction)SwitchView:(id)sender{
//    GET_LOCAL_LANGUAGE
//    NSLog(@"language %@",currentLanguage);
//
//    
//    if (![currentLanguage isEqualToString: @"zh-Hans"])
//    {
//        if (![self Noza_f_whether_Lock_Level_6]) {
//            return;
//        }
//    }
//    
//    //中国区免费
//    [self goToChooseWhichVersion];
    
//    if (![self Noza_f_whether_Lock_Level_6])
    if (NO == [self checkWhetherBuyed])
    {
        
        [self freeUnlock];

        [self alertMessageBuyOrFree];
    }else {
        [self goToChooseWhichVersion];
    }
}
-(BOOL)checkWhetherBuyed
{
    //whether purchase
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    //whether themp unlock
    int ii = [app TempUnlockState];
    if (ii == 11) {
        return YES;
    }
    int i = [app MenuIAPState];
    switch(i)
    {
        case 0://not buy
            return NO;
            break;
        case 11://buyed
            return YES;
            break;
            
    }
    
    return NO;
}
-(void)alertMessageBuyOrFree
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""   
                                                   message:NSLocalizedString(@"Unlock", @"Unlock") 
                                                  delegate:self   
                                         cancelButtonTitle:@"Cancel"   
                                         otherButtonTitles:NSLocalizedString(@"Buy Full version", @"Buy Full version"),nil];  
    
    //这个属性继承自UIView，当一个视图中有多个AlertView时，可以用这个属性来区分  
    alert.tag = UNLOCK_ADS;  
    
    //通过给定标题添加按钮  
//    [alert addButtonWithTitle:NSLocalizedString(@"Free Unlock", @"Free Unlock")];  
    [alert addButtonWithTitle:@"Restore"];
    //显示AlertView  
    [alert show];  
    
    [alert release];  
}
-(void)goToChooseWhichVersion
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey] ) {
        AudioServicesPlaySystemSound (self.soundFileObject3);
    }
    
    UIViewController *targetViewController = self.chooseWhichVersion;
    chooseWhichVersion.delegate = self;
    chooseWhichVersion.view.center = CGPointMake(160,-240);
    {
        [self.view addSubview:targetViewController.view];
        
    }
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];    
    chooseWhichVersion.view.center = CGPointMake(160,240);
    
    [UIView commitAnimations];
}
-(void)buyTheAppAndSwitch
{
    //购买iap
    
    if (![self Noza_f_whether_Lock_Level_6]) {
        NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
        [app requestProductData];
        return;
    }
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]  ) {
//        AudioServicesPlaySystemSound (self.soundFileObject);
//    }
//	
//	if (handleViewController == nil) {
////		[self loadHandleViewController];
//	}
//	
//	UIView *handleView = handleViewController.view;
//	UIView *mouseView = mouseViewController.view;
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//	
//	
//	
//	if ([mouseView superview] != nil) {
//		[mouseView removeFromSuperview];
//		[self.view insertSubview:handleViewController.view atIndex:0];
//		[defaults setBool:FALSE forKey:kViewSwitchKey];	
//	} else {		
//		[handleView removeFromSuperview];
//		[self.view insertSubview:mouseViewController.view atIndex:0];
//		[defaults setBool:TRUE forKey:kViewSwitchKey];
//	}

}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [mouseViewController release];
    [horizMouseViewController release];
    [handleViewController release];

    [switchButton release];
    [keyboardViewController release];
    
	[super dealloc];
}
-(void)initHorizMouseView
{
    if(horizMouseViewController == nil)
    {
        //horiz
        HorizMouseView *viewController1 = [[HorizMouseView alloc] initWithNibName:@"HorizMouseView" bundle:nil];
        self.horizMouseViewController = viewController1;
        [viewController1 release];
    }
}
#pragma mark -------------
#pragma mark accelerometer

// UIAccelerometerDelegate method, called when the device accelerates.
- (void)didReceiveAccelerometer:(UIAcceleration *)acceleration{
    // Update the accelerometer graph view
#if 0
    
    //whether shake the iphone
    if(deviceTilt.y !=0 && deviceTilt.x != 0)
        if ( (deviceTilt.x - acceleration.x) > 1.5f &&
            (deviceTilt.y - acceleration.y) > 0.5f) {
            UITextField *textField = (UITextField *)[self.view viewWithTag:TEXTFIELDTAG];
            if(!textField.editing) {
                [self textEditShow];
            }else
            {
                [self textEditHide];
            }
        }
	deviceTilt.x = acceleration.x;
	deviceTilt.y = acceleration.y;
    
    //is horiz or 
    if (acceleration.y < 0 && acceleration.z < 0 ) {
        if (acceleration.x > 0.8) {
            //horiz
            if (!iphone_horiz_state) {
                iphone_horiz_state = TRUE;
                [self initHorizMouseView];
                [self hidenTwoButton];
                [mouseViewController.view removeFromSuperview];
                [self.view insertSubview:horizMouseViewController.view atIndex:0];
            }
        }else if(acceleration.x < 0 )
        {
            //
            if (iphone_horiz_state) {
                iphone_horiz_state = FALSE;
                [self showTwoButton];
                [horizMouseViewController.view removeFromSuperview];
                [self.view insertSubview:mouseViewController.view atIndex:0];
            }
        }
    }
#endif
    
}
-(void)HelicopterGoBackToMainView
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey] ) {
        AudioServicesPlaySystemSound (self.soundFileObject2);
    }
    
    [self disappearHelicopterAds];
}
-(void)GoBackToMainView
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey] ) {
        AudioServicesPlaySystemSound (self.soundFileObject2);
    }
    
    [self disappearChooseWhichVersion];
}
-(void)SwitchToHelicopter
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]  ) {
        AudioServicesPlaySystemSound (self.soundFileObject);
    }
	
	{
		[self loadHelicopterViewController];
        
        helicopterViewController.view.center = CGPointMake(160,-240);
	}
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];    
    helicopterViewController.view.center = CGPointMake(160,240);
    
    [UIView commitAnimations];
    

//        CircleRoundViewController *viewController = [[[CircleRoundViewController alloc] initWithNibName:@"CircleRoundViewController" bundle:nil] autorelease];
//
//	[self.view addSubview:viewController.view];
}
-(void)SwitchToView1
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]  ) {
        AudioServicesPlaySystemSound (self.soundFileObject);
    }
	
	{
		[self loadHandleViewController];

        handleViewController.view.center = CGPointMake(160,-240);
	}
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];    
    handleViewController.view.center = CGPointMake(160,240);
    
    [UIView commitAnimations];
    
}
-(void)SwitchToView2
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]  ) {
        AudioServicesPlaySystemSound (self.soundFileObject);
    }
	
	{
		[self loadHandleViewController2];

        handleViewController2.view.center = CGPointMake(160,-240);
	}
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];    
    handleViewController2.view.center = CGPointMake(160,240);
    
    [UIView commitAnimations];
    
}
-(void)SwitchToView3
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]  ) {
        AudioServicesPlaySystemSound (self.soundFileObject);
    }
	
	{
		[self loadHandleViewController3];

        handleViewController3.view.center = CGPointMake(160,-240);
	}
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];    
    handleViewController3.view.center = CGPointMake(160,240);
    
    [UIView commitAnimations];
    
}
-(void)SwitchToHelpView
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]  ) {
        AudioServicesPlaySystemSound (self.soundFileObject);
    }
	
	{
		[self loadQuickSwitchHelpView];

        quickSwitchHelpView.view.center = CGPointMake(160,-240);
	}
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];    
    quickSwitchHelpView.view.center = CGPointMake(160,240);
    
    [UIView commitAnimations];
    
}
-(void)SwitchToKeyboardView
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kIPsoundKey]  ) {
        AudioServicesPlaySystemSound (self.soundFileObject);
    }
	
	{
		[self loadKeyboardViewController];

        keyboardViewController.view.center = CGPointMake(160,-240);
	}
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];    
    keyboardViewController.view.center = CGPointMake(160,240);
    
    [UIView commitAnimations];
    
}
-(void)disappearChooseWhichVersion
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];  
    chooseWhichVersion.view.center = CGPointMake(160,-240);
    [UIView setAnimationDelegate:chooseWhichVersion.view];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    [UIView commitAnimations];
}
-(void)disappearHelicopterAds
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];  
    helicopterViewController.view.center = CGPointMake(160,-240);
    [UIView setAnimationDelegate:helicopterViewController.view];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    [UIView commitAnimations];
}
-(void)GoBackToMainToHelicopter
{
    
    [self disappearChooseWhichVersion];
    
    [self SwitchToHelicopter];
    
}
-(void)GoBackToMainViewNo1
{

    [self disappearChooseWhichVersion];
    
    [self SwitchToView1];
      
}
-(void)GoBackToMainViewNo2
{
    [self disappearChooseWhichVersion];
    
    
    [self SwitchToView2];
    
}
-(void)GoBackToMainViewNo3
{
    [self disappearChooseWhichVersion];
    
    
    [self SwitchToView3];
    
}
-(void)GoBackToMainViewNo4
{
    [self disappearChooseWhichVersion];
    
    
    [self SwitchToHelpView];
    
}
-(void)GoBackToMainViewKeyboard
{
    [self disappearChooseWhichVersion];
    
    
    [self SwitchToKeyboardView];
    
}

-(void)removeFromSuperview:(UIView*)view
{
    for (UIView *tempView in [self.view subviews]) {
		{
			if (tempView == view) {
                [view removeFromSuperview];
            }
		}
	}
}
#pragma mark -----------------
#pragma mark UIScroll view
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}
// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}
//然后在滚动的过程中，scrollView的这个delegate方法被调用，我们在这个方法去设定加载的内容，然后再调用之前的loadScrollViewWithPage:去初始化和加载内容。
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    // 控制在页面转到50％的时候设定加载新内容
    CGFloat pageWidth = self.scrollButtonView.frame.size.width;
    int page = floor((self.scrollButtonView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;

    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
    // 这里就可以自己设定去释放那些没有加载的内容了
}

#pragma mark ---------
#pragma mark alertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == UNBALE_CONNECT) {
        if (buttonIndex == 1) {
            //truble shooting view
            [self trubleshootingshow];
            
        }else if (buttonIndex == 2){
            //view website
            		NSURL *url = [NSURL URLWithString:@"http://www.phonegamesoftware.cn"];
            		[[UIApplication sharedApplication] openURL:url];
        }
    }else
    if (alertView.tag == UNLOCK_ADS) {
        if (buttonIndex == 1) {
            //buy fullversion
            NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
            [app requestProductData];
            
        }else if (buttonIndex == 2){
            //free unlock
//            [self freeUnlock];
            //restore
            //restore
            NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
            [app startWaiting];
            [app requestRestoreProductData];
        }
    }else
	if (alertView.tag == GOTO_WEBSITE) {
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:@"http://www.phonegamesoftware.cn"];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}
#pragma mark -------------
#pragma mark free unlock
-(void)freeUnlock
{
    // Check if ad inventory is available per hook.
    BOOL adAvailableNR = [FlurryAppCircle appAdIsAvailable:@"NFS_STORE_APP_RECOMMEND"]; 
    //            BOOL videoAvailable = [FlurryClips videoAdIsAvailable:@"STORE_VIDEO"];
    //            BOOL adAvailableR = [FlurryAppCircle appAdIsAvailable:@"STORE_APP_REWARDS"];
    
    // Build IF statement based on ad inventory to determine which ad formats to display
    if (adAvailableNR) {    
//        [FlurryAppCircle openTakeover:@"NFS_STORE_APP_RECOMMEND" orientation:@"landscape" rewardImage:nil 
//                        rewardMessage:nil userCookies:nil];
        //            } else if (videoAvailable) {
        //                [FlurryClips openVideoTakeover:@"STORE_VIDEO" orientation:nil rewardImage:rewardImage 
        //                                 rewardMessage:@"10 Free Points" userCookies:dictionary autoPlay:NO];
        //            } else if (adAvailableR) {
        //                [FlurryAppCircle openTakeover:@"STORE_APP_REWARDS" orientation:@"landscape" 
        //                                  rewardImage:rewardImage rewardMessage:@"15 credits" userCookies:dictionary];
    }
    
    NSDictionary *dictionary =
    [NSDictionary dictionaryWithObjectsAndKeys:@"gold",
     @"rewardCurrency",
     @"10",
     @"rewardAmount",
     nil];

    UIImage *rewardImage = [UIImage imageNamed:@"Icon.png"];
    [FlurryAppCircle openTakeover:@"USE_AN_UNIQUE_HOOK_NAME"
                      orientation:@"portrait"
                      rewardImage:rewardImage
                    rewardMessage:@"DOWNLOAD and LAUNCH this app to earn 10 gold"
                      userCookies:dictionary];
    //unlock
    [self tempUnlockFeatures];
}

-(void)tempUnlockFeatures
{
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    [app setTempUnlockState:11];
    
}
@end
