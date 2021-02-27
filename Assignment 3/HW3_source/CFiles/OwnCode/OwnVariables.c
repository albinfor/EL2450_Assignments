double v = 0;
double w = 0;
double theta_R;
double theta_error;
double theta_g;
double d0;
double dg;
double dp;
int state = 0;
double d;
double theta_err;

//Simulator parameters
double R = 0.1001405119340;
double L = 0.5052864456892;
double h = 1;
int limit_v;
int limit_w;


//Controller parameters
double p = 50;
//double K_Psi = 5;
//double K_omega = 10;

double K_Psi_rotation = L/(h*R); //Ain't working brah
double K_Psi_drive = 100*L/(p*h*R);
double K_omega = 1/(h*R); //still ain't working brah
