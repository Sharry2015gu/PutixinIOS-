//
//  WisdomModel.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/13.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "WisdomModel.h"
#define KBookId @"bookId"
#define KClicks @"clicks"
#define KDownloadUrl_r @"downloadUrl_r"
#define KDownloadUrl_w @"downloadUrl_w"
#define KIsReco  @"isReco"
#define KTitle   @"title"
#define KWord    @"wordTotal"
#define KCategory @"category"
@implementation WisdomModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
//用于归档解档
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self !=  nil) {
        NSNumber  *bookIdNumber = [aDecoder decodeObjectForKey:KBookId];
        self.bookId =  [bookIdNumber integerValue];
        NSNumber  *clicksNumber = [aDecoder  decodeObjectForKey:KClicks];
        self.clicks = [clicksNumber integerValue];
        self.downloadUrl_r = [aDecoder  decodeObjectForKey:KDownloadUrl_r];
        self.downloadUrl_w = [aDecoder  decodeObjectForKey:KDownloadUrl_w];
        NSNumber  *isReco  = [aDecoder decodeObjectForKey:KIsReco];
        self.isReco = [isReco integerValue];
        self.title = [aDecoder decodeObjectForKey:KTitle];
        NSNumber *wordTotalNumber = [aDecoder decodeObjectForKey:KWord];
        self.wordTotal = [wordTotalNumber integerValue];
        NSNumber *categoryNumber = [aDecoder decodeObjectForKey:KCategory];
        self.category = [categoryNumber integerValue];
    }
    return self;
}
//归档时调用此方法
-(void)encodeWithCoder:(NSCoder *) aCoder
{
    [aCoder encodeObject:[NSNumber numberWithInteger:self.bookId] forKey:KBookId];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.clicks] forKey:KClicks];
    [aCoder encodeObject:self.downloadUrl_r forKey:KDownloadUrl_r];
    [aCoder encodeObject:self.downloadUrl_w forKey:KDownloadUrl_w];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.isReco] forKey:KIsReco];
    [aCoder encodeObject:self.title forKey:KTitle];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.wordTotal] forKey:KWord];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.category] forKey:KCategory];
}
@end
