import render = rendering.render;
import geometry.scene, geometry.model;
import bindbc.sdl;

int main() {
    if (!render.initialize()) return 1;
    Scene world = new Scene();
    world.add(new Model("./assets/teapot.obj"));

    // Main loop
    SDL_Event event;
    mainLoop: while (true) {
        // Handle events -- change to switch statement when adding in other events
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) break mainLoop;
        }

        // Set geometry for renderer to render
        render.worldToImageTransform(world);

        // Rasterize the scene
        render.rasterize(world);
    }

    render.close();
    return 0;
}