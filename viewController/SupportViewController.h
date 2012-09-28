//
//  SupportViewController.h
//  NFSJoystick
//
//  Created by  on 11-10-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupportViewController : UIViewController

- (IBAction)OtherAppClick:(id)sender;
- (IBAction)VolunteerClick:(id)sender;
- (IBAction)ReviewClick:(id)sender;
- (IBAction)TellClick:(id)sender;
- (IBAction)ViewHelpClick:(id)sender;
- (IBAction)DemoVideoClick:(id)sender;

-(void)AddLables;
-(void)AddStringToLable:(NSString*)text x:(int)x y:(int)y width:(int)width height:(int)height color:(UIColor*)color;

@end
