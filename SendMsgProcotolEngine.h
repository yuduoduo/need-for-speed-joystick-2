//
//  SendMsgProcotolEngine.h
//  NFSJoystick
//
//  Created by yongchang hu on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
#import "AsyncUdpSocket.h"
@protocol SendMSGEngineDelegate
@optional
- (void)didConnectToHost:(NSString *)host port:(UInt16)port;
- (void)didSocketReceiveData;
-(void)socketDidDisconnect;
-(void)disconnectSocketWithError;
-(void)searchServerFailed;
-(void)researchServerStarted;
-(void)showAnimateStr:(NSString*)str;
@end

@interface SendMsgProcotolEngine : NSObject<NSNetServiceBrowserDelegate>{

    BOOL isSearching;
}
@property(retain, nonatomic) AsyncSocket *mySocket;
@property(retain, nonatomic) AsyncUdpSocket *asyncUdpSocket;
@property (nonatomic, assign) id<SendMSGEngineDelegate> delegate;
@property (readwrite, retain) NSNetServiceBrowser *browser;
@property (readwrite, retain) NSMutableArray *services;

+(SendMsgProcotolEngine*)sharedInstance;
-(BOOL)ConnectToSocket:(NSString*)ip port:(NSInteger)port;
-(BOOL)whetherConnected;
-(void) sendMessageToServer:(NSString*)sendToMSG;
-(void)searchStart;
-(void) sendMessageToServerWithAnimate:(NSString*)sendToMSG showAnimate:(NSString*)str;
@end
