//
//  DockMenuView.h
//  abcd
//

#import <UIKit/UIKit.h>

typedef enum
{
    K_MENUITEM_DEFAULT=100,
    K_MENUITEM_FIRST ,
    K_MENUITEM_SECOND,
    K_MENUITEM_THIRD,
}MenuItemType;

@protocol DockMenuItemDelegate <NSObject>
-(void) onDockMenuItemClick:(id)sender;

@end

@interface DockMenuView : UIView
{
    NSMutableArray *mDockMenuItemArray;
}
@property (nonatomic,assign) id<DockMenuItemDelegate> mDockMenuItemDelegate;

-(void) setMenuItemData:(NSMutableArray*) array;
-(void) changeMenuItemState:(int) tag;
@end
