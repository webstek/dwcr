module rendering.render;

import bindbc.sdl;
import std.stdio;

// Window Constants
const int width = 640;
const int height = 480;

// SDL Constants
SDL_Window* window = null;
SDL_Surface* screenSurface = null;
SDL_Surface* bufferSurface = null;

// Array to write values to
// float[width][height][3] canvas;

import geometry.scene;

void render_loop(Scene scene) {
    // Transform vertices to screen-space
    // Clipping
    // Project vertices to the screen
    // Change to triangles
    // Rasterize the triangles

    // Until I write an algorithm to draw a triangle
    SDL_SetSurfaceRLE(bufferSurface, 1);
    SDL_LockSurface(bufferSurface);

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