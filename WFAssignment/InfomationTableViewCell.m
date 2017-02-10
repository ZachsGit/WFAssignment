//
//  InfomationTableViewCell.m
//  WFAssignment
//
//  Created by Zhang Xu on 2/9/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import "InfomationTableViewCell.h"

@implementation InfomationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _sizeButton.layer.cornerRadius = 5;
    _sizeButton.layer.masksToBounds = YES;
    _sizeButton.layer.borderWidth = 1;
    _sizeButton.layer.borderColor = [UIColor darkGrayColor].CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
