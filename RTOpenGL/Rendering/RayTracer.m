//
//  RayTracer.m
//  RTOpenGL
//
//  Created by Brendon Duncan on 16/09/12.
//
//

#import "RayTracer.h"


#define TRI_TEX_SIZE 256

@implementation RayTracer



- (id)init
{
    if (self = [super init]) {
        
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
        
        
        
        _eyePosition = GLKVector3Make(0.0f, -2.0f, 0.5f);
        _screenPosition = GLKVector3Make(0.0f, -1.0f, 0.5f);
        _right = GLKVector3Make(1.0f, 0.0f, 0.0f);
        _up = GLKVector3Make(0.0f, 0.0f, 1.0f);

        // Triangle data
        GLfloat triangleData[TRI_TEX_SIZE * TRI_TEX_SIZE * 3];
        
        /*for (int i = 0; i < TRI_TEX_SIZE * TRI_TEX_SIZE * 3; i++) {
            triangleData[i] = 0.15f;
        }*/
        
        // Back
        triangleData[ 0] = -0.5f; triangleData[ 1] = 0.5f; triangleData[2] = 1.0f;
        triangleData[ 3] = -0.5f; triangleData[ 4] = 0.5f; triangleData[5] = 0.0f;
        triangleData[ 6] =  0.5f; triangleData[ 7] = 0.5f; triangleData[8] = 0.0f;
        
        triangleData[ 9] = -0.5f; triangleData[10] = 0.5f; triangleData[11] = 1.0f;
        triangleData[12] =  0.5f; triangleData[13] = 0.5f; triangleData[14] = 0.0f;
        triangleData[15] =  0.5f; triangleData[16] = 0.5f; triangleData[17] = 1.0f;
        
        
        // Set up texture to contain triangle data
        glGenTextures(1, &_triangleTexture);
        glBindTexture(GL_TEXTURE_2D, _triangleTexture);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, TRI_TEX_SIZE, TRI_TEX_SIZE, 0, GL_RGB, GL_FLOAT, triangleData);
        
        glBindTexture(GL_TEXTURE_2D, 0);
        glBindVertexArrayOES(0);
        
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
    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _triangleTexture);
    glUniform1i(_rtShaderProgram.triangleSamplerUniformLocation, 0);
    
    glDrawArrays(GL_TRIANGLES, 0, 6);
}

@end
