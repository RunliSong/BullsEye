//
//  ViewController.m
//  BullsEye
//
//  Created by Runli Song on 14-4-7.
//  Copyright (c) 2014年 James. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController

{
    int currentValue;
    int targetValue;
    int score;
    int round;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad
{
    UIImage *thunbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thunbImageNormal forState:UIControlStateNormal];
    UIImage *thumbImageHighLighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighLighted forState:UIControlStateHighlighted];
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"]
                               resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //currentValue = self.slider.value;
    //targetValue = 1 + arc4random_uniform(100);
    [self startNewGame];
    [self updateLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)startNewRound
{
    round += 1;
    targetValue = 1 + arc4random_uniform(100);
    currentValue = 50;
    self.slider.value = currentValue;
    
}
- (void)startNewGame
{
    score = 0;
    round = 0;
    [self startNewRound];
}
-(void) updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d",targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d",round];
}
-(IBAction)showAlert{
    int difference = abs(targetValue - currentValue);
    int point = 100 - difference;
    
    NSString *title;
    if (difference == 0){
        title = @"Perfect ! ! !";
        point += 100;
    }
    else if (difference < 5){
        title = @"Great ! !";
        point += 50;
    }
    else if (difference < 10)
        title = @"Pretty good !";
    else
        title = @"Not even close...";
    score += point;
    
    NSString *message = [NSString stringWithFormat:@"Your score is: %d points!",point];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

    [alertView show];
    [self startNewRound];
    [self updateLabels];
}
- (IBAction)sliderMoved:(UISlider *)slider
{
    currentValue = lroundf(slider.value);
}
- (IBAction)startOver
{
    [self startNewGame];
    [self updateLabels];
}
- (void)alertView:(UIAlertView *)alertView didDismissButtonIndex:(NSInteger)buttonIndex
{
    [self startNewGame];
    [self updateLabels];
}




@end
