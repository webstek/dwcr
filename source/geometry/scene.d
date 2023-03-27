module geometry.scene;

import geometry.model;

class Scene {
    Model[] modelList = [];

    void add(Model model) {
        modelList ~= model;
    }
}