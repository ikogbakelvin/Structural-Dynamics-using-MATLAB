% %DYNAMICS OF STRUCTURES PRACTICE
% %#IKOGBA KELVIN OBOKPARO
% %2019/11/20........................ 
% 
% %initial displacement problems by Shibata Sensei
% h = 0; %damping factor or zeta
% m = 2000; %mass
% k = 1000000; %stiffness
% wn = sqrt (k/m); % frequency
% w = [0:0.02:5];
% c = 2*h.*w*m; %Viscous damping coeeficient
%  T = [0:0.02:5];
%  N=5;
% 
%     y = exp(-h.*w.*T) .* (cos(sqrt(1-h^2).*w.*T) + sin(sqrt(1-h^2).*w.*T));
%     plot (T,y);
%     
% 
%  Data = xlsread ('Kobe.xlsx');
% t = xlsread('Kobe.xlsx' ,1, 'A2:A2001'); %reads time
% Acc = xlsread('Kobe.xlsx' ,1, 'B2:B2001');  %Reads ground acceleration
% Do = xlsread('Kobe.xlsx' ,1, 'D2:D2001');%Displacement
% Vo = xlsread('Kobe.xlsx' ,1, 'E2:E2001'); %Velocity
% 

%y = exp(-h.*w.*T).*(Do*cos(sqrt(1-h^2).*w.*T) + ((Vo+h.*w.*Do)/(sqrt(1-h^2).*w))*sin(sqrt(1-h^2).*w.*T));


%initial displacement problems by Shibata Sensei
% N=200;
% H = [0.01,0.05,0.2,0.5]; %damping factor or zeta
% m = 2000; %mass
% k = 1000000; %stiffness
% %wn = sqrt (k/m); % frequency
% w = 0:0.02:4;
% 
%  T = 0:0.02:4;
%  y = zeros(1,length(N));
%  h = zeros(1,length(H));
%   
% for i = 1:4
%   
%     h(i)= H(i);
%        for j= 1:N+1
%         y(i,j) = exp(-h(i).*w(j).*T(j))*((cos(sqrt(1-h(i)^2)*w(j)*T(j)) + sind(sqrt(1-h(i)^2))*w(j)*T(j)));
%        end
% end
% hold on
% plot (T,y)


%###############################################################################################################
 % RESPONSE TO HARMONIC EXCITATION
 %***************************************************%##########################################################
 %clear all;
%  Wn = 1;
%  N=150;
%  p=1;
% H = [0, 0.1,0.2,0.4,0.707, 1]; %damping factor or zeta
% m = 2000; %mass
% k = 1000000; %stiffness
% %wn = sqrt (k/m); % frequency
% w = 0:0.02:3;
% 
%  %T = 0:0.02:4;
%  A = zeros(1,length(N));
%  h = zeros(1,length(H));
%   
% for i = 1:6
%   
%     h(i)= H(i);
%        for j= 1:N+1
%         A(i,j) = ((sqrt((1 - (w(j)/p).^2).^2 + 4.*h(i)^2*(w(j)/p).^2)).^-1);
% 
%        end
% end
% hold on
% plot (w,A)


%############################################################################################################
%^&ABSOLUTE ACCELERATION AMPLIFICATION

%  Wn = 1;
%  N=150;
%  p=1;
% H = [0, 0.1,0.2,0.4,0.707, 1]; %damping factor or zeta
% m = 2000; %mass
% k = 1000000; %stiffness
% %wn = sqrt (k/m); % frequency
% w = 0:0.02:3;
% 
%  %T = 0:0.02:4;
%  Y = zeros(1,length(N));
%  h = zeros(1,length(H));
%   
% for n = 1:6
%   
%     h(n)= H(n);
%        for A= 1:N+1
%           % theta = atan(2.*h(n).*(w(A)/p).^2./(1-(1-4.*h(n).^2)*(w(A)/p).^2));
%         Y(n,A) = sqrt((1+4.*h(n).^2*(w(A)./p).^2)./((1-(w(A)./p).^2).^2+ 4.*h(n)^2*(w(A)./p).^2)).* exp(-(1i));
%                 
%           
%        end
% end
% hold on
% plot (w,Y)
 



%#############################################################################################################
%NUMERICAL ANALYSIS OF DYNAMIC RESPONSE
%#############################################################################################################


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Newmark's Method for SDF Nonlinear Systems %%%
%%%            By: Christopher Wong            %%%
%%%            crswong888@gmail.com            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Method as per A.K. Chopra %%%
%%%    Example 5.5, (2014)    %%%

%%% Establish time step parameters
% T_n=1; % natural period
% dt=0.01; % time step size
% t=0:dt:10; % total length of time
% n=length(t)-1; % number of time steps
% TOL=1e-3; % convergence criteria
% %%% Determine which special case to use: constant avg. vs. linear
% if dt/T_n<=0.551 % Use linear accel. method - closest to theoretical
%     gamma=0.5;
%     beta=1/6;
% else % Use constant avg. accel. method - unconditionally stable
%     gamma=0.5;
%     beta=0.25;
% end
% %%% Establish system properties
% xi=0.05; % percentage of critical damping
% omega_n=2*pi/T_n; % natural angular frequency
% m=0.4559; % mass
% k=18; % stiffness
% c=2*xi*m*omega_n; % damping constant
% u_y=2; % yield deformation
% %%% Input excitation function
% p(t<0.6)=50*sin(pi*t(t<0.6)/0.6);
% p(t>=0.6)=0;
% %%% Establish initial conditions @ i=1
% u(1)=0; % displacement 
% v(1)=0; % velocity
% f_s(1)=0; % restoring force
% k_T(1)=k; % tangent stiffness
% a(1)=(p(1)-c*v(1)-f_s(1))/m; % acceleration
% %%% Calculate Newmark constants
% A1=m/(beta*dt.^2)+gamma*c/(beta*dt);
% A2=m/(beta*dt)+c*(gamma/beta-1);
% A3=m*(1/(2*beta)-1)+dt*c*(gamma/(2*beta)-1);
% k_hat=k+A1;
% %%% Calculations for each time step, i=0,1,2,...,n
% %%% Inititialize time step
% for i=1:n
%     p_hat(i+1)=p(i+1)+A1*u(i)+A2*v(i)+A3*a(i); % Chopra eqn. 5.4.12
%     u(i+1)=p_hat(i+1)/k_hat; % linear displacement
%     k_T(i+1)=k_T(i); % tangent stifness at beginning of time step
%     f_s(i+1)=u(i+1)*k_T(i+1); % linear restoring force
% %%% Determine if iteration is linear or nonlinear
%     if f_s(i+1)<=k*u_y % If linear
%         u(i+1)=u(i+1); % keep linear value
%         f_s(i+1)=f_s(i+1); % keep linear value
%     else % If nonlinear
%         u(i+1)=u(i); % restore value from previous nonlinear iteration
%         f_s(i+1)=f_s(i); % resore value from previous nonlinear iteration
%     end
%    R_hat(i+1)=p_hat(i+1)-f_s(i+1)-A1*u(i+1); % Compute initial residual
% %%% Begin Netwon-Raphson iteration
%     while abs(R_hat(i+1))>TOL % Terminate if converged
%         k_T_hat(i+1)=k_T(i+1)+A1;
%         du=R_hat(i+1)/k_T_hat(i+1);
%         u(i+1)=u(i+1)+du;
%         f_s(i+1)=f_s(i)+k*(u(i+1)-u(i));
% %%% Determine if restoring force is yielding
%         if f_s(i+1)>=k*u_y % If yielding
%             f_s(i+1)=k*u_y;
%             k_T(i+1)=0;
%         else % If elastic
%             k_T(i+1)=18; 
%         end
%         R_hat(i+1)=p_hat(i+1)-f_s(i+1)-A1*u(i+1); % Compute new residual
%     end
% %%% Calculations for new velocity and acceleration
%    v(i+1)=gamma*(u(i+1)-u(i))/(beta*dt)+v(i)*(1-gamma/beta)+dt*a(i)*(1-gamma/(2*beta));
%    a(i+1)=(u(i+1)-u(i))/(beta*dt.^2)-v(i)/(beta*dt)-a(i)*(1/(2*beta)-1);
% end
% %%% Generate plots
% figure(2)
% plot(t,u)
% xlabel('\itt\rm, s')
% ylabel('\itu\rm, cm')
% title('Displacement vs. Time Plot')
% figure(3)
% plot(t,p)
% xlabel('\itt\rm, s')
% ylabel('\itp\rm, kN')
% title('Excitation Function Plot')
% figure(4)
% plot(u,f_s)
% xlabel('\itu\rm, cm')
% ylabel('\itf_s\rm, kn')
% title('Elastoplastic Loop Plot')


%%
%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%RAYLEIGH DAMPING GRAPHS
a0 = 0.0589157;
a1 = 0.0005452;
w1 = 0:1:400;
massT = a0./(2.*w1);
StiffnessT = (a1.*w1)/2;
zeta = massT + StiffnessT;
w = w1';s = StiffnessT';m = massT';
damping_ratio = zeta';
zeta2 = 0.5.*(-26.04.*w1.^-3 + 1.064.*w1.^-1);

%figure(1)
%plot (w1, zeta2, 'b-');



plot (w1, damping_ratio, 'b-.','linewidth',1);

  xlabel ('Frequency, rad/sec')
ylabel ('Damping ratio')
title ('Rayleigh proportional damping curves')
hold on
plot (w1, StiffnessT,'k-', 'linewidth',0.8);
hold on
plot (w1, massT,'r-', 'linewidth',0.8);
yticks(0:0.02:1);
xticks(0:100:700)
legend ('Rayleigh','Stiffness prop.', 'Mass prop.');
  legend ('boxoff')
  
  
  E = 205000; G = 79000; J = 178812.6628; I = 65104.17;I1 = 130208.33; J2 = 438828.7862;
  L = 0:0.5:20; l= L';
 Mo = ((pi()./L)*sqrt(E*I*G*J))';M1 = ((pi()./L)*sqrt(E*I1*G*J2))';
 plot(L, Mo, L, M1)
 
 clc
clear all
close all

EI=1;
l=1;
Pe=(2*pi()^2*EI)/1^3;

gama=0:1:100; 
klc=0:1:100;
for i=1:101
    KLca(i)=(((gama(i)*klc(i)))/((klc(i)^2)+gama(i)));
    KLc(i)=(((2*KLca(i)+1)*pi())/2)-(2/((2*KLca(i)+1)*pi()));
    Pcr(i)=EI*(KLc(i))^2/(l^2);
end

a=Pcr/Pe; 
plot(gama,a)

