//
//  TimeCollectionViewCell.m
//  WFAssignment
//
//  Created by Zhang Xu on 2/9/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import "TimeCollectionViewCell.h"

@implementation TimeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.borderWidth = 0.5;
    
    self.checkImageView.image = [self.checkImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.checkImageView.tintColor = [UIColor whiteColor];
}


@end
