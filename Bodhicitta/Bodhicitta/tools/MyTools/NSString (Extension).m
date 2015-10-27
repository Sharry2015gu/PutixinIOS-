//
//  NSString (Extension).m
//  MemoryWebApp
//
//  Created by 怀恩03 on 15/7/29.
//  Copyright (c) 2015年 怀恩03. All rights reserved.
//

#import "NSString (Extension).h"

@implementation NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
