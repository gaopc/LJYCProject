
//  SendRequst.m
//  FlightProject
//
//  Created by longcd on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SendRequst.h"
#import "JSON.h"
@implementation SendRequst
@synthesize delegate;
@synthesize myRequest;
@synthesize aSelector,aDelegate;
-(void)dealloc
{
    self.delegate = nil;
    self.aDelegate = nil;
    self.aSelector = nil;
    self.myRequest.delegate = nil;
    [self.myRequest clearDelegatesAndCancel];
    self.myRequest  = nil;
    [super dealloc];
}

-(void)sendRequstAsiFormHttp:(ASIFormDataRequest *)theRequest
{
    self.myRequest = theRequest;
    [theRequest setPostValue:[TerminalId TerminalId]  forKey:@"reqHeader"];
    [theRequest setRequestMethod:@"POST"];
    if ([NSStringFromSelector(self.aSelector) isEqualToString:@"onPaseredUploadImageResult:" ] ) {
        [theRequest setTimeOutSeconds:180];
    }
    else
    {
        [theRequest setTimeOutSeconds:60];
    }
    theRequest.delegate = self;
    [theRequest startAsynchronous];
}
+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data
{
    @autoreleasepool {
        OSStatus securityError = errSecSuccess;
        
        CFStringRef password = CFSTR("lcd_8888"); //证书密码
        const void *keys[] =   { kSecImportExportPassphrase };
        const void *values[] = { password };
        
        CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys,values, 1,NULL, NULL);
        
        CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
        securityError = SecPKCS12Import((CFDataRef)inPKCS12Data,optionsDictionary,&items);
        
        if (securityError == 0) {
            CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
            const void *tempIdentity = NULL;
            tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
            *outIdentity = (SecIdentityRef)tempIdentity;
            const void *tempTrust = NULL;
            tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
            *outTrust = (SecTrustRef)tempTrust;
        } else {
            NSLog(@"Failed with error code %d",(int)securityError);
            return NO;
        }
        return YES;
    }
}

-(void)sendRequstAsiFormHttps:(ASIFormDataRequest *)theRequest
{
    
    [theRequest setPostValue:[TerminalId TerminalId]  forKey:@"terminalId"];
    [theRequest setRequestMethod:@"POST"];
    [theRequest setTimeOutSeconds:20];
    theRequest.delegate = self;
    
    SecIdentityRef identity = NULL;
    SecTrustRef trust = NULL;
    
    //绑定证书，证书放在Resources文件夹中
    NSData *PKCS12Data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"]];
    BOOL sendResult = [SendRequst extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data];
    
    if (sendResult) {
        //        [theRequest setClientCertificateIdentity:identity];
        [theRequest setClientCertificates:[NSArray arrayWithObjects:(id)identity,nil]];
        [theRequest setValidatesSecureCertificate:NO];
        [theRequest startAsynchronous];
    }
    else{
        [UIAlertView alertViewWithMessage:@"联网请求的证书验证失败！" Title:@"提示"];
    }
    
    
    NSError *error = [theRequest error];
    if (!error) {
        NSString *response = [theRequest responseString];
        NSLog(@"response is : %@",response);
    } else {
        NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
        NSLog(@"%@",[error userInfo]);
    }
}


-(void)requestFailed:(ASIFormDataRequest *)request
{
    NSLog(@"%s",__FUNCTION__);
    NSError * err = request.error;
    NSString * errorMess = nil;
    if (ShowNetErrorMessage) {
        errorMess = [NSString stringWithFormat:@"\n\n错误代码：%d\n错误描述：%@\n服务器返回字符串：%@",err.code, err.localizedDescription,request.responseString];
    }
    else{
        errorMess = @"";
    }
    NSDictionary * dic = [NSDictionary dictionaryWithObject:errorMess forKey:@"errorMessage"];
    [self requestResultStr:@"connectiondidFail" Dic:dic ];
}
-(void)requestFinished:(ASIFormDataRequest *)request
{
    NSString * str =  request.responseString;
    NSLog(@"%@",str);
    NSError * err = request.error;
    NSString * errorMess = nil;
    if (ShowNetErrorMessage) {
        errorMess = [NSString stringWithFormat:@"\n\n错误代码：%d\n错误描述：%@\n服务器返回字符串：%@",err.code, err.localizedDescription,request.responseString];
    }
    else{
        errorMess = @"";
    }
    if ([request responseData])
    {
	    NSDictionary * dic = [ str JSONValue ];
        if (dic) {
            [self requestResultStr:@"0" Dic:dic];
        }
        else {
            [self requestResultStr:@"connectiondidFail" Dic:[NSDictionary dictionaryWithObject:errorMess forKey:@"errorMessage"] ];
        }
    }
    else
    {
        [self requestResultStr:@"connectiondidFail" Dic:[NSDictionary dictionaryWithObject:errorMess forKey:@"errorMessage"] ];
    }
}

-(void)requestResultStr:(NSString *) _resultStr Dic:(NSDictionary *)resultDic
{
    if ([_resultStr isEqualToString:@"0"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestResultFinished:resultDic:)]) {
            [self.delegate performSelector:@selector(requestResultFinished:resultDic:) withObject:self withObject:resultDic];
        }
    }
    else{
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@\n%@",NetFailMessage,[resultDic objectForKey:@"errorMessage"]] Title:@"提示"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestResultFailed:)]) {
            [self.delegate performSelector:@selector(requestResultFailed:) withObject:self];
        }
    }
}


#pragma mark --
#pragma mark NSXMLParserDelegate
//-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
//{
//	[self.resultStr appendString:string];
//}
//
//- (void)parserDidEndDocument:(NSXMLParser *)parser{
//	NSString *JSONString = [self.resultStr stringByReplacingOccurrencesOfString:@"<![CDATA[[" withString:@""];
//	JSONString = [JSONString stringByReplacingOccurrencesOfString:@"]]>" withString:@""];
//    //NSLog(@"%@",JSONString);
//    NSArray * array = [JSONString JSONValue];
//    if (delegate &&[delegate respondsToSelector:@selector(requestResultStr:Arr:)])
//    {
//        @try {
//            [delegate performSelector:@selector(requestResultStr:Arr:) withObject:@"0" withObject:array];
//        }
//        @catch (NSException *exception) {
//            NSLog(@"%s,%@",__FUNCTION__,exception);
//        }
//    }
//
//}

//// post asiHttpRequest
//-(void)sendRequstAsiHttp:(NSMutableURLRequest *)theRequest
//{
//    NSMutableData * tempData = [[NSMutableData alloc] init];
//    NSMutableString * tempStr = [[NSMutableString alloc] init];
//    self.reciveData = tempData;
//    self.resultStr = tempStr;
//    [tempData release];
//    [tempStr release];
//
//    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:theRequest.URL];
//    [request setRequestMethod:@"POST"];
//    [request setTimeOutSeconds:45];
//    request.delegate = self;
//
//
//    request.requestHeaders = (NSMutableDictionary*)theRequest.allHTTPHeaderFields;
//
//    [request appendPostData:theRequest.HTTPBody];
//    [request startAsynchronous];
//
//}
//-(void)requestFailed:(ASIHTTPRequest *)request
//{
//    NSLog(@"%s",__FUNCTION__);
//    NSError * err = request.error;
//    NSArray * requestArr=[NSArray arrayWithObjects:err.localizedDescription, nil];
//    [delegate requestResultStr:@"connectiondidFail" Arr:requestArr];
//}
//-(void)requestFinished:(ASIHTTPRequest *)request
//{
//    if (request.responseData)
//    {
//        NSXMLParser * tempxmlParser = [[NSXMLParser alloc] initWithData: request.responseData];
//        self.xmlParser = tempxmlParser;
//        [tempxmlParser release];
//
//		[self.xmlParser setDelegate: self];
//		[self.xmlParser setShouldResolveExternalEntities: NO];
//		[self.xmlParser parse];
//	}
//    else
//    {
//        [delegate requestResultStr:@"array nil" Arr:nil];
//    }
//    
//}

@end
