//
//  BaseShaderProgram.m
//  VT2DShading
//
//  Created by Brendon Duncan on 7/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseShaderProgram.h"




@implementation BaseShaderProgram

@synthesize program = _program;

- (id)init
{
    if (self = [super init]) {
        
        return self;
    }
    
    return nil;
}

- (void)bindAttributeLocations {
    // Do something like:
    // glBindAttribLocation(_shadowProgram, ATTRIB_VERTEX, "position");
    // Must be done prior to linking
    glBindAttribLocation(_program, ATTRIB_POSITION, "aPosition");
};

// Should be called in init method of derived class
- (BOOL)loadShadersWithName:(NSString*) shaderName
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    _program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        NSLog(@"Failed to compile vertex shader of %@ shader program.", shaderName);
        return NO;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        NSLog(@"Failed to compile fragment shader of %@ shader program.", shaderName);
        return NO;
    }
    
    // Attach vertex shader to program.
    glAttachShader(_program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(_program, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    [self bindAttributeLocations];
    
    // Link program.
    if (![self linkProgram:_program]) {
        NSLog(@"Failed to link %@ program.", shaderName);
        
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (_program) {
            glDeleteProgram(_program);
            _program = 0;
        }
        
        return NO;
    }
    
    // Get uniform locations.
    //uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX] = glGetUniformLocation(_shadowProgram, "modelViewProjectionMatrix");
    //uniforms[UNIFORM_NORMAL_MATRIX] = glGetUniformLocation(_shadowProgram, "normalMatrix");
    
    // Release vertex and fragment shaders.
    if (vertShader) {
        glDetachShader(_program, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader) {
        glDetachShader(_program, fragShader);
        glDeleteShader(fragShader);
    }
    
    return YES;
}

- (void)logGLErrorWithMessage:(NSString*) message {
    GLenum error = glGetError();
    if (error != GL_NO_ERROR) {
        
    }
    switch (error) {
        case GL_NO_ERROR:
            // nop
            break;
        case GL_INVALID_ENUM:
            NSLog(@"%@. GL error: invalid enum.", message);
            break;
        case GL_INVALID_VALUE:
            NSLog(@"%@. GL error: invalid value.", message);
            break;
        case GL_INVALID_OPERATION:
            NSLog(@"%@. GL error: invalid operation.", message);
            break;
        case GL_OUT_OF_MEMORY:
            NSLog(@"%@. GL error: out of memory.", message);
            break;
        default:
            NSLog(@"%@. GL error (not recognised).", message);
            break;
    }
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

@end
