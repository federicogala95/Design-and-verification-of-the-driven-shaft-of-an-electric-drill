%DEFLECTION EVALUATION for slow transmission along y:
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
Fr=235.36;
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

y_AB=Rb_y*x^3/(6*Ib*E_rig)+A*x+B;
y_BC=Rb_y*x^3/(6*Ig*E_rig)+C*x+D;
y_CD=(Rb_y+Fr)*x^3/(6*Ig*E_rig)-Fr*24*x^2/(2*E_rig*Ig)+E*x+F;
y_DE=(Rb_y+Fr)*x^3/(6*Is*E_rig)-Fr*24*x^2/(2*E_rig*Is)+G*x+H;
y_EF=(Rb_y+Fr)*x^3/(6*Ig*E_rig)-Fr*24*x^2/(2*E_rig*Ig)+J*x+L;
y_FG=(Rb_y+Fr)*x^3/(6*Ib*E_rig)-Fr*24*x^2/(2*E_rig*Ib)+M*x+N;

[A,B,C,D,E,F,G,H,J,L,M,N]=solve(subs(y_AB,x,4)==subs(y_BC,x,4),subs(diff(y_AB,x),x,4)==subs(diff(y_BC,x),x,4),subs(y_BC,x,24)==subs(y_CD,x,24),subs(diff(y_BC,x),x,24)==subs(diff(y_CD,x),x,24),subs(y_CD,x,31.5)==subs(y_DE,x,31.5),subs(diff(y_CD,x),x,31.5)==subs(diff(y_DE,x),x,31.5),subs(y_DE,x,36.5)==subs(y_EF,x,36.5),subs(diff(y_DE,x),x,36.5)==subs(diff(y_EF,x),x,36.5),subs(y_EF,x,64)==subs(y_FG,x,64),subs(diff(y_EF,x),x,64)==subs(diff(y_FG,x),x,64),subs(y_AB,x,0)==0,subs(y_FG,x,68)==0,A,B,C,D,E,F,G,H,J,L,M,N);

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
%DEFLECTION ALONG Y:
y_AB=Rb_y*x_AB.^3/(6*E_rig*Ib)+A*x_AB+B;
y_BC=Rb_y*x_BC.^3/(6*E_rig*Ig)+C*x_BC+D;
y_CD=(Fr+Rb_y)*x_CD.^3/(6*E_rig*Ig)-Fr*24*x_CD.^2/(2*E_rig*Ig)+E*x_CD+F;
y_DE=(Fr+Rb_y)*x_DE.^3/(6*E_rig*Is)-Fr*24*x_DE.^2/(2*E_rig*Is)+G*x_DE+H;
y_EF=(Fr+Rb_y)*x_EF.^3/(6*E_rig*Ig)-Fr*24*x_EF.^2/(2*E_rig*Ig)+J*x_EF+L;
y_FG=(Fr+Rb_y)*x_FG.^3/(6*E_rig*Ib)-Fr*24*x_FG.^2/(2*E_rig*Ib)+M*x_FG+N;
%SLOPE ALONG Y:
y1_AB=Rb_y*x_AB.^2/(2*E_rig*Ib)+A;
y1_BC=Rb_y*x_BC.^2/(2*E_rig*Ig)+C;
y1_CD=(Fr+Rb_y)*x_CD.^2/(2*E_rig*Ig)-Fr*24*x_CD/(E_rig*Ig)+E;
y1_DE=(Fr+Rb_y)*x_DE.^2/(2*E_rig*Is)-Fr*24*x_DE/(E_rig*Is)+G;
y1_EF=(Fr+Rb_y)*x_EF.^2/(2*E_rig*Ig)-Fr*24*x_EF/(E_rig*Ig)+J;
y1_FG=(Fr+Rb_y)*x_FG.^2/(2*E_rig*Ib)-Fr*24*x_FG/(E_rig*Ib)+M;
%PLOT:
def_slow_y=[y_AB y_BC y_CD y_DE y_EF y_FG];
slop_slow_y=[y1_AB y1_BC y1_CD y1_DE y1_EF y1_FG];
figure(1);
plot(x,def_slow_y,'b');
figure(2);
plot(x,slop_slow_y,'r');
%TORSION ANGLE EVALUATION:
%The evaluation of the torsional rotation has been done by determining
%the highest value of the angle and confronting it with the assigned
%upperbuond.The result is espressed in form of a boolean value:
G_tors=79*10^3;
tors_ang_slow=T*6/(G_tors*Jb)+20*T/(G_tors*Jg)
tors_ang_slow/26<0.044/1000