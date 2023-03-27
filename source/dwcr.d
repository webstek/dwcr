import render = rendering.render;
import geometry.scene, geometry.model;
import bindbc.sdl;

void main() {
    render.initialize();
    Scene world;
    world.add(new Model("./assets/teapot.obj"));

    // Main loop
    SDL_Event event;
    mainLoop: while (true) {
        // Handle events -- change to switch statement when adding in other events
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) break mainLoop;
        }

        // Set geometry for renderer to render
        // geometry_loop();
        // Render geometry
        render.render_loop(world);
    }

    render.close();
}