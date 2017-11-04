//
//  HomeTableViewCell.m
//  ExampleOne
//
//  Created by Prem Budhwani on 04/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import "HomeTableViewCell.h"

#define TOP_MARGIN 10.0
#define RIGHT_MARGIN -10.0
#define BOTTOM_MARGIN -10.0
#define LEFT_MARGIN 10.0
#define IMG_WIDTH 50.0
#define IMG_HEIGHT 50.0

@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Heading label is self sizing i.e. it can extend to multiple rows
        self.lblHeading = [[UILabel alloc]init];
        self.lblHeading.backgroundColor = [UIColor redColor];
        self.lblHeading.numberOfLines = 0;
        self.lblHeading.font = [UIFont boldSystemFontOfSize:20.0];
        self.lblHeading.textAlignment = NSTextAlignmentCenter;
        
        // Thumbnail Image is of fixed size which is 50 x 50
        self.imgThumbnail = [[UIImageView alloc]initWithFrame:CGRectZero];
        
        // Description label is self sizing i.e. it can extend to multiple rows. Also, at least it will take the height of 50 points if there is lesser content.
        self.lblDescription = [[UILabel alloc]init];
        self.lblDescription.numberOfLines = 0;
        self.lblDescription.font = [UIFont systemFontOfSize:16.0];
        
        [self.contentView addSubview:self.lblHeading];
        [self.contentView addSubview:self.imgThumbnail];
        [self.contentView addSubview:self.lblDescription];
        
        [self setUpAutoLayoutConstraints];
    }
    return self;
}

- (void)setUpAutoLayoutConstraints
{
    
    [self.contentView removeConstraints:self.contentView.constraints];        //Remove all constraints first
    
    //Set up AutoLayout Constraints for lblHeading
    self.lblHeading.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Top Margin Constraint
    NSLayoutConstraint *topConstraintHeading = [NSLayoutConstraint constraintWithItem:self.lblHeading attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:TOP_MARGIN];
    
    //Right Margin Constraint
    NSLayoutConstraint *rightConstraintHeading = [NSLayoutConstraint constraintWithItem:self.lblHeading attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:RIGHT_MARGIN];
    
    //Left Margin Constraint
    NSLayoutConstraint *leftConstraintHeading = [NSLayoutConstraint constraintWithItem:self.lblHeading attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:LEFT_MARGIN];
    
    [self.contentView addConstraint:topConstraintHeading];
    [self.contentView addConstraint:rightConstraintHeading];
    [self.contentView addConstraint:leftConstraintHeading];
    
    //Set up Autolayout constraints for imgThumbnail
    self.imgThumbnail.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Top Margin Constraint
    NSLayoutConstraint *topConstraintImg = [NSLayoutConstraint constraintWithItem:self.imgThumbnail attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lblHeading attribute:NSLayoutAttributeBottom multiplier:1.0 constant:TOP_MARGIN];
    
    //Left Margin Constraint
    NSLayoutConstraint *leftConstraintImg = [NSLayoutConstraint constraintWithItem:self.imgThumbnail attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:LEFT_MARGIN];
    
    //Image Width Constraint
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.imgThumbnail attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:IMG_WIDTH];
    
    //Image Height Constraint
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.imgThumbnail attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:IMG_HEIGHT];
    
    [self.contentView addConstraint:leftConstraintImg];
    [self.contentView addConstraint:topConstraintImg];
    [self.contentView addConstraint:widthConstraint];
    [self.contentView addConstraint:heightConstraint];
    
    
    //Set up Autolayout constraints for lblDescription
    self.lblDescription.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Top Margin Constraint
    NSLayoutConstraint *topConstraintDescription = [NSLayoutConstraint constraintWithItem:self.lblDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lblHeading attribute:NSLayoutAttributeBottom multiplier:1.0 constant:TOP_MARGIN];
    
    //Right Margin Constraint
    NSLayoutConstraint *rightConstraintDescription = [NSLayoutConstraint constraintWithItem:self.lblDescription attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:RIGHT_MARGIN];
    
    //Left Margin Constraint
    NSLayoutConstraint *leftConstraintDescription = [NSLayoutConstraint constraintWithItem:self.lblDescription attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgThumbnail attribute:NSLayoutAttributeRight multiplier:1.0 constant:LEFT_MARGIN];
    
    //Bottom Margin Constraint
    NSLayoutConstraint *bottomConstraintDescription = [NSLayoutConstraint constraintWithItem:self.lblDescription attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:BOTTOM_MARGIN];
    
    //Minimum Height Constraint
    NSLayoutConstraint *minHeightConstraint = [NSLayoutConstraint constraintWithItem:self.lblDescription attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:IMG_HEIGHT];
    
    [self.contentView addConstraint:topConstraintDescription];
    [self.contentView addConstraint:rightConstraintDescription];
    [self.contentView addConstraint:leftConstraintDescription];
    [self.contentView addConstraint:bottomConstraintDescription];
    [self.contentView addConstraint:minHeightConstraint];
}

@end
