//
//  InAppPurchaseObject.m
//  AvatarBoy
//
//  Created by huyongchang on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InAppPurchaseObject.h"
#import "UIDevice+IdentifierAddition.h"
#define kMyFeatureIdentifier @"com.microkernel.joystick2.FullVersion"


@implementation InAppPurchaseObject

-(void)iapBuyAndHidenAds
{
    
    
    [self setDeviceID];//保存信息
    [self setMenuIAPState:11];
}

-(void)setDeviceID
{
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString *deviceID = [myDevice uniqueGlobalDeviceIdentifier]; 
    const char *c = [deviceID UTF8String]; 
    memcpy(&(iapstoredata.UDID), c, sizeof(iapstoredata.UDID));
    iapstoredata.m = 1;
    iapstoredata.n = 1;
    iapstoredata.x = 1;
    iapstoredata.y = 1;
    
    NSData *filedata = [NSData dataWithBytes:& iapstoredata length:sizeof(iapstoredata)];
    [[NSUserDefaults standardUserDefaults] setValue:filedata forKey:kMyFeatureIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)iapBuyFailed
{
    
    
    [self setMenuIAPState:0];
    
}

-(void)setMenuIAPState:(int)inivalue
{
    [[NSUserDefaults standardUserDefaults] setInteger:inivalue forKey:@"menuiapstate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark ----------------
#pragma mark restore
- (void) requestRestoreProductData
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
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

-(int)MenuIAPState
{
    
    return  [[[NSUserDefaults standardUserDefaults] objectForKey:@"menuiapstate"] intValue] ;
}

#pragma mark ---------
#pragma mark temp unlock

-(void)setTempUnlockState:(int)inivalue
{
    [[NSUserDefaults standardUserDefaults] setInteger:inivalue forKey:@"tempunlockstate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(int)TempUnlockState
{
    
    return  [[[NSUserDefaults standardUserDefaults] objectForKey:@"tempunlockstate"] intValue] ;
}

-(void)clearTempUnlockState
{
    if (11 == [self MenuIAPState]) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if (! [defaults objectForKey:@"tempunlockstatefirstRun"]) {
		[defaults setObject:[NSDate date] forKey:@"tempunlockstatefirstRun"];
	}
	
	NSInteger daysSinceInstall = [[NSDate date] timeIntervalSinceDate:[defaults objectForKey:@"tempunlockstatefirstRun"]] / 86400;
	
    if(daysSinceInstall > 1)
    {
        [self setTempUnlockState:0];
        [defaults setObject:[NSDate date] forKey:@"tempunlockstatefirstRun"];
    }
}
@end
