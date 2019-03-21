fid = fopen('20X_BF_beadsPIV.xml','wt');
fprintf(fid,'<temika>'); fprintf(fid,'\n');

%% open temika
fprintf(fid,'\t<microscope>\n');
fprintf(fid,'\t\t<eclipsetie>\n');
fprintf(fid,'\t\t\t<light_path>L100</light_path>\n');
fprintf(fid,'\t\t\t<filter_block_cassette>3</filter_block_cassette>\n');
fprintf(fid,'\t\t</eclipsetie>\n')

fprintf(fid,'\t</microscope>\n');
fprintf(fid,'\t\t<timestamp>0</timestamp>\n');
fprintf(fid,'\n');fprintf(fid,'\n');fprintf(fid,'\n');

%% setting area to explore
Lx=2000;
Ly=700;

x1=[0,0];
x2=[-219,965];
x3=[-11216.3,-210.15];
x4=[-11117.9,779.45];

x12 = (x1 + x2)/2; % move to here to start scan
x34 = (x3 + x4)/2; 

line_vector = x34 - x12;

num_points = 40;
points = zeros([2,num_points+1]); % num_points + 1 to account for starting from the base of x12.

delta = line_vector / num_points;
for ii=1:num_points+1
    points(:,ii) = x12 + ii * delta
end



pxFramex=1200;
pxFramey=1920;
%%%% magnification%%%% magnification

obj_n= 20;  
ppm= 5.84/obj_n;
obj= strcat(num2str(obj_n),'X_');

% setting frmae size
fsx= round(pxFramex*ppm);
fsy= round(pxFramey*ppm);

%points(2,:)=points(2,:)- fsy %TODO Why need this?

posx= (0:round((Lx/fsx)))* fsx;
posy= (0:round((Ly/fsy)))* fsy;

%posx = posx-round(Lx/2);
%posy = posy-round(Ly/2);


pathdir='/home/np451/data/boyko/12.11.18'
pause=5;   %%%% seconds int
recordF=20.0; %%%% seconds of movie 
recordBF=5.0; %%%% seconds of movie 

gain_value=1;
packet_size_fl=25920;
illumination_fl=0.14;
illumination_bf=0
%% For on moving in that position, taking 10s video and wait 20s 
%%for manual focus refinement

for jj=1:num_points
x=points(1,jj);
y=points(2,jj);

%%%%% move to the right place %%%%%%%%%%%%%%        
        filenameBF=strcat(obj,'_BF_','X',num2str(x),'Y',num2str(y));

        fprintf(fid,strcat('\t<!-- Position x=',num2str(x),'y=',num2str(y),' -->'));fprintf(fid,'\n');
    
        fprintf(fid,'\t\t<!-- MOVE -->\n');
        fprintf(fid,'\t\t<microscope>\n');
 
        fprintf(fid,'\t\t\t<xystage axis="x">\n');
        fprintf(fid,strcat('\t\t\t\t<enable>ON</enable>\n'));
        fprintf(fid,strcat('\t\t\t\t<move_absolute>',num2str(x),' 5</move_absolute>\n'));
        fprintf(fid,'\t\t\t</xystage>\n');

        fprintf(fid,'\t\t\t<xystage axis="y">\n');
        fprintf(fid,strcat('\t\t\t\t<enable>ON</enable>\n'));
        fprintf(fid,strcat('\t\t\t\t<move_absolute>',num2str(y),' 5</move_absolute>\n'));
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

%%%% set BF on ch 3 %%%%%%

fprintf(fid,'\t<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M">\n');
fprintf(fid,'\t\t<transmission>ON</transmission>\n');
fprintf(fid,'\t\t<iidc>\n');
fprintf(fid,'\t\t\t<video_mode>0</video_mode>\n');
fprintf(fid,'\t\t\t<color_coding>RAW8</color_coding>\n');
fprintf(fid,'\t\t\t<size>1920 1200 0 0</size> <!--size_x, size_y, position_x, position_y-->\n');

fprintf(fid,'\t\t\t<packet_size>14688</packet_size>\n');   %%%% packet size
fprintf(fid,'\t\t\t<brightness mode="relative">120</brightness>\n');
fprintf(fid,'\t\t\t<exposure mode="off"></exposure>\n');
fprintf(fid,'\t\t\t<gamma mode="off"></gamma>\n');
fprintf(fid,'\t\t\t<gain mode="relative"></gain>\n');
fprintf(fid,'\t\t\t<trigger_delay mode="off"></trigger_delay>\n');
fprintf(fid,'\t\t\t<shutter mode="relative">1244</shutter>\n'); %%%% shutter max
fprintf(fid,'\t\t</iidc>\n');
fprintf(fid,'\t</camera>\n');

%%%% set light for BF

set_illumination(fid, 3, 0.02, 'ON')

fprintf(fid,strcat('\t\t<sleep>0:0:0',pause,'</sleep>'));fprintf(fid,'\n');


%%%%% set name for BF  and record %%%%%%        
        
        fprintf(fid,'\t\t<!-- SET NAME -->');fprintf(fid,'\n');
        fprintf(fid,'\t\t<save>');fprintf(fid,'\n');
        fprintf(fid,strcat('\t\t\t<basename>',pathdir,filenameBF,'</basename>'));fprintf(fid,'\n');
        fprintf(fid,'\t\t\t<append>DATE</append>');fprintf(fid,'\n');
        fprintf(fid,'\t\t</save>');fprintf(fid,'\n');
        
        fprintf(fid,'\t\t<!-- Turn on the light -->');fprintf(fid,'\n');
        fprintf(fid,strcat('\t\t<sleep>0:0:',num2str(pause),'</sleep>'));fprintf(fid,'\n');
        fprintf(fid,'\t\t<!-- Take a record -->');fprintf(fid,'\n');
        fprintf(fid,'\t\t<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M"><record>ON</record></camera>');fprintf(fid,'\n');
        fprintf(fid,strcat('\t\t<sleep>0:0:',num2str(recordBF),'</sleep>'));fprintf(fid,'\n');
        fprintf(fid,'\t\t<camera name="IIDC Point Grey Research Grasshopper3 GS3-U3-23S6M"><record>OFF</record></camera>');fprintf(fid,'\n');
        fprintf(fid,'\t\t<sleep>0:0:1.0</sleep>');fprintf(fid,'\n');
        
fprintf(fid,'\n');fprintf(fid,'\n');fprintf(fid,'\n');fprintf(fid,'\n');
        
end
        
        
fprintf(fid,'</temika>'); fprintf(fid,'\n');
fclose(fid);
