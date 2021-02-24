
//Rotational fixing
theta_R = atan2(yg-y,xg-x)*180/PI;
theta_error = theta_R-theta;
theta_g = atan2(yg-y0,xg-x0)*180/PI;
if (state == 0){
    Serial.print("Rotating");
    //Keep close to start point and get correct angle
    v = K_omega*(cos(theta*PI/180)*(x0-x)+sin(theta*PI/180)*(y0-y));
    w = K_Psi*theta_error;
    if (abs(theta_error)<1) state = 1;
} else if (state == 1){
    Serial.print("Driving");
    //Keep close to line and drive to goal
    v = K_omega*(cos(theta_g*PI/180)*(xg-x)+sin(theta_g*PI/180)*(yg-y));
    w = K_Psi*(sin(theta_g*PI/180)*(x-x0+p*cos(theta*PI/180))-cos(theta_g*PI/180)*(y-y0+p*sin(theta*PI/180)));
    if (abs(x-xg)<3 && abs(y-yg)<3) state = 2;
} else if (state == 2){
    Serial.print("Stopping");
    v = 0;
    w = 0;
}
Serial.print("\nv = ");
Serial.print(v);
Serial.print("\nw = ");
Serial.print(w);




/*
if (abs(theta_error) > 1 && abs(pos_error)>0.16){
    //GOTO start point
    w = K_Psi*theta_error;
    v = 0;
    //Translational fixing
    double d_g;
    d_g = cos(theta*PI/180)*(x0-x)+sin(theta*PI/180)*(y0-y);
    v = K_omega*d_g;
    //w = 0;
}else{
    //Rotate towards goal position
    theta_R = atan2(yg-y,xg-x)*180/PI;
    theta_error = theta_R-theta;
    v = 0; 
    w = K_Psi*theta_error;
}
*/




//Convert v and w to control signal
right = v+w/2;
left = v-w/2;

