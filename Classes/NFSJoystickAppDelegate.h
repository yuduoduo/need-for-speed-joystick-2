//
//  NFSJoystickAppDelegate.h
//  NFSJoystick
//
//  Created by Jeff LaMarche on 7/24/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "MyStoreObserver.h"
#import<StoreKit/StoreKit.h>
#import "FlurryAnalytics.h"
#import "RootViewController.h"
#define FOR_VERSION_2 @"FirstInstallDictionaryForV2"
#import "InAppPurchaseObject.h"


@interface NFSJoystickAppDelegate : InAppPurchaseObject <UINavigationControllerDelegate, UIApplicationDelegate,MFMailComposeViewControllerDelegate,SKProductsRequestDelegate> {

    
	//flash animation
	UIImageView *view1;
	UIImageView *view2;
	
    MyStoreObserver *observer;

    FlurryAnalytics* FlurryAnalytics;

}

@property (nonatomic, retain)  UIWindow *window;

@property (nonatomic, retain) MyStoreObserver *observer;
@property (nonatomic, retain) IBOutlet FlurryAnalytics* FlurryAnalytics;

void uncaughtExceptionHandler(NSException *exception);

-(void)addActiveView;
-(void)setMenuIAPState:(int)inivalue;
-(void)displayComposerSheet :(NSString*)head body:(NSString*)body recipient:(NSString*)recipient;
-(void)launchMailAppOnDevice:(NSString*)head body:(NSString*)body recipient:(NSString*)recipient;
-(NSString*)getDeviceID;
-(void)setDeviceID;
-(void)TranslateToHelp;
-(void)TranslateToDemoView;
-(void)EmailToUS;
-(void)EmailToFriend;
-(BOOL)whetherIsBuyed;
-(NSString*)getStoreID;
- (void) requestProductData;
-(int)MenuIAPState;
-(int)firstRunState;
-(void)setFirstRunState:(int)inivalue;
-(void)iapBuyAndHidenAds;
-(void)iapBuyFailed;

-(void)startWaiting;
-(void)stopWaiting;
@end

