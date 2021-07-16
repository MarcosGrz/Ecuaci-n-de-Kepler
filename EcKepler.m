
%---[Obtención E a partir de M,e y los 4 datos de la tabla de Kepler]-----


%M\e  e0      e    e1
% M0  D00    D0    D01
% M           D    
% M1  D10    D1    D11

function E = EcKepler(D00,D01,D10,D11,Mgrad,e) 
  
  i=0; %Para contar iteraciones
  E0=TablaKepler(D00,D01,D10,D11,Mgrad,e); %E en radianes, obtenido mediante la tabla
  Mrad=Mgrad*2*pi/360;
  aux=E0-e*sin(E0);
  
  while abs(Mrad-aux)>= 0.0000001 %Si no coinciden Mrad y E-esin(E) en 7 cifras
    %se realiza otra iteración.
    i=i+1;
    x=(Mrad-aux)/(1-e*cos(E0));
    E0=E0+x;
    aux=E0-e*sin(E0);
    fprintf("----------------------------------\n")
    fprintf("E%i-e*sin(E%i)=%s\n",i,i,aux)
  end
  fprintf("--- Solución ---------------------\n")
  fprintf("Iteraciones: %i\n",i)
  fprintf("M= %s\n",Mrad) 
  fprintf("E-e*sin(E)= %s\n",E0-e*sin(E0))
  fprintf("E= %s\n",E0)
  E=E0;

  end

  ...
      
function [Erad,Egrad] = TablaKepler(D00,D01,D10,D11,M,e)
  e0=floor(10*e)/10;   %0.34->3.4->3->0.3
  e1=ceil(10*e)/10; %0.34->3.4->4->0.4
  M0=floor(M);
  M1=ceil(M);
  %Interpolación
  D0=(D01-D00)*(e-e0)/(e1-e0)+D00;
  D1=(D11-D10)*(e-e0)/(e1-e0)+D10;
  D=(D1-D0)*(M-M0)/(M1-M0)+D0;
  if M<180 
      Egrad=M+D;
  elseif M>180
      Egrad=M-D;
  else %M=180
      Egrad=M;
  end  
  fprintf("E en grados: %s\n",Egrad)
  Erad=Egrad*2*pi/360;
  fprintf("E en radianes: %s\n",Erad)
end

% Ejercicios resueltos en clase para la comprobación del algoritmo
% EcKepler(32.05,40.15,32.76,40.75,21.296,0.78)
% EcKepler(25.91,33.41,26.54,34.02,23.7,0.62)
 
