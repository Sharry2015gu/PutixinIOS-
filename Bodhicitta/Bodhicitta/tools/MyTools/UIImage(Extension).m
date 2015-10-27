//
//  UIImage(Extension).m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/24.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "UIImage(Extension).h"

@implementation UIImage (Extension)
+(UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
