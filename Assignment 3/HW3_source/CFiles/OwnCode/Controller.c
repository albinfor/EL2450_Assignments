
//Rotational fixing
theta_R = atan2(yg-y,xg-x)*180/PI;
theta_g = atan2(yg-y0,xg-x0)*180/PI;

if (abs(theta_R-theta) < abs(theta_R-theta-360)){
    theta_error = theta_R-theta;
} else {
    theta_error = theta_R-theta-360;
}

switch (state) {
    case 0:
        Serial.print("Rotating");

        //Keep close to start point and get correct angle
        d0 = (cos(theta*PI/180)*(x0-x)+sin(theta*PI/180)*(y0-y));
        v = K_omega*d0;

        w = K_Psi_rotation*theta_error;
        if (abs(theta_error)<1) state = 1;
        break;
    case 1:
        Serial.print("Driving");

        //Keep close to line and drive to goal
        dg = cos(theta_g*PI/180)*(xg-x)+sin(theta_g*PI/180)*(yg-y);
        p = sqrt((xg-x)*(xg-x)+(yg-y)*(yg-y));
        K_Psi_drive = 100*L/(p*h*R);
        if (p < 0.001) K_Psi_drive = 0;
        dp = (sin(theta_g*PI/180)*(x-x0+p*cos(theta*PI/180))-cos(theta_g*PI/180)*(y-y0+p*sin(theta*PI/180)));
        if (dg < 0) {
            dg = -dg;
            dp = -dp;
        }

        v = K_omega*dg;
        w = K_Psi_drive*dp;

        if (abs(x-xg)<1 && abs(y-yg)<1) state = 2;
        break;
    case 2:
        Serial.print("Stopping");
        v = 0;
        w = 0;
        if ((abs(x-xg)>100 || abs(y-yg)>100)) state = 1;
        send_done();
        break;
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

Serial.print("\nv = ");
Serial.print(v);
Serial.print("\nw = ");
Serial.print(w);
Serial.print("\ndg = ");
Serial.print(dg);
Serial.print("\ndp = ");
Serial.print(dp);

//Convert v and w to control signal
right = v+w/2;
left = v-w/2;



