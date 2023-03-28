module rendering.render;

import bindbc.sdl;
import std.stdio;

import geometry.scene;

// Window Constants
const int width = 640;
const int height = 480;

// SDL Constants
SDL_Window* window = null;
SDL_Surface* screenSurface = null;
SDL_Surface* bufferSurface = null;

/+
+ Does the following transformations of coordinates:
+ World       ->       View       ->       Clip        ->       Normalized       ->       Image
+       view transform   projection transform  perspective divide         screen transform
+/
void worldToImageTransform(Scene scene) {

}

void rasterize(Scene scene) {
    // Assume vertices are in image coordinates
    // 2. Change to triangles
    // 3. Rasterize each triangle

    // Prep buffer surface for drawing to
    SDL_SetSurfaceRLE(bufferSurface, 1);
    SDL_LockSurface(bufferSurface);

    // Until I finish the transform function, draw a test circle
    for (int v = 0; v < bufferSurface.w - 1; v++) {
        for (int u = 0; u < bufferSurface.h - 1; u++) {
            if ((u - width / 2) * (u - width / 2) + (v - height / 2) * (v - height / 2) < 100 * 100) {
                setPixelColor(bufferSurface, u, v, 130, 130, 200);
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
