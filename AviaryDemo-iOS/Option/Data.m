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
                              @"0",   @"EDIT_MODE",
                              @"0",   @"RESIZE_MODE",
                              @"0",   @"FORMAT",
                              @"1",   @"SILENT_MODE",
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
+ (void)loadUserData:(AFSDKDemoViewController *)mainClass {
    
    //Set Main Paras
    NSString *val;
    
    val = [[Data sharedManager].valuesDic objectForKey:@"EDIT_MODE"];
    mainClass.flagEdit = val.boolValue;
    
    val = [[Data sharedManager].valuesDic objectForKey:@"RESIZE_MODE"];
    mainClass.flagResize = val.boolValue;
    
    val = [[Data sharedManager].valuesDic objectForKey:@"FORMAT"];
    mainClass.fotmat = val.boolValue;
    
    val = [[Data sharedManager].valuesDic objectForKey:@"SILENT_MODE"];
    mainClass.flagSilent = val.boolValue;
    
    val = [[Data sharedManager].valuesDic objectForKey:@"LAST_VAL"];
    mainClass.lastVal = val.floatValue;
    
    mainClass.valuesArr = [Data sharedManager].valuesArr;
    
    //NSLog(@"--- [Data sharedManager].valuesDic:%@",[Data sharedManager].valuesDic);
    
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
                                [FMT:@"%d",(int)mainClass.flagEdit],     @"EDIT_MODE",
                                [FMT:@"%d",(int)mainClass.flagResize],   @"RESIZE_MODE",
                                [FMT:@"%d",(int)mainClass.fotmat],       @"FORMAT",
                                [FMT:@"%d",(int)mainClass.flagSilent],   @"SILENT_MODE",
                                [FMT:@"%f",mainClass.lastVal],           @"LAST_VAL",
                                nil];
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
