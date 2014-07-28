//
//  Data.h
//  PhotoEditor
//
//  Created by a.sato on 2014/07/22.
//  Copyright (c) 2014年 Aviary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"
#import "AFSDKDemoViewController.h"
@class AFSDKDemoViewController;
@interface Data : NSObject
{
    NSMutableArray *valuesArr;
}
@property (nonatomic, copy) NSMutableDictionary *valuesDic;
@property (nonatomic, copy) NSMutableArray *valuesArr;
@property (nonatomic) NSString *str;

// Data Paras
//@property (nonatomic, assign) BOOL *flagEdit, *flagResize, *fotmat, *flagSilent;


+ (NSString*)name;
+ (void)loadUserData:(AFSDKDemoViewController*)mainClass;
+ (NSMutableArray*)loadScaleArr;
+ (void)saveUserData;
+ (void)changeUserData:(AFSDKDemoViewController*)mainClass;
+ (void)changeScaleArr:(NSMutableArray*)preArr;
+ (void)settingLastData:(AFSDKDemoViewController*)mainClass;
@end
