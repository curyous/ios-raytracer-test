//
//  Shader.vsh
//  RTOpenGL
//
//  Created by Brendon Duncan on 24/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

attribute vec4 aPosition;
//attribute vec2 aScreenPosition;

//varying mediump vec2 vScreenPosition

void main()
{
    //vScreenPosition = aScreenPosition;
    gl_Position = aPosition;
}
