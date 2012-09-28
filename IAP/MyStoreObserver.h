//
//  MyStoreObserver.h
//  SignatureN
//
//  Created by fanshao on 09-9-1.
//  Copyright 2009 Sensky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h> 
#import <StoreKit/SKPaymentTransaction.h> 

@interface MyStoreObserver : NSObject
< SKPaymentTransactionObserver > {

}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction;
- (void) completeTransaction: (SKPaymentTransaction *)transaction;
- (void) failedTransaction: (SKPaymentTransaction *)transaction;
-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction;
-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error;
-(void)restoreTransaction:(SKPaymentTransaction *)transaction;


@end
