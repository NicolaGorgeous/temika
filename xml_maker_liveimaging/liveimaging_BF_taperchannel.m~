fid = fopen('BF_40X_taper.xml','wt');
fprintf(fid,'<temika>'); fprintf(fid,'\n');

%% setting area to explore
%%%%%% it work with field of you 1200 px



obj_n= 40;  %%%% magnification
ppm= 5.84/obj_n;
obj= strcat(num2str(obj_n),'X_');

% setting frmae size
fsx= round(1200*ppm);
fsy= round(1920*ppm);

%%% coordinate of the left and right wall at the top (up) and at the bottom
%%% (down)

ul=[0,0]
ur=[0,1000]
dl=[10977,154]
dr=[10977,1154]

uc= (ur+ul)/2; dc= (dr+dl)/2;

Nfov=20;  %%%% number of field of view
vline=(dc-uc)/Nfov; 
posx= uc(1) + vline(1)*(1:Nfov)+fsx/2; %%% here the sign depends on the coordinate system of this fucking camera/stage
posy= uc(2) + vline(2)*(1:Nfov)-fsy/2;


pathdir='/home/np451/data/constant_flow/20.3.19/'
record_BF=1;
%%%%illumination_BF=0.2;
%illumination_BF=0.2;
illumination_BF=0.4;
totT= 48*3600 %%% hours
pause_hours = 3 %%%% hours
pause_minutes = 30%%%% minutes
pause_seconds = 0 %%%% seconds

pause=pause_hours*3600+pause_minutes*60+pause_seconds; 
%% For on moving in that position, taking 3s video and wait 2s 


%%%% coordinate of a fov where we can see the channel, for y drift
x0=0;
y0=-fsy/2;



for t=1:(floor(totT/pause))
set_illumination(fid, 3, illumination_BF, 'ON');    


%%%%take a pic of the channel wall on the right


move_absolute_nico(fid, x0,y0);
sleep_nico(fid,0,0,3);
basename=strcat(pathdir,obj,'_DRIFT_R');
record(fid, 0.1, basename);
sleep_nico(fid,0,0,1);
         


    
%%%%% first it moves along y
for ii=1:numel(posx);
      x=posx(ii),y=posy(ii);  
    
        move_absolute_nico(fid, x, y);
        sleep_nico(fid,0,0,3);
        basename=strcat(pathdir,obj,'_X',num2str(x),'_Y',num2str(y));
        record(fid, record_BF, basename);
        sleep_nico(fid,0,0,1);

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