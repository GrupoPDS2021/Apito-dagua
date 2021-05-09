function y = vus_methods(z, Fs) 
s = z.';

N = length(z); % signal length
n = 0:N-1;
ts = n*(1/Fs); % time for signal

% define the window
wintype = 'rectwin';
winlen = 201;
winamp = [0.5,1]*(1/winlen);

% find the zero-crossing rate
zc = zerocross(s);
% disp(zc);

% find the STE
energy_threshold = 0.0009;
E = energy(s,wintype,winamp(2),winlen);
% disp(mean(E));

if (mean(E) > (energy_threshold))
    result_energy = true;
else result_energy = false;
end
if (result_energy == true)
     y = 'voiced';
else 
    if (zc<170)
        y = 'unvoiced';
    else
        y = 'silence';
    end
end
end
