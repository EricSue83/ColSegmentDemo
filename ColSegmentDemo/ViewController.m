//
//  ViewController.m
//  ColSegmentDemo
//
//  Created by EricSue on 17/05/2018.
//  Copyright © 2018 EricSue. All rights reserved.
//

#import "ViewController.h"
#import "CollectionSegment.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface ViewController ()<UIScrollViewDelegate, CollectionSegmentDelegate>

@property (nonatomic, strong)  CollectionSegment *collectionSeg;
@property (nonatomic, strong) UIScrollView *scrollview;

//保存可重用的
@property (nonatomic, strong) NSMutableArray *reusedVCArray;

@end

@implementation ViewController

#pragma mark - lazy
- (NSMutableArray*)reusedVCArray{
    if (!_reusedVCArray) {
        _reusedVCArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _reusedVCArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //CollectionSegment
    _collectionSeg = [[CollectionSegment alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, 55)];
    [self.view addSubview:_collectionSeg];
    _collectionSeg.titleArray = @[@"p1",@"p2",@"p3",@"p4"];
    [_collectionSeg setSelectedSegmentIndex:0 animated:YES]; // 默认选中第0个
    _collectionSeg.CSDelegate = self;
    
    //ScrollView
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionSeg.frame), [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - CGRectGetMaxY(_collectionSeg.frame))];
    _scrollview.pagingEnabled = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * _collectionSeg.titleArray.count, 0);
    _scrollview.delegate = self;
    _scrollview.bounces = NO;
    [self.view addSubview:_scrollview];

    [self showViewAtIndex:0];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showViewAtIndex:(NSInteger)index{
    CGRect bounds  = _scrollview.bounds;
    CGRect vcFrame = bounds;
    vcFrame.origin.x = CGRectGetWidth(bounds) * index;
    NSLog(@"弟 %ld 个页面",(long)index);
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch (index) {
        case 0:
        {
            FirstViewController* firstVC = [storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
            if (![self isInReused:firstVC]) {
                [self addChildViewController:firstVC];
                [self.reusedVCArray addObject:firstVC];
                [_scrollview addSubview:firstVC.view];
            }
            firstVC.view.frame = vcFrame;
   
            NSLog(@"000 ----- %@", [_scrollview subviews]);
        }
            break;
        case 1:
        {
            SecondViewController* secVC = [storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
            if (![self isInReused:secVC]) {
                [self addChildViewController:secVC];
                [self.reusedVCArray addObject:secVC];
                [_scrollview addSubview:secVC.view];
            }
            secVC.view.frame = vcFrame;
  
            NSLog(@"111 ----- %@", [_scrollview subviews]);
        }
            break;
        case 2:
        {
            ThirdViewController* thVC = [storyboard instantiateViewControllerWithIdentifier:@"ThirdViewController"];
            if (![self isInReused:thVC]) {
                [self addChildViewController:thVC];
                [self.reusedVCArray addObject:thVC];
                [_scrollview addSubview:thVC.view];
            }
            thVC.view.frame = vcFrame;

            NSLog(@"222 ----- %@", [_scrollview subviews]);
        }
            break;
        case 3:
        {
            FourthViewController* fourVC = [storyboard instantiateViewControllerWithIdentifier:@"FourthViewController"];
            
            if (![self isInReused:fourVC]) {
                [self addChildViewController:fourVC];
                [self.reusedVCArray addObject:fourVC];
                [_scrollview addSubview:fourVC.view];
            }
            fourVC.view.frame = vcFrame;
            
            NSLog(@"333 ----- %@", [_scrollview subviews]);
        }
            break;
        default:
            break;
    }
    
}

-(BOOL)isInReused:(id)vcType {
    for (int i = 0; i < self.reusedVCArray.count; i++) {
        id vc = [self.reusedVCArray objectAtIndex:i];
        if ([vc isKindOfClass:[vcType class]]) {
            return YES;
        }
    }
    return NO;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    [self showViewAtIndex:page];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    [_collectionSeg setSelectedSegmentIndex:page animated:YES];
}
#pragma mark - CollectionSegmentDelegate
- (void)didSelectAtIndexPath:(NSIndexPath *)indexPath {
    CGPoint offset = _scrollview.contentOffset;
    offset.x = indexPath.row * _scrollview.bounds.size.width;
    [_scrollview setContentOffset:offset animated:YES];
}



@end
