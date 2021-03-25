def_z_slow;
def_y_slow;
def_slow_tot=(def_slow_y.^2+def_slow_z.^2).^.5;
plot(x,def_slow_z,'r',x,def_slow_y,'b',x,def_slow_tot,'k');
legend('def_z','def_y','def tot');
title('Shaft Deflection  (SLOW T. GEARSET)')