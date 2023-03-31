module compute.linalg;

import std.math;
import std.algorithm;

/*
    Class representing a vector in R3
    
    Vec3 u, v = new Vec3(x, y, z);

    Unary operators:
    Access the components with u[0], u[1], u[2].
    u.length is the length of u
    ~u is the unit vector of u

    Binary Operators:
    u+v is the sum of vectors u and v
    u*v is the dot product of u and v
    u^v is the cross product of u and v


    Future work:
    - Add method so object can automatically print the x,y,z components instead of compute.linalg.Vec3 is writeln
*/
template vec(uint N) {
    float[N] components = 0;

    this(float[N] vals) {
        foreach (i ; 0 .. N) {
            components[i] = vals[i];
        }
    }

    // Component operator []
    // u[0] for the first entry
    // slices do not work
    float opIndex(uint index) {
        return components[index];
    }

    // Length of u
    // u.length
    float length() {
        float length = 0;
        foreach (e ; components) {
            length += e*e;
        }
        return sqrt(length);
    }

    // Unit vector of u
    // ~u
    vec!(N) opUnary(string s : "~")() {
        float l = this.length;
        float[N] unitVecComponents;
        foreach (i ; 0 .. N) {
            unitVecComponents[i] = components[i] / l;
        }
        return new vec!(N)(unitVecComponents);
    }

    // Adding Vectors
    // u + v
    vec!(N) opBinary(string op : "+")(vec!(N) vec) {
        float[N] sumComponents;
        foreach (i ; 0 .. N) {
            sumComponents[i] = components[i] + vec[i];
        }
        return new vec!(N)(sumComponents);
    }

    // Dot product
    // u * v
    float opBinary(string op : "*")(vec!(N) vec) {
        float dotProduct = 0;
        foreach (i ; 0 .. N) {
            dotProduct += components[i] * vec[i];
        }
    }

    // Cross Product
    // u ^ v
    vec!(N) opBinary(string s : "^")(vec!(N) vec) {
        // Must be a vec!(3)
        if (N != 3) {
            writeln("Trying to cross a non-vec!(3). Original vector returned");
            return this;
        }
        return new vec!(3)(  this[1]*vec[2] - this[2]*vec[1], 
                           -(this[0]*vec[2] - this[2]*vec[0]), 
                             this[0]*vec[1] - this[1]*vec[0]);
    }
}