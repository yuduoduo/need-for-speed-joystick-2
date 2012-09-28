//
//  AppListViewController.m
//  NFSJoystick
//
//  Created by  on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppListViewController.h"

@implementation AppListViewController

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
- (IBAction)button1Click:(id)sender
{
//    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/app/game-handle/id372963125?l=en&mt=8"];
//    [[UIApplication sharedApplication] openURL:url];
    [self goToSamePage];
}
- (IBAction)button2Click:(id)sender
{
//    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/app/ai-robot/id385067042?l=en&mt=8"];
//    [[UIApplication sharedApplication] openURL:url];
    [self goToSamePage];
}
- (IBAction)button3Click:(id)sender
{
//    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/app/cartoon-bowling/id405436478?l=en&mt=8"];
//    [[UIApplication sharedApplication] openURL:url];
    [self goToSamePage];
}
- (IBAction)button4Click:(id)sender
{
//    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/app/makeall/id478312882?l=en&mt=8"];
//    [[UIApplication sharedApplication] openURL:url];
    [self goToSamePage];
}
- (IBAction)button5Click:(id)sender
{
//    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/app/pendulum-ninja/id422245178?l=en&mt=8"];
//    [[UIApplication sharedApplication] openURL:url];
    [self goToSamePage];
}
- (IBAction)button6Click:(id)sender
{
//    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/app/adventure-boy-adventure-young/id449154473?l=en&mt=8"];
//    [[UIApplication sharedApplication] openURL:url];
    [self goToSamePage];
}

-(void)goToSamePage
{

    NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.com/apps/microkernel"];
//      NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/microkernel/id369536539?mt=8"];
    
    [[UIApplication sharedApplication] openURL:url];
}
@end
