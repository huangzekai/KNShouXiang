//
//  KNAICollectionCell.m
//  KNUnflodTextProject
//
//  Created by kennykhuang on 2023/7/2.
//

#import "KNShouXiangButton.h"
#import "UIView+JKFrame.h"
#import "KNGlobalDefine.h"

#define IMAGE_HEIGHT 48

@implementation KNShouXiangButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    }
    return self;
}

- (void)setup {
    CGFloat x = (self.jk_width - IMAGE_HEIGHT) / 2;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 8, IMAGE_HEIGHT, IMAGE_HEIGHT)];
    _imageView.layer.cornerRadius = _imageView.frame.size.width / 2;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderWidth = 0.5;
    _imageView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.3].CGColor;
    [self addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.jk_bottom, self.jk_width, self.jk_height - _imageView.jk_bottom)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:13];
    _titleLabel.textColor = GRAY_COLOR;
    [self addSubview:_titleLabel];
    
//    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 200, 20)];
//    _descriptionLabel.numberOfLines = 2;
//    _descriptionLabel.font = [UIFont systemFontOfSize:12];
//    _descriptionLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
//    [self.contentView addSubview:_descriptionLabel];
    
    [self setHighlighted:NO];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

@end
