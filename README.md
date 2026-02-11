# RF-System-Decomposition
RF System Block Explanations
1. Information Source / MCU (ARM® Cortex®-M4)
The "brain" of the system. It generates the digital data to be transmitted and processes received data. It manages the protocol stack (like BLE) and tells the radio when to wake up or sleep.

2. RF Transceiver (2.4 GHz Radio)
The core communication hub. It handles the transition between high-frequency analog signals and digital data. It contains the frequency synthesizer that generates the 2.4 GHz carrier wave.

3. Modulation / Demodulation (Baseband Processor)
This block converts digital 1s and 0s into Gaussian Frequency Shift Keying (GFSK) signals for transmission. During reception, it reverses the process, extracting digital bits from the frequency-shifted analog waves.

4. Power Amplifier (PA)
The "loudspeaker" of the transmitter. It boosts the power of the modulated RF signal before it reaches the antenna to ensure it can travel the required distance (up to +4 dBm in this device).

5. Low Noise Amplifier (LNA)
The "sensitive ear" of the receiver. It amplifies the incredibly weak signals picked up by the antenna from the air while adding as little noise as possible, making the signal readable for the demodulator.

6. RF Filtering / Matching Network (Balun)
This ensures the impedance of the chip matches the antenna (usually 50Ω) to prevent signal reflection. It also filters out unwanted harmonics (interference) to comply with radio regulations like FCC/CE.

7. Antenna Interface
The physical connection point (pin) where the signal exits to the antenna or enters from the air. It is the boundary between the internal circuitry and the wireless medium.

8. Power Supply (Internal DC/DC Converter)
Radio components are sensitive to noise. This block provides clean, stable voltage specifically for the RF analog blocks, often using an integrated Buck regulator to maximize battery life.
