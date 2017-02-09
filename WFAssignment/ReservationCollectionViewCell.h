//
//  ReservationCollectionViewCell.h
//  WFAssignment
//
//  Created by Zhang Xu on 2/8/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservationCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durantionLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *rescheduleButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end
