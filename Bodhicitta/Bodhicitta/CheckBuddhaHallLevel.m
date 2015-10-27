//
//  CheckBuddhaHallLevel.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/23.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "CheckBuddhaHallLevel.h"

@implementation CheckBuddhaHallLevel
+(instancetype)shareCheckBuddhaHallLevel
{
    static CheckBuddhaHallLevel * checkBuddhaHallLevel = nil;
    checkBuddhaHallLevel = [[CheckBuddhaHallLevel alloc]init
                            ];
    return checkBuddhaHallLevel;
}
-(NSInteger)checkBuddhaHallLevelWithValue:(NSInteger) value;
{
    NSString *path = [[NSBundle  mainBundle] pathForResource:@"grad" ofType:@"txt"];
    NSData  * data  = [NSData dataWithContentsOfFile:path];
    NSString * dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray  *lineArray = [dataStr componentsSeparatedByString:@"\n"];
    for (int i = 0 ; i < lineArray.count; i++) {
        NSString *lineStr = lineArray[i];
        NSArray  *singleStrArray  = [lineStr componentsSeparatedByString:@"\t"];
        NSInteger minInteger = [singleStrArray[0] integerValue];
        NSInteger maxInteger = [singleStrArray[1] integerValue];
        if (value >= minInteger && value < maxInteger) {
            return  [singleStrArray[2] integerValue];
        }
    }
    return 0;
}
@end
