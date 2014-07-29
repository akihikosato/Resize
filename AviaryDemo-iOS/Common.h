//
//  Common.h
//  PhotoEditor
//
//  Created by Akihiko Sato on 2014/07/15.
//  Copyright (c) 2014年 Aviary. All rights reserved.
//

#ifndef PhotoEditor_Common_h
#define PhotoEditor_Common_h

#import "ImobileSdkAds/ImobileSdkAds.h"
#import "ImobileSdkAds/ImobileSdkAdsIconParams.h"
//#import "ImobileSdkAdsProperty.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "Data.h"

#define PUBLISHER_ID     @"31137"
#define MEDIA_ID         @"110444"
#define SPOT_ID          @"257103"

#define PUBLISHER_ID_WALL     @"31137"
#define MEDIA_ID_WALL         @"110444"
#define SPOT_ID_WALL          @"257105"

#define PUBLISHER_ID_INT     @"31137"
#define MEDIA_ID_INT         @"110444"
#define SPOT_ID_INT          @"257104"

#define SPOT_ID_ICON         @"257393"

#define WAITVIEW_COL [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8]

#define SMALL_SCREEN self.view.frame.size.height == 480.0f

// Data
#define JSON_URL @"https://script.google.com/macros/s/AKfycbxMtAgs9XhylOre3LXRjRKCTgCrli7mvvkZzIVw-uPfjBXkolk/exec"
//#define DATA @"USER_DATA"
#define SCALES @"SCALE_ARR"
#define FMT NSString stringWithFormat

#endif
