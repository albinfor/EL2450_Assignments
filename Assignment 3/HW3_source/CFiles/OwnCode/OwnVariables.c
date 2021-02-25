double v = 0;
double w = 0;
double theta_R;
double theta_error;
double theta_g;
int state = 0;

//Simulator parameters
//double h = 0.02; //in seconds
double h = 1; //in seconds
int limit_v;
int limit_w;


//Controller parameters
//double K_Psi = 0.01*L_true/(h*R_true); //Ain't working brah
//double K_omega = 0.0001*1/(h*R_true); //Ain't working brah

double p = 40;
double K_Psi = 5;
double K_omega = 8;
