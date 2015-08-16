function [pw0 gradient Hpw]  = ...
    cracpowerconsumptionsecondorderapproximation(Tin, Tout, ...
    COP, coefficient)

% Luca Parolini 
% <lparolin@andrew.cmu.edu>

a = COP(1); b = COP(2); c = COP(3); k = coefficient;
pw0 = k * (Tin - Tout) / (a*Tout^2 + b*Tout + c);

% variation of pw with respect to the vector [Tin; Tout]
tempC10  = (1./((a*Tout.^2+b*Tout)+c));
gradient = [tempC10*k;tempC10*(k*-1)-(k*(Tin-Tout))*((tempC10*tempC10)*(a*(2*Tout)+b))];

% Calculus of the Hessian
tempC7   = a*Tout.^2+b*Tout;
tempC10  = (1./(tempC7+c));
tempC11  = tempC10*tempC10;
tempC14  = a*(2*Tout)+b;
tempC15  = tempC11*tempC14;
tempC16  = tempC10*tempC15;
tempC28  = k*-1;
Hpw      = [[0 -(k*tempC15)];[-1*(tempC15*k) -1*(tempC15*tempC28+(k*(Tin-Tout))*(tempC14*(-tempC16-tempC16)+tempC11*(a*2)))-tempC28*tempC15]];
end