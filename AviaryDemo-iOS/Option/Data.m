//
//  Data.m
//  PhotoEditor
//
//  Created by a.sato on 2014/07/22.
//  Copyright (c) 2014年 Aviary. All rights reserved.
//

#import "Data.h"

#define USER_DATA @"USER_DATA"

@implementation Data
//@synthesize flagEdit, flagResize, fotmat, flagSilent;
@synthesize str, valuesDic, valuesArr;

+ (Data*)sharedManager {
    
    static Data *data = nil;
    
    if (!data) {
        
        data = [[Data alloc]init];
        
        // Member
        //data.str = @"hoge";
        //data.valuesArr = [NSMutableArray arrayWithObject:@"ARRAY"];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        if ([ud objectForKey:USER_DATA]) {
            // 既存
            data.valuesDic = [ud objectForKey:USER_DATA];
            data.valuesArr = [ud objectForKey:SCALES];
            
        } else {
            // 初回
            // Create Data
            data.valuesArr = [NSMutableArray arrayWithObjects:
                              [NSNumber numberWithFloat:320],
                              [NSNumber numberWithFloat:640],
                              [NSNumber numberWithFloat:960],
                              [NSNumber numberWithFloat:1280],
                              nil];
            
            
            data.valuesDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              @"1",   @"EDIT_MODE",
                              @"1",   @"RESIZE_MODE",
                              @"0",   @"FORMAT",
                              @"0",   @"SILENT_MODE",
                              @"2000", @"LAST_VAL",
                              nil];
            // Save
            [ud setObject:data.valuesArr forKey:SCALES];
            [ud setObject:data.valuesDic forKey:USER_DATA];
        }
    }
    
    return data;
}


+ (NSString*)name {
    return [Data sharedManager].str;
}

#pragma mark -
+ (void)loadUserData:(AFSDKDemoViewController*)mainClass {
    
    //Set Main Paras
    mainClass.flagEdit   = [[[Data sharedManager].valuesDic objectForKey:@"EDIT_MODE"]boolValue];
    mainClass.flagResize = [[[Data sharedManager].valuesDic objectForKey:@"RESIZE_MODE"]boolValue];
    mainClass.format     = [[[Data sharedManager].valuesDic objectForKey:@"FORMAT"]boolValue];
    mainClass.flagSilent = [[[Data sharedManager].valuesDic objectForKey:@"SILENT_MODE"]boolValue];
    mainClass.lastVal    = [[[Data sharedManager].valuesDic objectForKey:@"LAST_VAL"]floatValue ];
    mainClass.valuesArr  = [NSMutableArray arrayWithArray:[Data sharedManager].valuesArr];
    
   // NSLog(@"--- [Data sharedManager].valuesDic:%@",[Data sharedManager].valuesDic);
    NSLog(@"--- Load Data -> flagEdit:%d flagResize:%d format:%d lastVal:%.1f",
          mainClass.flagEdit,
          mainClass.flagResize,
          mainClass.format,
          mainClass.lastVal);
}

+ (NSMutableArray*)loadScaleArr {
    return [Data sharedManager].valuesArr;
}

+ (void)saveUserData {
    // Save
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:[Data sharedManager].valuesArr forKey:SCALES];
    [ud setObject:[Data sharedManager].valuesDic forKey:USER_DATA];
}

+ (void)changeUserData:(AFSDKDemoViewController *)mainClass {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                [FMT:@"%d",mainClass.flagEdit],     @"EDIT_MODE",
                                [FMT:@"%d",mainClass.flagResize],   @"RESIZE_MODE",
                                [FMT:@"%d",mainClass.format],       @"FORMAT",
                                [FMT:@"%d",mainClass.flagSilent],   @"SILENT_MODE",
                                [FMT:@"%f",mainClass.lastVal],      @"LAST_VAL",
                                nil];
    
    NSLog(@"--- Save Data -> flagEdit:%d flagResize:%d format:%d lastVal:%.1f",
          mainClass.flagEdit,
          mainClass.flagResize,
          mainClass.format,
          mainClass.lastVal);

    // Save
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:USER_DATA];
}

+ (void)changeScaleArr:(NSMutableArray *)preArr {
    
    [Data sharedManager].valuesArr = preArr;
    
    // Save
    [[NSUserDefaults standardUserDefaults] setObject:[Data sharedManager].valuesArr
                                              forKey:SCALES];
}

+ (void)settingLastData:(AFSDKDemoViewController *)mainClass {
    
}

@end
