//
//  CollectionSegment.h
//  ColSegmentDemo
//
//  Created by EricSue on 17/05/2018.
//  Copyright © 2018 EricSue. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CollectionSegmentDelegate<NSObject>

-(void)didSelectAtIndexPath:(NSIndexPath*) indexPath;
@end

@interface CollectionSegment : UIView

@property(nonatomic, copy)NSArray* titleArray;
@property(nonatomic, assign)id<CollectionSegmentDelegate>CSDelegate;
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;

@end
