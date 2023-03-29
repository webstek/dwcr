module geometry.model;

import geometry.mesh;
import rendering.materials;

class Model {
    // A model is a mesh and a material together
    Mesh mesh;
    Material material;

    this(string meshDataPath) {
        this.mesh = new Mesh(meshDataPath);
    }
}