//
//  RootViewController.m
//  NFSJoystick
//
//  Created by Jeff LaMarche on 7/24/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
//#import "FlipsideViewController.h"
#import "BoardViewController.h"
#import "SettingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppListViewController.h"
#import <Math.h>
#import "NFSJoystickAppDelegate.h"
#import "DefineComm.h"
#import "UIImageEx.h"
@implementation UINavigationBar (MyNavigationBarAdditions)
- (void)drawRect:(CGRect)rect {
    UIImage *img = [UIImage imageNamed: @"NaviBar.png"];
    [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end

@implementation RootViewController


@synthesize flipsideNavigationBar;
@synthesize mainViewController;
//@synthesize flipsideViewController;
@synthesize boardViewController,settingViewController;

//sound
@synthesize soundFileURLRef;
@synthesize soundFileObject;
@synthesize soundFileURLRef2;
@synthesize soundFileObject2;

- (void)viewDidLoad {
    [super viewDidLoad];

	[self initRateView];


    
    //whether purchase
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    if([app whetherIsBuyed])
    {
        [app setMenuIAPState:11];
    }	
    
    int i = [app firstRunState];
    switch(i)
    {
        case 0://first run
            [self loadBoardViewController];
            [self.navigationController pushViewController:boardViewController animated:NO];

//            [app setFirstRunState:11];
            break;
        case 11://
            [self loadMainViewController];
            [self.navigationController pushViewController:mainViewController animated:NO];

            [mainViewController setRootViewController:self];
            
    
            break;
        default:
            [self loadBoardViewController];
            [self.navigationController pushViewController:boardViewController animated:NO];

            break;
    }
    

    [self setupApplicationAudio];
}
-(BOOL)whetherIsConnected
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL whether = [defaults boolForKey:IS_CONNECTED];
    return whether;
}

-(void)initRateView
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if (! [defaults objectForKey:@"firstRun"]) {
		[defaults setObject:[NSDate date] forKey:@"firstRun"];
	}
	
	NSInteger daysSinceInstall = [[NSDate date] timeIntervalSinceDate:[defaults objectForKey:@"firstRun"]] / 86400;
	BOOL whether = [defaults boolForKey:@"askedForRating"];
	if ( !whether ) {
		if(daysSinceInstall > 7)
		{
            //reward
            BOOL whether = [defaults boolForKey:@"askedForReward"];
            if ( !whether ) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setBool:YES forKey:@"askedForReward"];
                [defaults synchronize];
                
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:
                                      NSLocalizedString(@"Like This App?", 
                                                        @"Like This App?") 
                                                                message:NSLocalizedString(@"Unlock More Features", 
                                                                                          @"Unlock More Features")  delegate:self cancelButtonTitle:
                                      NSLocalizedString(@"Later", 
                                                        @"Later") 
                                                      otherButtonTitles:
                                      NSLocalizedString(@"Rate/Review it", 
                                                        @"Rate/Review it")
                                      , nil];
                [alert show];
                [alert release]; 
            }else {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:
                                      NSLocalizedString(@"Like This App?", 
                                                        @"Like This App?") 
                                                                message:@"If so, please rate this game with 5 stars on the App Store so we can keep the free updates coming." delegate:self cancelButtonTitle:
                                      NSLocalizedString(@"Later", 
                                                        @"Later") 
                                                      otherButtonTitles:
                                      NSLocalizedString(@"Rate/Review it", 
                                                        @"Rate/Review it")
                                      , nil];
                [alert show];
                [alert release]; 
            }
			
			
		}
		
	}

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setBool:YES forKey:@"askedForRating"];
		NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=375490342&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"];
		[[UIApplication sharedApplication] openURL:url];
		
	}else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"askedForRating"];
        [defaults setObject:[NSDate date] forKey:@"firstRun"];
        [defaults synchronize];
    }
}

-(void)loadMainViewController{
	MainViewController *viewController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = viewController;
	[viewController release];
	
	
}
#define NEXTBUTTONTAG 500
-(void)loadBoardViewController{
	BoardViewController *viewController = [[BoardViewController alloc] initWithNibName:@"BoardViewController" bundle:nil];
	self.boardViewController = viewController;
	[viewController release];
	
    // Set the Button Type.
    UIButton *help_next = [UIButton buttonWithType:UIButtonTypeCustom];
    help_next.tag = NEXTBUTTONTAG;
    // Position the button - I found these numbers align fine (0, 0 = top left of keyboard)
    help_next.frame = CGRectMake(240, 430, 65, 39);
    help_next.bounds = CGRectMake(0, 0, 65, 39);
    [help_next addTarget:self action:@selector(help_buttonPressed:) forControlEvents:UIControlEventTouchDown];
    help_next.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;

    [help_next.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    [help_next setTitle:NSLocalizedString(@"Next", @"button Next") forState:UIControlStateNormal];

    [self.boardViewController.view addSubview:help_next];
    
    // Add images to our button so that it looks just like a native UI Element.
    [help_next setBackgroundImage:[[UIImage imageNamed:@"help_next_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [help_next setBackgroundImage:[[UIImage imageNamed:@"help_next_highlighted_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    //news
    // Set the Button Type.
    UIButton *news_button = [UIButton buttonWithType:UIButtonTypeCustom];
    news_button.tag = NEXTBUTTONTAG;
    // Position the button - I found these numbers align fine (0, 0 = top left of keyboard)
    news_button.frame = CGRectMake(15, 430, 65, 39);
    news_button.bounds = CGRectMake(0, 0, 65, 39);
    [news_button addTarget:self action:@selector(news_buttonPressed:) forControlEvents:UIControlEventTouchDown];
    news_button.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    
    [news_button.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    [news_button setTitle:NSLocalizedString(@"News", @"button news") forState:UIControlStateNormal];
    
    [self.boardViewController.view addSubview:news_button];
    
    // Add images to our button so that it looks just like a native UI Element.
    [news_button setBackgroundImage:[UIImageEx rotateImage:[[UIImage imageNamed:@"help_next_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] ]  forState:UIControlStateNormal];
    [news_button setBackgroundImage:[UIImageEx rotateImage:[[UIImage imageNamed:@"help_next_highlighted_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]]  forState:UIControlStateHighlighted];
}

- (void)news_buttonPressed:(UIButton *)button
{
    [self playToggleSound];
    [self TranslateToNews];
}
#pragma mark --------
#pragma mark present news
-(void)news_done_buttonPressed:(UIButton *)button
{
    [self.boardViewController dismissModalViewControllerAnimated:YES];
}
-(void)TranslateToNews
{
    AppListViewController *viewcontrol = [[AppListViewController alloc] init];
    // Set the Button Type.
    UIButton* help_next = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Position the button - I found these numbers align fine (0, 0 = top left of keyboard)
    help_next.frame = CGRectMake(240, 430, 65, 39);
    help_next.bounds = CGRectMake(0, 0, 65, 39);
    [help_next addTarget:self action:@selector(news_done_buttonPressed:) forControlEvents:UIControlEventTouchDown];
    help_next.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    
    [help_next.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    [help_next setTitle:NSLocalizedString(@"Done", @"button done") forState:UIControlStateNormal];
    [help_next setBackgroundImage:[[UIImage imageNamed:@"help_next_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [help_next setBackgroundImage:[[UIImage imageNamed:@"help_next_highlighted_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    
    [viewcontrol.view addSubview:help_next];
    
    viewcontrol.modalPresentationStyle = UIModalPresentationFormSheet;
    viewcontrol.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.boardViewController presentModalViewController:viewcontrol animated:YES];
    [viewcontrol release];
}
- (void)help_buttonPressed:(UIButton *)button
{
    [self playToggleSound];
    
    int page = [boardViewController boardChangePageIndex];
    if (page < 6) {
        UIButton *help_next = (UIButton *)[self.view viewWithTag:NEXTBUTTONTAG];
        [help_next.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
        [help_next setTitle:NSLocalizedString(@"Next", @"button next") forState:UIControlStateNormal];

    }else if(page == 6)
    {
        UIButton *help_next = (UIButton *)[self.view viewWithTag:NEXTBUTTONTAG];
        [help_next.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
        [help_next setTitle:NSLocalizedString(@"Done", @"button done") forState:UIControlStateNormal];
        


    }else if(page == 7)
    {
                [self boardToMain];
    }

    
}
-(void)boardToMain
{
    if (mainViewController == nil) {
		[self loadMainViewController];
	}

	
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:YES];
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController pushViewController:mainViewController animated:NO];
    [UIView commitAnimations];
}

- (void)loadSettingViewController {
        
        SettingViewController *viewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        self.settingViewController = viewController;
    [self.settingViewController setRootViewController:self];
        [viewController release];	

	// Set up the navigation bar
	UINavigationBar *aNavigationBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)] autorelease];

	self.flipsideNavigationBar = aNavigationBar;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            [self.flipsideNavigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBar.png"] forBarMetrics:0]; 
        }
        
      
        UIButton *buttondone = [UIButton buttonWithType:UIButtonTypeCustom];
        buttondone.bounds = CGRectMake(0.0, 0, 50, 30);
        //buttondone.frame = CGRectMake(0, 0, 50, 30);
        [buttondone setBackgroundImage:[[UIImage imageNamed:@"settings_grey_button.png"] stretchableImageWithLeftCapWidth:3 topCapHeight:0] forState:UIControlStateNormal];
        [buttondone setBackgroundImage:[[UIImage imageNamed:@"settings_grey_button.png"] stretchableImageWithLeftCapWidth:3.0 topCapHeight:0.0]  forState:UIControlStateHighlighted];

        [buttondone addTarget:self action:@selector(toggleView)
             forControlEvents:UIControlEventTouchUpInside];

        [buttondone.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
        [buttondone setTitle:NSLocalizedString(@"Done", @"button done") forState:UIControlStateNormal];
        
	UIBarButtonItem *buttonItem = [[[UIBarButtonItem alloc] initWithCustomView:buttondone] autorelease];

	
	UINavigationItem *navigationItem = [[[UINavigationItem alloc] initWithTitle:@"NFSJoystick"] autorelease];
	navigationItem.rightBarButtonItem = buttonItem;

	[flipsideNavigationBar pushNavigationItem:navigationItem animated:NO];


}

-(void)buyFullVersion
{

}
//- (IBAction)moreAppView{	
//	
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//	BOOL showornot = [[defaults objectForKey:@"rateormore"] boolValue] ;
//	if (showornot) {
//		//	
//		BOOL proornot = [[defaults objectForKey:@"proormore"] boolValue] ;
//		if (proornot) {
//
//			NSURL *url = [NSURL URLWithString:@"http://www.phonegamesoftware.cn/tutorial.html"];
//			[[UIApplication sharedApplication] openURL:url];
//		}else {
//			
//            NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.com/apps/microkernel"];
//            
//            [[UIApplication sharedApplication] openURL:url];
//		}
//
//		
//	}else {
//		[[[UIAlertView alloc] initWithTitle:@"Like This App?" message:@"If so, please rate this game with 5 stars on the App Store so we can keep the free updates coming." delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"Rate It!", nil] show];
//		[defaults setBool:YES forKey:@"askedForRating"];
//	}
//	
//
//	
//
//
//}
- (void) setupApplicationAudio {
	// Get the main bundle for the app
	CFBundleRef mainBundle;
	mainBundle = CFBundleGetMainBundle ();
	
	// Get the URL to the sound file to play
	soundFileURLRef  =	CFBundleCopyResourceURL (
												 mainBundle,
												 CFSTR ("button_click"),
												 CFSTR ("caf"),
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
												 CFSTR ("settings_flip"),
												 CFSTR ("caf"),
												 NULL
												 );
	
	// Create a system sound object representing the sound file
	AudioServicesCreateSystemSoundID (
									  soundFileURLRef2,
									  &soundFileObject2
									  );
}
-(void)playToggleSound
{

    if (![[[NSUserDefaults standardUserDefaults] objectForKey:kIPsoundKey] boolValue] ) {
        AudioServicesPlaySystemSound (self.soundFileObject);
        AudioServicesPlaySystemSound (self.soundFileObject2);
    }
    
}

- (IBAction)toggleView{	
    [self playToggleSound];
	/*
	 This method is called when the info or Done button is pressed.
	 It flips the displayed view from the main view to the flipside view and vice-versa.
	 */

    if (settingViewController == nil) {
		[self loadSettingViewController];
	}
 
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:YES];
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController pushViewController:settingViewController animated:NO];
    [UIView commitAnimations];
}
-(void)toggleToMain
{
    [self playToggleSound];
    if (mainViewController == nil) {
		[self loadMainViewController];
	}
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:YES];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController pushViewController:mainViewController animated:NO];
    [UIView commitAnimations];
}

/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}*/

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {

	[flipsideNavigationBar release];
	[mainViewController release];
	[settingViewController release];
    [boardViewController release];
    
    //sound
	AudioServicesDisposeSystemSoundID (soundFileObject);
	CFRelease (soundFileURLRef);
	//sound
	AudioServicesDisposeSystemSoundID (soundFileObject2);
	CFRelease (soundFileURLRef2);
	[super dealloc];
}


@end
