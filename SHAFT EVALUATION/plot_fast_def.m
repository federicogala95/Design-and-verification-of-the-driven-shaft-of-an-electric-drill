def_FAST_z;
def_FAST_y;
def_fast_tot=(def_fast_y.^2+def_fast_z.^2).^.5;
plot(x,def_fast_z,'r',x,def_fast_y,'b',x,def_fast_tot,'k');
legend('def_z','def_y','def tot');
title('Shaft Deflection (FAST GEARSET)')