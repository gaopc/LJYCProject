//
//  TwoSectionsCell.h
//  LJYCProject
//
//  Created by z1 on 14-3-10.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TSectionsOneCell : UITableViewCell

@property(nonatomic,retain) UISubLabel *title;
@property(nonatomic,retain) UISubLabel *simpleDesc;
@property(nonatomic,retain) UIImageView *anyTimeGView;
@property(nonatomic,retain) UIImageView *anyTimeRView;
@property(nonatomic,retain) UIImageView *expTimeGView;
@property(nonatomic,retain) UIImageView *expTimeRView;
@property(nonatomic,retain) UISubLabel *time;//时间
@property(nonatomic,retain) UISubLabel *buyCount;//购买数量
@property(nonatomic,retain) UISubLabel *anyTimeL;
@property(nonatomic,retain) UISubLabel *expTimeL;
@end

@interface TSectionsTwoCell : UITableViewCell
{
	UIImageView *backView;
}

@property(nonatomic,retain) UISubLabel *title;
@property(nonatomic,retain) UISubLabel *desc;

- (void)initWithContent:(NSString *)content;
+ (int) height:(NSString*)content;
@end

@interface TSectionsThreeCell : UITableViewCell
{
	UIImageView *backView;
}
@property(nonatomic,retain) UISubLabel *desc;
+ (int) height:(NSString*)content;
- (void)initWithContent:(NSString *)content;
@end

@interface TSectionsFourCell : UITableViewCell



@end

@interface TwoSectionsCell : UITableViewCell<UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webView;


@end
