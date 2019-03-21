fid = fopen('calibration_HZ.xml','wt');
fprintf(fid,'<temika>'); fprintf(fid,'\n');

wait_time=0.5; ;   %%%% seconds int 
stop_time=3;

period= [70,50,40,33];    %%%% this is taken with sin_waveform 20
gain= [3,4,5,6,7,8];
offset= [4,5,6,7,8,9];

pathdir='/home/np451/data/syn/2.7.18/'
obj_n= 20;  %%%% magnification
ppm= 5.84/obj_n;
obj= strcat(num2str(obj_n),'X_');

%% open temika
fprintf(fid,'\t<microscope>'); fprintf(fid,'\n');
fprintf(fid,'\t\t<eclipsetie>'); fprintf(fid,'\n');
fprintf(fid,'\t\t\t<light_path>L100</light_path>'); fprintf(fid,'\n');
fprintf(fid,'\t\t</eclipsetie>'); fprintf(fid,'\n');
fprintf(fid,'\t</microscope>'); fprintf(fid,'\n');
fprintf(fid,'\n');
fprintf(fid,'\t\t<timestamp>0</timestamp>'); fprintf(fid,'\n');
fprintf(fid,'\n');fprintf(fid,'\n');fprintf(fid,'\n');


fprintf(fid,strcat('\t<!-- set smc with selected gain and voltage and period -->\n'))

	fprintf(fid,'\t<smc>\n');
	fprintf(fid,strcat('\t\t<offset>','0','</offset>\n'));
	fprintf(fid,strcat('\t\t<gain>','0','</gain>\n'));
	fprintf(fid,'\t\t<waveform>\n');
	fprintf(fid,strcat('\t\t\t<repetitions>0</repetitions>\n'));
	fprintf(fid,strcat('\t\t\t<period>','0','</period>\n'));
	fprintf(fid,'\t\t</waveform>\n');
	fprintf(fid,'\t</smc>\n');





fprintf(fid,'\t\t<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M"><record>ON</record></camera>\n')
fprintf(fid,'\t\t<sleep>0:0:0.5</sleep>\n');

for vv=1:numel(gain); 
for pp=1:numel(period)


%% set smc with selected gain and voltage

        fprintf(fid,strcat('\t<!-- set smc with selected gain and voltage and period -->\n'))

	fprintf(fid,'\t<smc>\n');
	fprintf(fid,strcat('\t\t<offset>',num2str(offset(vv)),'</offset>\n'));
	fprintf(fid,strcat('\t\t<gain>',num2str(gain(vv)),'</gain>\n'));
	fprintf(fid,'\t\t<waveform>\n');
	fprintf(fid,strcat('\t\t\t<repetitions>-1</repetitions>\n'));
	fprintf(fid,strcat('\t\t\t<period>',num2str(period(pp)),'</period>\n'));
	fprintf(fid,'\t\t</waveform>\n');
	fprintf(fid,'\t</smc>\n');

 	fprintf(fid,'\t\t<sleep>0:0:0.5</sleep>\n');               
        
        fprintf(fid,'\n');fprintf(fid,'\n');fprintf(fid,'\n');fprintf(fid,'\n');
        
    end
end

        fprintf(fid,strcat('\t<!-- set smc with selected gain and voltage and period -->\n'))

	fprintf(fid,'\t<smc>\n');
	fprintf(fid,strcat('\t\t<offset>0</offset>\n'));
	fprintf(fid,strcat('\t\t<gain>0</gain>\n'));
	fprintf(fid,'\t\t<waveform>\n');
	fprintf(fid,strcat('\t\t\t<repetitions>0</repetitions>\n'));
	fprintf(fid,strcat('\t\t\t<period>0</period>\n'));
	fprintf(fid,'\t\t</waveform>\n');
	fprintf(fid,'\t</smc>\n');
        
%% finish registartion

fprintf(fid,'\t\t<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M"><record>OFF</record></camera>\n')
fprintf(fid,'\t\t<sleep>0:0:1</sleep>\n');
fprintf(fid,'\n');



fprintf(fid,'</temika>'); fprintf(fid,'\n');
fclose(fid);
