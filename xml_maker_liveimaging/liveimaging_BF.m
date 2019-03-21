fid = fopen('BF_60X_smc.xml','wt');
fprintf(fid,'<temika>'); fprintf(fid,'\n');

%% setting area to explore
%%%%%% it work with field of you 1200 px

Ly=560;  %%%%% watch out that x and y are inverted on this microscope 
Lx=300; 

Ly=560;  %%%%% watch out that x and y are inverted on this microscope 
Lx=10; 


obj_n= 60;  %%%% magnification
ppm= 5.84/obj_n;
obj= strcat(num2str(obj_n),'X_');

% setting frmae size
fsx= round(1200*ppm);
fsy= round(1920*ppm);

posx= (0:round((Lx/fsx)))* fsx;
posy= (0:round((Ly/fsy)))* fsy;

posx = posx;%-round(Lx/2);
posy = posy;%-round(Ly/2);


%pathdir='/home/np451/data/oscillation_longtime/9.3.19/'
pathdir='/home/np451/data/constant_flow/14.3.19/'
record_BF=3;
%%%%illumination_BF=0.2;
%illumination_BF=0.2;
illumination_BF=0.65;
totT= 48*3600 %%% hours
pause_hours = 1 %%%% hours
pause_minutes = 30%%%% minutes
pause_seconds = 0 %%%% seconds

pause=pause_hours*3600+pause_minutes*60+pause_seconds; 
%% For on moving in that position, taking 3s video and wait 2s 


%%%% coordinate of a fov where we can see the channel, for y drift
x0=0;
y0=-271;



for t=1:(floor(totT/pause))
set_illumination(fid, 3, illumination_BF, 'ON');    


%%%%take a pic of the channel wall on the right


move_absolute_nico(fid, x0,y0);
sleep_nico(fid,0,0,3);
basename=strcat(pathdir,obj,'_DRIFT_R');
record(fid, 0.1, basename);
sleep_nico(fid,0,0,1);
         


    
%%%%% first it moves along y
for x=posx;
    for y=posy
        
        move_absolute_nico(fid, x, y);
        sleep_nico(fid,0,0,3);
        basename=strcat(pathdir,obj,'_X',num2str(x),'_Y',num2str(y));
        record(fid, record_BF, basename);
        sleep_nico(fid,0,0,1);
         
    end
end

%%%%take a pic of the channel wall on the left

%move_absolute_nico(fid, 339,780);
%sleep_nico(fid,0,0,3);
%basename=strcat(pathdir,obj,'_DRIFT_L');
%record(fid, 0.1, basename);
%sleep_nico(fid,0,0,1);


        
set_illumination(fid, 3, illumination_BF, 'OFF');
sleep_nico(fid,pause_hours,pause_minutes,pause_seconds);

end

fprintf(fid,'</temika>'); fprintf(fid,'\n');
fclose(fid);