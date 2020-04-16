//
//  WeiXinExport.m
//  FlightProject
//
//  Created by gaopengcheng on 13-7-5.
//
//

#import "WeiXinExport.h"

@implementation WeiXinExport

+ (void) sendAppContent:(NSString *)title withDes:(NSString *)desc withImg:(UIImage *)image withUrl:(NSString *)url
{
    // 发送内容给微信
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:image];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
//    ext.extInfo = @"<xml>test</xml>";
    ext.url = url;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

+ (void) sendAppContentTo:(NSString *)title withDes:(NSString *)desc withImg:(UIImage *)image withUrl:(NSString *)url
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:image];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    //    ext.extInfo = @"<xml>test</xml>";
    ext.url = url;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}
@end
