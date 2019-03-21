
PN=30;   %%%%% directoty name
ff=15;   %%%%% extimated frequency

fid = fopen(strcat('P',num2str(PN),'.xml'),'wt');
fprintf(fid,'<temika>'); fprintf(fid,'\n');

wait_time=2;  %%%% seconds int 
record_time=5.0;
stop_time=3;

f= (ff-6):0.5:(ff+6);
%f=10:0.5:30;
period= unique(floor(1000./f));%%%% this is taken with sin_waveform 20
gain= [2,3,4,5];
%gain= [2,2.5,3,3.5,4,4.5,5];
offset= gain+1;

pathdir=strcat('/home/np451/data/26.11.18/P',num2str(PN),'/');
obj_n= 60;  %%%% magnification
ppm= 5.84/obj_n;
obj= strcat(num2str(obj_n),'X_');

%%% open temika
fprintf(fid,'\t<microscope>'); fprintf(fid,'\n');
fprintf(fid,'\t\t<eclipsetie>'); fprintf(fid,'\n');
fprintf(fid,'\t\t\t<light_path>L100</light_path>'); fprintf(fid,'\n');
fprintf(fid,'\t\t</eclipsetie>'); fprintf(fid,'\n');
fprintf(fid,'\t</microscope>'); fprintf(fid,'\n');
fprintf(fid,'\n');
fprintf(fid,'\t\t<timestamp>0</timestamp>'); fprintf(fid,'\n');
fprintf(fid,'\n');fprintf(fid,'\n');fprintf(fid,'\n');




for vv=1:numel(gain);
        fprintf(fid,strcat('\t<!-- set smc with selected gain and voltage and period -->\n'))

	fprintf(fid,'\t<smc>\n');
	fprintf(fid,strcat('\t\t<offset>',num2str(offset(vv)),'</offset>\n'));
	fprintf(fid,strcat('\t\t<gain>',num2str(gain(vv)),'</gain>\n'));
	fprintf(fid,'\t\t<waveform>\n');
	fprintf(fid,strcat('\t\t\t<repetitions>0</repetitions>\n'));
	fprintf(fid,'\t\t</waveform>\n');
	fprintf(fid,'\t</smc>\n');

        fprintf(fid,strcat('\t<sleep>0:0:',num2str(wait_time),'</sleep>\n'));



	filename=strcat(obj,'V',num2str(gain(vv)),'_O',num2str(offset(vv)),'_P0');

        fprintf(fid,'\t\t<!-- SET NAME -->\n');
        fprintf(fid,'\t\t<save>\n');
        fprintf(fid,strcat('\t\t\t<basename>',pathdir,filename,'</basename>\n'));
        fprintf(fid,'\t\t\t<append>DATE</append>\n');
        fprintf(fid,'\t\t</save>\n');
        

        fprintf(fid,'\t\t<!-- Turn on light -->\n');
	fprintf(fid,'\t\t<multiled device="microscope">\n');
	fprintf(fid,'\t\t\t<enable channel="0">ON</enable>\n');
	fprintf(fid,'\t\t</multiled>\n');


        fprintf(fid,'\t\t<!-- Take a record -->\n');
        fprintf(fid,'\t\t<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M"><record>ON</record></camera>\n');
        fprintf(fid,strcat('\t\t<sleep>0:0:',num2str(record_time),'</sleep>\n'));
        fprintf(fid,'\t\t<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M"><record>OFF</record></camera>\n')
        fprintf(fid,'\t\t<sleep>0:0:1</sleep>\n');
	fprintf(fid,'\n');

        fprintf(fid,'\t\t<!-- Turn off light -->\n');
	fprintf(fid,'\t\t<multiled device="microscope">\n');
	fprintf(fid,'\t\t\t<enable channel="0">OFF</enable>\n');
	fprintf(fid,'\t\t</multiled>\n');


for pp=1:numel(period)

	filename=strcat(obj,'V',num2str(gain(vv)),'_O',num2str(offset(vv)),'_P',num2str(period(pp)));


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

        fprintf(fid,strcat('\t<sleep>0:0:',num2str(wait_time),'</sleep>\n'));
        
        fprintf(fid,'\t\t<!-- SET NAME -->\n');
        fprintf(fid,'\t\t<save>\n');
        fprintf(fid,strcat('\t\t\t<basename>',pathdir,filename,'</basename>\n'));
        fprintf(fid,'\t\t\t<append>DATE</append>\n');
        fprintf(fid,'\t\t</save>\n');
        
        fprintf(fid,'\t\t<!-- Turn on light -->\n');
	fprintf(fid,'\t\t<multiled device="microscope">\n');
	fprintf(fid,'\t\t\t<enable channel="0">ON</enable>\n');
	fprintf(fid,'\t\t</multiled>\n');

        fprintf(fid,'\t\t<!-- Take a record -->\n');
        fprintf(fid,'\t\t<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M"><record>ON</record></camera>\n');
        fprintf(fid,strcat('\t\t<sleep>0:0:',num2str(record_time),'</sleep>\n'));
        fprintf(fid,'\t\t<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M"><record>OFF</record></camera>\n')

        fprintf(fid,'\t\t<sleep>0:0:1.0</sleep>');

        fprintf(fid,'\t\t<!-- Turn off light -->\n');
	fprintf(fid,'\t\t<multiled device="microscope">\n');
	fprintf(fid,'\t\t\t<enable channel="0">OFF</enable>\n');
	fprintf(fid,'\t\t</multiled>\n');

                
        
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
        
        
fprintf(fid,'</temika>'); fprintf(fid,'\n');
fclose(fid);
