//
//  CustomBtn.m
//  PhotoEditor
//
//  Created by Akihiko Sato on 2014/07/17.
//  Copyright (c) 2014年 Aviary. All rights reserved.
//

#import "CustomBtn.h"

@implementation CustomBtn
//@synthesize label;
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //[[self layer] setBorderWidth:1.0f];
    //[self.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    self.layer.cornerRadius = 7;
    self.clipsToBounds = YES;
    
    // Title
    //[self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 180, 50);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = self.titleLabel.font;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [self myTitle];
    [self addSubview:label];
    
}

- (NSString*)myTitle {
    
    NSString *res;
    
    if (self.tag == 0) {
        res = @"Camera";
    }
    if (self.tag == 1) {
        res = @"Album";
    }
    if (self.tag == 2) {
        res = @"Setting";
    }
    if (self.tag == 3) {
        res = @"Ranking";
    }
    return res;
}

+ (void)addAnimation:(UIButton*)btn {
    NSLog(@"--- Animation");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    btn.transform = CGAffineTransformMakeScale(1.1, 1.05);

    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView commitAnimations];
    
    /*
    [self performSelector:@selector(addAnimation2:)
               withObject:btn
               afterDelay:0.23f];
    */

}

- (void)addAnimation2:(UIButton*)btn {
    
}

@end
