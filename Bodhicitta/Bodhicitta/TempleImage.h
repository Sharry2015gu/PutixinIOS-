//
//  TempleImage.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/3.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TempleImage : NSObject

@property(nonatomic,assign)NSInteger buddhistTempleID;//佛寺的id
@property(nonatomic,strong)NSString * flower; //当前献花
@property(nonatomic,strong)NSString * flowerUrl;//花材料的URL
@property(nonatomic,assign)NSInteger flowerValidTime;//当前献花生效截至时长
@property(nonatomic,strong)NSString * incense; // 当前敬香
@property(nonatomic,strong)NSString * incenseUrl; //香材料的URL
@property(nonatomic,assign)NSInteger incenseValidTime;//当前香生效截至时长
@property(nonatomic,strong)NSString  * materialImageUrl; //佛像图片URL
@property(nonatomic,strong)NSString  *taskCode;//对应恭请的佛ID
@property(nonatomic,strong)NSString * taskName;//佛像名字
@property(nonatomic,strong)NSString * tea; //当前供茶
@property(nonatomic,strong)NSString * teaUrl; //茶材料的URL
@property(nonatomic,strong)NSString * teaTime; //当前供茶生效截至时长
@property(nonatomic,assign)NSInteger templeIntegral;//佛堂的积分
@property(nonatomic,strong)NSString * tribute; //当前献贡
@property(nonatomic,strong)NSString * tributeURL;//贡品素材的URL
@property(nonatomic,assign)NSInteger tributeValidTime;//当前贡品生效截至时长
@property(nonatomic,strong)NSString * TotalQty;//被请数量
@property(nonatomic,assign)NSInteger isHot;//是否热门
@property(nonatomic,strong)NSString * meaning;//佛的寓意
@property(nonatomic,assign)NSInteger isSelected; //是否已请
@property(nonatomic,strong)NSString * taskDesc;//详细描述
@property(nonatomic,assign)NSInteger makeWishQty;//许愿次数

@end
