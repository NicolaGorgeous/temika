function record_frame(fid, basename)
%INPUT: file identifier, basename for the file
%OUTPUT: none, writes xml for taking a single photo for an iidc camera

fprintf(fid, '<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M">\n');
fprintf(fid, '<transmission>ON</transmission>');

fprintf(fid, '\t<iidc>\n');
fprintf(fid, '\t\t<video_mode>0</video_mode>\n');
fprintf(fid, '\t\t<color_coding>RAW8</color_coding>\n');
fprintf(fid, '\t\t<size>1920 1200 0 0</size>\n');
fprintf(fid, '\t\t<packet_size>14688</packet_size>\n');
fprintf(fid, '\t\t<brightness mode="relative">120</brightness>\n');
fprintf(fid, '\t\t<exposure mode="off"></exposure>\n');
fprintf(fid, '\t\t<gamma mode="off"></gamma>\n');
fprintf(fid, '\t\t<gain mode="relative">0</gain>\n');
fprintf(fid, '\t\t<trigger_delay mode="off"></trigger_delay>\n');
fprintf(fid, '\t\t<shutter mode="relative">1244</shutter>\n');
fprintf(fid, '\t\t<packet_size>7576</packet_size>\n');

fprintf(fid, '\t</iidc>\n');

fprintf(fid, '\t<trigger>SOFTWARE</trigger>\n');
fprintf(fid, '\t<trigger_timeout>5.2</trigger_timeout>\n');
fprintf(fid, '\t<send_trigger></send_trigger>\n');

fprintf(fid, '</camera>\n');

fprintf(fid, '<save>');
fprintf(fid, strcat('<basename>',basename,'</basename>'));
fprintf(fid, '<append>TWONUMBERS</append>');
fprintf(fid, '</save>');

end