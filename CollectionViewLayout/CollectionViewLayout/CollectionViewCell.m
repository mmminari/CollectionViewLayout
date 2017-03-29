//
//  CollectionViewCell.m
//  CollectionViewLayout
//
//  Created by 김민아 on 2017. 3. 28..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *btnIndex;

@end

@implementation CollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.btnIndex.titleLabel.text = [NSString stringWithFormat:@"%zd", self.cellIndex];
    
}


- (IBAction)touchedIndexButton:(UIButton *)sender
{
    NSLog(@"cellIndex : %zd", self.cellIndex);
}



@end
