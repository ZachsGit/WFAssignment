//
//  MonthTableViewCell.h
//  WFAssignment
//
//  Created by Zhang Xu on 2/9/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MonthCellDelegate

-(void)monthCellSelectedWithDateString:(NSString *) dateString;

@end

@interface MonthTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *theCollectionView;

@property (strong, nonatomic) NSString *dateString;

@property (nonatomic, weak) id <MonthCellDelegate> delegate;

@end
