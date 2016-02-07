#import "MDCSwipeToChoose.h"

typedef void(^LFReversibleTinderViewBlockVoid)			(void);

//	name wrap
@interface LFReversibleTinderSubview: MDCSwipeToChooseView
@end


@interface LFReversibleTinderView: UIView <MDCSwipeToChooseDelegate>
{
	NSMutableArray*	swipe_views;
}
@property (nonatomic) NSUInteger index;
@property (nonatomic) NSUInteger count;
// contains LFReversibleTinderSubview
@property (nonatomic, strong) NSMutableArray*	swipe_views;	
@property (nonatomic, strong) LFReversibleTinderViewBlockVoid	block_previous;	
@property (nonatomic, strong) LFReversibleTinderViewBlockVoid	block_next;	
//@property (nonatomic, strong) id		delegate;

- (void)skip;

@end
