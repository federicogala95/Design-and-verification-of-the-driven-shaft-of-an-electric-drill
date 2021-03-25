x=0:0.5:72;
d_b=15;
d_g=20;
d_s=25;

Ib=(pi*d_b^4)/64;
Ig=(pi*d_g^4)/64;
Is=(pi*d_s^4)/64;

Jb=(pi*d_b^4)/32;
Jg=(pi*d_g^4)/32;
Js=(pi*d_s^4)/32;

E=205*1000;
G=79000;

Rb_y=-150.37;
Re_y=-84.99;
Rb_z=-413.15;
Re_z=-233.51;

Fr=235.36;
Ft=646.66;
T=29100;

%Stress evaluation for slow transmission:
M_z_BK_slow=Rb_y*x(1:53);
V_y_BK_slow=Rb_y*ones(1,53);
M_z_KE_slow=Rb_y*x(54:145)+Fr*(x(54:145)-26);
V_y_KE_slow=-Re_y*ones(1,92);
M_z_slow=[M_z_BK_slow M_z_KE_slow];
V_y_slow=[V_y_BK_slow V_y_KE_slow];

M_y_BK_slow=Rb_z*x(1:53);
V_z_BK_slow=Rb_z*ones(1,53);
M_y_KE_slow=Rb_z*x(54:145)+Ft*(x(54:145)-26);
V_z_KE_slow=-Re_z*ones(1,92);
M_y_slow=[M_y_BK_slow M_y_KE_slow];
V_z_slow=[V_z_BK_slow V_z_KE_slow];
T_BK=29100*ones(1,53);
T_KE=zeros(1,92);
T_slow=[T_BK T_KE];
sigma_slow_BH=((M_y_slow(1:13).^2+M_z_slow(1:13).^2).^0.5)/(Ib)*(d_b/2);
sigma_slow_HC=((M_y_slow(14:68).^2+M_z_slow(14:68).^2).^0.5)/(Ig)*(d_g/2);
sigma_slow_CD=((M_y_slow(69:78).^2+M_z_slow(69:78).^2).^0.5)/(Is)*(d_s/2);
sigma_slow_DJ=((M_y_slow(79:121).^2+M_z_slow(79:121).^2).^0.5)/(Ig)*(d_g/2);
sigma_slow_JE=((M_y_slow(122:145).^2+M_z_slow(122:145).^2).^0.5)/(Ib)*(d_b/2);
sigma_slow=[sigma_slow_BH sigma_slow_HC sigma_slow_CD sigma_slow_DJ sigma_slow_JE];
tau_BH=T_slow(1:13)*d_b/Jb;
tau_HK=T_slow(14:53)*d_g/Jg;
tau_KE=zeros(1,92);
tau_slow=[tau_BH tau_HK tau_KE];
sigma_eq_slow=(sigma_slow.^2+4*tau_slow.^2).^0.5;