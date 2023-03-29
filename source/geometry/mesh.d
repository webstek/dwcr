module geometry.mesh;

import std.stdio, std.array;
import std.conv : to;
import std.range : drop;
import std.algorithm.iteration : map;

class Mesh {
    // A mesh has an array of vertices and an array of indices for that array that form the triangles
    float[][] vertices;
    uint[][] faceIndices;
    int numTri;

    this() {}
    this(string meshDataPath) {
        // takes the path to a .obj file
        File meshData = File(meshDataPath);

        foreach (line; meshData.byLine()) {
            if (line[0] == 'v') vertices ~= line.split.drop(1).map!(to!float).array;
            if (line[0] == 'f') faceIndices ~= line.split.drop(1).map!(to!uint).array;
        }

        numTri = faceIndices.length.to!int;
    }
    
    // Returns the array of triangles which are arrays of the vertices
    auto triangles() {
        return faceIndices.map!(map!(i=>vertices[i-1])).array;
    }
}

