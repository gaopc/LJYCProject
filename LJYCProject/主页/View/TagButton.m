//
//  TagButton.m
//  LJYCProject
//
//  Created by xiemengyue on 13-10-28.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "TagButton.h"
#import "AsyncImageView.h"
#import "AddTagsViewController.h"

@implementation TagButton
@synthesize selectedImageView,tag,delegate,isSelected;
@synthesize shopType,serviceTag,titleName,tagName;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)dealloc
{
    self.selectedImageView = nil;
    self.delegate = nil;
    self.serviceTag = nil;
    self.shopType = nil;
    self.titleName = nil;
	self.tagName = nil;
    [super dealloc];
}

+(TagButton*)setTagButton:(NSString*)imageURL  frame:(CGRect)frame tag:(NSInteger)tag showImageView:(BOOL)showImageView title:(NSString *)title isShowRightLine:(BOOL)isShowRightLine isShowBelowLine:(BOOL)isShowBelowLine isAddButton:(BOOL)isAddButton
{
    
    TagButton *tagButton = [[[TagButton alloc] init] autorelease];
    tagButton.frame = frame;
    tagButton.backgroundColor = [UIColor clearColor];
    tagButton.alpha = 0.9;
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tagButton.frame.size.width, tagButton.frame.size.height)];
    [aView setBackgroundColor:[UIColor whiteColor]];
    [tagButton addSubview:aView];
    [aView release];
    
    if(!isAddButton)
    {
        AsyncImageView *imageView2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, tagButton.frame.size.width-20, tagButton.frame.size.width-20)];
        imageView2.defaultImage = 1;
        [imageView2 setUrlString:[imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [tagButton addSubview:imageView2];
        [imageView2 release];
    }
    else
    {
        [tagButton addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 5, tagButton.frame.size.width-20, tagButton.frame.size.width-20) image:[UIImage imageNamed:@"添加标签.png"]]];
    }
    
    UISubLabel *titleLabel = [UISubLabel labelWithTitle:title frame:CGRectMake(5, tagButton.frame.size.height-12, tagButton.frame.size.width-10, 10) font:FontSize22 color:FontColor000000 alignment:NSTextAlignmentCenter];
    
    UIButton *button = [UIButton customButtonTitle:nil tag:tag image:nil frame:CGRectMake(0, 0, tagButton.frame.size.width, tagButton.frame.size.height) target:tagButton action:@selector(click:)];
    [button setImage:[UIImage imageNamed:@"标签2.png"] forState:UIControlStateHighlighted];
    tagButton.tag = button.tag;
    [button setExclusiveTouch:YES];
   
    [tagButton addSubview:titleLabel];
    
    
    if(showImageView)
    {
        tagButton.selectedImageView = [UIImageView ImageViewWithFrame:CGRectMake(tagButton.frame.size.width-15, 0, 15, 15) image:[UIImage imageNamed:@"添加标签_03.png"]];
        [tagButton addSubview:tagButton.selectedImageView];
        tagButton.selectedImageView.hidden = YES;
    }
    
    [tagButton addSubview:button];
    
    if(isShowBelowLine)
    [tagButton addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, tagButton.frame.size.height-1.0, tagButton.frame.size.width, 1.0f) image:[UIImage imageNamed:@"横向分割线.png"]]];
    if(isShowRightLine)
        [tagButton addSubview:[UIImageView ImageViewWithFrame:CGRectMake(tagButton.frame.size.width-1.0f, 0, 1.0f, tagButton.frame.size.height) image:[UIImage imageNamed:@"分割线.png"]]];
    return tagButton;
}

-(void)click:(UIButton *)sender
{
    if(![delegate isKindOfClass:[HomeViewController class]])
    {
        AddTagsViewController *addTagsVC = (AddTagsViewController*)delegate;
        if(addTagsVC.selectTags.count == 15 && self.selectedImageView.hidden)
        {
            [UIAlertView alertViewWithMessage:@"最多可以选择15项"];
            return;
        }
        else
        {
            self.selectedImageView.hidden = !self.selectedImageView.hidden;
            self.isSelected = !self.selectedImageView.hidden;
        }
    }
   else
   {
       self.selectedImageView.hidden = !self.selectedImageView.hidden;
       self.isSelected = !self.selectedImageView.hidden;
   }
    if(self.delegate && [self.delegate respondsToSelector:@selector(click:)])
    {
        [self.delegate performSelector:@selector(click:) withObject:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
