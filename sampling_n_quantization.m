%  Institute: Indian Institute of Information Technology Nagpur
%  Laboratory: Wireless Communication
%  Engineer: Chaitra Guruvelli
%  Create Date: 23.01.2024 20:41:32
%  Project Name: Sampling and Quantization of given signal 
%  Tool: Matlab
%  Description: 
clc
clear all
close all

% Take input of sampling frequency
fs = input('Enter sampling frequency: ');

% Take input of signal frequency
f1 = input('Enter signal frequency: ');

% Define time
t = 0:1/fs:1;

% Define signal
x = 2*sin(2*pi*f1*t) + 5*cos(2*pi*f1*t);

% Plot original signal
subplot(2,2,1)
plot(t, x)
xlabel('\bf Time');
ylabel('\bf Amplitude');
title('Continuous Original Signal');

% Plot discrete version of original signal
subplot(2,2,2)
stem(t, x)
xlabel('\bf Time');
ylabel('\bf Amplitude');
title('Discrete Original Signal');

% Extract time for sampling purpose
t1 = t(1:2:end);

% Define signal for sampling
x1 = 2*sin(2*pi*f1*t1) + 5*cos(2*pi*f1*t1);

% Plot sample signal with fewer samples
subplot(2,2,3)
plot(t1, x1)
xlabel('\bf Time');
ylabel('\bf Amplitude');
title('Continuous Sampled Signal');

% Plot discrete version of sampled signal
subplot(2,2,4)
stem(t1, x1)
xlabel('\bf Time');
ylabel('\bf Amplitude');
title('Discrete Sampled Signal');

% Extreme values of the signal
x_max = max(x1);
x_min = min(x1);
x_quantised = x1 / x_max;

% Number of quantization levels
n = 16;

% Step size to accommodate n quantization levels
d = (x_max - x_min) / n;

% Store values of levels for quantization purpose
q = (x_min:d:x_max);
for ii = 1:n
    q1(ii) = (q(ii) + q(ii+1)) / 2;
end

% Quantize the signal and also convert it to decimal value
for jj = 1:n
    x_quantised(find((q1(jj)-d/2 <= x) & (x <= q1(jj)+d/2))) = q1(jj) .* ones(1, length(find((q1(jj)-d/2 <= x) & (x <= q1(jj)+d/2))));
    decimal_number(find(x_quantised == q1(jj))) = (jj - 1) .* ones(1, length(find(x_quantised == q1(jj))));
end

% Plot quantized signal 
figure(2);
plot(t, x_quantised);
xlabel('Time');
ylabel('Amplitude');
title('Quantized Signal');

% Change decimal value of level into binary numbers 
% or encoded string
binary_number = cell(size(decimal_number));
for kk = 1:length(decimal_number)
    binary_number{kk} = flip(de2bi(decimal_number(kk), 4));
end

% Pause to keep the figures open indefinitely
pause;
