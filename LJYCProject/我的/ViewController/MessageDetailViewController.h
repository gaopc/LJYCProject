//
//  MessageDetailViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMessageData.h"

@interface MessageDetailViewController : RootViewController <UIAlertViewDelegate>
@property(nonatomic,retain)Message *myMessage;
@property (nonatomic, retain) id _delegate;
@end
