function Mixing_script

    % Загружаем данные
    load('EEG_all_epochs.mat');  % либо путь к вашему файлу
    load('EMG_all_epochs.mat');  % либо путь к вашему файлу
    load('EOG_all_epochs.mat');

    % Удаляем последние 1084 строки из EMG_all_epochs, чтобы приравнять
    % размер матрицы к размеру EEG_all_epochs
    EMG_all_epochs = EMG_all_epochs(1:end-1084, :);

    % Сохраняем первые 500 строк в отдельную переменную (Откладываем их для
    % будущкй тестировки нейросети)
    first_500_rows_EEG_all_epochs = EEG_all_epochs(1:500, :);
    first_500_rows_EMG_all_epochs = EMG_all_epochs(1:500, :);
    first_500_rows_EOG_all_epochs = EOG_all_epochs(1:500, :);
    save('first_500_rows_EEG_all_epochs.mat', 'first_500_rows_EEG_all_epochs');
    save('first_500_rows_EMG_all_epochs.mat', 'first_500_rows_EMG_all_epochs');
    save('first_500_rows_EOG_all_epochs.mat', 'first_500_rows_EOG_all_epochs');

    % Удаляем первые 500 строк из сетов
    EEG_all_epochs = EEG_all_epochs(501:end, :);
    EMG_all_epochs = EMG_all_epochs(501:end, :);
    EOG_all_epochs = EOG_all_epochs(501:end, :);

    % Выводим количество элементов в каждом датасете
    %disp(['Size of clean EEG signal: ', num2str(size(EEG_all_epochs))]);
    %disp(['Size of artifact signal: ', num2str(size(EMG_all_epochs))]);

    % Предполагаем, что у нас есть чистый сигнал EEG и сигнал артефакта, загруженные или сгенерированные ранее
    clean_eeg = EEG_all_epochs;  % чистого сигнала EEG
    artifact_emg = EMG_all_epochs;  % сигнала артефакта EMG
    artifact_eog = EOG_all_epochs; % сигнала артефакта EOG
    
    % Желаемое значение SNR в децибелах
    desired_snr_db = -5;  % Например, -5 дБ

    % Создаем зашумленный сигнал
    noisy_eeg_emg = generate_noisy_data(clean_eeg, artifact_emg, 0, desired_snr_db);
    clean_eeg = clean_eeg(1:2900, :); % Приравниваем EEG данные к размеру EOG матрицы
    noisy_eeg_eog = generate_noisy_data(clean_eeg, 0, artifact_eog, desired_snr_db);
    artifact_emg = artifact_emg(1:2900, :); % Приравниваем EMG данные к размеру остальных
    noisy_eeg_emg_eog = generate_noisy_data(clean_eeg, artifact_emg, artifact_eog, desired_snr_db);

    save('EEG+EMG_noisy_data.mat', 'noisy_eeg_emg');
    save('EEG+EOG_noisy_data.mat', 'noisy_eeg_eog');
    save('EEG+EMG+EOG_noisy_data.mat', "noisy_eeg_emg_eog");

    % Теперь в noisy_data содержится чистый сигнал EEG с добавленным к нему артефактом при заданном SNR
end

function noisy_signal = generate_noisy_data(clean_eeg, artifact1, artifact2, snr_db)

    % Функция для добавления артефактов к чистому сигналу EEG.

    % Входные параметры:
    % clean_eeg - массив с чистым сигналом  EEG
    % artifact - массив с артефактом, который нужно добавить (EOG или EMG)
    % snr_db - желаемое значение SNR в децибелах
    %
    % Выходные данные:
    % noisy_signal - зашумленный сигнал EEG

    % Рассчитываем мощность сигнала и шума в линейном масштабе
    signal_power = mean(clean_eeg .^ 2, 2);
    if artifact1 ~= 0
        noise_power1 = mean(artifact1 .^ 2, 2);
    else
        noise_power1 = 1; % для избежания деления на 0 в фомуле lambda_factor
    end
    if artifact2 ~= 0
        noise_power2 = mean(artifact2 .^ 2, 2); % для избежания деления на 0 в фомуле lambda_factor
    else
        noise_power2 = 1;
    end

    % Конвертируем SNR из дБ в линейный масштаб
    snr_linear = 10 ^ (snr_db / 10);
    
    % Рассчитываем коэффициент для корректировки мощности шума
    lambda_factor1 = sqrt(signal_power / (snr_linear * noise_power1));
    lambda_factor2 = sqrt(signal_power / (snr_linear * noise_power2));
    
    % Генерируем зашумленный сигнал
    noisy_signal = clean_eeg + lambda_factor1 * artifact1 + lambda_factor2 * artifact2;
    
    % Создаем новое графическое окно
    figure;
    
    epoch_number_to_show = 1000;

    % Рисуем первый график (чистый сигнал EEG)
    subplot(2, 1, 1); % Создаем первую подграфик
    plot(clean_eeg(epoch_number_to_show, :)); % Рисуем график чистого сигнала для 24 записи
    xlabel('Время');
    ylabel('Амплитуда');
    title('Чистый сигнал EEG');
    
    % Рисуем второй график (зашумленный сигнал EEG)
    subplot(2, 1, 2); % Создаем вторую подграфик
    plot(noisy_signal(epoch_number_to_show, :)); % Рисуем график зашумленного сигнала для 24 записи с наложенным шумом
    xlabel('Время');
    ylabel('Амплитуда');
    title('Зашумленный сигнал EEG');

    clear("noise_power1","noise_power2","snr_linear","lambda_factor1","lambda_factor2","signal_power");
    
end
