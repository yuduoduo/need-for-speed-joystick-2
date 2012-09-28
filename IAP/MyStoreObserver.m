//
//  MyStoreObserver.m
//  SignatureN
//
//  Created by fanshao on 09-9-1.
//  Copyright 2009 Sensky. All rights reserved.
//

#import "MyStoreObserver.h"
#import<UIKit/UIKit.h>
#import<UIKit/UIAlert.h>
#import "JSON.h"
#import "NFSJoystickAppDelegate.h"

@implementation MyStoreObserver


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
	//NSLog(@"paymetnQueue");
	for (SKPaymentTransaction* transaction in transactions)
	{
		switch (transaction.transactionState)
		{
			case SKPaymentTransactionStatePurchased:
				//NSLog(@"Complete Transaction");
				[self completeTransaction:transaction];
				break;
			case SKPaymentTransactionStateFailed:
				[self failedTransaction:transaction];
				break;
			case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
				break;
			default:
				break;
		}
	}
}

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction{
	NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
	[self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
	[transactions release];
}

#define kMyFeatureIdentifier @"com.microkernel.joystick2.FullVersion"
- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    //save date to local

    //hiden ads
    
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    [app iapBuyAndHidenAds];
}
- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
	/*NSString *transactionReceipt = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
	[[NSNotificationCenter defaultCenter]  postNotificationName:@"completeTransaction" object:transactionReceipt];
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];*/
	//NSString *transactionReceipt = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
	//NSLog(@"Transaction　complete");
	//[[NSNotificationCenter defaultCenter]  postNotificationName:@"completeTransaction" object:transaction];
	NSDictionary *tempDict = [NSDictionary dictionaryWithObject:[transaction transactionReceipt] forKey:@"receipt-data"];
	NSString *josnValue = [tempDict JSONRepresentation];
	//NSLog(@"%@", josnValue);
	//NSURL *sandboxStoreURL = [[NSURL alloc] initWithString: @"https://sandbox.itunes.apple.com/verifyReceipt"];
    NSURL *sandboxStoreURL = [[[NSURL alloc] initWithString: @"https://buy.itunes.apple.com/verifyReceipt"] autorelease];
	NSData *postData = [NSData dataWithBytes:[josnValue UTF8String] length:[josnValue length]];
	NSMutableURLRequest *connectionRequest = [NSMutableURLRequest requestWithURL:sandboxStoreURL];
	[connectionRequest setHTTPMethod:@"POST"];
	[connectionRequest setTimeoutInterval:120.0];
	[connectionRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
	[connectionRequest setHTTPBody:postData];
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
	
	
	NSURLConnection *connection = [[NSURLConnection alloc]
																 initWithRequest:connectionRequest
																 delegate:self];
	[connection release];
    
    //save date to local

    //hiden ads
    
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    [app iapBuyAndHidenAds];
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
		NSLog(@"failed %@",transaction.error);
    }    
	[[NSNotificationCenter defaultCenter] postNotificationName:@"faliedTransaction" object:nil];
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    [app iapBuyFailed];
}

-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction{
    //hiden ads
    
    NFSJoystickAppDelegate *app = (NFSJoystickAppDelegate *) [[UIApplication sharedApplication] delegate];
    [app iapBuyAndHidenAds];
    [app stopWaiting];
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{

}


#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	//NSLog(@"%@",  [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
	//[self.receivedData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	switch([(NSHTTPURLResponse *)response statusCode]) {
		case 200:
		case 206:
			break;
		case 304:
	
			break;
		case 400:

			break;
			
			
		case 404:
		break;
		case 416:
			break;
		case 403:
			break;
		case 401:
		case 500:
			break;
		default:
			break;
	}	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	

}

@end
