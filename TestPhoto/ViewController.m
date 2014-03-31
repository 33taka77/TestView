//
//  ViewController.m
//  TestPhoto
//
//  Created by Aizawa Takashi on 2014/03/31.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)buttonClicked:(id)sender;
- (IBAction)button2Clicked:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage* image = [UIImage imageNamed:@"um_074.jpg"];
    self.imageView.image = image;
    self.imageView.frame = self.view.frame;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    /*
    CGRect rect = self.view.bounds;
    float angle = 90.0 * M_PI / 180;
    CGAffineTransform t1 = CGAffineTransformMakeRotation(angle);
    CGRect currentRect = self.imageView.frame;
    float scalX = rect.size.width / currentRect.size.width;
    float scalY = rect.size.height / currentRect.size.height;
    
    CGAffineTransform t2 = CGAffineTransformMakeScale(scalX, scalY);
    self.imageView.transform = CGAffineTransformConcat(t1,t2);
    self.imageView.frame = rect;
    */ 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    CALayer *layer = self.imageView.layer;
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.toValue = [NSNumber numberWithFloat:M_PI / 2.0];
    animation.duration = 0.2;           // 0.5秒で90度回転
    animation.repeatCount = 1;   // 無限に繰り返す
    animation.cumulative = NO;         // 効果を累積
    [layer addAnimation:animation forKey:@"ImageViewRotation"];
    CABasicAnimation* animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.toValue = [NSNumber numberWithFloat:1.5];
    animation2.duration = 0.2;           // 0.5秒で90度回転
    animation2.repeatCount = 1;   // 無限に繰り返す
    animation2.cumulative = NO;         // 効果を累積
    [layer addAnimation:animation2 forKey:@"ImageViewScale"];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;

}

- (IBAction)button2Clicked:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    float angle = 90.0 * M_PI / 180;
    CGAffineTransform t1 = CGAffineTransformMakeRotation(angle);
    CGRect currentRect = self.imageView.frame;
    float scalX = currentRect.size.height / currentRect.size.width;

    
    CGAffineTransform t2 = CGAffineTransformMakeScale(scalX, scalX);
    self.imageView.transform = CGAffineTransformConcat(t1,t2);
    //self.imageView.transform = CGAffineTransformMakeRotation(0);

    
    [UIView commitAnimations];
    
}

- (void)endAnimation
{
}

@end
