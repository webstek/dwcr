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
    
    //faceIndices[j].map!(i=>vertices[i-1]) will give the array with the three vertices for the jth triangle in the mesh
    float[][] triangle(uint index) {
        return faceIndices[index].map!(i=>vertices[i-1]).array;
    }
}

