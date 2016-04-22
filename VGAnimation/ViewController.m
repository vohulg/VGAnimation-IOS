//
//  ViewController.m
//  VGAnimation
//
//  Created by Admin on 4/20/16.
//  Copyright © 2016 vohulg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray* arrSqwer;

@property (strong, nonatomic) NSArray* arrOptions;

@property (strong, nonatomic) NSMutableArray* positionArray;

//@property (strong, nonatomic) NSMutableDictionary* positonDictionary;

@property (strong, nonatomic) NSMutableArray* colorArr;

@property (strong, nonatomic) NSMutableArray* centerPointArr;

@property (strong, nonatomic) NSArray* imageArr;

enum VGAnimationDirectionMove {
    VGAnimationDirectionMoveForward,
    VGAnimationDirectionMoveBack

};

-(NSInteger) getDirectionMove;


@end



@implementation ViewController

-(void) drawSqwers:(NSArray*)arrSqwer colors:(NSMutableArray*)colorArr superView:(UIView*)view centerPointArr:(NSMutableArray*)centerPointArr
{
    
    CGFloat x = 0;
    CGFloat y = 0;
  
    for (UIImageView* viewItem in arrSqwer) {
        
        
        switch ([arrSqwer indexOfObject:viewItem]) {
            case 0:
                x = CGRectGetWidth(viewItem.frame) / 2;
                y = CGRectGetHeight(viewItem.frame) / 2;
                 //[viewItem setImage:[UIImage imageNamed:@"1.png"]];
                
                break;
                
            case 1:
                x = CGRectGetWidth(view.frame) - CGRectGetWidth(viewItem.frame) / 2;
                y = CGRectGetHeight(viewItem.frame) / 2;
                 //[viewItem setImage:[UIImage imageNamed:@"2.png"]];
                break;
                
            case 2:
                x = CGRectGetWidth(view.frame) - CGRectGetWidth(viewItem.frame) / 2;
                y = CGRectGetHeight(view.frame) - CGRectGetHeight(viewItem.frame) / 2;
                 //[viewItem setImage:[UIImage imageNamed:@"3.png"]];
                break;
                
            case 3:
                x = CGRectGetWidth(viewItem.frame) / 2;
                y = CGRectGetHeight(view.frame) - CGRectGetHeight(viewItem.frame) / 2;
                 //[viewItem setImage:[UIImage imageNamed:@"4.png"]];
                break;
                
                
            default:
                break;
        }
        
        
        NSInteger position = [arrSqwer indexOfObject:viewItem];
        
        viewItem.tag = position;
        //viewItem.backgroundColor = [colorArr objectAtIndex:position];
        
       
        
        viewItem.center = CGPointMake(x, y);
        
        [centerPointArr addObject:NSStringFromCGPoint(CGPointMake(x, y)) ];
        
       
        
        [self.positionArray addObject:[NSNumber numberWithInt:position]];
        
        
        
    }
    
}

-(void)printViewInfo:(UIView*)viewFigur
{
  NSLog(@"color: %@ position: %d center %@   \n",
        viewFigur.backgroundColor,
        viewFigur.tag,
        NSStringFromCGPoint(viewFigur.center)
        );


}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.centerPointArr = [[NSMutableArray alloc]init];
    
    self.positionArray = [[NSMutableArray alloc]init];
    
    self.arrOptions = [[NSArray alloc]initWithObjects:
                       [NSNumber numberWithInteger:UIViewAnimationOptionCurveEaseIn ],
                       [NSNumber numberWithInteger:UIViewAnimationOptionCurveEaseInOut ],
                       [NSNumber numberWithInteger:UIViewAnimationOptionCurveEaseOut ],
                       [NSNumber numberWithInteger:UIViewAnimationOptionCurveLinear ],
                       nil];
    
    self.colorArr = [NSMutableArray arrayWithObjects:
                      [UIColor redColor],
                      [UIColor greenColor],
                      [UIColor yellowColor],
                      [UIColor blueColor],
                      nil];
    
     self.imageArr = [NSArray arrayWithObjects:
                                [UIImage imageNamed:@"1.png" ],
                                [UIImage imageNamed:@"2.png" ],
                                [UIImage imageNamed:@"3.png" ],
                                [UIImage imageNamed:@"4.png" ], nil];
                                  
                                  
    
    
}

-(void)startAnimate
{
    /*
    for (UIView* viewItem in self.arrSqwer)
     {
         [self printViewInfo:viewItem];
     }
     */
    
    
    NSInteger index = 0;
    
    NSInteger direction = [self getDirectionMove];
    NSInteger lastView = 0;
    
    for (UIView* viewItem in self.arrSqwer) {
        
        if ([self.arrSqwer objectAtIndex:index] == [self.arrSqwer lastObject]  )
        {
            lastView = 1;
        }
        
        NSNumber* item = [self.arrOptions objectAtIndex:index];
        NSInteger option = item.integerValue ;
        
        
        [self animeViewStudent:viewItem
              centerPOintArray:self.centerPointArr
                       options:option
                         delay:0
                      duration:5
                     direction:direction
                      lastView:lastView
         ];
        
        //NSInteger option = item.integerValue | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
        
        /*
         
         [self animeViewOption:viewItem
         options:option
         delay:0
         duration:10];
         
         */
        
        index++;
        
    }
    
    
    




}

-(void)viewDidAppear:(BOOL)animated
{
    
    [self drawSqwers:self.arrSqwer colors:self.colorArr superView:self.view centerPointArr:self.centerPointArr];
    [self startAnimate];
}

-(NSInteger) getNextPosition:(NSInteger) currPos direction:(NSInteger)direction
{
    //1 get current position
    NSInteger nextPos = NSIntegerMax;
    
    // forward move
    if (direction == VGAnimationDirectionMoveForward)
    {
        if (currPos == 3) {
            nextPos = 0;
        }
        else
            nextPos = currPos + 1;
    }
    
    // back move
    else if (direction == VGAnimationDirectionMoveBack)
    {
        if (currPos == 0) {
            nextPos = 3;
        }
        else
            nextPos = currPos - 1;

    }
    
    
    
    
    // 2 get view with next position
    
    
    return nextPos;


}


-(void) animeViewStudent:(UIView*) viewFigure
                  centerPOintArray:centerPointArr
                  options:(UIViewAnimationOptions) options
                  delay:(NSInteger)delay
                  duration:(NSInteger)duration
                  direction:(NSInteger) direction
                  lastView:(NSInteger) lastView
{
    
    
    
    [UIView animateWithDuration:duration
                          delay:delay
                        options:(options)
                     animations:^{
                         
                         
                         
                        // 1 Get next position
                         NSInteger nextPos = [self getNextPosition:viewFigure.tag direction:direction];
                         
                         //2 change by view to new position
                         viewFigure.tag = nextPos;
                         
                         //3 get cgpoint for nextPosition
                         
                         NSString* nextCGPointStr = [centerPointArr objectAtIndex:nextPos];
                         CGPoint nextPosition = CGPointFromString(nextCGPointStr);
                          //NSLog(@"next position : %@ \n", nextCGPointStr);
                         
                         //4. move figure
                         viewFigure.center = nextPosition;
                         
                         //5. change color
                         //viewFigure.backgroundColor = [self.colorArr objectAtIndex:nextPos];
                         
                         //6. change picture here
                         if ([viewFigure isKindOfClass:[UIImageView class]]) {
                             
                             UIImageView* imageView = (UIImageView*)viewFigure;
                             imageView.animationImages = self.imageArr;
                             imageView.animationDuration = 3;
                             [imageView startAnimating];
                             
                             
                             
                         }
                         
                                            }
                     completion:^(BOOL finished) {
                         
                         NSLog(@"\n\n completion result: %d \n\n", finished);
                         
                         if (lastView) {
                             [self startAnimate];
                         }
                         
                         
                        
                     }];




}


-(void) animeViewOption:(UIView*) viewFigure
                        options:(UIViewAnimationOptions) options
                        delay:(NSInteger)delay
                        duration:(NSInteger)duration

{
    
    
    [UIView animateWithDuration:duration
                          delay:delay
                          options:(options)
                           animations:^{
                               
                               CGFloat widthView = CGRectGetWidth(self.view.frame);
                               CGFloat widthSqwer = CGRectGetWidth(viewFigure.frame);
                               CGFloat newX = widthView - widthSqwer / 2.f ;
                               CGFloat newY = viewFigure.center.y;
                               
                               viewFigure.center = CGPointMake(newX, newY);
                               
                               viewFigure.backgroundColor = [self randomColor];
                           }
                           completion:^(BOOL finished) {
                               
                               NSLog(@"%hhd", finished);
                               ;
                           }];
   
}


-(void) animeView:(UIView*) viewFigure
{
    
    [UIView animateWithDuration:1 animations:^{
        
        
        CGFloat widthView = CGRectGetWidth(self.view.frame);
        CGFloat widthSqwer = CGRectGetWidth(viewFigure.frame);
        CGFloat newX = widthView - widthSqwer / 2.f ;
        CGFloat newY = viewFigure.center.y;
        
        viewFigure.center = CGPointMake(newX, newY);
        
        
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIColor*) randomColor{
    return[UIColor colorWithRed:[self getRandomFloat] green:[self getRandomFloat]  blue:[self getRandomFloat] alpha:1];
    
}

-(CGFloat)getRandomFloat{
    CGFloat ret = (float)(arc4random() % 256) / 255;
    return ret;
}

-(NSInteger) getDirectionMove
{
    return arc4random() % 2;

}


@end
