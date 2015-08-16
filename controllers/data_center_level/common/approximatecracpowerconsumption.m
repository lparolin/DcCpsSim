function powerCrac = approximatecracpowerconsumption(copParameters, airFlow, ...
    airHeatCapacity, powerScalingCoefficient, initialTin, initialTout, ...
    tin, tout, approximationOrder)
%APPROXIMATECRACPOWERCONSUMPTION Approximate the power consumption of a
%CRAC unit.

    persistent basePower gradient hessian d3fdtout2dtin d3fdtout3;
    persistent d4fdtout3dtin d4fdtout4;

    if isempty(basePower)
        [basePower gradient hessian d3fdtout2dtin d3fdtout3 d4fdtout3dtin ...
        d4fdtout4]  = ...
            computecracpowerbasepowerandderivative(initialTin, initialTout, ...
            copParameters, airFlow * airHeatCapacity * powerScalingCoefficient);
    end
    
    dTin = tin - initialTin;
    dTout = tout - initialTout; 

    if approximationOrder == +Inf
        % no approximation, use the nonlinear formula
        powerCrac = airFlow * airHeatCapacity * (tin - tout) ./ ...
            (copParameters(1) * tout.^2 + copParameters(2) * tout + copParameters(1));
        return
    end
    
    if approximationOrder > 4
        logcomment(['The current version of approximatecracpowerconsumption ' ...
            'does not allow polynomial approximation of order higher than 4.']);
        logcomment(['A 4th order polynomial approximation will be used for ' ...
            'the power consumption of the CRAC units']);
        approximationOrder = 4;
    end
    
    % 0 order approximation
    powerCrac = basePower;
    
    % 1st order
    if approximationOrder >= 1
        powerCrac = powerCrac + gradient(1) * dTin + ...
            gradient(2) *  dTout;
    end
    
    % 2nd order
    if approximationOrder >= 2
        powerCrac = powerCrac + 1/2 * dTin.^2 * hessian(1) + ...
            1/2 * dTout.^2 * hessian(4) + dTout .* dTin .* hessian(1,2);
    end
    
    % 3rd order
    if approximationOrder >= 3
        powerCrac = powerCrac + 1/2 * d3fdtout2dtin * dTout.^2 .* dTin + ...
            1/6 * dTout.^3 .* d3fdtout3;
    end
    
    % 4rd order
    if approximationOrder >= 4
        powerCrac = powerCrac + 1/6 * d4fdtout3dtin .* dTout.^3 .* dTin + ...
        1/24 * dTout.^4 * d4fdtout4;
    end
end


function [basePower gradient hessian d3fdtout2dtin d3fdtout3 d4fdtout3dtin ...
    d4fdtout4]  = computecracpowerbasepowerandderivative(tin, tout, ...
    cop, coefficient)
% equations are obtained via Tomsym
cop1 = cop(1); cop2 = cop(2); cop3 = cop(3);

basePower = (1./((cop1*tout.^2+cop2*tout)+cop3))*(coefficient*(tin-tout));

% gradient
tempC10  = (1./((cop1*tout.^2+cop2*tout)+cop3));
gradient = [tempC10*coefficient;tempC10*(coefficient*-1)- ...
    (coefficient*(tin-tout))*((tempC10*tempC10)*(cop1*(2*tout)+cop2))];

% hessian
tempC7   = cop1*tout.^2+cop2*tout;
tempC10  = (1./(tempC7+cop3));
tempC11  = tempC10*tempC10;
tempC14  = cop1*(2*tout)+cop2;
tempC15  = tempC11*tempC14;
tempC16  = tempC10*tempC15;
tempC28  = coefficient*-1;
hessian      = [[0 -(coefficient*tempC15)]; [-1*(tempC15*coefficient) ...
    -1*(tempC15*tempC28+(coefficient*(tin-tout))*(tempC14*(-tempC16-tempC16)+tempC11*(cop1*2)))-tempC28*tempC15]];

% d3pwdTin3 = 0;
% d3pwdTin2dTout1 = 0;
% d3fdtout2dtin
tempC10  = (1./((cop1*tout.^2+cop2*tout)+cop3));
tempC11  = tempC10*tempC10;
tempC14  = cop1*(2*tout)+cop2;
tempC16  = tempC10*(tempC11*tempC14);
d3fdtout2dtin  = -1*(coefficient*(tempC14*(-tempC16-tempC16)+tempC11*(cop1*2)));

tempC10  = (1./((cop1*tout.^2+cop2*tout)+cop3));
tempC11  = tempC10*tempC10;
tempC14  = cop1*(2*tout)+cop2;
tempC15  = tempC11*tempC14;
tempC16  = tempC10*tempC15;
tempC17  = -tempC16;
tempC18  = tempC17-tempC16;
tempC20  = cop1*2;
tempC22  = tempC14*tempC18+tempC11*tempC20;
tempC26  = -1*(tempC10*tempC22-tempC15*tempC15);
tempC38  = coefficient*-1;
tempC41  = tempC38*tempC22;
d3fdtout3= -1*(tempC41+(tempC22*tempC38+(coefficient*(tin-tout))*((tempC18*tempC20+tempC14*(tempC26+tempC26))+tempC20*tempC18)))+-1*tempC41;

% fourth order derivative
tempC10  = (1./((cop1*tout.^2+cop2*tout)+cop3));
tempC11  = tempC10*tempC10;
tempC14  = cop1*(2*tout)+cop2;
tempC15  = tempC11*tempC14;
tempC16  = tempC10*tempC15;
tempC18  = -tempC16-tempC16;
tempC20  = cop1*2;
tempC26  = -1*(tempC10*(tempC14*tempC18+tempC11*tempC20)-tempC15*tempC15);
d4fdtout3dtin = -1*(coefficient*((tempC18*tempC20+tempC14*(tempC26+tempC26))+tempC20*tempC18));


tempC7   = cop1*tout.^2+cop2*tout;
tempC10  = (1./(tempC7+cop3));
tempC11  = tempC10*tempC10;
tempC14  = cop1*(2*tout)+cop2;
tempC15  = tempC11*tempC14;
tempC16  = tempC10*tempC15;
tempC18  = -tempC16-tempC16;
tempC20  = cop1*2;
tempC22  = tempC14*tempC18+tempC11*tempC20;
tempC26  = -1*(tempC10*tempC22-tempC15*tempC15);
tempC27  = tempC26+tempC26;
tempC32  = (tempC18*tempC20+tempC14*tempC27)+tempC20*tempC18;
tempC36  = tempC15*tempC22;
tempC40  = -1*((tempC10*tempC32-tempC22*tempC15)+-1*(tempC36+tempC36));
tempC45  = tempC20*tempC27;
tempC53  = coefficient*-1;
tempC56  = tempC53*tempC32;
d4fdtout4 = -1*(tempC56+(tempC56+(tempC32*tempC53+(coefficient*(tin-tout))*((tempC45+(tempC27*tempC20+tempC14*(tempC40+tempC40)))+tempC45))))+-1*tempC56;
end