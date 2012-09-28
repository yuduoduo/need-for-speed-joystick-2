//
//  FlipsideViewController.h
//  NFSJoystick
//
//  Created by Jeff LaMarche on 7/24/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;
@interface FlipsideViewController : UIViewController {
	
    IBOutlet UIImageView* internetConnectionIcon;
    IBOutlet UITextField* internetConnectionStatusField;
    
    IBOutlet UIImageView* localWiFiConnectionIcon;
    IBOutlet UITextField* localWiFiConnectionStatusField;
    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
	
	IBOutlet UITextField *inputSocket;
	IBOutlet UITextField *inputPort;
	IBOutlet UISwitch *acceleSwitch;
	IBOutlet UISwitch *soundSwitch;
    
	//add dot
	UIButton *dot;
	BOOL numberPadShowing;
	

}

@property(retain, nonatomic) UITextField *inputSocket;
@property(retain, nonatomic) UITextField *inputPort;
@property(retain, nonatomic) IBOutlet UISwitch *acceleSwitch;
@property(retain, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (nonatomic, assign) BOOL numberPadShowing;
@property (nonatomic, retain) UIButton *dot;
- (IBAction)soundSwitchClick:(id)sender;
- (IBAction)backgroundClick:(id)sender;

-(void)AddLables;
- (void) updateInterfaceWithReachability: (Reachability*) curReach;
-(void)AddStringToLable:(NSString*)text x:(int)x y:(int)y width:(int)width height:(int)height color:(UIColor*)color;
@end

