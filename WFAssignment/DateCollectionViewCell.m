//
//  DateCollectionViewCell.m
//  WFAssignment
//
//  Created by Zhang Xu on 2/9/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import "DateCollectionViewCell.h"

@implementation DateCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.borderWidth = 0.5;
    
    self.checkmarkImageView.image = [self.checkmarkImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.checkmarkImageView.tintColor = [UIColor whiteColor];

}

@end
