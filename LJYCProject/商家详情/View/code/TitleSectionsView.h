//
//  TitleSectionsView.h
//  LJYCProject
//
//  Created by z1 on 14-3-11.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleSectionsDelegate
@optional
- (void)carClick:(UIButton *)sender;
@end


@interface TitleSectionsView : UIView
{
	UIImageView *lineView;
}
@property (nonatomic, assign) id <TitleSectionsDelegate> delegate;
@property(nonatomic,retain) UISubLabel *nprice;
@property(nonatomic,retain) UISubLabel *oprice;

@property (nonatomic, retain) UIButton* carBtn;
- (void)carState:(int)state;
-(void) setContentSize;
@end
