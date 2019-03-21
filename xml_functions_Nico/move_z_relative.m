function move_z_relative(fid, z, speed)

if ~ischar(z)
    z = num2str(z);
end 
if ~ischar(speed)
    speed = num2str(speed);
end

fprintf(fid, '\t<microscope>\n');
fprintf(fid, '\t\t<eclipsetie>\n');
fprintf(fid, strcat('\t\t\t<zdrive_move_relative>',[z,' ',speed],'</zdrive_move_relative> <!-- displacement, speed (0..8) -->\n'))
fprintf(fid, '\t\t</eclipsetie>\n');
fprintf(fid, '\t</microscope>\n');

end