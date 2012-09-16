//
//  RayTracer.m
//  RTOpenGL
//
//  Created by Brendon Duncan on 16/09/12.
//
//

#import "RayTracer.h"


@implementation RayTracer

// GL default is CCW (Counter-clockwise)
GLfloat twoTriangles[30] =
{
    // Data layout is:
    // positionX, positionY, positionZ,  clipSpaceX, clipSpaceY
    -1.0f, -1.0f, 0.0f,  -1.0f, -1.0f,
     1.0f, -1.0f, 0.0f,   1.0f, -1.0f,
    -1.0f,  1.0f, 0.0f,  -1.0f,  1.0f,
    
    -1.0f,  1.0f, 0.0f,  -1.0f,  1.0f,
     1.0f, -1.0f, 0.0f,   1.0f, -1.0f,
     1.0f,  1.0f, 0.0f,   1.0f,  1.0f
};

GLfloat triangleVertices[9] =
{
    -0.5f, 0.5f, 1.0f,
    -0.5f, 0.5f, 0.0f,
     0.5f, 0.5f, 1.0f
};


- (id)init
{
    if (self = [super init]) {
        
        _rtShaderProgram = [[RTShaderProgram alloc] init];
        
        glGenVertexArraysOES(1, &_rtVertexArray);
        glBindVertexArrayOES(_rtVertexArray);
        
        glGenBuffers(1, &_rtVertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _rtVertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, sizeof(twoTriangles), twoTriangles, GL_STATIC_DRAW);
        
        glEnableVertexAttribArray(ATTRIB_POSITION);
        glVertexAttribPointer(ATTRIB_POSITION, 3, GL_FLOAT, GL_FALSE, 20, BUFFER_OFFSET(0));
        
        glEnableVertexAttribArray(ATTRIB_TEXCOORD);
        glVertexAttribPointer(ATTRIB_TEXCOORD, 2, GL_FLOAT, GL_FALSE, 20, BUFFER_OFFSET(12));
        
        glBindVertexArrayOES(0);
        
        _eyePosition = GLKVector3Make(0.0f, -2.0f, 0.5f);
        _screenPosition = GLKVector3Make(0.0f, -1.0f, 0.5f);
        _right = GLKVector3Make(1.0f, 0.0f, 0.0f);
        _up = GLKVector3Make(0.0f, 0.0f, 1.0f);

        
        return self;
    }
    
    return nil;
}


-(void)render
{
    glUseProgram(_rtShaderProgram.program);
    glBindVertexArrayOES(_rtVertexArray);
        
    glUniform3f(_rtShaderProgram.eyePositionUniformLocation, _eyePosition.x, _eyePosition.y, _eyePosition.z);
    glUniform3f(_rtShaderProgram.screenPositionUniformLocation, _screenPosition.x, _screenPosition.y, _screenPosition.z);
    glUniform3f(_rtShaderProgram.rightUniformLocation, _right.x, _right.y, _right.z);
    glUniform3f(_rtShaderProgram.upUniformLocation, _up.x, _up.y, _up.z);
    
    glUniform3fv(_rtShaderProgram.trianglesUniformLocation, 3, triangleVertices);
    
    glDrawArrays(GL_TRIANGLES, 0, 6);
}

@end
