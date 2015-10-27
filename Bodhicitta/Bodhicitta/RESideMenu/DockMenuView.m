//
//  DockMenuView.m
//  abcd
//

#import "DockMenuView.h"

@implementation DockMenuView
@synthesize mDockMenuItemDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        mDockMenuItemArray  = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void) setMenuItemData:(NSMutableArray*) array
{
    if ([mDockMenuItemArray count]>0) {
        [mDockMenuItemArray removeAllObjects];
    }
    [mDockMenuItemArray addObjectsFromArray:array];
    
    [self addMenuItemViews];
    [self setBackgroundColor:[UIColor whiteColor]];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor grayColor]CGColor];
}

-(void) addMenuItemViews
{
    int count = [mDockMenuItemArray count];
    int itemWidth = self.frame.size.width/count;
    int itemHeight = self.frame.size.height;
    for (int i=0; i<count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, itemHeight)];
        [btn setTitle:[mDockMenuItemArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitle:[mDockMenuItemArray objectAtIndex:i] forState:UIControlStateHighlighted];
        [btn setTag:K_MENUITEM_DEFAULT+i];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn addTarget:self action:@selector(onMenuItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIImageView * view=[[UIImageView alloc]initWithFrame:CGRectMake(125, 0, 1, 48)];
        view.image=[UIImage imageNamed:@"line.jpg"];
        [btn addSubview:view];
        
        if (i < count -1) {
            UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.origin.x+btn.frame.size.width, 0, 0.5, itemHeight)];
            [line setBackgroundColor:[UIColor whiteColor]];
            [self addSubview:line];
            
        }
    }
}

-(void) onMenuItemClick:(id)sender
{
//    NSArray *viewArray =[[NSArray alloc]initWithArray:[self subviews]];
//    int viewCount = [viewArray count];
//    for (int i=0; i<viewCount; i++) {
//        if ([[viewArray objectAtIndex:i] isKindOfClass:[UIButton class]]) {
//            UIButton *subView = (UIButton*) [viewArray objectAtIndex:i];
//            if (subView.tag == ((UIButton*)sender).tag) {
//                [subView setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            }
//            else
//            {
//                [subView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            }
//        }
//        
//    }
    
    
    [self changeMenuItemState:((UIButton*)sender).tag];
    if (mDockMenuItemDelegate != nil) {
        [mDockMenuItemDelegate onDockMenuItemClick:sender];
    }
}

-(void) changeMenuItemState:(int) tag
{
    NSArray *viewArray =[[NSArray alloc]initWithArray:[self subviews]];
    int viewCount = [viewArray count];
    for (int i=0; i<viewCount; i++) {
        if ([[viewArray objectAtIndex:i] isKindOfClass:[UIButton class]]) {
            UIButton *subView = (UIButton*) [viewArray objectAtIndex:i];
            if (subView.tag == tag) {
                [subView setTitleColor:[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f]
 forState:UIControlStateNormal];
                [subView setBackgroundImage:[UIImage imageNamed:@"选中副本"] forState:UIControlStateNormal];
            }
            else
            {
                [subView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [subView setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
            }
            
        }
    }
    
}
@end
