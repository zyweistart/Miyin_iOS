@protocol ResultDelegate <NSObject>

@required
- (void)onControllerResult:(NSInteger)resultCode data:(NSMutableDictionary*)result;

@end
