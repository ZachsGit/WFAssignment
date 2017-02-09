//
//  ReservationCollectionViewCell.m
//  WFAssignment
//
//  Created by Zhang Xu on 2/8/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import "ReservationCollectionViewCell.h"

@implementation ReservationCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.cancelButton.layer.cornerRadius = 5;
    self.cancelButton.layer.masksToBounds = YES;
    self.rescheduleButton.layer.cornerRadius = 5;
    self.rescheduleButton.layer.masksToBounds = YES;
}

@end
