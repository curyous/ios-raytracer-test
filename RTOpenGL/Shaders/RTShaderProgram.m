//
//  RTShaderProgram.m
//  RTOpenGL
//
//  Created by Brendon Duncan on 16/09/12.
//
//

#import "RTShaderProgram.h"

@implementation RTShaderProgram

@synthesize eyePositionUniformLocation = _eyePositionUniformLocation;
@synthesize screenPositionUniformLocation = _screenPositionUniformLocation;
@synthesize rightUniformLocation = _rightUniformLocation;
@synthesize upUniformLocation = _upUniformLocation;

@synthesize triangleSamplerUniformLocation = _triangleSamplerUniformLocation;

-(id)init {
    if (self = [super init]) {
        [self loadShadersWithName:@"RTShader"];
        
        _eyePositionUniformLocation = glGetUniformLocation(_program, "uEyePosition");
        _screenPositionUniformLocation = glGetUniformLocation(_program, "uScreenPosition");
        _rightUniformLocation = glGetUniformLocation(_program, "uRight");
        _upUniformLocation = glGetUniformLocation(_program, "uUp");
        
        _triangleSamplerUniformLocation = glGetUniformLocation(_program, "uTriangleSampler");
        
        return self;
    }
    
    return nil;
}

- (void)bindAttributeLocations {
    // Do something like:
    // glBindAttribLocation(_shadowProgram, ATTRIB_VERTEX, "position");
    // Must be done prior to linking
    glBindAttribLocation(_program, ATTRIB_POSITION, "aPosition");
    glBindAttribLocation(_program, ATTRIB_TEXCOORD, "aClipSpace");
};

@end
