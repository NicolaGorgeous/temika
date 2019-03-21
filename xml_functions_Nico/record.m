function record(fid, record_seconds, basename)
% INPUT: absolute directory and filename, seconds to record
% OUTPUT: none, writes .movie at basename with the date appended to the
% name.

fprintf(fid,'\t\t<!-- SET NAME -->');fprintf(fid,'\n');
fprintf(fid,'\t\t<save>');fprintf(fid,'\n');
fprintf(fid,strcat('\t\t\t<basename>',basename,'</basename>'));fprintf(fid,'\n');
fprintf(fid,'\t\t\t<append>DATE</append>');fprintf(fid,'\n');
fprintf(fid,'\t\t</save>');fprintf(fid,'\n');

fprintf(fid,'\t\t<!-- Take a record -->');fprintf(fid,'\n');
fprintf(fid,'\t\t<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M"><record>ON</record></camera>');fprintf(fid,'\n');
fprintf(fid,strcat('\t\t<sleep>0:0:',num2str(record_seconds),'</sleep>'));fprintf(fid,'\n');
fprintf(fid,'\t\t<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M"><record>OFF</record></camera>');fprintf(fid,'\n');

end