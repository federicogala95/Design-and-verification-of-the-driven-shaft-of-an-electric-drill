%EVALUATION OF A GEARSET : by using this script is possible to evaluate the fast and slow trasmission gearsets in terms of interference 
% and line of action using the module relationship

tau=input('Enter the trasmission ratio:');
m=input('Enter the module of the gearset:');
z1=input('Enter the number of teeth for the pinion:');
z2=ceil(z1/tau);
alpha=20;
r1=m*z1/2
r2=m*z2/2
r1_e=r1+m
r2_e=r2+m
r1_b=r1*cosd(alpha)
r2_b=r2*cosd(alpha)

if 2*r1+2*r2+2*m>120
    fprintf('The maximum envelope between the gear couple has not been respected. It is necessary to change gear dimensions!')
    
end

if r2_e>((r2_b^2+(sind(alpha)^2)*(r1+r2)^2))^.5
    fprintf('There is interference through the couple of gear. It is necessary to change gear dimensions!')
    
end

line_of_act=((r1_e^2-r1_b^2)^.5+(r2_e^2-r2_b^2)^.5-(r1+r2)*sind(alpha))/(m*pi*cosd(alpha))

