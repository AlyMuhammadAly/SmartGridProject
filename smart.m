% This code was written by:
% Sief Maged, Mohamed Mohsen, Aly Muhammad Aly
% It consists of 3 scripts.
% In order to use one script you have to comment the other two to get the desidred values. 

clc;
clear;

busVoltages = [1 1 1 1 1];
LinePowers = [0.5+0.25i 0.5+0.1i 0.25+0.05i 0.5+0.1i 1+0.25i];
tlImpedance = [0.05+0.1i 0.06+0.12i 0.02+0.04i 0.06+0.12i];
SRCurrents = [0 0 0 0 0];
lineCurrents = [0 0 0 0 0];
powerLosses = [0 0 0 0];
totalPower = 0;
currentVoltages = [0 0 0 0 0];
n = 5;

% Script 1
 for t = 0:1157
     
%     Evaluate line currents.
    for i = n:-1:1
        lineCurrents(i) = conj(LinePowers(i)) / conj(busVoltages(i));
        if i == n
            SRCurrents(i) = lineCurrents(i); 
        elseif i ~= 1
            SRCurrents(i) = lineCurrents(i) + SRCurrents(i+1);
        end

%         Evaluate power losses.
        if i ~= 1
            powerLosses(i) = (abs(SRCurrents(i))) ^ 2 * tlImpedance(i - 1);
        end
    end
    if t == 1157
         disp("TL currents,US:")
         disp(SRCurrents(2:5));
         disp("------------");
         disp("Line currents, US:")
         disp(lineCurrents);
         disp("------------");
     end
%     Evaluate total power.
    totalPower = sum(LinePowers) + sum(powerLosses);
    
%     Downstream calculations.
    SRCurrents(1) = conj(totalPower) / conj(busVoltages(1));
     for i = 2:n
         if i == 2
             SRCurrents(i) = SRCurrents(i - 1) - lineCurrents(1);
         elseif i ~= 2
             SRCurrents(i) = SRCurrents(i - 1) - conj(LinePowers(i - 1))/conj(busVoltages(i - 1));
         end
         busVoltages(i) = busVoltages(i - 1) - (SRCurrents(i)* tlImpedance(i - 1));    
     end
     if t == 1157
         disp("Bus Voltages:")
         disp(busVoltages);
         disp("------------");
         disp("total power:")
         disp(sum(powerLosses));
         disp("------------");
         disp("power losses:")
         disp(sum(powerLosses));
         disp("------------");
         disp("TL currents, DS:")
         disp(SRCurrents);
         disp("------------");
         disp("Line currents, DS:")
         disp(lineCurrents);
     end
 end

% getting the turns ratio to result in a 1 pu voltage at b 6.
% Script 2

%  for i = n:-1:1
%         lineCurrents(i) = conj(LinePowers(i))/conj(busVoltages(i));
%         if i == n
%             SRCurrents(i) = lineCurrents(i); 
%             busVoltages(i-1) = busVoltages(i) + (tlImpedance(i-1) * SRCurrents(i));
%         elseif i ~= 1
%             SRCurrents(i) = lineCurrents(i) + SRCurrents(i+1);
%             busVoltages(i-1) = busVoltages(i) + (tlImpedance(i-1) * SRCurrents(i));
%         end
%  end
%  
%  turnsRatio = 1/abs(busVoltages(1));
%  answer = ['Turns ratio = ',num2str(turnsRatio)];
%  disp(answer);


% getting the value of the capacitor bank.
% Script 3

% for t = 0:1:306
%     LinePowers(3) = LinePowers(3) + 0.0001i;
%     for i = n:-1:1
%         lineCurrents(i) = conj(LinePowers(i))/conj(busVoltages(i));
%         if i == n
%             SRCurrents(i) = lineCurrents(i); 
%         elseif i ~= 1
%             SRCurrents(i) = lineCurrents(i) + SRCurrents(i+1);
%         end
% 
%         % Evaluate power losses.
%         if i ~= 1
%             powerLosses(i) = (abs(SRCurrents(i)))^2 * tlImpedance(i-1);
%         end
%     end
%     % Evaluate total power.
%     totalPower = sum(LinePowers) + sum(powerLosses);
%     
%     % Downstream calculations.
%     SRCurrents(1) = conj(totalPower) / conj(busVoltages(1));
%      for i = 2:n
%          if i == 2
%              SRCurrents(i) = SRCurrents(i-1) - lineCurrents(1);
%          elseif i ~= 2
%              SRCurrents(i) = SRCurrents(i-1) - conj(LinePowers(i-1))/conj(busVoltages(i-1));
%          end
%          busVoltages(i) = busVoltages(i-1) - (SRCurrents(i)* tlImpedance(i-1));
%      end
%  end
%     
% disp(real(sum(powerLosses)))
% disp(LinePowers(3))

