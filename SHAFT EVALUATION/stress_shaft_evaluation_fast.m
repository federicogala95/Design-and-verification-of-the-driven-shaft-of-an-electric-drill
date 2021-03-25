%STRESS EVALUATION IN SLOW TRANSMISSION:
%We first define the parameters to include in the evaluation of the stress
%along the shaft:
%GEOMETRICAL PARAMETERS:
x=0:0.5:68;  %shaft length 
d_b=15;      %bearing diameter
d_g=20;      %gear diameter
d_s=25;      %shoulder diameter

Ib=(pi*d_b^4)/64;  %shaft section moment of inertia related to bearing diameter
Ig=(pi*d_g^4)/64;  %shaft section moment of inertia related to gear diameter
Is=(pi*d_s^4)/64;  %shaft section moment of inertia related to shoulder diameter

Jb=(pi*d_b^4)/32;  %module of Young for steel
Jg=(pi*d_g^4)/32;
Js=(pi*d_s^4)/32;



E=205*1000; %module of Young for steel
G=79000;    %module of torsional elasticity for steel

%SHAFT MAIN FORCES:
%BEARING RADIAL REACTIONS:
Rb_y=-50.26;
Re_y=-88.91;
Rb_z=-138.09;
Re_z=-244.3;
%FORCES ACTING ALONG THE SHAFT:
Fr=139.17;
Ft=382.39;
T=13641;
%Stress evaluation for fast transmission:

%INTERNAL REACTIONS evaluation for slow transmission:
%We first deduce the distribution of the internal reactions along the shaft
%based on the external forces and reactions. We neglected the presence of
%N along the shaft sections since there is not an axial component for the
%forces transmitted by the spur gear nore an axial reaction of the
%bearings.

M_z_BD_fast=Rb_y*x(1:89);
M_z_DE_fast=flip(Re_y*x(1:(137-89)));
V_y_BD_fast=Rb_y*ones(1,89);
V_y_DE_fast=-Re_y*ones(1,48);
M_z_fast=[M_z_BD_fast M_z_DE_fast];
V_y_fast=[V_y_BD_fast V_y_DE_fast];

M_y_BD_fast=Rb_z*x(1:89);
M_y_DE_fast=flip(Re_z*x(1:(137-89)));
V_z_BD_fast=Rb_z*ones(1,89);
V_z_DE_fast=-Re_z*ones(1,48);
M_y_fast=[M_y_BD_fast M_y_DE_fast];
V_z_fast=[V_z_BD_fast V_z_DE_fast];

T_BK=T*ones(1,89);
T_KE=zeros(1,48);
T_fast=[T_BK T_KE];

%STRESS EVALUATION ALONG THE SHAFTS:
%The stress evaluation has been made taking into account of the different
%sections and moments of inertia characterizing the shaft. In the
%determination of the normal stress we considered both the contributions of
%the bending moment acting along the z and the y axis, while for the
%determination of the shear stress we only considered the one related to
%the torque moment on the most external points of the circular sections.
%The shear stress related to V has been neglected since it assumes the
%maximum value at the centre of the section while on the external points is
%almost zero and torque shear stress is considerably higher then the
%one associated with V.

sigma_fast_BH=((M_y_fast(1:9).^2+M_z_fast(1:9).^2).^0.5)/(Ib)*(d_b/2);
sigma_fast_HC=((M_y_fast(10:64).^2+M_z_fast(10:64).^2).^0.5)/(Ig)*(d_g/2);
sigma_fast_CD=((M_y_fast(65:74).^2+M_z_fast(65:74).^2).^0.5)/(Is)*(d_s/2);
sigma_fast_DJ=((M_y_fast(75:129).^2+M_z_fast(75:129).^2).^0.5)/(Ig)*(d_g/2);
sigma_fast_JE=((M_y_fast(130:137).^2+M_z_fast(130:137).^2).^0.5)/(Ib)*(d_b/2);

sigma_fast=[sigma_fast_BH sigma_fast_HC sigma_fast_CD sigma_fast_DJ sigma_fast_JE];


tau_fast_BH=T_fast(1:9)*d_b/(Jb*2);
tau_fast_HC=T_fast(10:64)*d_g/(Jg*2);
tau_fast_CD=T_fast(65:74)*d_s/(Js*2);
tau_fast_DJ=T_fast(75:89)*d_g/(Jg*2);

tau_fast_KE=zeros(1,48);

tau_fast=[tau_fast_BH tau_fast_HC tau_fast_CD tau_fast_DJ tau_fast_KE];


sigma_eq_fast=(sigma_fast.^2+3*tau_fast.^2).^.5;
%EVALUATION OF THE MOST STRESSED SECTION (STATIC ANALYSIS):
%We now evaluate the stress acting in the most critical section taking into
%account of the notch factors (both for torsion and bending moment).
%STRESS INTENSIFICATION FACTORS:
Kt_b1=2.6;
Kt_t1=2.2;
SF_static=235/((Kt_b1*sigma_fast(9).^2+Kt_t1*tau_fast(9).^2).^.5)
plot(x,sigma_eq_fast,'k',x,sigma_fast,'b',x,tau_fast,'r');
legend('sigma eq','sigma','tau_T');
title('Shaft stress (FAST T. GEARSET)');


%FATIGUE EVALUATION:
SF=1;
q=.45; %notch sensivity on the shaft shoulders
Kt_b1=2.6;
Kt_b2=2.5;
Kt_t1=2.2;
Kt_t2=2.35;
sigma_a_y=360*.958*.9143*.45;
H=sigma_a_y/(235/(3)^.5);
%1)BEARING-GEAR SITE (x=4 mm):d=15 mm D=20 mm

sigma_eq_fast_fat1=((sigma_fast(9)*Kt_b1)^2+H*(Kt_t1*tau_fast(9)^2)).^.5;

sigma_eq_fast_fat1<(sigma_a_y)/SF;
ratio_stress_fast1=sigma_eq_fast_fat1/((sigma_a_y)/SF);

%2)GEAR-SHOULDER SITE (x=31.5):d=20 mm D=25 mm
sigma_eq_fast_fat2=((sigma_fast(64)*Kt_b2)^2+H*(Kt_t2*tau_fast(64)^2)).^.5;

sigma_eq_fast_fat2<(sigma_a_y)/SF;
ratio_stress_fast2=sigma_eq_fast_fat2/((sigma_a_y)/SF);

%3)SHUOLDER-GEAR SITE (x=36.5 mm):d=20 mm D=25 mm
sigma_eq_fast_fat3=((sigma_fast(75)*Kt_b2)^2+H*(Kt_t2*tau_fast(75)^2)).^.5;

sigma_eq_fast_fat3<(sigma_a_y)/SF;
ratio_stress_fast3=sigma_eq_fast_fat3/((sigma_a_y)/SF);

%4)GEAR-BEARING SITE (x=64 mm): d=15 mm D=20 mm
sigma_eq_fast_fat4=((sigma_fast(130)*Kt_b1)^2+H*(Kt_t1*tau_fast(130)^2)).^.5;

sigma_eq_fast_fat4<(sigma_a_y)/SF;
ratio_stress_fast4=sigma_eq_fast_fat4/((sigma_a_y)/SF);
%The following vector contains the ratios between the sigma equivalent and
%the critical stress value for position 1-2-3-4 (from R to L):
ratio_stress_fast=[ratio_stress_fast1 ratio_stress_fast2 ratio_stress_fast3 ratio_stress_fast4].^(-1)

