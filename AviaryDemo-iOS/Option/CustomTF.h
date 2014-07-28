//
//  CustomTF.h
//  PhotoEditor
//
//  Created by Akihiko Sato on 2014/07/21.
//  Copyright (c) 2014年 Aviary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AFSDKDemoViewController.h"
#import "InfoViewController.h"

@class AFSDKDemoViewController;
@class InfoViewController;

@interface CustomTF : UITextField
<UITextFieldDelegate>
{
    AFSDKDemoViewController *main;
    InfoViewController      *info;
    //NSMutableArray          *valuesArr;
}
@property (nonatomic, retain)NSMutableArray *valuesArr;
- (id)init:(AFSDKDemoViewController*)mainClass
 infoClass:(InfoViewController*)infoClass
       tag:(int)tag;
@end
