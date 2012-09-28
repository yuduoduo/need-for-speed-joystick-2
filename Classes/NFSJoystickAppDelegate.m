//
//  NFSJoystickAppDelegate.m
//  NFSJoystick
//
//  Created by Jeff LaMarche on 7/24/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "NFSJoystickAppDelegate.h"

#import "BoardViewController.h"
#import "DemoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIDevice+IdentifierAddition.h"
#import "FlurryAppCircle.h"

#define kMyFeatureIdentifier @"com.microkernel.joystick2.FullVersion"

@implementation NFSJoystickAppDelegate


@synthesize window = _window;

@synthesize observer,FlurryAnalytics;
- (void)loadCompontAction {

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
//	application.applicationSupportsShakeToEdit = NO;
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];

    [self addViewCompont];
	
    
	[self.window makeKeyAndVisible];
    
    //in app purchase
    MyStoreObserver *tempObserver = [[MyStoreObserver alloc] init];
	self.observer = tempObserver;
	[tempObserver release];
	[[SKPaymentQueue defaultQueue] addTransactionObserver:self.observer];
	
    [FlurryAppCircle setAppCircleEnabled:YES]; 
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [FlurryAnalytics startSession:@"QG8P5JBMFWYG6DPHNB8K"];
    
      
    //check whether is updated
//    if ([self whetherIsFirstInstallV2]) {
//        if ([self whetherIsUpdateFromeV1]) {
//            UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"alertTitle", 
//                                                                                    @"Please note that")
//        message:NSLocalizedString(@"alertMessage", 
//                                  @"The major changes from version 2.0, you must upgrade the PC server-side, or else unable to connect.Please visit http://www.phonegamesoftware.cn")
//        delegate:nil cancelButtonTitle:NSLocalizedString(@"alertDone", 
//                                                         @"I have downloaded the latest version.")
//        otherButtonTitles:nil,nil] autorelease];
//            [alert show];
//        }
//        [self setFirstInstallDictionaryForV2];
//    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //程序初始化

    
    [self loadCompontAction];
    [self clearTempUnlockState];
    return YES;
}
-(void)addViewCompont
{
    UINavigationController *nav =  [[UINavigationController alloc] init];
    nav.delegate = self;
    [nav setNavigationBarHidden:TRUE];
    
    
    RootViewController *viewController = [[[RootViewController alloc]init]  autorelease];
    [nav pushViewController:viewController animated:NO];
    
    self.window.rootViewController =  nav;
}
void uncaughtExceptionHandler(NSException *exception) {
    [FlurryAnalytics logError:@"Uncaught" message:@"Crash!" exception:exception];
}
- (void)applicationWillTerminate:(UIApplication *)application{

    [self setMenuIAPState:0];
    
    
}
- (void)dealloc {
	//buy
	[observer release];


	[super dealloc];
}
#pragma mark -
#pragma mark Utilities method to help find ressources from the applications directory or from the user directory:

// Permits to retrieve the path for the given file on the user documents dir
- (NSString *)documentPathForFile:(NSString *)aPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *appFile = [documentsDirectory stringByAppendingPathComponent:aPath];
	return appFile;
}

// Permits to retrive the path for the given file on the application ressources dir
- (NSString *)bundlePathForRessource:(NSString *)aRessource ofType:(NSString *)aType
{
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *path = [bundle pathForResource:aRessource ofType:aType];
	return path;
}


#pragma mark --------
#pragma mark email
-(void)EmailToFriend
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet:NSLocalizedString(@"EmailTitle1", 
                                                         @"To Friend Head") 
                                  body:NSLocalizedString(@"EmailBody1", 
                                                         @"To Friend Body")
             recipient:@""];
		}
		else
		{
			[self launchMailAppOnDevice:NSLocalizedString(@"EmailTitle1", 
                                                          @"To Friend Head") 
                                   body:NSLocalizedString(@"EmailBody1", 
                                                          @"To Friend Body")
             recipient:@""];
		}
	}
	else
	{
		[self launchMailAppOnDevice:NSLocalizedString(@"EmailTitle1", 
                                                      @"To Friend Head") 
                               body:NSLocalizedString(@"EmailBody1", 
                                                      @"To Friend Body")
         recipient:@""];
	}
}
-(void)EmailToUS
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet:NSLocalizedString(@"EmailTitle2", 
                                                         @"ToUs Head") 
                                  body:NSLocalizedString(@"EmailBody2", 
                                                         @"ToUs Body") 
             recipient:@"microkernel.com@gmail.com"];
		}
		else
		{
			[self launchMailAppOnDevice:NSLocalizedString(@"EmailTitle2", 
                                                          @"ToUs Head") 
                                   body:NSLocalizedString(@"EmailBody2", 
                                                          @"ToUs Body")
             recipient:@"microkernel.com@gmail.com"];
		}
	}
	else
	{
		[self launchMailAppOnDevice:NSLocalizedString(@"EmailTitle2", 
                                                      @"ToUs Head") 
                               body:NSLocalizedString(@"EmailBody2", 
                                                      @"ToUs Body")
                          recipient:@"microkernel.com@gmail.com"];
	}
}
#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet :(NSString*)head body:(NSString*)body recipient:(NSString*)recipient
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
// 添加发送者
NSArray *toRecipients = [NSArray arrayWithObject:recipient];
 [picker setToRecipients:toRecipients];
    
	[picker setSubject:head];
	
	[picker setMessageBody:body isHTML:NO];
	
	[self.window.rootViewController presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
    
	[self.window.rootViewController dismissModalViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice:(NSString*)head body:(NSString*)body recipient:(NSString*)recipient
{
	NSString *email = [NSString stringWithFormat:@"%@%@%@%@%@%@", @"mailto:",recipient,@"&subject=",head, @"&body=",body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

#pragma mark request delegate
- (void) requestProductData{

    
	//NSLog(@"requestProductData");
	SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers: [NSSet setWithObject: kMyFeatureIdentifier]];
	request.delegate = self;
	[request start];
}
//!收到产品的消息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
	NSLog(@"ProductsRequest did receiveResponse");
//	NSArray *myProduct = response.products;
   
	SKPayment *payment;

    payment = [SKPayment paymentWithProductIdentifier:kMyFeatureIdentifier];
    
    
	[[SKPaymentQueue defaultQueue] addPayment:payment];
	[request autorelease];
	
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
	UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"Alert" message:[error localizedDescription]
                                                       delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
	
	[alerView show];
	[alerView release];
}
-(void)iapBuyFailed
{

    
    [self setMenuIAPState:0];

}
-(BOOL)whetherIsBuyed
{
    NSString *UDID = [self getDeviceID];
    NSString *storeID = [self getStoreID];
    BOOL isEqual = [UDID isEqualToString: storeID];

    
    return isEqual;
}
-(void)iapBuyAndHidenAds
{

    
    [self setDeviceID];//保存信息
    [self setMenuIAPState:11];
}
-(int)MenuIAPState
{

    return  [[[NSUserDefaults standardUserDefaults] objectForKey:@"menuiapstate"] intValue] ;
}
-(void)setMenuIAPState:(int)inivalue
{
    [[NSUserDefaults standardUserDefaults] setInteger:inivalue forKey:@"menuiapstate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//firest run
-(int)firstRunState
{
    
    return  [[[NSUserDefaults standardUserDefaults] objectForKey:@"firstrunapp"] intValue] ;
}
-(void)setFirstRunState:(int)inivalue
{
    [[NSUserDefaults standardUserDefaults] setInteger:inivalue forKey:@"firstrunapp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//-(NSString*) stringWithUUID {
//    CFUUIDRef    uuidObj = CFUUIDCreateFromString(nil,@"68753A44-4D6F-1226-9C60-0050E4C00067");//create a new UUID
//    //get the string representation of the UUID
//    NSString    *uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
//    CFRelease(uuidObj);
//    return [uuidString autorelease];
//}



-(NSString*)getDeviceID
{
    
    //
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString *deviceID = [myDevice uniqueGlobalDeviceIdentifier]; 
    return deviceID;
}

-(NSString*)getStoreID
{
    NSData *storeData = [[NSUserDefaults standardUserDefaults] dataForKey:kMyFeatureIdentifier];
    
    [storeData getBytes:&iapstoredata length:sizeof(iapstoredata)];
    
    NSString *deviceID = [[[NSString alloc] initWithUTF8String:iapstoredata.UDID] autorelease]; 
    return deviceID;
}

-(void)setDeviceID
{
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString *deviceID = [myDevice uniqueGlobalDeviceIdentifier]; 
    char *c = [deviceID UTF8String]; 
    memcpy(&(iapstoredata.UDID), c, sizeof(iapstoredata.UDID));
    iapstoredata.m = 1;
    iapstoredata.n = 1;
    iapstoredata.x = 1;
    iapstoredata.y = 1;
    
    NSData *filedata = [NSData dataWithBytes:& iapstoredata length:sizeof(iapstoredata)];
    [[NSUserDefaults standardUserDefaults] setValue:filedata forKey:kMyFeatureIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark ----------------
#pragma mark restore
- (void) requestRestoreProductData
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}
#pragma mark --------
#pragma mark demo view

-(void)TranslateToDemoView
{
    DemoViewController *viewcontrol = [[DemoViewController alloc] init];
    // Set the Button Type.
    UIButton* help_next = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Position the button - I found these numbers align fine (0, 0 = top left of keyboard)
    help_next.frame = CGRectMake(251, 440, 65, 39);
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
    
    [self.window.rootViewController presentModalViewController:viewcontrol animated:YES];
    [viewcontrol release];
}

#pragma mark --------
#pragma mark present help
-(void)help_buttonPressed:(UIButton *)button
{
    [self.window.rootViewController dismissModalViewControllerAnimated:YES];
}
-(void)TranslateToHelp
{
    BoardViewController *viewcontrol = [[BoardViewController alloc] init];
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
    
    [self.window.rootViewController presentModalViewController:viewcontrol animated:YES];
    [viewcontrol release];
}
#pragma mark --------
#pragma mark v2
-(void)setFirstInstallDictionaryForV2
{
    //    FOR_VERSION_2
    NSString *boundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSDate *_date = [NSDate date];
    NSString *create_date = [NSString stringWithFormat:@"%@",_date];
    NSDictionary *saveinfo = [[[NSDictionary alloc]initWithObjectsAndKeys:
                              boundleVersion,@"version",
                              create_date,@"createdate",
                              @"NO",@"firstrunapp2",
                              nil] autorelease];
    
    [[NSUserDefaults standardUserDefaults] setObject:saveinfo forKey:FOR_VERSION_2];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)whetherIsUpdateFromeV1
{
    NSDictionary *saveinfo = [[NSUserDefaults standardUserDefaults] objectForKey:FOR_VERSION_2];
    if (saveinfo == nil || [saveinfo count] == 0) {
        if (11 == [self firstRunState]) {
            return YES;
        }else {
            return NO;
        }
    }
    return NO;
}
-(BOOL)whetherIsFirstInstallV2
{
    NSDictionary *saveinfo = [[NSUserDefaults standardUserDefaults] objectForKey:FOR_VERSION_2];
    if (saveinfo != nil && [saveinfo count] != 0) {
        NSString *first = [saveinfo objectForKey:@"firstrunapp2"];
        if ([first isEqualToString:@"NO"]) {
            return NO;
        }else {
            return YES;
        }
    }else {
        return YES;
    }
    return YES;
}

#pragma mark -------------
#pragma mark waiting
-(void)startWaiting
{

}
-(void)stopWaiting
{

}
@end
