def_z_slow;
def_y_slow;
slop_slow_tot=atan((tan(slop_slow_y).^2+tan(slop_slow_z).^2).^.5);
plot(x,slop_slow_z,'r',x,slop_slow_y,'b',x,slop_slow_tot,'k');
legend('Slope_z','Slope_y','Slope tot');
title('Shaft Slope(SLOW T. GEARSET)')