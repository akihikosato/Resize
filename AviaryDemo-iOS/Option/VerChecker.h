//
//  VerChecker.h
//  Request_Test
//
//  Created by a.sato on 2014/07/18.
//  Copyright (c) 2014年 a.sato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFSDKDemoViewController.h"
#import "Common.h"

@class AFSDKDemoViewController;

@interface VerChecker : NSObject
<UIAlertViewDelegate>
{
    AFSDKDemoViewController *main;
}
- (id)init:(AFSDKDemoViewController*)mainClass;
- (NSDictionary*)userDataDic;
- (void)loadUserData;
- (void)saveUserData;

@end
