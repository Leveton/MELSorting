
#import <UIKit/UIKit.h>

@protocol PanManagerDelegate;

@interface PanManager : NSObject
@property (weak, nonatomic) id<PanManagerDelegate> delegate;
@property(nonatomic, strong, readonly) NSArray *dropAreas;

- (id)initWithDragSubjects:(NSArray <UIView*> *)dragSubjects andDropAreas:(NSArray <UIView*> *)dropAreas;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

@end

@protocol PanManagerDelegate <NSObject>

@optional
- (void)viewWasMovedWithView:(UIView *)view;
- (void)view:(UIView *)view didAlternateWithView:(UIView *)destinationView fromOriginalRect:(CGRect)originalRect;

@end
