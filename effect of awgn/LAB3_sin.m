clc;
clear all;
close all;

%Parameters
Fs=1000; %sampling frequency
T=1;     %signal duration
t=0:1/Fs:T-1/Fs; %Time Vector

%Signal generation

%Sinusoidal
f_signal=10; %frequency of signal (Hz)
A_signal= 1; %amplitude of signal
signal= A_signal * sin(2*pi*f_signal*t);
subplot(2,1,1);
plot(t,signal);
title('Original Signal');
xlabel('time');
ylabel('signal');

%Square
signal_square= square(t*50);

%Ramp wave
unitstep = t>=0;
signal_ramp = t.*unitstep;

%Noise Generation
SNR_dB=20;
noise_power= var(signal)/(10^(SNR_dB/10));
noise= sqrt(noise_power)* randn(size(t));


%Add noise to signal
noisy_signal1= signal+noise;
noisy_signal2= awgn(signal,SNR_dB);


subplot(2,1,2);
plot(t,noisy_signal1);
title('SNR 20dB');
xlabel('time');
ylabel('signal with AWGN');

figure;
plot(t,signal_square);
figure;
plot(t,signal_ramp);

figure;
plot(t,noisy_signal2);