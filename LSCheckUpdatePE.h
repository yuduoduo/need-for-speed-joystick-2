//
//  LSLoginInPE.h
//  Locoso
//
//  Created by yongchang hu on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSBaseProtocolEngine.h"
#import "LSData.h"
@class LSLoginRspData;
@interface LSCheckUpdatePE : LSBaseProtocolEngine{
    NSString* _password;
    NSString* _loginName;
    
    LSLoginRspData* _rspData;
}
@property (nonatomic, retain) NSString* password;
@property (nonatomic, retain) NSString* loginName;
@property (nonatomic, retain) LSLoginRspData* rspData;
@end
@interface LSLoginRspData : LSBaseResponseData
{
    LSDataSession* _session;
}
@property (nonatomic, retain) LSDataSession* session;
@end