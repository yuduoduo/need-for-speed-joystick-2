//
//  SendMsgProcotolEngine.m
//  NFSJoystick
//
//  Created by yongchang hu on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SendMsgProcotolEngine.h"
#import "DefineComm.h"

@implementation SendMsgProcotolEngine
static SendMsgProcotolEngine* sendMsgEngine = nil;
@synthesize mySocket = _mySocket;
@synthesize delegate = _delegate;
@synthesize browser = _browser;
@synthesize services = _services;
@synthesize asyncUdpSocket = _asyncUdpSocket;
+(SendMsgProcotolEngine*)sharedInstance
{
    if (!sendMsgEngine) 
    {
		@synchronized(self) 
        {
			if (!sendMsgEngine) 
            {
                sendMsgEngine = [[self alloc] init];
			}
		}
	}
	return sendMsgEngine;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        
        self.browser = [[NSNetServiceBrowser new] autorelease];
        self.browser.delegate = self;
        self.services = [NSMutableArray new];
        isSearching = NO;
        
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    self.browser = nil;
    
    self.mySocket = nil;
    [self.mySocket release];
    self.asyncUdpSocket = nil;
    [self.services release];
    self.services = nil;
}

-(void)searchStart
{
//if is searching,
    if (isSearching) {
        return;
    }
    //boardcast
    //get version
    NSString *boundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];

    
    NSString *sendStr = [@"searchServer" stringByAppendingString:boundleVersion];
    isSearching = YES;
    [self SendBoradcast:sendStr];
}
-(BOOL)whetherConnected
{
    return [self.mySocket isConnected];
}
-(BOOL)ConnectToSocket:(NSString*)ip port:(NSInteger)port
{
    self.mySocket = [[[AsyncSocket alloc] initWithDelegate:self] autorelease];
    
    NSError *err = nil;
    [self.mySocket connectToHost:ip onPort:port withTimeout:SOCKET_CONNECT_TIME_OUT error:&err];

    NSLog(@"Error: %@", err);
    return TRUE;


}
-(void) sendMessageToServerWithAnimate:(NSString*)sendToMSG showAnimate:(NSString*)str
{
    [self.delegate showAnimateStr:str];
    if (![self whetherConnected]) {//没连接，从新搜索
        
        [self.delegate researchServerStarted];
        return;
    }
    NSData *writeData = [sendToMSG dataUsingEncoding:NSUTF8StringEncoding]; 
	
	[self.mySocket writeData:writeData withTimeout:SOCKET_CONNECT_TIME_OUT tag:0];
    
    //for continue write
	[self.mySocket readDataWithTimeout:SOCKET_CONNECT_TIME_OUT tag:0];
}
-(void) sendMessageToServer:(NSString*)sendToMSG
{
    if (![self whetherConnected]) {//没连接，从新搜索
        
        [self.delegate researchServerStarted];
        return;
    }
    NSData *writeData = [sendToMSG dataUsingEncoding:NSUTF8StringEncoding]; 
	
	[self.mySocket writeData:writeData withTimeout:SOCKET_CONNECT_TIME_OUT tag:0];
    
    //for continue write
	[self.mySocket readDataWithTimeout:SOCKET_CONNECT_TIME_OUT tag:0];
}
#pragma mark ----------------------
#pragma mark Net Service Browser Delegate Methods
-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didFindService:(NSNetService *)aService moreComing:(BOOL)more {
    [self.services addObject:aService];
	NSLog(@"Did find service:%@",[aService name]);
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didRemoveService:(NSNetService *)aService moreComing:(BOOL)more {
    [self.services removeObject:aService];
}

-(void)netServiceDidResolveAddress:(NSNetService *)service {
//    NSError *error;
//    [mySocket connectToAddress:service.addresses.lastObject error:&error]; 
    [self ConnectToSocket:service.domain port:service.port];
    
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didNotSearch:(NSDictionary *)errorInfo
{
    [self.delegate searchServerFailed];
}
#pragma mark ----------------------
#pragma mark socket connect read
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    
   [sock readDataWithTimeout:SOCKET_CONNECT_TIME_OUT tag:0];
    [self.delegate didConnectToHost:host port:port];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData*)data withTag:(long)tag {

	
    [self.delegate didSocketReceiveData];
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock {
	NSLog(@"onSocketDidDisconnect: sock: %@",sock);
    [self.delegate socketDidDisconnect];
    
}

-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err {
	NSLog(@"onSocket:willDisconnectWithError: %@",err);
    [self.delegate disconnectSocketWithError];
}

#pragma mark ------------------------
#pragma mark UDP
//建立基于UDP的Socket连接 
-(void)openUDPServer{ 
    //初始化udp 
    self.asyncUdpSocket = [[[AsyncUdpSocket alloc] initWithDelegate:self] autorelease]; 
    
    //绑定端口 
    NSError *error = nil; 
    [self.asyncUdpSocket enableBroadcast:YES error:&error];
    [self.asyncUdpSocket bindToPort:9527 error:&error]; 
    //启动接收线程 
//    [self.asyncUdpSocket receiveWithTimeout:SOCKET_CONNECT_TIME_OUT tag:0]; 
} 
//发送信息 
-(void)SendBoradcast:(NSString*)str
{ 
    [self openUDPServer];
    
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding]; 
    { 
        
        [self.asyncUdpSocket sendData:data  
                          toHost:@"255.255.255.255"  
                            port:8888  
                     withTimeout:SOCKET_CONNECT_TIME_OUT  
                             tag:0]; 
        [self.asyncUdpSocket receiveWithTimeout:10 tag:0]; 
        
    } 
} 
#pragma mark -------------
#pragma mark UDP delegate
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    NSString* aStr;
    aStr = [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
    int version = [aStr intValue];
    NSString *boundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    int boundle = [boundleVersion intValue];
    if (version > boundle) {
        //alarm version is low
        //whether update
        
    }
    //find the server
    NSLog(@"host = %@",host);
//    if (![self checkHostLegal:host]) {//非法字符ƒ√
//        return YES;
//        
//    }
    [self ConnectToSocket:host port:port];
    isSearching = NO;
    return YES;
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{
    isSearching = NO;
    [self.delegate searchServerFailed];
}
-(BOOL)checkHostLegal:(NSString*)host
{
    char perchar;
    NSInteger asc;
    for (int i = 0; i<[host length]; i++) {
        perchar = [host characterAtIndex:i];
        asc = perchar;
        if(asc>96 && asc < 123 )
        {
            NSLog(@"%c是小写字母",perchar);
            return NO;
        }
        
        else if(asc>64 && asc < 91 )
        {
            NSLog(@"%c是大写字母",perchar);
            return NO;
        }
        
    }
    return YES;
}
@end
