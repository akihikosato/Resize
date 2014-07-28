//
//  Setting.h
//  AviaryDemo-iOS
//
//  Created by Akihiko Sato on 2014/07/15.
//  Copyright (c) 2014年 Aviary. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/types.h>
#include <sys/sysctl.h>

#import "AFSDKDemoViewController.h"

@class AFSDKDemoViewController;

@interface Setting : NSObject
{
    AFSDKDemoViewController *main;

}

@property (nonatomic, retain)NSMutableArray *sizeArr;

- (id)init:(AFSDKDemoViewController*)mainClass;
- (int)checkDevicePhotoSize;

@end
