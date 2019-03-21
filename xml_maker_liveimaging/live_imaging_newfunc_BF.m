fid = fopen('rbc_tile_test.xml', 'wt');

fprintf(fid, '<temika>\n');

% Define grid area
x1 = [0,250];
x2 = [0,750];
x3 = [-10500,250];
x4 = [-10500,750];
fov_x = 295; % x FoV in microns absolute value
fov_y = 250; % y Fov in microns absolute value
led_intensity = 0.01;
overlap_x = 10; % number of microns to overlap adjacent fields of view
overlap_y = 10;

diagonal = x4 - x1;
% +1 to make sure entire area is scanned because floor rounds to neg infinity and part of the area is lost
x_steps = abs(floor(diagonal(1) / fov_x)) + 1;
y_steps = abs(floor(diagonal(2) / fov_y)) + 1;

% Letting step in x and y to be one FoV
delta_x = fov_x * sign(diagonal(1));
delta_y = fov_y * sign(diagonal(2));

% Correction for keeping focus in case PFS does not work properly.
% Take change in z between x0 and x0+diagonal and apply gradient.
z_correction_y = 0; % microns correction in z per step in y direction
z_correction_x = 0; % microns correction in z per step in x direction

x_positions = linspace(x1(1), x_steps * delta_x, x_steps);
y_positions = linspace(y_steps * delta_y, x1(2), y_steps); % Initialise flipped so that scan moves in the right direction in the for loop

for ii=1:x_steps
    y_positions = fliplr(y_positions); % This is to make the scan not return all the way back and waste time.
    for jj=1:y_steps
        move_absolute(fid, x_positions(ii), y_positions(jj));
        sleep(fid,0.2);
        basename = strcat(pwd,['/X_',num2str(x_positions(ii))],['.Y_',num2str(y_positions(jj)),'.']);
        record(fid, 3, basename);
    end
end
        

set_illumination(fid, 3, 0.01, 'OFF');
fprintf(fid, '</temika>');
fclose(fid);