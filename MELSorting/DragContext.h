#import <Foundation/Foundation.h>


@interface DragContext : NSObject

@property(nonatomic, retain, readonly) UIView *draggedView;
@property(nonatomic, retain) UIView *originalView;

- (id)initWithDraggedView:(UIView *)draggedView;

- (void)snapToOriginalPosition;

@end