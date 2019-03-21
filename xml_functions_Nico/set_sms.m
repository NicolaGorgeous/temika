function [ ] = set_sms( fid,gain,offset,period,enable)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


    fprintf(fid,strcat('\t<!-- set smc with selected gain and voltage and period -->\n'))

	fprintf(fid,'\t<smc>\n');
	fprintf(fid,strcat('\t\t<offset>',num2str(offset),'</offset>\n'));
	fprintf(fid,strcat('\t\t<gain>',num2str(gain),'</gain>\n'));
	fprintf(fid,'\t\t<waveform>\n');
	fprintf(fid,strcat('\t\t\t<repetitions>',num2str(enable),'</repetitions>\n'));
	fprintf(fid,strcat('\t\t\t<period>',num2str(period),'</period>\n'));
	fprintf(fid,'\t\t</waveform>\n');
	fprintf(fid,'\t</smc>\n');


end

