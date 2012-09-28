//
//  SupportViewController.m
//  NFSJoystick
//
//  Created by  on 11-10-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SupportViewController.h"
#import "NFSJoystickAppDelegate.h"

@implementation SupportViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    [self AddLables];
}

-(void)AddLables
{
    
    
    [self AddStringToLable:NSLocalizedString(@"View Help", 
                                             @"View Help") 
                         x:40
                         y:5 
                     width:240
                    height:40
                     color:[UIColor whiteColor]];
    [self AddStringToLable:NSLocalizedString(@"Demo video", 
                                             @"Demo video") 
                         x:40
                         y:46 
                     width:240
                    height:40
                     color:[UIColor whiteColor]];
    [self AddStringToLable:NSLocalizedString(@"Other apps by us", 
                                             @"Other apps by us") 
                         x:40
                         y:87 
                     width:240
                    height:40
                     color:[UIColor whiteColor]];
    [self AddStringToLable:NSLocalizedString(@"Local Language", 
                                             @"Local Language") 
                         x:40
                         y:133 
                     width:240
                    height:40
                     color:[UIColor colorWithRed:117.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0]];
    [self AddStringToLable:NSLocalizedString(@"Volunteer Translator", 
                                             @"Volunteer Translator") 
                         x:40
                         y:172 
                     width:240
                    height:40
                     color:[UIColor whiteColor]];
    [self AddStringToLable:NSLocalizedString(@"Review", 
                                             @"Review") 
                         x:40
                         y:214 
                     width:240
                    height:40
                     color:[UIColor colorWithRed:117.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0]];
    [self AddStringToLable:NSLocalizedString(@"Rate/Review it", 
                                             @"Rate/Review it") 
                         x:40
                         y:259 
                     width:240
                    height:40
                     color:[UIColor whiteColor]];
    [self AddStringToLable:NSLocalizedString(@"Tell Friends", 
                                             @"Tell Friends") 
                         x:40
                         y:297 
                     width:240
                    height:40
                     color:[UIColor whiteColor]];
    [self AddStringToLable:NSLocalizedString(@"Full Version", 
                                             @"Full Version") 
                         x:40
                         y:373 
                     width:240
                    height:40
                     color:[UIColor colorWithRed:87.0f/255.0f green:87.0f/255.0f blue:87.0f/255.0f alpha:1.0]];
    [self AddStringToLable:NSLocalizedString(@"Full Version Features 1", 
                                             @"Full Version Features 1") 
                         x:40
                         y:403 
                     width:240
                    height:40
                     color:[UIColor colorWithRed:87.0f/255.0f green:87.0f/255.0f blue:87.0f/255.0f alpha:1.0]];
    [self AddStringToLable:NSLocalizedString(@"Full Version Features 2", 
                                             @"Full Version Features 2") 
                         x:40
                         y:423 
                     width:240
                    height:40
                     color:[UIColor colorWithRed:87.0f/255.0f green:87.0f/255.0f blue:87.0f/255.0f alpha:1.0]];
    [self AddStringToLable:NSLocalizedString(@"Full Version Features 3", 
                                             @"Full Version Features 3") 
                         x:40
                         y:443 
                     width:240
                    height:40
                     color:[UIColor colorWithRed:87.0f/255.0f green:87.0f/255.0f blue:87.0f/255.0f alpha:1.0]];
}
-(void)AddStringToLable:(NSString*)text x:(int)x y:(int)y width:(int)width height:(int)height color:(UIColor*)color
{
    UILabel *myLable;
    myLable=[[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [myLable setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    [myLable setTextColor:color];
    [myLable setNumberOfLines:0];
    [myLable setBackgroundColor:[UIColor clearColor]];
    
    
    //    UIFont *font = [UIFont fontWithName:@"Helvetica" size:15.0];
    //    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(175.0f, 2000.0f) lineBreakMode:UILineBreakModeWordWrap];
    //    CGRect rect=myLable.frame;
    //    rect.size=size;
    //    [myLable setFrame:rect];
    [myLable setText:text];
    [self.view addSubview:myLable];
    [myLable release];
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
#pragma mark -------------
-(void)moreApps
{
    NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.com/apps/microkernel"];
    [[UIApplication sharedApplication] openURL:url];
}
-(void)rateThisApp
{
    NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=537150318&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark -
#pragma mark button click
- (IBAction)ViewHelpClick:(id)sender
{
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    [app TranslateToHelp];
}
- (IBAction)DemoVideoClick:(id)sender
{
//    NSURL *url = [NSURL URLWithString:@"http://www.youtube.com/watch?v=qSTUpoF5k5A"];
//    [[UIApplication sharedApplication] openURL:url];
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    [app TranslateToDemoView];
}
- (IBAction)OtherAppClick:(id)sender
{
    [self moreApps];
    
}
- (IBAction)VolunteerClick:(id)sender
{
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    [app EmailToUS];

}
- (IBAction)ReviewClick:(id)sender
{
    [self rateThisApp];
}
- (IBAction)TellClick:(id)sender
{
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    [app EmailToFriend];

}

@end
