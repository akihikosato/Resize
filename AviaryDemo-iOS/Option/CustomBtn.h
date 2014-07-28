//
//  CustomBtn.h
//  PhotoEditor
//
//  Created by Akihiko Sato on 2014/07/17.
//  Copyright (c) 2014年 Aviary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "InfoViewController.h"

@class InfoViewController;

@interface CustomBtn : UIButton
{
    InfoViewController *info;

}
//@property (nonatomic) UILabel *label;
- (id)init;
+ (void)addAnimation:(UIButton*)btn;


@end
