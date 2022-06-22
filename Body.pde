// import java.lang.Math;
public class Body{
    //variables for body class
    PVector pos, vel, acc;
    float mass, rad;
    ArrayList<PVector> past;
    int pastN;
    //Constructor takes floats for position, velocity and mass
    Body(float x, float y, float vx, float vy, float m){
        pos = new PVector(x, y);
        vel = new PVector(vx, vy);
        acc = new PVector();
        mass = m;
        double d = (double)mass;
        rad = (float)(Math.sqrt(d) * 2);
        past = new ArrayList<PVector>();
        pastN = 25;
    }
    //functions for body class are listed alphabetically

    //Takes a PVector argument and adds it to acceleration after taking our mass into account
    void applyForce(PVector force){
        PVector f = PVector.div(force, mass);
        acc.add(f);
    }
    //Takes another body object and attracts them to us taking both mass' into account
    void attract(Body other){
        PVector force = PVector.sub(pos, other.pos);
        float distanceSq = force.magSq();
        if (distanceSq < 100){
            distanceSq = 100;
        }else if (distanceSq > 1000){
            distanceSq = 1000;
        }
        int G = 2;
        float strength = (G * (mass * other.mass)) / distanceSq;
        force.setMag(strength);
        other.applyForce(force);
    }
    //Display the body and its past positions
    void show(){
        stroke(255);
        strokeWeight(2);
        fill(255, 100);
        ellipse(pos.x, pos.y, rad *2, rad * 2);
        for (int i = 0; i < past.size(); i++){
            int a = floor(100 - i *2);
            fill(255, a);
            ellipse(past.get(i).x, past.get(i).y, rad * 2, rad * 2);
        }
    }
    //move the body
    void update(){
        PVector temp = pos.copy();
        if (past.size() > pastN){
            past.pop();
        }
        past.add(temp);
        vel.add(acc);
        pos.add(vel);
        acc.mult(0);
    }
}