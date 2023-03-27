module geometry.scene;

import geometry.model;

class Scene {
    Model[] modelList;

    this() {
        this.modelList = [];
    }

    void add(Model model) {
        modelList ~= model;
    }
}