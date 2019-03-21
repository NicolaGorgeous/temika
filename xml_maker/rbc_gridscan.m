fid = fopen('rbc_tile_test.xml', 'wt');

fprintf(fid, '<temika>\n');

x1 = [0,0];
x2 = [0,-5000];
x3 = [-5000,-5000];
x4 = [-5000,0];

fov_x = 140; % x FoV in microns absolute value
fov_y = 280; % y Fov in microns absolute value

diagonal = x3 - x1;
x_steps = abs(floor(diagonal(1) / fov_x));
y_steps = abs(floor(diagonal(2) / fov_y));

delta_x = diagonal(1) / x_steps;
delta_y = diagonal(2) / y_steps;

led_names = {'blue','green','red','white'};
led_number = [0,1,2,3];
led_intensity = [0.02577, 0.03867, 0.1197, 0.0265]; % Recalibrate for different objectives
% led_intensity numbers from keeping the range of pixel values between
% ~2500 - 55000 in auto mode

z_correction_y = 20/9943; % microns correction in z per step in y direction
z_correction_x = 8.4/6965; % microns correction in z per step in x direction

move_absolute(fid,0,0);
for ii=1:x_steps
    basename = strcat(pwd,'/test');
    move_relative(fid, delta_x, 0);
    move_z_relative(fid, sign(delta_x) * z_correction_x, 4);
    for kk=1:4
            set_illumination(fid, kk-1, led_intensity(kk), 'ON');
            sleep(fid, 0.1);
            record(fid, 0.1, strcat(basename,'_',num2str(led_number(kk))));
            set_illumination(fid, kk-1, led_intensity(kk), 'OFF');
    end
    for jj=1:y_steps
        if mod(ii,2) == 1
            move_relative(fid, 0, delta_y);
            move_z_relative(fid, z_correction_y * sign(delta_y), 4);
        else
            move_relative(fid, 0, -delta_y);
            move_z_relative(fid, z_correction_y * sign(-delta_y), 4);
        end

        for kk=1:4
            set_illumination(fid, kk-1, led_intensity(kk), 'ON');
            sleep(fid, 0.1);
            record(fid, 0.1, strcat(basename,'_',num2str(led_number(kk))));
            set_illumination(fid, kk-1, led_intensity(kk), 'OFF');
        end
    end
end
        

set_illumination(fid, 3, 0.01, 'OFF');
fprintf(fid, '</temika>');
fclose(fid);