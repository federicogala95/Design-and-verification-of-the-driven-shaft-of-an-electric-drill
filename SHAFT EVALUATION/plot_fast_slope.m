def_FAST_z;
def_FAST_y;
slop_fast_tot=atan((tan(slop_fast_y).^2+(tan(slop_fast_z).^2)).^.5);
plot(x,slop_fast_z,'r',x,slop_fast_y,'b',x,slop_fast_tot,'k');
legend('Slope_z','Slope_y','Slope tot');
title('Shaft slope along the beam (FAST T. GEARSET)')