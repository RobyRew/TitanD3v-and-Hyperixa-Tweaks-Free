#import "TDConfettiView.h"

@interface TDConfettiView ()

@property (nonatomic, strong) CAEmitterLayer *emitter;
@property (nonatomic, assign) BOOL isRaining;

@end

@implementation TDConfettiView

#pragma mark - Properties

-(void)setBirthRate:(CGFloat)birthRate
{
    if(birthRate == _birthRate)
        return;
    
    _birthRate = birthRate;
    self.emitter.birthRate = _birthRate;
}

#pragma mark - Lifecycle

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self)
        return nil;
    
    [self setupConfetti];

    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self)
        return nil;
    
    [self setupConfetti];
    
    return self;
}

-(void)setupConfetti
{
    self.colors = @[[UIColor colorWithRed:0.95 green:0.40 blue:0.27 alpha:1.0],
                    [UIColor colorWithRed:1.00 green:0.78 blue:0.36 alpha:1.0],
                    [UIColor colorWithRed:0.48 green:0.78 blue:0.64 alpha:1.0],
                    [UIColor colorWithRed:0.30 green:0.76 blue:0.85 alpha:1.0],
                    [UIColor colorWithRed:0.58 green:0.39 blue:0.55 alpha:1.0]];
    
    self.intensity = 1.5;
    self.birthRate = 1;
    self.type = TDConfettiTypeConfetti;
}


#pragma mark - Public

-(void)startConfetti
{
    //*
    if(self.emitter == nil) {
        self.emitter = CAEmitterLayer.new;
        self.emitter.emitterPosition = CGPointMake(self.center.x, 0);
        self.emitter.emitterShape = kCAEmitterLayerLine;
        self.emitter.emitterSize = CGSizeMake(self.bounds.size.width, 1);

        
        NSMutableArray *cells = NSMutableArray.new;
        for (UIColor *color in self.colors) {
            [cells addObject:[self cellWithColor:color]];
        }
        
        self.emitter.emitterCells = cells;
        [self.layer addSublayer:self.emitter];
    }

    self.emitter.birthRate = self.birthRate;
    self.isRaining = YES;
}

-(void)stopConfetti
{
    if(self.emitter)
        self.emitter.birthRate = 0;
    
    self.isRaining = NO;
}

#pragma mark - Private

-(CAEmitterCell *)cellWithColor:(UIColor *)color
{
    CAEmitterCell *confetti = [CAEmitterCell new];
    
    confetti.birthRate = 6.0 * self.intensity / 2;
    confetti.lifetime = 14.0 * self.intensity * 2.2;
    confetti.lifetimeRange = 0;
    confetti.color = color.CGColor;
    confetti.velocity = (CGFloat)350.0 * self.intensity / 2.3;
    confetti.velocityRange = (CGFloat)80.0 * self.intensity;
    confetti.emissionLongitude = (CGFloat)M_PI;
    confetti.emissionRange = (CGFloat)M_PI_4;
    confetti.spin = (CGFloat)3.5 * self.intensity;
    confetti.spinRange = (CGFloat)4.0 * self.intensity;
    confetti.scaleRange = (CGFloat)self.intensity;
    confetti.scaleSpeed = (CGFloat)(-0.1 * self.intensity);
    
    confetti.contents = (id)[[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Confetti/diamond.png"] CGImage];
    
    return confetti;
}

@end
