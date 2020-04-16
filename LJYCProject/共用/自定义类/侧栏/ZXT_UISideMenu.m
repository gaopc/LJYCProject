//
//  ZXT_UISideMenu.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-4.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ZXT_UISideMenu.h"
#import "UIImage+Extension.h"
@implementation ZXT_UISideMenuItem

-(void) dealloc
{
    self.action = nil;
    self.image = nil;
    self.highlightedImage = nil;
    self.title = nil;
    [super dealloc];
}
@synthesize title,image,highlightedImage,action;
- (id)initWithTitle:(NSString *)_title action:(ZXTUISideItemActionBlock) _action
{
    return [self initWithTitle:_title image:nil highlightedImage:nil action:_action];
}

- (id)initWithTitle:(NSString *)_title image:(UIImage *)_image highlightedImage:(UIImage *)_highlightedImage action:(ZXTUISideItemActionBlock) _action
{
    self = [super init];
    if (!self)
        return nil;
    
    self.title = _title;
    self.action = _action;
    self.image =_image;
    self.highlightedImage = _highlightedImage;
    
    return self;
}


@end

@implementation MenuCell
@synthesize imageV,textLabel;
- (void)dealloc
{
    self.imageV = nil;
    self.textLabel = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageV = [UIImageView ImageViewWithFrame:CGRectMake(0, 9, 32, 32)];
        self.textLabel = [UILabel labelWithTitle:nil frame:CGRectMake(35, 9, 100, 32) font:[UIFont systemFontOfSize:14] color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        [self addSubview:self.imageV];
        [self addSubview:self.textLabel];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@interface ZXT_UISideMenu () <UITableViewDataSource,UITableViewDelegate>
{
    float _initialX;
}

@property(nonatomic,assign) UIImageView * screenshotView;
@property(nonatomic,assign) CGSize screenshotOriginalSize;
@property(nonatomic,assign) UITableView * tableView;

@end

@implementation ZXT_UISideMenu
@synthesize items,font,textColor,highlightedTextColor,verticalOffset,horizontalOffset,isShowing,itemHeight;
-(void) dealloc
{
    self.items = nil;
    self.font = nil;
    self.textColor = nil;
    self.highlightedTextColor = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithItems:(NSArray *)_items
{
    self = [self initWithFrame:CGRectMake(0, 0, ((UIView*)[UIApplication sharedApplication].keyWindow).frame.size.width, ((UIView*)[UIApplication sharedApplication].keyWindow).frame.size.height)];
    if (!self)
        return nil;
    
    self.items = _items;
    
    self.verticalOffset = 100;
    self.horizontalOffset = 40;
    self.itemHeight = 50;
    self.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22];
    self.textColor = [UIColor whiteColor];
    self.highlightedTextColor = [UIColor lightGrayColor];
    
    [self setupUI];
    
    return self;
}
-(void) setupUI
{
    UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, ViewHeight+20)];
    imageV.image = [UIImage imageNamed:@"background.png"];
    [self insertSubview:imageV atIndex:0];
    [imageV release];
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.userInteractionEnabled = YES;
    
    _screenshotView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.screenshotView.image = [UIImage screenshotsKeyWindowWithStatusBar:NO];
    self.screenshotView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.screenshotView.userInteractionEnabled = YES;
    
    self.screenshotOriginalSize = self.screenshotView.frame.size;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.horizontalOffset, 0, self.frame.size.width-self.horizontalOffset, self.frame.size.height)];
    self.tableView.tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.horizontalOffset)] autorelease];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.alpha = 0;
    
    [self addSubview:_tableView];
    [self addSubview:_screenshotView];
    [_tableView release];
    [_screenshotView release];
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    [self.screenshotView addGestureRecognizer:tapGestureRecognizer];
    [tapGestureRecognizer release];
//    UIScreenEdgePanGestureRecognizer * screenEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
//    [self.screenshotView addGestureRecognizer:screenEdgePanGestureRecognizer];
//    [screenEdgePanGestureRecognizer release];

}
- (void)show
{
    if (isShowing)
        return;
    
    isShowing = YES;
    
    BOOL init = NO;
    
    for (UIView * view in ((UIView*)[UIApplication sharedApplication].keyWindow).subviews) {
        if (view == self) {
            init = YES;
            break;
        }
    }
    
    if (init == NO) {
        [((UIView*)[UIApplication sharedApplication].keyWindow) addSubview:self];
    }
    
    _screenshotView.userInteractionEnabled = YES;
    self.screenshotView.image = [UIImage screenshotsKeyWindowWithStatusBar:NO];
    
    [self screenshotViewToMinimize];
    
    self.alpha = 1;
}

- (void)hide
{
    if (!isShowing)
        return;
    
    isShowing = NO;
    
    _screenshotView.userInteractionEnabled = NO;
    
    [self screenshotViewRestore];
}

- (void)setRootViewController:(UIViewController *)viewController
{
    ;
}

- (void) screenshotViewToMinimize
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.screenshotView.transform = CGAffineTransformScale(self.screenshotView.transform, 0.8, 0.8);
        self.screenshotView.center = CGPointMake(([[UIScreen mainScreen] bounds].size.width), self.center.y);
        self.screenshotView.alpha = 1;
        
    }];

    
    if (_tableView.alpha == 0) {
        
        self.tableView.transform = CGAffineTransformScale(_tableView.transform, 0.9, 0.9);
        [UIView animateWithDuration:0.5 animations:^{
            
            self.tableView.transform = CGAffineTransformIdentity;
            
        }];
        
        [UIView animateWithDuration:0.6 animations:^{
            
            self.tableView.alpha = 1;
            
        }];

    }
}

-(void) screenshotViewRestore
{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.tableView.alpha = 0;
        self.tableView.transform = CGAffineTransformScale(_tableView.transform, 0.7, 0.7);
        
    }];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.screenshotView.transform = CGAffineTransformScale(self.screenshotView.transform, 1/0.8, 1/0.8);
        self.screenshotView.center = self.center;

        
    } completion:^(BOOL finished){
        
        self.alpha = 0;
        
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sideBarIdentifier = @"sideBarIdentifier";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:sideBarIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[[MenuCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sideBarIdentifier] autorelease];
    }
    ZXT_UISideMenuItem * item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    cell.imageV.image = item.image;
    cell.imageV.highlightedImage = item.highlightedImage;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZXT_UISideMenuItem * item = [self.items objectAtIndex:indexPath.row];
    item.action(self,item);
}


- (void)tapGestureRecognized:(UITapGestureRecognizer *)sender
{
    [self hide];
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
