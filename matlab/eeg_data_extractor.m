function [delta_signal, theta_signal, alpha_signal, beta_signal, gamma_signal] = eeg_data_extractor(eeg_signal, fs)

delta_signal = [0];
theta_signal = [0];
alpha_signal = [0];
beta_signal = [0];
gamma_signal = [0];

% Определить параметры для фильтрации сигнала
delta_band = [1 3]; % Частотный диапазон delta-ритма
theta_band = [4 8]; % Частотный диапазон theta-ритма
alpha_band = [9 13]; % Частотный диапазон alpha-ритма
beta_band = [14 30]; % Частотный диапазон beta-ритма
gamma_band = [31 45]; % Частотный диапазон gamma-ритма

% Создать фильтры для каждого частотного диапазона
delta_filter = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',delta_band(1),'HalfPowerFrequency2',delta_band(2), 'SampleRate',fs);
theta_filter = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',theta_band(1),'HalfPowerFrequency2',theta_band(2), 'SampleRate',fs);
alpha_filter = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',alpha_band(1),'HalfPowerFrequency2',alpha_band(2), 'SampleRate',fs);
beta_filter = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',beta_band(1),'HalfPowerFrequency2',beta_band(2), 'SampleRate',fs);
gamma_filter = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',gamma_band(1),'HalfPowerFrequency2',gamma_band(2), 'SampleRate',fs);

% Фильтрация сигнала по частотным диапазонам
delta_signal = filter(delta_filter, eeg_signal);
theta_signal = filter(theta_filter, eeg_signal);
alpha_signal = filter(alpha_filter, eeg_signal);
beta_signal = filter(beta_filter, eeg_signal);
gamma_signal = filter(gamma_filter, eeg_signal);

end
