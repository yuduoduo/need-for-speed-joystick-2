//
//  LSParseDataUtils.h
//  Locoso
//
//  Created by zhiwei ma on 12-3-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSData.h"
#import "SBJson.h"

#define LSJSONKEY_id                @"id"
#define LSJSONKEY_name              @"name"
#define LSJSONKEY_spell             @"spell"
#define LSJSONKEY_shortname         @"shortname"
#define LSJSONKEY_ico               @"ico"
#define LSJSONKEY_parentnames       @"parentnames"
#define LSJSONKEY_parentids         @"parentids"
#define LSJSONKEY_parentid          @"parentid"
#define LSJSONKEY_cityname          @"cityname"
#define LSJSONKEY_cityid            @"cityid"
#define LSJSONKEY_ishot             @"ishot"
#define LSJSONKEY_arrchildid        @"arrchildid"
#define LSJSONKEY_childnum          @"childnum"
#define LSJSONKEY_depth             @"depth"
#define LSJSONKEY_childid           @"childid"

#define LSJSONKEY_companyid         @"companyid"
#define LSJSONKEY_companyname       @"companyname"
#define LSJSONKEY_logo              @"logo"
#define LSJSONKEY_address           @"address"
#define LSJSONKEY_area              @"area"
#define LSJSONKEY_province          @"province"
#define LSJSONKEY_MapX           @"mapx"
#define LSJSONKEY_MapY           @"mapy"
#define LSJSONKEY_ProductId           @"producid"
#define LSJSONKEY_ProductName          @"productname"
#define LSJSONKEY_info                 @"info"
#define LSJSONKEY_product                 @"product"
#define LSJSONKEY_contactphone      @"telephone"
#define LSJSONKEY_PhotoCount          @"photocount" 
#define LSJSONKEY_mesgcount          @"mesgcount" 
#define LSJSONKEY_viewCount          @"viewCount" 
#define LSJSONKEY_procount          @"procount" 
#define LSJSONKEY_newscount          @"newscount" 
#define LSJSONKEY_state             @"state"
#define LSJSONKEY_articleid          @"articleid"
#define LSJSONKEY_title              @"title"

#define LSJSONKEY_messageid            @"messageid"
#define LSJSONKEY_senderuaid            @"senderuaid"
#define LSJSONKEY_senderuaname          @"senderuaname"
#define LSJSONKEY_summary               @"summary"
#define LSJSONKEY_content               @"content"
#define LSJSONKEY_image                 @"image"
#define LSJSONKEY_createtime            @"createtime"
#define LSJSONKEY_replycontent          @"replycontent"
#define LSJSONKEY_state                 @"state"

#define LSJSONKEY_mediaid               @"mediaid"
#define LSJSONKEY_filepath              @"filepath"
#define LSJSONKEY_medianame             @"medianame"

#define LSJSONKEY_listCompany           @"listCompany"
#define LSJSONKEY_listCity              @"listCity"
#define LSJSONKEY_listCate              @"listCate"

#define LSJSONKEY_telephone             @"telephone"
#define LSJSONKEY_contactphonem         @"contactphone"
#define LSJSONKEY_mobilephone           @"mobilephone"
#define LSJSONKEY_email                 @"email"
#define LSJSONKEY_website               @"website"
#define LSJSONKEY_contactpeople         @"contactpeople"
#define LSJSONKEY_city                  @"city"
#define LSJSONKEY_catename              @"catename"
#define LSJSONKEY_category              @"category"

#define LSJSONKEY_count                 @"count"
#define LSJSONKEY_score                 @"score"

#define LSJSONKEY_uaid                  @"uaid"
#define LSJSONKEY_session               @"session"

#define LSJSONKEY_value                 @"value"
#define LSJSONKEY_url                   @"url"

#define LSJSONKEY_company           @"company"

@interface LSParseDataUtils : NSObject

+ (LSDataSession*)parseSession:(NSDictionary*)aJSONData;
+ (LSDataAD*)parseAd:(NSDictionary*)aJSONData;
@end
