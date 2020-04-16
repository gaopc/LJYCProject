//
//  SinaWeiBoExtend.h
//  CarDemoProject
//
//  Created by 张 晓婷 on 13-8-2.
//  Copyright (c) 2013年 张 晓婷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "SinaWeibo.h"
//#import "ErrorView.h"


#define SinaWeiboAuthData @"SinaWeiboAuthData"

#define kAppKey         @"2114242333"
#define kAppSecret      @"d094072ad1db23b4cd5d8736269da17c"
#define kRedirectURI    @"http://www.itkt.com/jsp/phone.jsp"

@interface SinaWeiboDelegateClass : NSObject<SinaWeiboDelegate,SinaWeiboRequestDelegate>
@property (readonly, nonatomic) SinaWeibo *_sinaweibo;
+(SinaWeiboDelegateClass *)sharedSinaWeiboDelegateClass;

@end

@interface SinaWeiBoExtend : NSObject
+(NSString *) sina_userID;
+(BOOL) sina_isAuthValid;
+(void) sina_logIn:(id) delegate Sel : (SEL) selector;
+(void) sina_logOut:(id) delegate Sel : (SEL) selector;
+(void) sina_usersShow: (id) delegate Sel : (SEL) selector;

+(void) sina_2_friendships_create;
+(void) sina_2_statuses_user_timeline :(NSString *)page delegate: (id) delegate Sel : (SEL) selector;
+(void) sina_2_comments_show:(NSString *) weiboID delegate: (id) delegate Sel : (SEL) selector;
+(void) sina_2_comments_create:(NSString *) weiboID contentText:(NSString *)text delegate: (id) delegate Sel : (SEL) selector;
+(void) sina_2_comments_destroy:(NSString *) cID  delegate: (id) delegate Sel : (SEL) selector;
+(void) sina_2_emotions: (id) delegate Sel : (SEL) selector;

@end
