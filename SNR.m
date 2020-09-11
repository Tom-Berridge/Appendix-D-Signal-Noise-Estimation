%A script to find the amplitude spectra of the signal and noise and
%resulting Signal/Noise ratio

%Author: T. Berridge
%Date: 24/07/2020

clc; % Clear Command Window
close all; %Close all figures
clear; %Erase all existing variables

load('signal.txt')
load('noise.txt')

figure;
hold on
plot(signal(:,1),signal(:,2), 'r')
plot(noise(:,1),noise(:,2), 'b')

Fs = 1/4e-3; %sampling freq as time sampling interval is 4e-3, therefore Nyquist frequency, finds Nyquist Frequency

NFFT1=2^nextpow2(length(signal(:,2)));	% next power of 2 is 2^7 = 128
SIGNAL=fft(signal(:,2),NFFT1); 
f1=Fs*(0:(NFFT1/2))/NFFT1;	% Define frequency axis, in Fs increments.
%%Frequency axis runs from zero to the Nyquist frequency

AMP1=abs(SIGNAL/NFFT1);
AMP_dB1=20*log10(AMP1);
%%%%%%

NFFT2=2^nextpow2(length(noise(:,2)));	% next power of 2 is 2^7 = 128
NOISE=fft(noise(:,2),NFFT2); 
f2=Fs*(0:(NFFT2/2))/NFFT2;	% Define frequency axis, in Fs increments.
%%Frequency axis runs from zero to the Nyquist frequency

AMP2=abs(NOISE/NFFT2);
AMP_dB2=20*log10(AMP2);
%%%%%%

figure; 
hold on
plot(f1,AMP1(1:NFFT1/2+1), 'Linewidth', 1.5);
plot(f2,AMP2(1:NFFT2/2+1), 'r', 'Linewidth', 1.5);
xlabel('Frequency (Hz)')
ylabel('Amplitude')
legend('Signal','Noise', 'FontSize',10)
xlim([0 125])

%Gives SNR: 9.9 by comparing height of peaks
%%
figure; 
hold on
plot(f1,AMP_dB1(1:NFFT1/2+1), 'Linewidth', 1.5);
plot(f2,AMP_dB2(1:NFFT2/2+1), 'r', 'Linewidth', 1.5);
xlabel('Frequency (Hz)')
ylabel('Amplitude (dB)')
legend('Signal','Noise', 'FontSize',10)
xlim([0 125])


Amplitude1 = AMP1(1:NFFT1/2+1);
Amplitude2 = AMP2(1:NFFT2/2+1);
Amplitude1_dB = AMP_dB1(1:NFFT1/2+1);
Amplitude2_dB = AMP_dB2(1:NFFT1/2+1);

