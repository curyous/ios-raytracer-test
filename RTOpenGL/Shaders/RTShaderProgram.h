//
//  RTShaderProgram.h
//  RTOpenGL
//
//  Created by Brendon Duncan on 16/09/12.
//
//

#import "BaseShaderProgram.h"

@interface RTShaderProgram : BaseShaderProgram
{
    GLint _eyePositionUniformLocation;
    GLint _screenPositionUniformLocation;
    GLint _rightUniformLocation;
    GLint _upUniformLocation;
    
    GLint _trianglesUniformLocation;
}

@property (readonly) GLint eyePositionUniformLocation;
@property (readonly) GLint screenPositionUniformLocation;
@property (readonly) GLint rightUniformLocation;
@property (readonly) GLint upUniformLocation;

@property (readonly) GLint trianglesUniformLocation;

@end
