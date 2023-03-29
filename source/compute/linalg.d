module compute.linalg;

import std.math;

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
class Vec3 {
    float x;
    float y;
    float z;

    this() {
        x, y, z = 0;
    }
    this(float x, float y, float z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    // Get component at index. 0, 1, 2 and the only permissible values.
    float opIndex(uint index) {
        switch (index) {
            case 0:
                return this.x;
            case 1:
                return this.y;
            case 2:
                return this.z;
            default:
                import std.stdio : writeln;
                writeln("Index Out or bounds!");
                return 0;
        }
    }

    // Length of u
    float length() {
        return sqrt(this.x*this.x + this.y*this.y + this.z*this.z);
    }

    // Unit vector of u
    Vec3 opUnary(string s : "~")() {
        float l = this.length;
        return new Vec3(this.x / l, this.y / l, this.z / l);
    }

    // Adding Vectors
    Vec3 opBinary(string op : "+")(Vec3 vec) {
        return new Vec3(this.x + vec.x, this.y + vec.y, this.z + vec.z);
    }

    // Dot product
    float opBinary(string op : "*")(Vec3 v) {
        return this.x * v.x + this.y * this.y + this.z * v.z;
    }

    // Cross Product
    Vec3 opBinary(string s : "^")(Vec3 vec) {
        return new Vec3(this.y*vec.z - this.z*vec.y, -(this.x*vec.z - this.z*vec.x), this.x*vec.y - this.y*vec.x);
    }
}