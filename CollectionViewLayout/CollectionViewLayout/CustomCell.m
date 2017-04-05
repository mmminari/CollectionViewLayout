//
//  CustomCell.m
//  CollectionViewLayout
//
//  Created by 김민아 on 2017. 4. 5..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()

@property (weak, nonatomic) IBOutlet UILabel *lbIndex;

@end

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setIndexLabel:(NSInteger)index
{
    self.lbIndex.text = [NSString stringWithFormat:@"%zd", index];
}
@end
