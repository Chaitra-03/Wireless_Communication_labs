clc
clear all
close all

x = rand(1, 5000)-0.5;
x = sort(x);
sigma = 0.5;
mean_val = 0;

y = (1 / (sqrt(2 * pi * sigma^2))) * (exp(-(mean_val-x).^2 / (2 * sigma^2)));

plot(x, y);

hold on;

sigma1=1;
y1=(1 / (sqrt(2 * pi * sigma1^2))) * (exp(-(mean_val-x).^2 / (2 * sigma1^2)));
plot(x,y1);

hold on;
sigma2=1.5;
y2=(1 / (sqrt(2 * pi * sigma2^2))) * (exp(-(mean_val-x).^2 / (2 * sigma2^2)));
plot(x,y2);

legend('y','y1','y2');