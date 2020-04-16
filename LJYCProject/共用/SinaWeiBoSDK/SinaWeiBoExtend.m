//
//  SinaWeiBoExtend.m
//  CarDemoProject
//
//  Created by 张 晓婷 on 13-8-2.
//  Copyright (c) 2013年 张 晓婷. All rights reserved.
//

#import "SinaWeiBoExtend.h"
#import "JSON.h"

@implementation SinaWeiboDelegateClass

@synthesize _sinaweibo;
- (void)dealloc
{
    [_sinaweibo release];
    _sinaweibo = nil;
    [super dealloc];
}

+(SinaWeiboDelegateClass *)sharedSinaWeiboDelegateClass
{
    static SinaWeiboDelegateClass * class = nil;
    if (class == nil) {
        class = [[SinaWeiboDelegateClass alloc] init];
        [class initSinaWeibo];
    }
    return class;
}

-(void) initSinaWeibo
{
    _sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kRedirectURI andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:SinaWeiboAuthData];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
}
- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SinaWeiboAuthData];
    _sinaweibo.accessToken = nil;
    _sinaweibo.expirationDate = nil;
    _sinaweibo.userID = nil;
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = self._sinaweibo;
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:SinaWeiboAuthData];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo//接受登录信息
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self storeAuthData];
    if (self._sinaweibo._needResultDataDelegate )  {
        if ([self._sinaweibo._needResultDataDelegate respondsToSelector:self._sinaweibo._needResultDataDelegateSel]) {
            [self._sinaweibo._needResultDataDelegate performSelector:self._sinaweibo._needResultDataDelegateSel withObject:sinaweibo];
        }
    }
    [WaitView hiddenWaitView];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
    if (self._sinaweibo._needResultDataDelegate )  {
        if ([self._sinaweibo._needResultDataDelegate respondsToSelector:self._sinaweibo._needResultDataDelegateSel]) {
            [self._sinaweibo._needResultDataDelegate performSelector:self._sinaweibo._needResultDataDelegateSel];
        }
    }
    [WaitView hiddenWaitView];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
    [WaitView hiddenWaitView];
    
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
    [WaitView hiddenWaitView];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
    [WaitView hiddenWaitView];
    
}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error : %@", error);
    if (error.code == 20506) {
        [UIAlertView alertViewWithMessage:@"您已成功关注该用户"];
    }
    else{
        //        [ErrorView errorViewShow:error.description];
        id result = [self readFromFile:request];
        if (self._sinaweibo._needResultDataDelegate )  {
            if ([self._sinaweibo._needResultDataDelegate respondsToSelector:self._sinaweibo._needResultDataDelegateSel]) {
                [self._sinaweibo._needResultDataDelegate performSelector:self._sinaweibo._needResultDataDelegateSel withObject:result];
            }
        }
    }
    [WaitView hiddenWaitView];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    [self writeToFile:request result:result];
    if (self._sinaweibo._needResultDataDelegate )  {
        if ([self._sinaweibo._needResultDataDelegate respondsToSelector:self._sinaweibo._needResultDataDelegateSel]) {
            [self._sinaweibo._needResultDataDelegate performSelector:self._sinaweibo._needResultDataDelegateSel withObject:result];
        }
    }
    [WaitView hiddenWaitView];
    
}
-(void)writeToFile:(SinaWeiboRequest *)request result:(id)result
{
    NSString * realPath= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, //NSDocumentDirectory or NSCachesDirectory
                                                              NSUserDomainMask, //NSUserDomainMask
                                                              YES)	// YES
                          objectAtIndex: 0];
    NSString *imageCachePath = nil;
    imageCachePath = [[NSString stringWithFormat:@"%@",request.url] stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    NSString * filePath=[realPath stringByAppendingPathComponent:@"urlCaches"];
    if(![[NSFileManager defaultManager] fileExistsAtPath: filePath])
    {
        if ([[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil]) {
            filePath=[filePath stringByAppendingPathComponent:imageCachePath];
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil ];
            }
            if([[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil])
            {
                NSData * data = [[NSString stringWithFormat:@"%@",result] dataUsingEncoding:NSUTF8StringEncoding];
                NSLog(@"%d",[data writeToFile:filePath atomically:YES]);
            }
        }
    }
    else
    {
        filePath=[filePath stringByAppendingPathComponent:imageCachePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil ];
        }
        if([[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil])
        {
            NSData * data = [[NSString stringWithFormat:@"%@",result] dataUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"%d",[data writeToFile:filePath atomically:YES]);
        }
    }
    
}
-(NSString *)readFromFile:(SinaWeiboRequest *)request
{
    NSString * realPath= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, //NSDocumentDirectory or NSCachesDirectory
                                                              NSUserDomainMask, //NSUserDomainMask
                                                              YES)	// YES
                          objectAtIndex: 0];
    NSString *imageCachePath = nil;
    imageCachePath = [[NSString stringWithFormat:@"%@",request.url] stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    NSString * filePath=[realPath stringByAppendingPathComponent:@"urlCaches"];
    filePath=[filePath stringByAppendingPathComponent:imageCachePath];
    if([[NSFileManager defaultManager] fileExistsAtPath: filePath]){
        id result = [NSDictionary dictionaryWithContentsOfFile:filePath];
        //        NSString * str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        //        id result = [str JSONValue];
        return result;
    }
    return nil;
}

@end

@implementation SinaWeiBoExtend
+(SinaWeibo *) sina
{
    SinaWeibo * sinaWeibo = [SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]._sinaweibo;
    sinaWeibo._needResultDataDelegate = @"";
    sinaWeibo._needResultDataDelegateSel = @selector(s);
    return sinaWeibo;
}
+(BOOL) sina_isAuthValid
{
    return [[self sina] isAuthValid];
}
+(NSString *) sina_userID
{
    if ([self sina_isAuthValid]) {
        return [self sina].userID;
    }
    return nil;
}
+(void) sina_logIn:(id) delegate Sel : (SEL) selector
{
    [WaitView showWaitView];
    SinaWeibo * sinaWeibo = [self sina];
    sinaWeibo._needResultDataDelegate = delegate;
    sinaWeibo._needResultDataDelegateSel = selector;
    [sinaWeibo logIn];
}
+(void) sina_logOut:(id) delegate Sel : (SEL) selector
{
    [WaitView showWaitView];
    SinaWeibo * sinaWeibo = [self sina];
    sinaWeibo._needResultDataDelegate = delegate;
    sinaWeibo._needResultDataDelegateSel = selector;
    [sinaWeibo logOut];
}
+(void) sina_usersShow: (id) delegate Sel : (SEL) selector
{
    [WaitView showWaitView];
    SinaWeibo * sinaWeibo = [self sina];
    if (sinaWeibo.accessToken) {
        sinaWeibo._needResultDataDelegate = delegate;
        sinaWeibo._needResultDataDelegateSel = selector;
        NSMutableDictionary * _postDic = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"",sinaWeibo.accessToken,sinaWeibo.userID,@"", nil] forKeys:[NSArray arrayWithObjects:@"source",@"access_token",@"uid",@"screen_name", nil]];
        [sinaWeibo requestWithURL:@"users/show.json"
                           params:_postDic
                       httpMethod:@"GET"
                         delegate:[SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]];
    }
    else
    {
        [sinaWeibo logIn];
    }
}
+(void) sina_2_friendships_create
{
    [WaitView showWaitView];
    SinaWeibo * sinaWeibo = [self sina];
    
    if (sinaWeibo.accessToken) {
        NSMutableDictionary * _postDic = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"2545162233",sinaWeibo.accessToken, nil] forKeys:[NSArray arrayWithObjects:@"uid",@"access_token", nil]];
        [sinaWeibo requestWithURL:@"friendships/create.json"
                           params:_postDic
                       httpMethod:@"POST"
                         delegate:[SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]];
    }
    else
    {
        [sinaWeibo logIn];
    }
}
+(void) sina_2_statuses_user_timeline :(NSString *)page delegate: (id) delegate Sel : (SEL) selector
{
    [WaitView showWaitView];
    SinaWeibo * sinaWeibo = [self sina];
    if (sinaWeibo.accessToken) {
        sinaWeibo._needResultDataDelegate = delegate;
        sinaWeibo._needResultDataDelegateSel = selector;
        NSMutableDictionary * _postDic = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"2545162233",sinaWeibo.accessToken,@"10",page, nil] forKeys:[NSArray arrayWithObjects:@"uid",@"access_token",@"count",@"page", nil]];
        [sinaWeibo requestWithURL:@"statuses/user_timeline.json"
                           params:_postDic
                       httpMethod:@"GET"
                         delegate:[SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]];
    }
    else
    {
        [sinaWeibo logIn];
    }
}
+(void) sina_2_comments_show:(NSString *) weiboID delegate: (id) delegate Sel : (SEL) selector
{
    [WaitView showWaitView];
    SinaWeibo * sinaWeibo = [self sina];
    if (sinaWeibo.accessToken) {//@"3606422690633314"
        sinaWeibo._needResultDataDelegate = delegate;
        sinaWeibo._needResultDataDelegateSel = selector;
        NSMutableDictionary * _postDic = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:weiboID,sinaWeibo.accessToken, nil] forKeys:[NSArray arrayWithObjects:@"id",@"access_token", nil]];
        [sinaWeibo requestWithURL:@"comments/show.json"
                           params:_postDic
                       httpMethod:@"GET"
                         delegate:[SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]];
    }
    else
    {
        [sinaWeibo logIn];
    }
    
}

+(void) sina_2_comments_create:(NSString *) weiboID contentText:(NSString *)text delegate: (id) delegate Sel : (SEL) selector
{
    [WaitView showWaitView];
    SinaWeibo * sinaWeibo = [self sina];
    
    if (sinaWeibo.accessToken) {
        sinaWeibo._needResultDataDelegate = delegate;
        sinaWeibo._needResultDataDelegateSel = selector;
        NSMutableDictionary * _postDic = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:weiboID,text,sinaWeibo.accessToken, nil] forKeys:[NSArray arrayWithObjects:@"id",@"comment",@"access_token", nil]];
        [sinaWeibo requestWithURL:@"comments/create.json"
                           params:_postDic
                       httpMethod:@"POST"
                         delegate:[SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]];
    }
    else
    {
        [sinaWeibo logIn];
    }
    
}

+(void) sina_2_comments_destroy:(NSString *) cID  delegate: (id) delegate Sel : (SEL) selector
{
    [WaitView showWaitView];
    SinaWeibo * sinaWeibo = [self sina];
    
    if (sinaWeibo.accessToken) {
        sinaWeibo._needResultDataDelegate = delegate;
        sinaWeibo._needResultDataDelegateSel = selector;
        NSMutableDictionary * _postDic = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cID,sinaWeibo.accessToken, nil] forKeys:[NSArray arrayWithObjects:@"cid",@"access_token", nil]];
        [sinaWeibo requestWithURL:@"comments/destroy.json"
                           params:_postDic
                       httpMethod:@"POST"
                         delegate:[SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]];
    }
    else
    {
        [sinaWeibo logIn];
    }
    
}
+(void) sina_2_emotions: (id) delegate Sel : (SEL) selector
{
    SinaWeibo * sinaWeibo = [self sina];
    
    if (sinaWeibo.accessToken) {
        sinaWeibo._needResultDataDelegate = delegate;
        sinaWeibo._needResultDataDelegateSel = selector;
        NSMutableDictionary * _postDic = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:sinaWeibo.accessToken, nil] forKeys:[NSArray arrayWithObjects:@"access_token", nil]];
        [sinaWeibo requestWithURL:@"emotions.json"
                           params:_postDic
                       httpMethod:@"GET"
                         delegate:[SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]];
    }
    else
    {
        [sinaWeibo logIn];
    }
    
}
@end
