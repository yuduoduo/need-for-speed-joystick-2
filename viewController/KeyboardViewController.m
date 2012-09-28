//
//  KeyboardViewController.m
//  NFSJoystick
//
//  Created by  on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KeyboardViewController.h"
#import "MsgComm.h"
#import "DefineComm.h"
@implementation KeyboardViewController

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
-(IBAction)goBackToMain:(id)sender
{
    DISAPPEAR_VIEW
    
}
//down
-(IBAction)goLeftClickDown:(id)sender
{
    //left
    [self startAnimateFont:@"Left" frame:CGRectMake(200, 100, 200, 40) transfrom:1];
    [SEND_MSG_PE sendMessageToServer:KEY_LEFT_CLICK_DOWN_STR];
}
-(IBAction)goRightClickDown:(id)sender
{
    [self startAnimateFont:@"Right" frame:CGRectMake(200, 100, 200, 40) transfrom:1];
    [SEND_MSG_PE sendMessageToServer:KEY_RIGHT_CLICK_DOWN_STR];
}
-(IBAction)GoUpClickDown:(id)sender
{
    [self startAnimateFont:@"Up" frame:CGRectMake(200, 100, 200, 40) transfrom:1];
    [SEND_MSG_PE sendMessageToServer:KEY_UP_CLICK_DOWN_STR];
}
-(IBAction)goDownClickDown:(id)sender
{
    [self startAnimateFont:@"Down" frame:CGRectMake(200, 100, 200, 40) transfrom:1];
    [SEND_MSG_PE sendMessageToServer:KEY_DOWN_CLICK_DOWN_STR];
}
-(IBAction)goBackSpaceClickDown:(id)sender
{
    [self startAnimateFont:@"BackSpace" frame:CGRectMake(200, 100, 320, 40) transfrom:1];
     [SEND_MSG_PE sendMessageToServer:KEY_BACK_SPACE_CLICK_DOWN_STR];
}
-(IBAction)goWclickDown:(id)sender
{
    [self startAnimateFont:@"W" frame:CGRectMake(200, 100, 200, 40) transfrom:1];
     [SEND_MSG_PE sendMessageToServer:KEY_W_CLICK_DWON];
}
-(IBAction)goSClickDown:(id)sender
{
    [self startAnimateFont:@"S" frame:CGRectMake(200, 100, 200, 40) transfrom:1];
     [SEND_MSG_PE sendMessageToServer:KEY_S_CLICK_DWON];
}
-(IBAction)goEscClickDown:(id)sender
{
    [self startAnimateFont:@"ESC" frame:CGRectMake(200, 100, 200, 40) transfrom:1];
     [SEND_MSG_PE sendMessageToServer:KEY_ESC_CLICK_DWON];
}
-(IBAction)goEnterClickDown:(id)sender
{
    [self startAnimateFont:@"Enter" frame:CGRectMake(200, 100, 200, 40) transfrom:1];
     [SEND_MSG_PE sendMessageToServer:KEY_ENTER_CLICK_DWON];
}
-(IBAction)goShiftClickDown:(id)sender
{
    [self startAnimateFont:@"Shift" frame:CGRectMake(200, 100, 200, 40) transfrom:1];
     [SEND_MSG_PE sendMessageToServer:KEY_SHIFT_CLICK_DWON];
}


//up
-(IBAction)goLeftClickUp:(id)sender
{
    [SEND_MSG_PE sendMessageToServer:KEY_LEFT_CLICK_UP_STR];
}
-(IBAction)goRightClickUp:(id)sender
{
    [SEND_MSG_PE sendMessageToServer:KEY_RIGHT_CLICK_UP_STR];
}
-(IBAction)GoUpClickUp:(id)sender
{
    [SEND_MSG_PE sendMessageToServer:KEY_UP_CLICK_UP_STR];
}
-(IBAction)goDownClickUp:(id)sender
{
    [SEND_MSG_PE sendMessageToServer:KEY_DOWN_CLICK_UP_STR];
}
-(IBAction)goBackSpaceClickUp:(id)sender
{
    [SEND_MSG_PE sendMessageToServer:KEY_BACK_SPACE_CLICK_UP_STR];
}
-(IBAction)goWclickUp:(id)sender
{
    [SEND_MSG_PE sendMessageToServer:KEY_W_CLICK_UP];
}
-(IBAction)goSClickUp:(id)sender
{
    [SEND_MSG_PE sendMessageToServer:KEY_S_CLICK_UP];
}
-(IBAction)goEscClickUp:(id)sender
{
    [SEND_MSG_PE sendMessageToServer:KEY_ESC_CLICK_UP];
}
-(IBAction)goEnterClickUp:(id)sender
{
    [SEND_MSG_PE sendMessageToServer:KEY_ENTER_CLICK_UP];
}
-(IBAction)goShiftClickUp:(id)sender
{
    [SEND_MSG_PE sendMessageToServer:KEY_SHIFT_CLICK_UP];
}
@end
