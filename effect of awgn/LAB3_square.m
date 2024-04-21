clc;
clear all;
close all;

%Parameters
Fs=1000; %sampling frequency
T=1;     %signal duration
t=0:1/Fs:T-1/Fs; %Time Vector

%Signal generation
signal= square(t*50);

%Noise Generation
SNR_dB=0;
noise_power= var(signal)/(10^(SNR_dB/10));
noise= sqrt(noise_power)* randn(size(t));


%Add noise to signal
noisy_signal1= signal+noise;
noisy_signal2= awgn(signal,SNR_dB);

subplot(2,1,1);
plot(t,signal);
title('Original Signal');
xlabel('time');
ylabel('signal');
subplot(2,1,2);
plot(t,noisy_signal1);
title('SNR 0dB');
xlabel('time');
ylabel('signal with AWGN');
