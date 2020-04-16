//
//  CustomMKAnnotationView.h
//  LJYCProject
//
//  Created by z1 on 13-10-30.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BMapKit.h"
#import "BMKMapComponent.h"
#import "CustomAnnotationCell.h"
@interface CustomMKAnnotationView : BMKAnnotationView

@property (nonatomic,retain)UIView *contentView;
@property (nonatomic,retain)CustomAnnotationCell  *cell;

- (id)initWithFrame:(CGRect)rct  Annotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;


@end
