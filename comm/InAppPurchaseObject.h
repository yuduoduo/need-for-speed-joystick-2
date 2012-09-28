//
//  InAppPurchaseObject.h
//  AvatarBoy
//
//  Created by huyongchang on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyStoreObserver.h"

struct  IAPStoreData {
    short x;
    short y;
    char UDID[100];
    short m;
    short n;
};
typedef struct  IAPStoreData IAPStoreData;

@interface InAppPurchaseObject : NSObject<SKProductsRequestDelegate>
{
    //store iap
    IAPStoreData iapstoredata;
}
-(void)iapBuyAndHidenAds;
-(void)iapBuyFailed;
- (void) requestProductData;
-(int)MenuIAPState;
- (void)stopWaiting;
- (void)startWaiting;
-(void)setTempUnlockState:(int)inivalue;
-(int)TempUnlockState;
-(void)clearTempUnlockState;
- (void) requestRestoreProductData;
@end
