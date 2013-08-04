#import <Foundation/Foundation.h>
@class DragContext;


@interface DragDropManager : NSObject
- (id)initWithDragSubjects:(NSArray *)dragSubjects andDropAreas:(NSArray *)dropAreas;

- (void)dragging:(id)sender;


@property(nonatomic, retain) DragContext *dragContext;
@property(nonatomic, retain, readonly) NSArray *dropAreas;


@end