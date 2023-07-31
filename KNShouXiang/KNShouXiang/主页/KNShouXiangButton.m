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
        self.layer.cornerRadius = 10;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.hidden = NO;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:26];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.hidden = NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat space = 30;
    CGFloat width = self.jk_height - 2 * 20;
    self.imageView.frame = CGRectMake(space, 20, width, width);
    
    self.titleLabel.frame = CGRectMake(self.imageView.jk_right + 8, space, self.jk_width - width - space * 3, self.jk_height - space * 2);
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    if (highlighted) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    } else {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    }
}

@end
