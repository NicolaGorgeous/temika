function move_relative(fid,x,y)
% INPUT: file handler, x position, y position in microns
% OUTPUT: none, appends xml to the file to be run by temika

fprintf(fid,strcat('\t<!-- Position x=',num2str(x),'y=',num2str(y),' -->'));fprintf(fid,'\n');
    
fprintf(fid,'\t\t<!-- MOVE -->\n');
fprintf(fid,'\t\t<microscope>\n');

fprintf(fid,'\t\t\t<xystage axis="x">\n');
fprintf(fid,strcat('\t\t\t\t<enable>ON</enable>\n'));
fprintf(fid,strcat('\t\t\t\t<move_relative>',num2str(x),' 5</move_relative>\n'));
fprintf(fid,'\t\t\t</xystage>\n');

fprintf(fid,'\t\t\t<xystage axis="y">\n');
fprintf(fid,strcat('\t\t\t\t<enable>ON</enable>\n'));
fprintf(fid,strcat('\t\t\t\t<move_relative>',num2str(y),' 5</move_relative>\n'));
fprintf(fid,'\t\t\t</xystage>\n');

fprintf(fid,'\t\t\t<xystage axis="x">\n');
fprintf(fid,'\t\t\t\t<wait_moving_end></wait_moving_end>\n')
fprintf(fid,'\t\t\t</xystage>\n');

fprintf(fid,'\t\t\t<xystage axis="y">\n');
fprintf(fid,'\t\t\t\t<wait_moving_end></wait_moving_end>\n');
fprintf(fid,'\t\t\t</xystage>\n');
fprintf(fid,'\t\t</microscope>\n');

fprintf(fid,'\t\t<microscope>\n');
fprintf(fid,'\t\t\t<xystage axis="x">\n');
fprintf(fid,strcat('\t\t\t\t<enable>OFF</enable>\n'));
fprintf(fid,'\t\t\t</xystage>\n');

fprintf(fid,'\t\t\t<xystage axis="y">\n');
fprintf(fid,strcat('\t\t\t\t<enable>OFF</enable>\n'));
fprintf(fid,'\t\t\t</xystage>\n');

fprintf(fid,'\t\t</microscope>\n');
end