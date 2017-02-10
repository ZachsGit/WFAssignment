//
//  TimeTableViewCell.h
//  WFAssignment
//
//  Created by Zhang Xu on 2/9/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeCellDelegate

-(void)timeCellSelectedWithTimeString:(NSString *) timeString;

@end

@interface TimeTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *theCollectionView;
@property (strong, nonatomic) NSString *selectedTimeString;

@property (nonatomic, weak) id <TimeCellDelegate> delegate;

@end
