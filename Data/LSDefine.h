//
//  LSDefine.h
//  Test1
//
//  Created by zhiwei ma on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



//
//-------notification------------------------
//
#define LSNOTIFICATION_SENDMESSAGE_SUCCESS      @"LSNotificationSendMessageSuccess"
#define LSNOTIFICATION_MESSAGE_DELETE_SUCCESS   @"LSNotificationMessageDeleteSuccess"
#define LSNOTIFICATION_MESSAGE_REPLY_SUCCESS    @"LSNotificationMessageReplySuccess"
#define LSNOTIFICATION_MYCOMPANY_CLEAR_DATA     @"LSNotificationMyCompanyClearData"
#define LSNOTIFICATION_PRODUCT_DELETE_SUCCESS   @"LSNotificationProductDeleteSuccess"
#define LSNOTIFICATION_LOGIN_EXPIRED            @"LSNotificationLoginExpired"

#define LSNOTIFICATION_USERINFO_KEY_District    @"district"
#define LSNOTIFICATION_USERINFO_KEY_Industry    @"industry"

#define LSNOTIFICATION_USERINFO_KEY_CITYID      @"cityid"
#define LSNOTIFICATION_USERINFO_KEY_CITYNAME      @"cityname"
#define LSNOTIFICATION_USERINFO_KEY_CATEGORYID  @"categoryid"
#define LSNOTIFICATION_USERINFO_KEY_CATEGORYNAME  @"categoryname"
#define LSNOTIFICATION_USERINFO_KEY_COMPANYID       @"companyid"

//
//-----------------service error code----------------------
//
#define LSErrorCodeLoginExpired  -120002    //登录失效  

//
//------------------ font ------------------
//
#define LSFontMoreBig       [UIFont systemFontOfSize:18.0f]
#define LSFontBig           [UIFont systemFontOfSize:16.0f]
#define LSFontNormal        [UIFont systemFontOfSize:14.0f]
#define LSFontSmall         [UIFont systemFontOfSize:12.0f]

//
//------------------ color ----------------
//
#define LSRGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
	
#define LSCOLOR_CLEAR   [UIColor clearColor]
#define LSCOLOR_BLACK   [UIColor blackColor]
#define LSCOLOR_333333  LSRGBA(51,51,51,1)
#define LSCOLOR_6A6A6A  LSRGBA(0x6a,0x6a,0x6a,1)
#define LSCOLOR_999999  LSRGBA(153,153,153,1)
#define LSCOLOR_CORNER  LSRGBA(218,218,218,1)
#define LSCOLOR_FEFDED  LSRGBA(0xfe,0xfd,0xed,1)
#define LSCOLOR_EB7A00  LSRGBA(0xeb,0x7a,0x00,1)
#define LSCOLOS_SearchBar   LSRGBA(251,201,29,1)
#define LSCOLOR_Border  LSCOLOR_6A6A6A
#define LSCOLOR_GRAY_BOARD LSRGBA(224,224,224,1)              

//
//------------------views---------------------------
//
#define LSSendMessageTextViewContentMaxLength 500


