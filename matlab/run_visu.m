ch = 16;

if (ch == 8)
    in_data = 	{
	    {	'Fp1'	randi([0, 1000])/1000.0		}	;
	    {	'Fp2'	randi([0, 1000])/1000.0		}	;
	    {	'C3'	randi([0, 1000])/1000.0		}	;
	    {	'C4'	randi([0, 1000])/1000.0		}	;
	    {	'P7'	randi([0, 1000])/1000.0		}	;
	    {	'P8'	randi([0, 1000])/1000.0		}	;
	    {	'O1'	randi([0, 1000])/1000.0		}	;
	    {	'O2'	randi([0, 1000])/1000.0		}
    };
end

if (ch == 16)
    in_data = 	{
	    {	'Fp1'	randi([0, 1000])/1000.0		}	;
	    {	'Fp2'	randi([0, 1000])/1000.0		}	;
	    {	'C3'	randi([0, 1000])/1000.0		}	;
	    {	'C4'	randi([0, 1000])/1000.0		}	;
	    {	'P7'	randi([0, 1000])/1000.0		}	;
	    {	'P8'	randi([0, 1000])/1000.0		}	;
	    {	'O1'	randi([0, 1000])/1000.0		}	;
	    {	'O2'	randi([0, 1000])/1000.0		}	;
	    {	'F3'	randi([0, 1000])/1000.0		}	;
	    {	'F4'	randi([0, 1000])/1000.0		}	;
	    {	'F7'	randi([0, 1000])/1000.0		}	;
	    {	'F8'	randi([0, 1000])/1000.0		}	;
	    {	'T7'	randi([0, 1000])/1000.0		}	;
	    {	'T8'	randi([0, 1000])/1000.0		}	;
	    {	'P3'	randi([0, 1000])/1000.0		}	;
	    {	'P4'	randi([0, 1000])/1000.0		}
    };
end

% Параметры интерполяции
step = 0.01;
min_value = 0;
max_value = 1;
R = 1;

% Параметры гауссового размытия
sigma = 5;
apply_blur = false;

eeg_data_visualization_v1(in_data, step, min_value, max_value, R, sigma, apply_blur);
eeg_data_visualization_v2(in_data, step, min_value, max_value, R, sigma, apply_blur);