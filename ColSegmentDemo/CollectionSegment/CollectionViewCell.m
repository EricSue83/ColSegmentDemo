//
//  CollectionViewCell.m
//  ColSegmentDemo
//
//  Created by EricSue on 17/05/2018.
//  Copyright © 2018 EricSue. All rights reserved.
//

#import "CollectionViewCell.h"
@interface CollectionViewCell()
@property (nonatomic, strong) UILabel* titleLabel;
@end
@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor purpleColor];
        _titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.contentView.backgroundColor = selected ? [UIColor lightGrayColor]:[UIColor purpleColor];
    _titleLabel.textColor = selected ? [UIColor greenColor]:[UIColor whiteColor];
}

- (void)setTitle:(NSString *)str{
    _titleLabel.text = str;
}
@end
