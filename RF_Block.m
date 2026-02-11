%% GFSK Modulation Simulation (nRF52832 BLE Style)
% This script simulates the smoothing of digital bits into a 
% Gaussian Frequency Shift Keying signal.

clear; clc; close ;

%% 1. Parameters
fs = 10000;              % Sampling frequency
T = 0.01;                % Bit duration
t = 0:1/fs:T-1/fs;       % Time vector for one bit
fc = 500;                % Center Carrier Frequency
f_dev = 150;             % Frequency deviation
bits = [1 0 1 1 0];      % Sample bit sequence

%% 2. Generate Bit Stream
bit_stream = [];
for b = bits
    bit_stream = [bit_stream, ones(1, length(t)) * b];
end
full_t = (0:length(bit_stream)-1)/fs;

%% 3. Gaussian Filtering (The "G" in GFSK)
% This represents the internal baseband filtering of the SoC
bt = 0.5; % Bandwidth-Time product
sigma = sqrt(log(2)) / (2 * pi * bt * T);
gauss_filter = exp(-full_t.^2 / (2 * sigma^2));
gauss_filter = gauss_filter / sum(gauss_filter);

% Smooth the bit transitions
smoothed_bits = conv(bit_stream, gauss_filter, 'same');

%% 4. Voltage Controlled Oscillator (VCO) Modulation
% The frequency changes smoothly based on the bit value
phase = 2 * pi * (fc * full_t + f_dev * cumsum(smoothed_bits-0.5)/fs);
gfsk_signal = cos(phase);

%% 5. Plotting
figure('Color', 'w', 'Position', [100, 100, 800, 600]);

subplot(3,1,1);
stairs(full_t, bit_stream, 'LineWidth', 2);
title('1. Original Digital Data (Information Source)');
ylabel('Logic Level'); grid on; ylim([-0.2 1.2]);

subplot(3,1,2);
plot(full_t, smoothed_bits, 'r', 'LineWidth', 2);
title('2. Smoothed Signal (Gaussian Filtering Block)');
ylabel('Freq Shift'); grid on;

subplot(3,1,3);
plot(full_t, gfsk_signal, 'Color', [0 .5 0]);
title('3. Final RF GFSK Signal (To Power Amplifier)');
xlabel('Time (s)'); ylabel('Amplitude'); grid on;

sgtitle('nRF52832 Internal Modulation Signal Flow');