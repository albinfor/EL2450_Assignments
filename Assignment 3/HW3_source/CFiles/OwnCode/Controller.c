
//Rotational fixing
theta_R = atan2(yg-y,xg-x)*180/PI;
theta_g = atan2(yg-y0,xg-x0)*180/PI;
if (abs(theta_R-theta) < abs(theta_R-theta-360)){
    theta_error = theta_R-theta;
} else {
    theta_error = theta_R-theta-360;
}

if (state == 0){
    Serial.print("Rotating");

    //Keep close to start point and get correct angle
    d0 = (cos(theta*PI/180)*(x0-x)+sin(theta*PI/180)*(y0-y));
    v = K_omega*d0;

    w = K_Psi_rotation*theta_error;

    if (abs(theta_error)<2) state = 1;
} else if (state == 1){
    Serial.print("Driving");

    //Keep close to line and drive to goal
    dg = (cos(theta_g*PI/180)*(xg-x)+sin(theta_g*PI/180)*(yg-y));
    v = K_omega*dg;

    dp = (sin(theta_g*PI/180)*(x-x0+p*cos(theta*PI/180))-cos(theta_g*PI/180)*(y-y0+p*sin(theta*PI/180)));
    w = K_Psi_drive*dp;

    if (abs(x-xg)<5 && abs(y-yg)<5) state = 2;
} else if (state == 2){
    Serial.print("Stopping");
    v = 0;
    w = 0;
    send_done();
}


//In case students implement limits on control outputs
limit_v = 200;
limit_w = 200;
if (v >= limit_v){
        v=limit_v;
}
if (v <= -limit_v){
        v=-limit_v;
}
if ( w >= limit_w){
        w=limit_w;
}
if ( w <= -limit_w){
        w=-limit_w;
}

//Serial.print("\nv = ");
//Serial.print(v);
//Serial.print("\nw = ");
//Serial.print(w);

//Convert v and w to control signal
right = v+w/2;
left = v-w/2;



