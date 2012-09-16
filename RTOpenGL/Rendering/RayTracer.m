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
        
        return self;
    }
    
    return nil;
}


-(void)render
{
    glUseProgram(_rtShaderProgram.program);
    glBindVertexArrayOES(_rtVertexArray);
    glDrawArrays(GL_TRIANGLES, 0, 6);
}

@end
