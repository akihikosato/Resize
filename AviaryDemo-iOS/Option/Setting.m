//
//  Setting.m
//  AviaryDemo-iOS
//
//  Created by Akihiko Sato on 2014/07/15.
//  Copyright (c) 2014年 Aviary. All rights reserved.
//

#import "Setting.h"

@implementation Setting
@synthesize sizeArr;

- (id)init:(AFSDKDemoViewController*)mainClass {
    
    main = mainClass;
    
    return self;
}

- (int)checkDevicePhotoSize {
    
    int type = 0;
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    NSArray *array = [platform componentsSeparatedByString:@","];
    
    //NSLog(@"array:%@", [array description]);
    //NSLog(@"--- %@",[array objectAtIndex:0]);
    // 5s, 5 ,4s
    //PixelXDimension = 3264;
    //PixelYDimension = 2448;
    // 1936 × 2592 . 4
    
    sizeArr = [NSMutableArray array];
    
    if ([[array objectAtIndex:0]isEqualToString:@"iPhone4"]) {
        
        type = 1;
        
        main.maxX = 1936.0f;
        main.maxY = 2592.0f;

        
    } else { // iPhone5s, 5, 4s

        main.maxX = 2448.0f;
        main.maxY = 3264.0f;

    }
    
    NSLog(@"--- maxY:3264");
    return type;
}

@end
