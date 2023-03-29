module rendering.render;

import bindbc.sdl;
import std.stdio;
import std.array;
import std.algorithm;
import std.math.rounding : floor, ceil;
import std.conv : to;

import geometry.scene;
import rendering.materials;

// Window Constants
const int width = 640;
const int height = 480;

// SDL Constants
SDL_Window* window = null;
SDL_Surface* screenSurface = null;
SDL_Surface* bufferSurface = null;

// Transforms the world coordinates to the view coordinates
void worldToView(Scene scene) { // Also needs a camera when I implement it

}

void rasterize(Scene scene) {
    // Assume the vertices are in View coordinates

    /* Our steps are:
    For every triangle in each model:
      Perspective projection
      Compute interpolation matrix: allows projected coords to 3d barycentric
      Compute bounding box and clip to screen limits?
      For all pixels x,y in the box:
        Test edge functions
        If all edges pass:
          compute barycentrics using interpolation matrix
          interpolate z from vertices
          if z < zbuffer[x,y]:
            interpolate uv coordinates from vertices
            look up texture color k
            Framebuffer[x,y] = k
    */

    // Prep buffer surface for drawing to
    SDL_SetSurfaceRLE(bufferSurface, 1);
    SDL_LockSurface(bufferSurface);

    // Draw each triangle with a simple algorithm
    foreach(model ; scene.modelList) {
        foreach(tri ; model.mesh.triangles()) {
            // perspective projection
            // interpolation matrix

            // Setup edge equations

            // for each pixel in the bounding box of the triangle
            int ymin = floor(min(tri[0][1], tri[1][1], tri[2][1])).to!int;
            int ymax = ceil(max(tri[0][1], tri[1][1], tri[2][1])).to!int;
            int xmin = floor(min(tri[0][0], tri[1][0], tri[2][0])).to!int;
            int xmax = ceil(max(tri[0][0], tri[1][0], tri[2][0])).to!int;
            foreach (y ; ymin..ymax) {
                foreach (x ; xmin..xmax) {
                    // Test edge equations
                        // compute barycentric coordinates from x,y
                        // interpolate z value for each x,y
                        // if z < zbuffer[x,y]:
                            // interpolate uv coordinates from xy
                            // look up color from material
                            // setPixelColor(bufferSurface, u, v, color.r, color.g, color.b);
                }

            }
        }
    }
    
    SDL_UnlockSurface(bufferSurface);

    SDL_BlitSurface(bufferSurface, null, screenSurface, null);
    SDL_UpdateWindowSurface(window);
}

void setPixelColor(SDL_Surface* surface, uint u, uint v, ubyte r, ubyte g, ubyte b) {
    uint* pixels = cast(uint*) surface.pixels;
    pixels[v * surface.w + u] = SDL_MapRGB(surface.format, r, g, b);
}

bool initialize() {
    loadSDL();
    // Initialize SDL
    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        writeln("Failed to Initialize SDL! ", SDL_GetError());
        return false;
    }

    // Create the SDL Window
    window = SDL_CreateWindow("D Watercolor Renderer", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
        width, height, SDL_WINDOW_SHOWN);
    if (window == null) {
        writeln("Failed to create Window! ", SDL_GetError());
        return false;
    }

    // Create the surface we will write to when rendering a scene
    screenSurface = SDL_GetWindowSurface(window);
    bufferSurface = SDL_CreateRGBSurface(SDL_SWSURFACE, width, height, 32,
        0xff000000, 0x00ff0000, 0x0000ff00, 0x000000ff);

    return true;
}

void close() {
    SDL_FreeSurface(screenSurface);
    SDL_DestroyWindow(window);
    SDL_Quit();
}
