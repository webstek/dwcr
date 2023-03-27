module rendering.render;

import bindbc.sdl;
import std.stdio;

// Window Constants
const int width = 640;
const int height = 480;

// SDL Constants
SDL_Window* window = null;
SDL_Surface* screenSurface = null;

// Array to write values to
float[width][height][3] canvas;

import geometry.scene;

void render_loop(Scene scene) {
    // Transform vertices to screen-space
    // Clipping
    // Project vertices to the screen
    // Change to triangles
    // Rasterize the triangles
}

bool initialize() {
    // Initialize SDL
    if (!SDL_Init(SDL_INIT_VIDEO)) {
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

    return true;
}

void close() {
    SDL_FreeSurface(screenSurface);
    SDL_DestroyWindow(window);
    SDL_Quit();
}
