//
//  CollectionSegment.m
//  ColSegmentDemo
//
//  Created by EricSue on 17/05/2018.
//  Copyright © 2018 EricSue. All rights reserved.
//

#import "CollectionSegment.h"
#import "CollectionViewCell.h"

#define KItemWidth  [[UIScreen mainScreen] bounds].size.width/4 //如果结果为 x.5，可能会有缝隙

@interface CollectionSegment()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView* collectionView;
@end
@implementation CollectionSegment

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 1; //分隔线，设置为0，会有缝隙，因为item宽度为x.5
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(KItemWidth, self.bounds.size.height);
        
        _collectionView = [[UICollectionView  alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:flowLayout];
        
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CSCell"];
        _collectionView.backgroundColor = [UIColor redColor]; //设置为分隔线颜色
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionView];
    }
    return self;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        self.titleArray = [NSArray array];
    }
    return _titleArray;
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [_collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titleArray.count;
}

- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(KItemWidth, self.bounds.size.height);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];

    CollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"CSCell" forIndexPath:indexPath];
    cell.title = _titleArray[indexPath.row];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_CSDelegate != nil) {
        if ([_CSDelegate respondsToSelector:@selector(didSelectAtIndexPath:)]) {
            [_CSDelegate didSelectAtIndexPath:indexPath];
        }
    }
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
