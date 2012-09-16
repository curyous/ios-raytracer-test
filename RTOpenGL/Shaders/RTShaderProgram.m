//
//  RTShaderProgram.m
//  RTOpenGL
//
//  Created by Brendon Duncan on 16/09/12.
//
//

#import "RTShaderProgram.h"

@implementation RTShaderProgram

-(id)init {
    if (self = [super init]) {
        [self loadShadersWithName:@"RTShader"];
        
        //_ambientLightColourUniformLocation = glGetUniformLocation(_program, "uAmbientLightColour");
        //_modelViewProjectionMatrixUniformLocation = glGetUniformLocation(_program, "uModelViewProjectionMatrix");
        //_textureUniformLocation = glGetUniformLocation(_program, "uTexture");
        
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
