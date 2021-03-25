%DEFLECTION EVALUATION for slow transmission along z:
%DIAMETERS OF THE SHAFT(BEARING-GEAR-SHOULDER):
d_b=15;
d_g=20;
d_s=25;
%PARAMETERS OF THE SHAFT SECTIONS:

Ib=(pi*d_b^4)/64;
Ig=(pi*d_g^4)/64;
Is=(pi*d_s^4)/64;

Jb=(pi*d_b^4)/32;
Jg=(pi*d_g^4)/32;
Js=(pi*d_s^4)/32;

E_rig=205*1000;
G_rig=79000;
%BEARINGS REACTIONS:

Rb_y=-152.3;
Re_y=-83.06;
Rb_z=-418.43;
Re_z=-228.23;
%FORCES ACTING ON THE GEARSET:

Ft=646.66;
T=29100;
%INTEGRATION CONSTRANTS OF THE SHAFT:

%We divided the shaft into 6 different segments characterised by different
%internal bending moment due to the variation of the diameter.
%This part of the script is finalized to the determination of the different
%intagration constants derived from the Euler equation, which establish the
%relation between the shaft deflection and the internal bending moment.
%All the values have been defined in "symbolic form" to be able to apply
%the MATLAB equation solver.
A=sym('A');
B=sym('B');
C=sym('C');
D=sym('D');
E=sym('E');
F=sym('F');
G=sym('G');
H=sym('H');
J=sym('J');
L=sym('L');
M=sym('M');
N=sym('N');
x=sym('x');

z_AB=Rb_z*x^3/(6*Ib*E_rig)+A*x+B;
z_BC=Rb_z*x^3/(6*Ig*E_rig)+C*x+D;
z_CD=(Rb_z+Ft)*x^3/(6*Ig*E_rig)-Ft*24*x^2/(2*E_rig*Ig)+E*x+F;
z_DE=(Rb_z+Ft)*x^3/(6*Is*E_rig)-Ft*24*x^2/(2*E_rig*Is)+G*x+H;
z_EF=(Rb_z+Ft)*x^3/(6*Ig*E_rig)-Ft*24*x^2/(2*E_rig*Ig)+J*x+L;
z_FG=(Rb_z+Ft)*x^3/(6*Ib*E_rig)-Ft*24*x^2/(2*E_rig*Ib)+M*x+N;

[A,B,C,D,E,F,G,H,J,L,M,N]=solve(subs(z_AB,x,4)==subs(z_BC,x,4),subs(diff(z_AB,x),x,4)==subs(diff(z_BC,x),x,4),subs(z_BC,x,24)==subs(z_CD,x,24),subs(diff(z_BC,x),x,24)==subs(diff(z_CD,x),x,24),subs(z_CD,x,31.5)==subs(z_DE,x,31.5),subs(diff(z_CD,x),x,31.5)==subs(diff(z_DE,x),x,31.5),subs(z_DE,x,36.5)==subs(z_EF,x,36.5),subs(diff(z_DE,x),x,36.5)==subs(diff(z_EF,x),x,36.5),subs(z_EF,x,64)==subs(z_FG,x,64),subs(diff(z_EF,x),x,64)==subs(diff(z_FG,x),x,64),subs(z_AB,x,0)==0,subs(z_FG,x,68)==0,A,B,C,D,E,F,G,H,J,L,M,N);
%Once the values of the integration constaints had been determined we
%proceeded with the verification of the shaft rigidity. The following
%vectors rapresent the deflection and slope equations for the 6 segments.

A=double(A);
B=double(B);
C=double(C);
D=double(D);
E=double(E);
F=double(F);
G=double(G);
H=double(H);
J=double(J);
L=double(L);
M=double(M);
N=double(N);

x_AB=0:0.01:4;
x_BC=4:0.01:24;
x_CD=24:0.01:31.5;
x_DE=31.5:0.01:36.5;
x_EF=36.5:0.01:64;
x_FG=64:0.01:68;

x=[x_AB x_BC x_CD x_DE x_EF x_FG];
%DEFLECTION ALONG Z:
z_AB=Rb_z*x_AB.^3/(6*E_rig*Ib)+A*x_AB+B;
z_BC=Rb_z*x_BC.^3/(6*E_rig*Ig)+C*x_BC+D;
z_CD=(Ft+Rb_z)*x_CD.^3/(6*E_rig*Ig)-Ft*24*x_CD.^2/(2*E_rig*Ig)+E*x_CD+F;
z_DE=(Ft+Rb_z)*x_DE.^3/(6*E_rig*Is)-Ft*24*x_DE.^2/(2*E_rig*Is)+G*x_DE+H;
z_EF=(Ft+Rb_z)*x_EF.^3/(6*E_rig*Ig)-Ft*24*x_EF.^2/(2*E_rig*Ig)+J*x_EF+L;
z_FG=(Ft+Rb_z)*x_FG.^3/(6*E_rig*Ib)-Ft*24*x_FG.^2/(2*E_rig*Ib)+M*x_FG+N;
%SLOPE ALONG Z:
z1_AB=Rb_z*x_AB.^2/(2*E_rig*Ib)+A;
z1_BC=Rb_z*x_BC.^2/(2*E_rig*Ig)+C;
z1_CD=(Ft+Rb_z)*x_CD.^2/(2*E_rig*Ig)-Ft*24*x_CD/(E_rig*Ig)+E;
z1_DE=(Ft+Rb_z)*x_DE.^2/(2*E_rig*Is)-Ft*24*x_DE/(E_rig*Is)+G;
z1_EF=(Ft+Rb_z)*x_EF.^2/(2*E_rig*Ig)-Ft*24*x_EF/(E_rig*Ig)+J;
z1_FG=(Ft+Rb_z)*x_FG.^2/(2*E_rig*Ib)-Ft*24*x_FG/(E_rig*Ib)+M;

def_slow_z=[z_AB z_BC z_CD z_DE z_EF z_FG];
slop_slow_z=[z1_AB z1_BC z1_CD z1_DE z1_EF z1_FG];
%PLOT:
figure(1);
plot(x,def_slow_z,'b');
figure(2);
plot(x,slop_slow_z,'r');
%TORSION ANGLE EVALUATION:
%The evaluation of the torsional rotation has been done by determining
%the highest value of the angle and confronting it with the assigned
%upperbuond.The result is espressed in form of a boolean value:
G_tors=79*10^3;
tors_ang_slow=T*6/(G_tors*Jb)+20*T/(G_tors*Jg)
tors_ang_slow/26<0.044/1000
